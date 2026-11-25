# Pokémon TCG — PJ2

Protótipo do modelo B com visualização VisB para execução no ProB2-UI. O estado exibido e as ações vêm das máquinas B; não existe uma implementação paralela das regras em JavaScript.

## Abrir e jogar

1. Instale o ProB2-UI e os requisitos de Java indicados pela distribuição escolhida.
2. Mantenha juntas as quatro máquinas `.mch` da raiz e a pasta `visualizacao`.
3. Abra **`jogoPokemon.mch` da raiz** no ProB2-UI. Execute a configuração das constantes e a inicialização, caso o programa solicite.
4. Abra a visualização VisB. A definição `VISB_JSON_FILE` aponta para `visualizacao/pokemon.json`; se for necessário selecionar o arquivo manualmente, escolha esse JSON.
5. Use os botões do jogador da vez. As ações esmaecidas não possuem uma execução habilitada nesse estado. Quando houver mais de uma combinação de parâmetros, escolha a carta ou posição na seleção de eventos do ProB2.
6. Use o histórico/reinicialização do ProB para desfazer ações ou começar novamente.

O arquivo SVG isolado mostra apenas a composição gráfica. A interação com as máquinas requer o VisB no ProB2. A imagem de prévia também é estática.

**Pasta `bdp`:** contém fontes e resultados de uma versão anterior do Atelier B. Para este protótipo, as fontes oficiais são as máquinas da raiz. As provas antigas não certificam as alterações desta entrega; será necessário gerar novamente as obrigações de prova no Atelier B se a avaliação exigir essa evidência.

## Como as máquinas se conectam

`jogoPokemon INCLUDES Jogadores`, `Jogadores INCLUDES decks`; essas máquinas consultam as constantes de `cards` por `SEES`.

- `cards.mch`: enumera nove cartas e define categoria, estágio, HP, dano do ataque, custo em energias e família evolutiva.
- `decks.mch`: define as duas sequências de 20 cartas e mantém o restante de cada baralho para compra.
- `Jogadores.mch`: mantém mão, ativo, banco, prêmios e descarte; oferece movimentos internos entre essas zonas.
- `jogoPokemon.mch`: expõe as operações da partida, controla turno e fase e mantém dano e energia por jogador/posição. Declara também o vencedor.
- `visualizacao/pokemon.svg`: desenha os dois campos.
- `visualizacao/pokemon.json`: associa os elementos gráficos a expressões B e os botões às operações de `jogoPokemon`.

As operações auxiliares das máquinas incluídas não são promovidas como ações da interface. Para jogar, use as operações da máquina principal, que verificam fase, turno, custos e evolução.

## Regras representadas

- Dois jogadores, cada um com um baralho de **20 cartas** nesta versão reduzida: 5 cartas na mão, 6 reservadas como prêmios e 9 restantes para compra.
- No máximo um ativo por jogador e cinco posições no banco. Cartas repetidas são mantidas em sequências.
- Uma compra obrigatória abre o turno. Depois ocorrem as ações principais e, se escolhido, um único ataque.
- Apenas Pokémon Básicos entram diretamente da mão no campo. A evolução exige mesma família e avanço de exatamente um estágio.
- Uma energia pode ser ligada por turno, no ativo ou no banco. O ataque exige a quantidade definida em `custo_dano` e aplica o dano definido em `dano_ataque`.
- A poção remove todo o dano do alvo, conforme a abstração existente.
- Depois de atacar, o jogador passa o turno se não houve nocaute. Se o dano foi letal, deve usar **Resolver nocaute**.
- O nocaute descarta o ativo derrotado, limpa seus contadores e leva um prêmio para a mão do atacante. Se o jogo continuar, o oponente sobe um Pokémon do banco antes de comprar.
- Ao subir um Pokémon do banco, seus contadores acompanham a carta; os índices dos contadores das outras posições são ajustados.
- Há vitória ao recolher o último prêmio, ao nocautear o último Pokémon em campo do oponente ou quando o adversário tenta realizar a compra obrigatória sem cartas no baralho. Apenas esvaziar o baralho não encerra a partida imediatamente.

Fluxo: **compra → principal → batalha → próxima compra**. Um nocaute pode levar a **reposição → compra** ou a **encerrada**. Também é possível passar a partir da fase principal.

## Roteiro curto de demonstração

Sem baixar Pokémon no banco nem evoluir:

1. Jogador 1: comprar; definir Squirtle como ativo; ligar Energia Água; passar.
2. Jogador 2: comprar; definir Elekid como ativo; ligar Energia Raio; atacar; passar.
3. Jogador 1: comprar; atacar; passar.
4. Jogador 2: comprar; atacar; resolver nocaute.

Resultado esperado: o Squirtle recebeu 80 de dano, sai do campo e vai para o descarte. O Jogador 2 recolhe um prêmio e vence porque o Jogador 1 não tem Pokémon no banco. A interface passa a exibir a vitória e as ações da partida deixam de estar habilitadas.

## Correções desta etapa

1. **Preparação das zonas:** os seis prêmios já eram separados da lista original, mas continuavam no restante comprável. O baralho restante agora ignora as primeiras onze posições, correspondentes à mão e aos prêmios.
2. **Nocaute e término da partida:** adicionados resolução de nocaute, reposição do ativo, limpeza de contadores e estado de vencedor. A consulta de vencedor só fica habilitada após o encerramento.
3. **Movimentação do banco:** adicionada promoção para o ativo e reindexação dos contadores. A promoção também funciona na fase principal, para não bloquear a preparação quando o único Básico foi colocado no banco primeiro.
4. **Preservação dos tipos:** o banco contém apenas Pokémon com HP definido; as operações auxiliares de evolução exigem que a nova carta também tenha HP.
5. **Passagem de turno:** impede pular a compra ou ignorar um nocaute pendente.

## Abstrações mantidas

Esta versão não reproduz todas as regras oficiais. Mantém 20 cartas e mão inicial de 5, preparação durante os primeiros turnos, ausência de embaralhamento e mulligan, evolução sem espera de um turno, energias contadas sem compatibilidade de tipo, cura total e evolução que envia a carta anterior ao descarte. Não implementa recuo, fraqueza, resistência, condições especiais, habilidades nem restrições especiais do primeiro turno.

As constantes de baralho foram preservadas, incluindo `wartotle` no segundo baralho. Os baralhos fornecidos não contêm poções nem todas as evoluções; testes específicos usam configurações temporárias para exercitar essas ações. Não há ação normal que cause dano ao banco, portanto a cura do banco não é alcançável pelos ataques atuais.

O modelo usa identificadores de tipos de carta, sem identificador individual para cada cópia. Dano e energia ficam associados ao jogador e à posição. Energias ligadas e treinadores consumidos não são preservados como cartas no descarte: conservação física completa das cartas permanece fora do modelo.

## Validação reproduzível

Na raiz, com Python 3 e o executável do ProB disponíveis:

```powershell
python ./tests/test_prob.py --probcli 'C:/caminho/ProB/probcli.exe'
```

Neste computador, a variável `JAVA_HOME` encontrada apontava para `C:/Program Files/Java`, que não contém `bin/java.exe`. Para executar os testes em uma sessão PowerShell, foi usado `$env:JAVA_HOME = "C:/Program Files/Java/jdk-22"`. A configuração permanente do computador não foi modificada.

Se necessário, configure `JAVA_HOME` e inclua a pasta `bin` do Java no `PATH`. A comunicação do analisador Java com o ProB utiliza uma conexão local.

O teste executa as operações **no ProB real**, testa rejeições por precondição e consulta `@INVARIANT` após cada tentativa. Ele não substitui o motor por uma simulação em Python. O parâmetro `--logs` permite escolher onde salvar os resultados.

Foram aprovados **8 cenários, com 339 consultas e tentativas de operação**, cobrindo inicialização, limites por turno, evolução válida/inválida, cura do ativo, nocaute, reposição e reindexação, último prêmio e compra impossível. Três cenários usam baralhos temporários; as constantes do projeto não são alteradas por eles.

Também foi feita uma exploração limitada a 500 estados analisados: 1.449 transições, sem violação de invariante ou bloqueio encontrado nesse limite. Restaram estados abertos; **não é uma verificação exaustiva nem substitui uma prova**. A checagem por restrições (`-cbc all`) encontrou um erro interno do ProB na resolução de uma operação incluída; esse resultado é inconclusivo.

A exportação VisB avaliou 119 vínculos de estado e 26 botões. A prévia foi renderizada a partir do estado inicial exportado pelo ProB. A interação por cliques no aplicativo ProB2-UI ainda precisa de validação manual antes da apresentação.

Evidências da execução estão em `validacao`. Versão utilizada do motor: ProB 1.16.1-final.

Documentação oficial: [VisB](https://prob.hhu.de/w/index.php?title=VisB) e [linha de comando do ProB](https://prob.hhu.de/w/index.php?title=Handbook/Command_Line).
