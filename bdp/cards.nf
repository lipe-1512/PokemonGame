Normalised(
THEORY MagicNumberX IS
  MagicNumber(Machine(cards))==(3.5)
END
&
THEORY UpperLevelX IS
  First_Level(Machine(cards))==(Machine(cards));
  Level(Machine(cards))==(0)
END
&
THEORY LoadedStructureX IS
  Machine(cards)
END
&
THEORY ListSeesX IS
  List_Sees(Machine(cards))==(?)
END
&
THEORY ListUsesX IS
  List_Uses(Machine(cards))==(?)
END
&
THEORY ListIncludesX IS
  Inherited_List_Includes(Machine(cards))==(?);
  List_Includes(Machine(cards))==(?)
END
&
THEORY ListPromotesX IS
  List_Promotes(Machine(cards))==(?)
END
&
THEORY ListExtendsX IS
  List_Extends(Machine(cards))==(?)
END
&
THEORY ListVariablesX IS
  External_Context_List_Variables(Machine(cards))==(?);
  Context_List_Variables(Machine(cards))==(?);
  Abstract_List_Variables(Machine(cards))==(?);
  Local_List_Variables(Machine(cards))==(energia_ligada,dano);
  List_Variables(Machine(cards))==(energia_ligada,dano);
  External_List_Variables(Machine(cards))==(energia_ligada,dano)
END
&
THEORY ListVisibleVariablesX IS
  Inherited_List_VisibleVariables(Machine(cards))==(?);
  Abstract_List_VisibleVariables(Machine(cards))==(?);
  External_List_VisibleVariables(Machine(cards))==(?);
  Expanded_List_VisibleVariables(Machine(cards))==(?);
  List_VisibleVariables(Machine(cards))==(?);
  Internal_List_VisibleVariables(Machine(cards))==(?)
END
&
THEORY ListInvariantX IS
  Gluing_Seen_List_Invariant(Machine(cards))==(btrue);
  Gluing_List_Invariant(Machine(cards))==(btrue);
  Expanded_List_Invariant(Machine(cards))==(btrue);
  Abstract_List_Invariant(Machine(cards))==(btrue);
  Context_List_Invariant(Machine(cards))==(btrue);
  List_Invariant(Machine(cards))==(dano: CARTA +-> NAT & energia_ligada: CARTA +-> NAT & dom(dano) <: dom(hp_base))
END
&
THEORY ListAssertionsX IS
  Expanded_List_Assertions(Machine(cards))==(btrue);
  Abstract_List_Assertions(Machine(cards))==(btrue);
  Context_List_Assertions(Machine(cards))==(btrue);
  List_Assertions(Machine(cards))==(btrue)
END
&
THEORY ListCoverageX IS
  List_Coverage(Machine(cards))==(btrue)
END
&
THEORY ListExclusivityX IS
  List_Exclusivity(Machine(cards))==(btrue)
END
&
THEORY ListInitialisationX IS
  Expanded_List_Initialisation(Machine(cards))==(dano,energia_ligada:={},{});
  Context_List_Initialisation(Machine(cards))==(skip);
  List_Initialisation(Machine(cards))==(dano:={} || energia_ligada:={})
END
&
THEORY ListParametersX IS
  List_Parameters(Machine(cards))==(?)
END
&
THEORY ListInstanciatedParametersX END
&
THEORY ListConstraintsX IS
  List_Context_Constraints(Machine(cards))==(btrue);
  List_Constraints(Machine(cards))==(btrue)
END
&
THEORY ListOperationsX IS
  Internal_List_Operations(Machine(cards))==(aplicar_dano,adicionar_energia,curar_dano,resetar_carta,consultar_hp_restante);
  List_Operations(Machine(cards))==(aplicar_dano,adicionar_energia,curar_dano,resetar_carta,consultar_hp_restante)
END
&
THEORY ListInputX IS
  List_Input(Machine(cards),aplicar_dano)==(cc,valor);
  List_Input(Machine(cards),adicionar_energia)==(cc);
  List_Input(Machine(cards),curar_dano)==(cc,valor_cura);
  List_Input(Machine(cards),resetar_carta)==(cc);
  List_Input(Machine(cards),consultar_hp_restante)==(cc)
END
&
THEORY ListOutputX IS
  List_Output(Machine(cards),aplicar_dano)==(?);
  List_Output(Machine(cards),adicionar_energia)==(?);
  List_Output(Machine(cards),curar_dano)==(?);
  List_Output(Machine(cards),resetar_carta)==(?);
  List_Output(Machine(cards),consultar_hp_restante)==(hp_restante)
END
&
THEORY ListHeaderX IS
  List_Header(Machine(cards),aplicar_dano)==(aplicar_dano(cc,valor));
  List_Header(Machine(cards),adicionar_energia)==(adicionar_energia(cc));
  List_Header(Machine(cards),curar_dano)==(curar_dano(cc,valor_cura));
  List_Header(Machine(cards),resetar_carta)==(resetar_carta(cc));
  List_Header(Machine(cards),consultar_hp_restante)==(hp_restante <-- consultar_hp_restante(cc))
END
&
THEORY ListOperationGuardX END
&
THEORY ListPreconditionX IS
  List_Precondition(Machine(cards),aplicar_dano)==(cc: CARTA & cc: dom(hp_base) & valor: NAT1);
  List_Precondition(Machine(cards),adicionar_energia)==(cc: CARTA);
  List_Precondition(Machine(cards),curar_dano)==(cc: CARTA & cc: dom(dano) & valor_cura: NAT1);
  List_Precondition(Machine(cards),resetar_carta)==(cc: CARTA);
  List_Precondition(Machine(cards),consultar_hp_restante)==(cc: CARTA & cc: dom(hp_base))
END
&
THEORY ListSubstitutionX IS
  Expanded_List_Substitution(Machine(cards),consultar_hp_restante)==(cc: CARTA & cc: dom(hp_base) | cc: dom(dano) ==> (hp_base(cc)>dano(cc) ==> hp_restante:=hp_base(cc)-dano(cc) [] not(hp_base(cc)>dano(cc)) ==> hp_restante:=0) [] not(cc: dom(dano)) ==> hp_restante:=hp_base(cc));
  Expanded_List_Substitution(Machine(cards),resetar_carta)==(cc: CARTA | dano,energia_ligada:={cc}<<|dano,{cc}<<|energia_ligada);
  Expanded_List_Substitution(Machine(cards),curar_dano)==(cc: CARTA & cc: dom(dano) & valor_cura: NAT1 | dano(cc)<=valor_cura ==> dano:={cc}<<|dano [] not(dano(cc)<=valor_cura) ==> dano:=dano<+{cc|->dano(cc)-valor_cura});
  Expanded_List_Substitution(Machine(cards),adicionar_energia)==(cc: CARTA | cc: dom(energia_ligada) ==> energia_ligada:=energia_ligada<+{cc|->energia_ligada(cc)+1} [] not(cc: dom(energia_ligada)) ==> energia_ligada:=energia_ligada<+{cc|->1});
  Expanded_List_Substitution(Machine(cards),aplicar_dano)==(cc: CARTA & cc: dom(hp_base) & valor: NAT1 | cc: dom(dano) ==> dano:=dano<+{cc|->dano(cc)+valor} [] not(cc: dom(dano)) ==> dano:=dano<+{cc|->valor});
  List_Substitution(Machine(cards),aplicar_dano)==(IF cc: dom(dano) THEN dano(cc):=dano(cc)+valor ELSE dano(cc):=valor END);
  List_Substitution(Machine(cards),adicionar_energia)==(IF cc: dom(energia_ligada) THEN energia_ligada(cc):=energia_ligada(cc)+1 ELSE energia_ligada(cc):=1 END);
  List_Substitution(Machine(cards),curar_dano)==(IF dano(cc)<=valor_cura THEN dano:={cc}<<|dano ELSE dano(cc):=dano(cc)-valor_cura END);
  List_Substitution(Machine(cards),resetar_carta)==(dano:={cc}<<|dano || energia_ligada:={cc}<<|energia_ligada);
  List_Substitution(Machine(cards),consultar_hp_restante)==(IF cc: dom(dano) THEN IF hp_base(cc)>dano(cc) THEN hp_restante:=hp_base(cc)-dano(cc) ELSE hp_restante:=0 END ELSE hp_restante:=hp_base(cc) END)
END
&
THEORY ListConstantsX IS
  List_Valuable_Constants(Machine(cards))==(tipo_da_carta,estagio_pokemon,hp_base);
  Inherited_List_Constants(Machine(cards))==(?);
  List_Constants(Machine(cards))==(tipo_da_carta,estagio_pokemon,hp_base)
END
&
THEORY ListSetsX IS
  Set_Definition(Machine(cards),TIPO_CARTA)==({Pokemon,Energia,Treinador});
  Context_List_Enumerated(Machine(cards))==(?);
  Context_List_Defered(Machine(cards))==(?);
  Context_List_Sets(Machine(cards))==(?);
  List_Valuable_Sets(Machine(cards))==(CARTA);
  Inherited_List_Enumerated(Machine(cards))==(?);
  Inherited_List_Defered(Machine(cards))==(?);
  Inherited_List_Sets(Machine(cards))==(?);
  List_Enumerated(Machine(cards))==(TIPO_CARTA,ESTAGIO);
  List_Defered(Machine(cards))==(CARTA);
  List_Sets(Machine(cards))==(TIPO_CARTA,ESTAGIO,CARTA);
  Set_Definition(Machine(cards),ESTAGIO)==({Basico,Estagio1,Estagio2});
  Set_Definition(Machine(cards),CARTA)==(?)
END
&
THEORY ListHiddenConstantsX IS
  Abstract_List_HiddenConstants(Machine(cards))==(?);
  Expanded_List_HiddenConstants(Machine(cards))==(?);
  List_HiddenConstants(Machine(cards))==(?);
  External_List_HiddenConstants(Machine(cards))==(?)
END
&
THEORY ListPropertiesX IS
  Abstract_List_Properties(Machine(cards))==(btrue);
  Context_List_Properties(Machine(cards))==(btrue);
  Inherited_List_Properties(Machine(cards))==(btrue);
  List_Properties(Machine(cards))==(tipo_da_carta: CARTA --> TIPO_CARTA & estagio_pokemon: CARTA +-> ESTAGIO & hp_base: CARTA +-> NAT1 & dom(estagio_pokemon) = tipo_da_carta~[{Pokemon}] & dom(hp_base) = tipo_da_carta~[{Pokemon}] & CARTA: FIN(INTEGER) & not(CARTA = {}) & TIPO_CARTA: FIN(INTEGER) & not(TIPO_CARTA = {}) & ESTAGIO: FIN(INTEGER) & not(ESTAGIO = {}))
END
&
THEORY ListSeenInfoX END
&
THEORY ListANYVarX IS
  List_ANY_Var(Machine(cards),aplicar_dano)==(?);
  List_ANY_Var(Machine(cards),adicionar_energia)==(?);
  List_ANY_Var(Machine(cards),curar_dano)==(?);
  List_ANY_Var(Machine(cards),resetar_carta)==(?);
  List_ANY_Var(Machine(cards),consultar_hp_restante)==(?)
END
&
THEORY ListOfIdsX IS
  List_Of_Ids(Machine(cards)) == (tipo_da_carta,estagio_pokemon,hp_base,TIPO_CARTA,ESTAGIO,CARTA,Pokemon,Energia,Treinador,Basico,Estagio1,Estagio2 | ? | energia_ligada,dano | ? | aplicar_dano,adicionar_energia,curar_dano,resetar_carta,consultar_hp_restante | ? | ? | ? | cards);
  List_Of_HiddenCst_Ids(Machine(cards)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(cards)) == (tipo_da_carta,estagio_pokemon,hp_base);
  List_Of_VisibleVar_Ids(Machine(cards)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(cards)) == (?: ?)
END
&
THEORY SetsEnvX IS
  Sets(Machine(cards)) == (Type(TIPO_CARTA) == Cst(SetOf(etype(TIPO_CARTA,0,2)));Type(ESTAGIO) == Cst(SetOf(etype(ESTAGIO,0,2)));Type(CARTA) == Cst(SetOf(atype(CARTA,"[CARTA","]CARTA"))))
END
&
THEORY ConstantsEnvX IS
  Constants(Machine(cards)) == (Type(Pokemon) == Cst(etype(TIPO_CARTA,0,2));Type(Energia) == Cst(etype(TIPO_CARTA,0,2));Type(Treinador) == Cst(etype(TIPO_CARTA,0,2));Type(Basico) == Cst(etype(ESTAGIO,0,2));Type(Estagio1) == Cst(etype(ESTAGIO,0,2));Type(Estagio2) == Cst(etype(ESTAGIO,0,2));Type(tipo_da_carta) == Cst(SetOf(atype(CARTA,"[CARTA","]CARTA")*etype(TIPO_CARTA,0,2)));Type(estagio_pokemon) == Cst(SetOf(atype(CARTA,?,?)*etype(ESTAGIO,?,?)));Type(hp_base) == Cst(SetOf(atype(CARTA,?,?)*btype(INTEGER,?,?))))
END
&
THEORY VariablesEnvX IS
  Variables(Machine(cards)) == (Type(energia_ligada) == Mvl(SetOf(atype(CARTA,?,?)*btype(INTEGER,?,?)));Type(dano) == Mvl(SetOf(atype(CARTA,?,?)*btype(INTEGER,?,?))))
END
&
THEORY OperationsEnvX IS
  Operations(Machine(cards)) == (Type(consultar_hp_restante) == Cst(btype(INTEGER,?,?),atype(CARTA,?,?));Type(resetar_carta) == Cst(No_type,atype(CARTA,?,?));Type(curar_dano) == Cst(No_type,atype(CARTA,?,?)*btype(INTEGER,?,?));Type(adicionar_energia) == Cst(No_type,atype(CARTA,?,?));Type(aplicar_dano) == Cst(No_type,atype(CARTA,?,?)*btype(INTEGER,?,?)));
  Observers(Machine(cards)) == (Type(consultar_hp_restante) == Cst(btype(INTEGER,?,?),atype(CARTA,?,?)))
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
