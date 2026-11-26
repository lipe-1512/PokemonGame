"""Cenarios de execucao real no ProB. Nao simula as regras em Python."""
import argparse, json, os, re, subprocess, tempfile
from pathlib import Path

parser=argparse.ArgumentParser()
parser.add_argument('--probcli',required=True)
parser.add_argument('--model-dir',default=str(Path(__file__).resolve().parent.parent))
parser.add_argument('--logs',default=str(Path(__file__).resolve().parent/'logs'))
args=parser.parse_args()
model=Path(args.model_dir).resolve();logs=Path(args.logs).resolve();logs.mkdir(parents=True,exist_ok=True)
engine=Path(args.probcli).resolve();env=os.environ.copy()
if not env.get('JAVA_HOME') and Path('C:/Program Files/Java/jdk-22/bin/java.exe').exists():
 env['JAVA_HOME']='C:/Program Files/Java/jdk-22';env['PATH']=env['JAVA_HOME']+'/bin;'+env.get('PATH','')

if env.get("JAVA_HOME"):
 java_bin=Path(env["JAVA_HOME"])/"bin"
 if not any((java_bin/name).is_file() for name in ("java.exe","java")):
  parser.error("JAVA_HOME deve apontar para a pasta do JDK que contem bin/java; ajuste essa variavel antes de executar.")
 env["PATH"]=str(java_bin)+os.pathsep+env.get("PATH","")

def fixture(folder,one,two):
 folder.mkdir(parents=True,exist_ok=True)
 for f in model.glob('*.mch'):(folder/f.name).write_bytes(f.read_bytes())
 s=(folder/'decks.mch').read_text(encoding='utf-8-sig')
 assert len(one)==len(two)==20
 for k,deck in [(1,one),(2,two)]:s=re.sub(rf'deck_{k} = \[[^\]]*\]',f'deck_{k} = ['+', '.join(deck)+']',s)
 marker='\nSETS\n'
 assert s.count(marker)==1
 s=s.replace(marker,' &\n    ordem_1 = id(1..size(deck_1)) &\n    ordem_2 = id(1..size(deck_2))\n'+marker)
 (folder/'decks.mch').write_text(s,encoding='utf-8')
 return folder

class Scenario:
 def __init__(self,name,folder=model):self.name=name;self.folder=folder;self.commands=[]
 def check(self,predicate):self.commands.append(('check',predicate,True));return self
 def do(self,operation,success=True):
  self.commands.append(('execute',operation,success));self.check('@INVARIANT');return self
 def run(self):
  commands=[]
  for i,(kind,text,expected) in enumerate(self.commands):commands += [f'"STEP_{i:04d}"',(':exec '+text) if kind=='execute' else text]
  commands+=[':q']
  result=subprocess.run([str(engine),str(self.folder/'jogoPokemon.mch'),'-init','-repl','-timeout','10000'],input='\n'.join(commands)+'\n',capture_output=True,text=True,encoding='utf-8',errors='replace',env=env,timeout=90)
  output=result.stdout+'\n'+result.stderr
  (logs/(self.name+'.log')).write_text(output,encoding='utf-8')
  # Cada marcador identifica uma consulta, sem confundir FALSE em valores de estado.
  marks=list(re.finditer(r'(?m)^"STEP_(\d{4})"\s*$',output))
  if len(marks)!=len(self.commands):raise AssertionError(f'{self.name}: marcadores incompletos {len(marks)}/{len(self.commands)}; ver log')
  for k,m in enumerate(marks):
   i=int(m.group(1));segment=output[m.end():marks[k+1].start() if k+1<len(marks) else len(output)]
   kind,text,expected=self.commands[i]
   needle=('Execution result: ' if kind=='execute' else 'Predicate is ')+('TRUE' if expected else 'FALSE')
   matched=(needle in segment or (not expected and 'Could not execute statement:' in segment and 'NOT-WELL-DEFINED (FALSE)' in segment)) if kind=='execute' else bool(re.search(r'(?m)^[^\n]*Predicate[^\n]* is TRUE\s*$',segment))
   if not matched:raise AssertionError(f'{self.name} passo {i}: {text}\nEsperado {needle}\n{segment[:1600]}')
  if result.returncode:raise AssertionError(f'{self.name}: ProB terminou com {result.returncode}')
  print(f'PASS {self.name}: {len(self.commands)} verificacoes e operacoes',flush=True)
  return {'cenario':self.name,'consultas_e_operacoes':len(self.commands),'resultado':'PASS'}

cases=[]
initial=Scenario('01_inicializacao')
initial.check('!(pp).(pp:JOGADOR => size(mao(pp))=5 & size(premios(pp))=6 & size(decks_jogadores(pp))=9)')
initial.check('ganhador = {} & fase_atual = fase_compra & ativo = {}')
initial.check('!(pp).(pp:JOGADOR => ran(mao(pp)) /\\ estagio_pokemon~[{Basico}] /= {})')
initial.check('mao(jogador1) ^ premios(jogador1) ^ decks_jogadores(jogador1) = baralho_1')
initial.check('mao(jogador2) ^ premios(jogador2) ^ decks_jogadores(jogador2) = baralho_2')
initial.check('!(cc).(cc:CARTA => card(baralho_1~[{cc}])=card(deck_1~[{cc}]) & card(baralho_2~[{cc}])=card(deck_2~[{cc}]))')
initial.check('@INVARIANT');cases.append(initial)
initial.do('comprar_carta_turno(jogador1)')
initial.check('size(mao(jogador1))=6 & size(decks_jogadores(jogador1))=8')
initial.check('(mao(jogador1) /|\\ 5) ^ premios(jogador1) ^ [last(mao(jogador1))] ^ decks_jogadores(jogador1) = baralho_1')

with tempfile.TemporaryDirectory(prefix='pokemon-prob-',dir=logs) as directory:
 tmp=Path(directory)
 fixed=fixture(
  tmp/'fixed',
  ['squirtle','energia_agua','energia_agua','wartotle','energia_agua']*4,
  ['elekid','energia_raio','energia_raio','wartotle','energia_raio']*4,
 )
 s=Scenario('08_ativo_inicial_a_partir_do_banco',fixed)
 s.do('comprar_carta_turno(jogador1)').do('baixar_pokemon_banco(jogador1,squirtle)').do('jogar_energia_banco(jogador1,energia_agua,1)')
 s.do('repor_pokemon_ativo(jogador1,1)').check('ativo(jogador1)=squirtle & energia_ativa(jogador1)=1 & banco(jogador1)=[] & fase_atual=fase_principal')
 s.do('passar_turno(jogador1)');cases.append(s)

 s=Scenario('02_turnos_ataque_nocaute',fixed)
 s.do('comprar_carta_turno(jogador1)').do('comprar_carta_turno(jogador1)',False)
 s.do('definir_pokemon_ativo(jogador1,squirtle)').do('jogar_energia_ativo(jogador1,energia_agua)').do('jogar_energia_ativo(jogador1,energia_agua)',False)
 s.do('atacar_oponente(jogador1)',False).do('passar_turno(jogador1)').do('comprar_carta_turno(jogador1)',False)
 s.do('comprar_carta_turno(jogador2)').do('definir_pokemon_ativo(jogador2,elekid)').do('jogar_energia_ativo(jogador2,energia_raio)').do('atacar_oponente(jogador2)')
 s.do('atacar_oponente(jogador2)',False).do('passar_turno(jogador2)')
 s.do('comprar_carta_turno(jogador1)').do('atacar_oponente(jogador1)').do('passar_turno(jogador1)')
 s.do('comprar_carta_turno(jogador2)').do('atacar_oponente(jogador2)').do('passar_turno(jogador2)',False).do('resolver_nocaute(jogador2)')
 s.check('ganhador={jogador2} & fase_atual=fase_encerrada & jogador1 /: dom(ativo) & jogador1 /: dom(dano_ativo) & jogador1 /: dom(energia_ativa)')
 s.check('size(premios(jogador2))=5 & last(descarte(jogador1))=squirtle')
 s.do('comprar_carta_turno(jogador2)',False).do('passar_turno(jogador2)',False);cases.append(s)

 s=Scenario('03_evolucao_e_familia',fixed)
 s.do('comprar_carta_turno(jogador1)').do('definir_pokemon_ativo(jogador1,squirtle)').do('evoluir_ativo(jogador1,wartotle)').check('ativo(jogador1)=wartotle')
 s.do('passar_turno(jogador1)').do('comprar_carta_turno(jogador2)').do('definir_pokemon_ativo(jogador2,elekid)').do('evoluir_ativo(jogador2,wartotle)',False);cases.append(s)

 s=Scenario('04_esgotamento_baralho',fixed)
 for turn in range(9):
  for who,card in [('jogador1','squirtle'),('jogador2','elekid')]:
   s.do(f'comprar_carta_turno({who})')
   if turn==0:s.do(f'definir_pokemon_ativo({who},{card})')
   s.do(f'passar_turno({who})')
 s.check('ganhador={} & size(decks_jogadores(jogador1))=0 & size(decks_jogadores(jogador2))=0')
 s.do('comprar_carta_turno(jogador1)').check('ganhador={jogador2} & fase_atual=fase_encerrada');cases.append(s)

 rich=fixture(tmp/'rich',['squirtle','squirtle','pocao','wartotle','blastoise']+['energia_agua']*6+['energia_agua','energia_agua','pocao','energia_agua','energia_agua','squirtle','energia_agua','energia_agua','pocao'],['elekid','elekid','elekid','electabuzz','pocao']+['energia_raio']*6+['energia_raio','energia_raio','pocao','energia_raio','energia_raio','elekid','energia_raio','energia_raio','pocao'])
 s=Scenario('05_cura_e_evolucao_completa_fixture',rich)
 s.do('comprar_carta_turno(jogador1)').do('definir_pokemon_ativo(jogador1,squirtle)').do('baixar_pokemon_banco(jogador1,squirtle)').do('jogar_energia_ativo(jogador1,energia_agua)').do('passar_turno(jogador1)')
 s.do('comprar_carta_turno(jogador2)').do('definir_pokemon_ativo(jogador2,elekid)').do('jogar_energia_ativo(jogador2,energia_raio)').do('atacar_oponente(jogador2)').do('passar_turno(jogador2)')
 s.do('comprar_carta_turno(jogador1)').check('dano_ativo(jogador1)=40').do('usar_pocao_ativo(jogador1,pocao)').check('jogador1 /: dom(dano_ativo)')
 s.do('evoluir_ativo(jogador1,wartotle)').do('evoluir_ativo(jogador1,blastoise)').do('jogar_energia_ativo(jogador1,energia_agua)').do('atacar_oponente(jogador1)').do('resolver_nocaute(jogador1)').check('ganhador={jogador1}');cases.append(s)

 s=Scenario('06_reposicao_e_reindexacao_fixture',rich)
 s.do('comprar_carta_turno(jogador1)').do('definir_pokemon_ativo(jogador1,squirtle)').do('jogar_energia_ativo(jogador1,energia_agua)').do('passar_turno(jogador1)')
 s.do('comprar_carta_turno(jogador2)').do('definir_pokemon_ativo(jogador2,elekid)').do('baixar_pokemon_banco(jogador2,elekid)').do('baixar_pokemon_banco(jogador2,elekid)').do('jogar_energia_banco(jogador2,energia_raio,2)').do('passar_turno(jogador2)')
 s.do('comprar_carta_turno(jogador1)').do('jogar_energia_ativo(jogador1,energia_agua)').do('evoluir_ativo(jogador1,wartotle)').do('atacar_oponente(jogador1)').do('passar_turno(jogador1)')
 s.do('comprar_carta_turno(jogador2)').do('jogar_energia_banco(jogador2,energia_raio,2)').do('passar_turno(jogador2)')
 s.do('comprar_carta_turno(jogador1)').do('atacar_oponente(jogador1)').do('resolver_nocaute(jogador1)').check('fase_atual=fase_reposicao & turno=jogador2 & ganhador={}')
 s.do('repor_pokemon_ativo(jogador2,1)').check('size(banco(jogador2))=1 & ativo(jogador2)=elekid & jogador2 /: dom(energia_ativa) & energia_banco(jogador2|->1)=2 & (jogador2|->2) /: dom(energia_banco) & fase_atual=fase_compra');cases.append(s)

 prize=fixture(tmp/'prize',['squirtle','wartotle','blastoise','energia_agua','energia_agua']+['energia_agua']*15,['elekid','elekid','elekid','elekid','energia_raio']+['energia_raio']*6+['elekid','elekid','elekid']+['energia_raio']*6)
 s=Scenario('07_vitoria_sexto_premio_fixture',prize)
 s.do('comprar_carta_turno(jogador1)').do('definir_pokemon_ativo(jogador1,squirtle)').do('evoluir_ativo(jogador1,wartotle)').do('evoluir_ativo(jogador1,blastoise)').do('jogar_energia_ativo(jogador1,energia_agua)').do('passar_turno(jogador1)')
 s.do('comprar_carta_turno(jogador2)').do('definir_pokemon_ativo(jogador2,elekid)')
 for _ in range(4):s.do('baixar_pokemon_banco(jogador2,elekid)')
 s.do('passar_turno(jogador2)')
 for ko in range(6):
  s.do('comprar_carta_turno(jogador1)')
  if ko==0:s.do('jogar_energia_ativo(jogador1,energia_agua)')
  s.do('atacar_oponente(jogador1)').do('resolver_nocaute(jogador1)')
  if ko<5:
   s.do('repor_pokemon_ativo(jogador2,1)').do('comprar_carta_turno(jogador2)')
   if ko<2:s.do('baixar_pokemon_banco(jogador2,elekid)')
   s.do('passar_turno(jogador2)')
 s.check('ganhador={jogador1} & size(premios(jogador1))=0 & size(banco(jogador2))>0');cases.append(s)

 results=[s.run() for s in cases]
(logs/'resultados.json').write_text(json.dumps(results,ensure_ascii=False,indent=2),encoding='utf-8')
print('Todos os cenarios passaram. As fixtures nao alteram os baralhos do projeto.')
