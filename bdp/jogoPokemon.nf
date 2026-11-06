Normalised(
THEORY MagicNumberX IS
  MagicNumber(Machine(jogoPokemon))==(3.5)
END
&
THEORY UpperLevelX IS
  First_Level(Machine(jogoPokemon))==(Machine(jogoPokemon));
  Level(Machine(jogoPokemon))==(0)
END
&
THEORY LoadedStructureX IS
  Machine(jogoPokemon)
END
&
THEORY ListSeesX IS
  List_Sees(Machine(jogoPokemon))==(?)
END
&
THEORY ListUsesX IS
  List_Uses(Machine(jogoPokemon))==(?)
END
&
THEORY ListIncludesX IS
  Inherited_List_Includes(Machine(jogoPokemon))==(Jogadores,cards);
  List_Includes(Machine(jogoPokemon))==(cards,Jogadores)
END
&
THEORY ListPromotesX IS
  List_Promotes(Machine(jogoPokemon))==(?)
END
&
THEORY ListExtendsX IS
  List_Extends(Machine(jogoPokemon))==(?)
END
&
THEORY ListVariablesX IS
  External_Context_List_Variables(Machine(jogoPokemon))==(?);
  Context_List_Variables(Machine(jogoPokemon))==(?);
  Abstract_List_Variables(Machine(jogoPokemon))==(?);
  Local_List_Variables(Machine(jogoPokemon))==(energia_jogada_turno,turno);
  List_Variables(Machine(jogoPokemon))==(energia_jogada_turno,turno,energia_ligada,dano,descarte,premios,banco,ativo,mao,deck);
  External_List_Variables(Machine(jogoPokemon))==(energia_jogada_turno,turno,energia_ligada,dano,descarte,premios,banco,ativo,mao,deck)
END
&
THEORY ListVisibleVariablesX IS
  Inherited_List_VisibleVariables(Machine(jogoPokemon))==(?);
  Abstract_List_VisibleVariables(Machine(jogoPokemon))==(?);
  External_List_VisibleVariables(Machine(jogoPokemon))==(?);
  Expanded_List_VisibleVariables(Machine(jogoPokemon))==(?);
  List_VisibleVariables(Machine(jogoPokemon))==(?);
  Internal_List_VisibleVariables(Machine(jogoPokemon))==(?)
END
&
THEORY ListInvariantX IS
  Gluing_Seen_List_Invariant(Machine(jogoPokemon))==(btrue);
  Gluing_List_Invariant(Machine(jogoPokemon))==(btrue);
  Abstract_List_Invariant(Machine(jogoPokemon))==(btrue);
  Expanded_List_Invariant(Machine(jogoPokemon))==(dano: CARTA +-> NAT & energia_ligada: CARTA +-> NAT & deck: JOGADOR --> seq(CARTA) & mao: JOGADOR --> POW(CARTA) & ativo: JOGADOR +-> CARTA & banco: JOGADOR --> POW(CARTA) & premios: JOGADOR --> POW(CARTA) & descarte: JOGADOR --> seq(CARTA) & !pp.(pp: JOGADOR => card(banco(pp))<=max_cartas_banco) & !pp.(pp: JOGADOR => card(premios(pp))<=max_cartas_premio));
  Context_List_Invariant(Machine(jogoPokemon))==(btrue);
  List_Invariant(Machine(jogoPokemon))==(turno: JOGADOR & energia_jogada_turno: BOOL)
END
&
THEORY ListAssertionsX IS
  Abstract_List_Assertions(Machine(jogoPokemon))==(btrue);
  Expanded_List_Assertions(Machine(jogoPokemon))==(btrue);
  Context_List_Assertions(Machine(jogoPokemon))==(btrue);
  List_Assertions(Machine(jogoPokemon))==(btrue)
END
&
THEORY ListCoverageX IS
  List_Coverage(Machine(jogoPokemon))==(btrue)
END
&
THEORY ListExclusivityX IS
  List_Exclusivity(Machine(jogoPokemon))==(btrue)
END
&
THEORY ListInitialisationX IS
  Expanded_List_Initialisation(Machine(jogoPokemon))==(dano,energia_ligada:={},{};(@(deck$0).(deck$0: JOGADOR --> {ss | ss: seq(CARTA) & size(ss) = max_cartas_deck} ==> deck:=deck$0) || mao:={jogador1|->{},jogador2|->{}} || ativo:={} || banco:={jogador1|->{},jogador2|->{}} || premios:={jogador1|->{},jogador2|->{}} || descarte:={jogador1|-><>,jogador2|-><>});turno,energia_jogada_turno:=jogador1,FALSE);
  Context_List_Initialisation(Machine(jogoPokemon))==(skip);
  List_Initialisation(Machine(jogoPokemon))==(turno:=jogador1 || energia_jogada_turno:=FALSE)
END
&
THEORY ListParametersX IS
  List_Parameters(Machine(jogoPokemon))==(?)
END
&
THEORY ListInstanciatedParametersX IS
  List_Instanciated_Parameters(Machine(jogoPokemon),Machine(cards))==(?);
  List_Instanciated_Parameters(Machine(jogoPokemon),Machine(Jogadores))==(?)
END
&
THEORY ListConstraintsX IS
  List_Constraints(Machine(jogoPokemon),Machine(Jogadores))==(btrue);
  List_Context_Constraints(Machine(jogoPokemon))==(btrue);
  List_Constraints(Machine(jogoPokemon))==(btrue);
  List_Constraints(Machine(jogoPokemon),Machine(cards))==(btrue)
END
&
THEORY ListOperationsX IS
  Internal_List_Operations(Machine(jogoPokemon))==(comprar_carta_turno,baixar_pokemon,jogar_energia,atacar_oponente,passar_turno);
  List_Operations(Machine(jogoPokemon))==(comprar_carta_turno,baixar_pokemon,jogar_energia,atacar_oponente,passar_turno)
END
&
THEORY ListInputX IS
  List_Input(Machine(jogoPokemon),comprar_carta_turno)==(pp);
  List_Input(Machine(jogoPokemon),baixar_pokemon)==(pp,cc);
  List_Input(Machine(jogoPokemon),jogar_energia)==(pp,cc_energia,cc_alvo);
  List_Input(Machine(jogoPokemon),atacar_oponente)==(pp,valor_dano);
  List_Input(Machine(jogoPokemon),passar_turno)==(pp)
END
&
THEORY ListOutputX IS
  List_Output(Machine(jogoPokemon),comprar_carta_turno)==(?);
  List_Output(Machine(jogoPokemon),baixar_pokemon)==(?);
  List_Output(Machine(jogoPokemon),jogar_energia)==(?);
  List_Output(Machine(jogoPokemon),atacar_oponente)==(?);
  List_Output(Machine(jogoPokemon),passar_turno)==(?)
END
&
THEORY ListHeaderX IS
  List_Header(Machine(jogoPokemon),comprar_carta_turno)==(comprar_carta_turno(pp));
  List_Header(Machine(jogoPokemon),baixar_pokemon)==(baixar_pokemon(pp,cc));
  List_Header(Machine(jogoPokemon),jogar_energia)==(jogar_energia(pp,cc_energia,cc_alvo));
  List_Header(Machine(jogoPokemon),atacar_oponente)==(atacar_oponente(pp,valor_dano));
  List_Header(Machine(jogoPokemon),passar_turno)==(passar_turno(pp))
END
&
THEORY ListOperationGuardX END
&
THEORY ListPreconditionX IS
  List_Precondition(Machine(jogoPokemon),comprar_carta_turno)==(pp: JOGADOR & pp = turno);
  List_Precondition(Machine(jogoPokemon),baixar_pokemon)==(pp: JOGADOR & pp = turno & cc: CARTA & cc: mao(pp));
  List_Precondition(Machine(jogoPokemon),jogar_energia)==(pp: JOGADOR & pp = turno & cc_energia: CARTA & cc_energia: mao(pp) & cc_alvo: CARTA & tipo_da_carta(cc_energia) = Energia & energia_jogada_turno = FALSE & (cc_alvo = ativo(pp) or cc_alvo: banco(pp)));
  List_Precondition(Machine(jogoPokemon),atacar_oponente)==(pp: JOGADOR & pp = turno & valor_dano: NAT1 & pp: dom(ativo));
  List_Precondition(Machine(jogoPokemon),passar_turno)==(pp: JOGADOR & pp = turno)
END
&
THEORY ListSubstitutionX IS
  Expanded_List_Substitution(Machine(jogoPokemon),passar_turno)==(pp: JOGADOR & pp = turno | pp = jogador1 ==> turno:=jogador2 [] not(pp = jogador1) ==> turno:=jogador1 || energia_jogada_turno:=FALSE);
  Expanded_List_Substitution(Machine(jogoPokemon),atacar_oponente)==(pp: JOGADOR & pp = turno & valor_dano: NAT1 & pp: dom(ativo) | @oponente.(oponente: JOGADOR & oponente/=pp & oponente: dom(ativo) ==> (ativo(oponente): CARTA & ativo(oponente): dom(hp_base) & valor_dano: NAT1 | ativo(oponente): dom(dano) ==> dano:=dano<+{ativo(oponente)|->dano(ativo(oponente))+valor_dano} [] not(ativo(oponente): dom(dano)) ==> dano:=dano<+{ativo(oponente)|->valor_dano})));
  Expanded_List_Substitution(Machine(jogoPokemon),jogar_energia)==(pp: JOGADOR & pp = turno & cc_energia: CARTA & cc_energia: mao(pp) & cc_alvo: CARTA & tipo_da_carta(cc_energia) = Energia & energia_jogada_turno = FALSE & (cc_alvo = ativo(pp) or cc_alvo: banco(pp)) & cc_alvo: CARTA & pp: JOGADOR & cc_energia: mao(pp) | cc_alvo: dom(energia_ligada) ==> energia_ligada:=energia_ligada<+{cc_alvo|->energia_ligada(cc_alvo)+1} [] not(cc_alvo: dom(energia_ligada)) ==> energia_ligada:=energia_ligada<+{cc_alvo|->1} || mao:=mao<+{pp|->mao(pp)-{cc_energia}} || energia_jogada_turno:=TRUE);
  Expanded_List_Substitution(Machine(jogoPokemon),baixar_pokemon)==(pp: JOGADOR & pp = turno & cc: CARTA & cc: mao(pp) & pp: JOGADOR & cc: mao(pp) & tipo_da_carta(cc) = Pokemon & estagio_pokemon(cc) = Basico & card(banco(pp))<max_cartas_banco | banco,mao:=banco<+{pp|->(banco(pp)\/{cc})},mao<+{pp|->mao(pp)-{cc}});
  Expanded_List_Substitution(Machine(jogoPokemon),comprar_carta_turno)==(pp: JOGADOR & pp = turno & pp: JOGADOR & size(deck(pp))>0 | mao,deck:=mao<+{pp|->(mao(pp)\/{first(deck(pp))})},deck<+{pp|->tail(deck(pp))});
  List_Substitution(Machine(jogoPokemon),comprar_carta_turno)==(comprar_carta_jogador(pp));
  List_Substitution(Machine(jogoPokemon),baixar_pokemon)==(mover_mao_para_banco(pp,cc));
  List_Substitution(Machine(jogoPokemon),jogar_energia)==(adicionar_energia(cc_alvo) || remover_carta_mao(pp,cc_energia) || energia_jogada_turno:=TRUE);
  List_Substitution(Machine(jogoPokemon),atacar_oponente)==(ANY oponente WHERE oponente: JOGADOR & oponente/=pp & oponente: dom(ativo) THEN aplicar_dano(ativo(oponente),valor_dano) END);
  List_Substitution(Machine(jogoPokemon),passar_turno)==(IF pp = jogador1 THEN turno:=jogador2 ELSE turno:=jogador1 END || energia_jogada_turno:=FALSE)
END
&
THEORY ListConstantsX IS
  List_Valuable_Constants(Machine(jogoPokemon))==(tipo_da_carta,estagio_pokemon,hp_base,max_cartas_deck,max_cartas_banco,max_cartas_premio);
  Inherited_List_Constants(Machine(jogoPokemon))==(tipo_da_carta,estagio_pokemon,hp_base,max_cartas_deck,max_cartas_banco,max_cartas_premio);
  List_Constants(Machine(jogoPokemon))==(?)
END
&
THEORY ListSetsX IS
  Set_Definition(Machine(jogoPokemon),JOGADOR)==({jogador1,jogador2});
  Context_List_Enumerated(Machine(jogoPokemon))==(?);
  Context_List_Defered(Machine(jogoPokemon))==(?);
  Context_List_Sets(Machine(jogoPokemon))==(?);
  List_Valuable_Sets(Machine(jogoPokemon))==(CARTA);
  Inherited_List_Enumerated(Machine(jogoPokemon))==(TIPO_CARTA,ESTAGIO,JOGADOR);
  Inherited_List_Defered(Machine(jogoPokemon))==(CARTA);
  Inherited_List_Sets(Machine(jogoPokemon))==(TIPO_CARTA,ESTAGIO,CARTA,JOGADOR);
  List_Enumerated(Machine(jogoPokemon))==(?);
  List_Defered(Machine(jogoPokemon))==(?);
  List_Sets(Machine(jogoPokemon))==(?);
  Set_Definition(Machine(jogoPokemon),ESTAGIO)==({Basico,Estagio1,Estagio2});
  Set_Definition(Machine(jogoPokemon),TIPO_CARTA)==({Pokemon,Energia,Treinador});
  Set_Definition(Machine(jogoPokemon),CARTA)==(?)
END
&
THEORY ListHiddenConstantsX IS
  Abstract_List_HiddenConstants(Machine(jogoPokemon))==(?);
  Expanded_List_HiddenConstants(Machine(jogoPokemon))==(?);
  List_HiddenConstants(Machine(jogoPokemon))==(?);
  External_List_HiddenConstants(Machine(jogoPokemon))==(?)
END
&
THEORY ListPropertiesX IS
  Abstract_List_Properties(Machine(jogoPokemon))==(btrue);
  Context_List_Properties(Machine(jogoPokemon))==(btrue);
  Inherited_List_Properties(Machine(jogoPokemon))==(tipo_da_carta: CARTA --> TIPO_CARTA & estagio_pokemon: CARTA +-> ESTAGIO & hp_base: CARTA +-> NAT1 & dom(estagio_pokemon) = tipo_da_carta~[{Pokemon}] & dom(hp_base) = tipo_da_carta~[{Pokemon}] & CARTA: FIN(INTEGER) & not(CARTA = {}) & TIPO_CARTA: FIN(INTEGER) & not(TIPO_CARTA = {}) & ESTAGIO: FIN(INTEGER) & not(ESTAGIO = {}) & max_cartas_deck = 60 & max_cartas_banco = 5 & max_cartas_premio = 6 & JOGADOR: FIN(INTEGER) & not(JOGADOR = {}));
  List_Properties(Machine(jogoPokemon))==(btrue)
END
&
THEORY ListSeenInfoX END
&
THEORY ListANYVarX IS
  List_ANY_Var(Machine(jogoPokemon),comprar_carta_turno)==(?);
  List_ANY_Var(Machine(jogoPokemon),baixar_pokemon)==(?);
  List_ANY_Var(Machine(jogoPokemon),jogar_energia)==(?);
  List_ANY_Var(Machine(jogoPokemon),atacar_oponente)==(Var(oponente) == etype(JOGADOR,?,?));
  List_ANY_Var(Machine(jogoPokemon),passar_turno)==(?)
END
&
THEORY ListOfIdsX IS
  List_Of_Ids(Machine(jogoPokemon)) == (? | max_cartas_deck,max_cartas_banco,max_cartas_premio,JOGADOR,jogador1,jogador2,tipo_da_carta,estagio_pokemon,hp_base,TIPO_CARTA,ESTAGIO,CARTA,Pokemon,Energia,Treinador,Basico,Estagio1,Estagio2 | energia_jogada_turno,turno | descarte,premios,banco,ativo,mao,deck,energia_ligada,dano | comprar_carta_turno,baixar_pokemon,jogar_energia,atacar_oponente,passar_turno | ? | included(Machine(cards)),included(Machine(Jogadores)) | ? | jogoPokemon);
  List_Of_HiddenCst_Ids(Machine(jogoPokemon)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(jogoPokemon)) == (max_cartas_deck,max_cartas_banco,max_cartas_premio,tipo_da_carta,estagio_pokemon,hp_base);
  List_Of_VisibleVar_Ids(Machine(jogoPokemon)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(jogoPokemon)) == (seen(Machine(cards)): (tipo_da_carta,estagio_pokemon,hp_base,TIPO_CARTA,ESTAGIO,CARTA,Pokemon,Energia,Treinador,Basico,Estagio1,Estagio2 | ? | energia_ligada,dano | ? | ? | ? | ? | ? | ?));
  List_Of_Ids(Machine(Jogadores)) == (max_cartas_deck,max_cartas_banco,max_cartas_premio,JOGADOR,jogador1,jogador2 | ? | descarte,premios,banco,ativo,mao,deck | ? | comprar_carta_jogador,mover_mao_para_banco,remover_carta_mao,definir_ativo | ? | seen(Machine(cards)) | ? | Jogadores);
  List_Of_HiddenCst_Ids(Machine(Jogadores)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(Jogadores)) == (max_cartas_deck,max_cartas_banco,max_cartas_premio);
  List_Of_VisibleVar_Ids(Machine(Jogadores)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(Jogadores)) == (?: ?);
  List_Of_Ids(Machine(cards)) == (tipo_da_carta,estagio_pokemon,hp_base,TIPO_CARTA,ESTAGIO,CARTA,Pokemon,Energia,Treinador,Basico,Estagio1,Estagio2 | ? | energia_ligada,dano | ? | aplicar_dano,adicionar_energia,resetar_carta | ? | ? | ? | cards);
  List_Of_HiddenCst_Ids(Machine(cards)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(cards)) == (tipo_da_carta,estagio_pokemon,hp_base);
  List_Of_VisibleVar_Ids(Machine(cards)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(cards)) == (?: ?)
END
&
THEORY SetsEnvX IS
  Sets(Machine(jogoPokemon)) == (Type(CARTA) == Cst(SetOf(atype(CARTA,"[CARTA","]CARTA")));Type(ESTAGIO) == Cst(SetOf(etype(ESTAGIO,0,2)));Type(TIPO_CARTA) == Cst(SetOf(etype(TIPO_CARTA,0,2)));Type(JOGADOR) == Cst(SetOf(etype(JOGADOR,0,1))))
END
&
THEORY ConstantsEnvX IS
  Constants(Machine(jogoPokemon)) == (Type(hp_base) == Cst(SetOf(atype(CARTA,?,?)*btype(INTEGER,?,?)));Type(estagio_pokemon) == Cst(SetOf(atype(CARTA,?,?)*etype(ESTAGIO,?,?)));Type(tipo_da_carta) == Cst(SetOf(atype(CARTA,"[CARTA","]CARTA")*etype(TIPO_CARTA,0,2)));Type(Estagio2) == Cst(etype(ESTAGIO,0,2));Type(Estagio1) == Cst(etype(ESTAGIO,0,2));Type(Basico) == Cst(etype(ESTAGIO,0,2));Type(Treinador) == Cst(etype(TIPO_CARTA,0,2));Type(Energia) == Cst(etype(TIPO_CARTA,0,2));Type(Pokemon) == Cst(etype(TIPO_CARTA,0,2));Type(max_cartas_premio) == Cst(btype(INTEGER,?,?));Type(max_cartas_banco) == Cst(btype(INTEGER,?,?));Type(max_cartas_deck) == Cst(btype(INTEGER,?,?));Type(jogador2) == Cst(etype(JOGADOR,0,1));Type(jogador1) == Cst(etype(JOGADOR,0,1)))
END
&
THEORY VariablesEnvX IS
  Variables(Machine(jogoPokemon)) == (Type(dano) == Mvl(SetOf(atype(CARTA,?,?)*btype(INTEGER,?,?)));Type(energia_ligada) == Mvl(SetOf(atype(CARTA,?,?)*btype(INTEGER,?,?)));Type(deck) == Mvl(SetOf(etype(JOGADOR,0,1)*SetOf(btype(INTEGER,?,?)*atype(CARTA,?,?))));Type(mao) == Mvl(SetOf(etype(JOGADOR,0,1)*SetOf(atype(CARTA,"[CARTA","]CARTA"))));Type(ativo) == Mvl(SetOf(etype(JOGADOR,?,?)*atype(CARTA,?,?)));Type(banco) == Mvl(SetOf(etype(JOGADOR,0,1)*SetOf(atype(CARTA,"[CARTA","]CARTA"))));Type(premios) == Mvl(SetOf(etype(JOGADOR,0,1)*SetOf(atype(CARTA,"[CARTA","]CARTA"))));Type(descarte) == Mvl(SetOf(etype(JOGADOR,0,1)*SetOf(btype(INTEGER,?,?)*atype(CARTA,?,?))));Type(energia_jogada_turno) == Mvl(btype(BOOL,?,?));Type(turno) == Mvl(etype(JOGADOR,?,?)))
END
&
THEORY OperationsEnvX IS
  Operations(Machine(jogoPokemon)) == (Type(passar_turno) == Cst(No_type,etype(JOGADOR,?,?));Type(atacar_oponente) == Cst(No_type,etype(JOGADOR,?,?)*btype(INTEGER,?,?));Type(jogar_energia) == Cst(No_type,etype(JOGADOR,?,?)*atype(CARTA,?,?)*atype(CARTA,?,?));Type(baixar_pokemon) == Cst(No_type,etype(JOGADOR,?,?)*atype(CARTA,?,?));Type(comprar_carta_turno) == Cst(No_type,etype(JOGADOR,?,?)))
END
&
THEORY TCIntRdX IS
  predB0 == OK;
  extended_sees == KO;
  B0check_tab == KO;
  local_op == OK;
  abstract_constants_visible_in_values == KO;
  project_type == SOFTWARE_TYPE;
  event_b_deadlockfreeness == KO;
  variant_clause_mandatory == KO;
  event_b_coverage == KO;
  event_b_exclusivity == KO;
  genFeasibilityPO == KO
END
)
