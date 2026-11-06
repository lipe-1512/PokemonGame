Normalised(
THEORY MagicNumberX IS
  MagicNumber(Machine(Jogadores))==(3.5)
END
&
THEORY UpperLevelX IS
  First_Level(Machine(Jogadores))==(Machine(Jogadores));
  Level(Machine(Jogadores))==(0)
END
&
THEORY LoadedStructureX IS
  Machine(Jogadores)
END
&
THEORY ListSeesX IS
  List_Sees(Machine(Jogadores))==(cards)
END
&
THEORY ListUsesX IS
  List_Uses(Machine(Jogadores))==(?)
END
&
THEORY ListIncludesX IS
  Inherited_List_Includes(Machine(Jogadores))==(?);
  List_Includes(Machine(Jogadores))==(?)
END
&
THEORY ListPromotesX IS
  List_Promotes(Machine(Jogadores))==(?)
END
&
THEORY ListExtendsX IS
  List_Extends(Machine(Jogadores))==(?)
END
&
THEORY ListVariablesX IS
  External_Context_List_Variables(Machine(Jogadores))==(?);
  Context_List_Variables(Machine(Jogadores))==(?);
  Abstract_List_Variables(Machine(Jogadores))==(?);
  Local_List_Variables(Machine(Jogadores))==(descarte,premios,banco,ativo,mao,deck);
  List_Variables(Machine(Jogadores))==(descarte,premios,banco,ativo,mao,deck);
  External_List_Variables(Machine(Jogadores))==(descarte,premios,banco,ativo,mao,deck)
END
&
THEORY ListVisibleVariablesX IS
  Inherited_List_VisibleVariables(Machine(Jogadores))==(?);
  Abstract_List_VisibleVariables(Machine(Jogadores))==(?);
  External_List_VisibleVariables(Machine(Jogadores))==(?);
  Expanded_List_VisibleVariables(Machine(Jogadores))==(?);
  List_VisibleVariables(Machine(Jogadores))==(?);
  Internal_List_VisibleVariables(Machine(Jogadores))==(?)
END
&
THEORY ListInvariantX IS
  Gluing_Seen_List_Invariant(Machine(Jogadores))==(btrue);
  Gluing_List_Invariant(Machine(Jogadores))==(btrue);
  Expanded_List_Invariant(Machine(Jogadores))==(btrue);
  Abstract_List_Invariant(Machine(Jogadores))==(btrue);
  Context_List_Invariant(Machine(Jogadores))==(dano: CARTA +-> NAT & energia_ligada: CARTA +-> NAT);
  List_Invariant(Machine(Jogadores))==(deck: JOGADOR --> seq(CARTA) & mao: JOGADOR --> POW(CARTA) & ativo: JOGADOR +-> CARTA & banco: JOGADOR --> POW(CARTA) & premios: JOGADOR --> POW(CARTA) & descarte: JOGADOR --> seq(CARTA) & !pp.(pp: JOGADOR => card(banco(pp))<=max_cartas_banco) & !pp.(pp: JOGADOR => card(premios(pp))<=max_cartas_premio))
END
&
THEORY ListAssertionsX IS
  Expanded_List_Assertions(Machine(Jogadores))==(btrue);
  Abstract_List_Assertions(Machine(Jogadores))==(btrue);
  Context_List_Assertions(Machine(Jogadores))==(btrue);
  List_Assertions(Machine(Jogadores))==(btrue)
END
&
THEORY ListCoverageX IS
  List_Coverage(Machine(Jogadores))==(btrue)
END
&
THEORY ListExclusivityX IS
  List_Exclusivity(Machine(Jogadores))==(btrue)
END
&
THEORY ListInitialisationX IS
  Expanded_List_Initialisation(Machine(Jogadores))==(@(deck$0).(deck$0: JOGADOR --> {ss | ss: seq(CARTA) & size(ss) = max_cartas_deck} ==> deck:=deck$0) || mao:={jogador1|->{},jogador2|->{}} || ativo:={} || banco:={jogador1|->{},jogador2|->{}} || premios:={jogador1|->{},jogador2|->{}} || descarte:={jogador1|-><>,jogador2|-><>});
  Context_List_Initialisation(Machine(Jogadores))==(skip);
  List_Initialisation(Machine(Jogadores))==(deck:: JOGADOR --> {ss | ss: seq(CARTA) & size(ss) = max_cartas_deck} || mao:={jogador1|->{},jogador2|->{}} || ativo:={} || banco:={jogador1|->{},jogador2|->{}} || premios:={jogador1|->{},jogador2|->{}} || descarte:={jogador1|-><>,jogador2|-><>})
END
&
THEORY ListParametersX IS
  List_Parameters(Machine(Jogadores))==(?)
END
&
THEORY ListInstanciatedParametersX IS
  List_Instanciated_Parameters(Machine(Jogadores),Machine(cards))==(?)
END
&
THEORY ListConstraintsX IS
  List_Context_Constraints(Machine(Jogadores))==(btrue);
  List_Constraints(Machine(Jogadores))==(btrue)
END
&
THEORY ListOperationsX IS
  Internal_List_Operations(Machine(Jogadores))==(comprar_carta_jogador,mover_mao_para_banco,remover_carta_mao,definir_ativo);
  List_Operations(Machine(Jogadores))==(comprar_carta_jogador,mover_mao_para_banco,remover_carta_mao,definir_ativo)
END
&
THEORY ListInputX IS
  List_Input(Machine(Jogadores),comprar_carta_jogador)==(pp);
  List_Input(Machine(Jogadores),mover_mao_para_banco)==(pp,cc);
  List_Input(Machine(Jogadores),remover_carta_mao)==(pp,cc);
  List_Input(Machine(Jogadores),definir_ativo)==(pp,cc)
END
&
THEORY ListOutputX IS
  List_Output(Machine(Jogadores),comprar_carta_jogador)==(?);
  List_Output(Machine(Jogadores),mover_mao_para_banco)==(?);
  List_Output(Machine(Jogadores),remover_carta_mao)==(?);
  List_Output(Machine(Jogadores),definir_ativo)==(?)
END
&
THEORY ListHeaderX IS
  List_Header(Machine(Jogadores),comprar_carta_jogador)==(comprar_carta_jogador(pp));
  List_Header(Machine(Jogadores),mover_mao_para_banco)==(mover_mao_para_banco(pp,cc));
  List_Header(Machine(Jogadores),remover_carta_mao)==(remover_carta_mao(pp,cc));
  List_Header(Machine(Jogadores),definir_ativo)==(definir_ativo(pp,cc))
END
&
THEORY ListOperationGuardX END
&
THEORY ListPreconditionX IS
  List_Precondition(Machine(Jogadores),comprar_carta_jogador)==(pp: JOGADOR & size(deck(pp))>0);
  List_Precondition(Machine(Jogadores),mover_mao_para_banco)==(pp: JOGADOR & cc: mao(pp) & tipo_da_carta(cc) = Pokemon & estagio_pokemon(cc) = Basico & card(banco(pp))<max_cartas_banco);
  List_Precondition(Machine(Jogadores),remover_carta_mao)==(pp: JOGADOR & cc: mao(pp));
  List_Precondition(Machine(Jogadores),definir_ativo)==(pp: JOGADOR & pp/:dom(ativo) & cc: mao(pp) & tipo_da_carta(cc) = Pokemon)
END
&
THEORY ListSubstitutionX IS
  Expanded_List_Substitution(Machine(Jogadores),definir_ativo)==(pp: JOGADOR & pp/:dom(ativo) & cc: mao(pp) & tipo_da_carta(cc) = Pokemon | ativo,mao:=ativo<+{pp|->cc},mao<+{pp|->mao(pp)-{cc}});
  Expanded_List_Substitution(Machine(Jogadores),remover_carta_mao)==(pp: JOGADOR & cc: mao(pp) | mao:=mao<+{pp|->mao(pp)-{cc}});
  Expanded_List_Substitution(Machine(Jogadores),mover_mao_para_banco)==(pp: JOGADOR & cc: mao(pp) & tipo_da_carta(cc) = Pokemon & estagio_pokemon(cc) = Basico & card(banco(pp))<max_cartas_banco | banco,mao:=banco<+{pp|->(banco(pp)\/{cc})},mao<+{pp|->mao(pp)-{cc}});
  Expanded_List_Substitution(Machine(Jogadores),comprar_carta_jogador)==(pp: JOGADOR & size(deck(pp))>0 | mao,deck:=mao<+{pp|->(mao(pp)\/{first(deck(pp))})},deck<+{pp|->tail(deck(pp))});
  List_Substitution(Machine(Jogadores),comprar_carta_jogador)==(mao(pp):=mao(pp)\/{first(deck(pp))} || deck(pp):=tail(deck(pp)));
  List_Substitution(Machine(Jogadores),mover_mao_para_banco)==(banco(pp):=banco(pp)\/{cc} || mao(pp):=mao(pp)-{cc});
  List_Substitution(Machine(Jogadores),remover_carta_mao)==(mao(pp):=mao(pp)-{cc});
  List_Substitution(Machine(Jogadores),definir_ativo)==(ativo(pp):=cc || mao(pp):=mao(pp)-{cc})
END
&
THEORY ListConstantsX IS
  List_Valuable_Constants(Machine(Jogadores))==(max_cartas_deck,max_cartas_banco,max_cartas_premio);
  Inherited_List_Constants(Machine(Jogadores))==(?);
  List_Constants(Machine(Jogadores))==(max_cartas_deck,max_cartas_banco,max_cartas_premio)
END
&
THEORY ListSetsX IS
  Set_Definition(Machine(Jogadores),ESTAGIO)==({Basico,Estagio1,Estagio2});
  Context_List_Enumerated(Machine(Jogadores))==(TIPO_CARTA,ESTAGIO);
  Context_List_Defered(Machine(Jogadores))==(CARTA);
  Context_List_Sets(Machine(Jogadores))==(TIPO_CARTA,ESTAGIO,CARTA);
  List_Valuable_Sets(Machine(Jogadores))==(?);
  Inherited_List_Enumerated(Machine(Jogadores))==(?);
  Inherited_List_Defered(Machine(Jogadores))==(?);
  Inherited_List_Sets(Machine(Jogadores))==(?);
  List_Enumerated(Machine(Jogadores))==(JOGADOR);
  List_Defered(Machine(Jogadores))==(?);
  List_Sets(Machine(Jogadores))==(JOGADOR);
  Set_Definition(Machine(Jogadores),TIPO_CARTA)==({Pokemon,Energia,Treinador});
  Set_Definition(Machine(Jogadores),JOGADOR)==({jogador1,jogador2})
END
&
THEORY ListHiddenConstantsX IS
  Abstract_List_HiddenConstants(Machine(Jogadores))==(?);
  Expanded_List_HiddenConstants(Machine(Jogadores))==(?);
  List_HiddenConstants(Machine(Jogadores))==(?);
  External_List_HiddenConstants(Machine(Jogadores))==(?)
END
&
THEORY ListPropertiesX IS
  Abstract_List_Properties(Machine(Jogadores))==(btrue);
  Context_List_Properties(Machine(Jogadores))==(tipo_da_carta: CARTA --> TIPO_CARTA & estagio_pokemon: CARTA +-> ESTAGIO & hp_base: CARTA +-> NAT1 & dom(estagio_pokemon) = tipo_da_carta~[{Pokemon}] & dom(hp_base) = tipo_da_carta~[{Pokemon}] & CARTA: FIN(INTEGER) & not(CARTA = {}) & TIPO_CARTA: FIN(INTEGER) & not(TIPO_CARTA = {}) & ESTAGIO: FIN(INTEGER) & not(ESTAGIO = {}));
  Inherited_List_Properties(Machine(Jogadores))==(btrue);
  List_Properties(Machine(Jogadores))==(max_cartas_deck = 60 & max_cartas_banco = 5 & max_cartas_premio = 6 & JOGADOR: FIN(INTEGER) & not(JOGADOR = {}))
END
&
THEORY ListSeenInfoX IS
  Seen_Internal_List_Operations(Machine(Jogadores),Machine(cards))==(aplicar_dano,adicionar_energia,resetar_carta);
  Seen_Context_List_Enumerated(Machine(Jogadores))==(?);
  Seen_Context_List_Invariant(Machine(Jogadores))==(btrue);
  Seen_Context_List_Assertions(Machine(Jogadores))==(btrue);
  Seen_Context_List_Properties(Machine(Jogadores))==(btrue);
  Seen_List_Constraints(Machine(Jogadores))==(btrue);
  Seen_List_Precondition(Machine(Jogadores),resetar_carta)==(cc: CARTA);
  Seen_Expanded_List_Substitution(Machine(Jogadores),resetar_carta)==(dano,energia_ligada:={cc}<<|dano,{cc}<<|energia_ligada);
  Seen_List_Precondition(Machine(Jogadores),adicionar_energia)==(cc: CARTA);
  Seen_Expanded_List_Substitution(Machine(Jogadores),adicionar_energia)==(cc: dom(energia_ligada) ==> energia_ligada:=energia_ligada<+{cc|->energia_ligada(cc)+1} [] not(cc: dom(energia_ligada)) ==> energia_ligada:=energia_ligada<+{cc|->1});
  Seen_List_Precondition(Machine(Jogadores),aplicar_dano)==(cc: CARTA & cc: dom(hp_base) & valor: NAT1);
  Seen_Expanded_List_Substitution(Machine(Jogadores),aplicar_dano)==(cc: dom(dano) ==> dano:=dano<+{cc|->dano(cc)+valor} [] not(cc: dom(dano)) ==> dano:=dano<+{cc|->valor});
  Seen_List_Operations(Machine(Jogadores),Machine(cards))==(aplicar_dano,adicionar_energia,resetar_carta);
  Seen_Expanded_List_Invariant(Machine(Jogadores),Machine(cards))==(btrue)
END
&
THEORY ListANYVarX IS
  List_ANY_Var(Machine(Jogadores),comprar_carta_jogador)==(?);
  List_ANY_Var(Machine(Jogadores),mover_mao_para_banco)==(?);
  List_ANY_Var(Machine(Jogadores),remover_carta_mao)==(?);
  List_ANY_Var(Machine(Jogadores),definir_ativo)==(?)
END
&
THEORY ListOfIdsX IS
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
  Sets(Machine(Jogadores)) == (Type(JOGADOR) == Cst(SetOf(etype(JOGADOR,0,1))))
END
&
THEORY ConstantsEnvX IS
  Constants(Machine(Jogadores)) == (Type(jogador1) == Cst(etype(JOGADOR,0,1));Type(jogador2) == Cst(etype(JOGADOR,0,1));Type(max_cartas_deck) == Cst(btype(INTEGER,?,?));Type(max_cartas_banco) == Cst(btype(INTEGER,?,?));Type(max_cartas_premio) == Cst(btype(INTEGER,?,?)))
END
&
THEORY VariablesEnvX IS
  Variables(Machine(Jogadores)) == (Type(descarte) == Mvl(SetOf(etype(JOGADOR,0,1)*SetOf(btype(INTEGER,?,?)*atype(CARTA,?,?))));Type(premios) == Mvl(SetOf(etype(JOGADOR,0,1)*SetOf(atype(CARTA,"[CARTA","]CARTA"))));Type(banco) == Mvl(SetOf(etype(JOGADOR,0,1)*SetOf(atype(CARTA,"[CARTA","]CARTA"))));Type(ativo) == Mvl(SetOf(etype(JOGADOR,?,?)*atype(CARTA,?,?)));Type(mao) == Mvl(SetOf(etype(JOGADOR,0,1)*SetOf(atype(CARTA,"[CARTA","]CARTA"))));Type(deck) == Mvl(SetOf(etype(JOGADOR,0,1)*SetOf(btype(INTEGER,?,?)*atype(CARTA,?,?)))))
END
&
THEORY OperationsEnvX IS
  Operations(Machine(Jogadores)) == (Type(definir_ativo) == Cst(No_type,etype(JOGADOR,?,?)*atype(CARTA,?,?));Type(remover_carta_mao) == Cst(No_type,etype(JOGADOR,?,?)*atype(CARTA,?,?));Type(mover_mao_para_banco) == Cst(No_type,etype(JOGADOR,?,?)*atype(CARTA,?,?));Type(comprar_carta_jogador) == Cst(No_type,etype(JOGADOR,?,?)))
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
