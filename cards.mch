MACHINE
    cards

SETS
    TIPO_CARTA = {Pokemon, Energia, Treinador};
    ESTAGIO = {Basico, Estagio1, Estagio2};
    CARTA = {squirtle, wartotle, blastoise, elekid, electabuzz, electivire, energia_raio, energia_agua, pocao}

CONSTANTS
    tipo_da_carta,
    estagio_pokemon,
    hp_base

PROPERTIES
    tipo_da_carta = {
        squirtle |-> Pokemon,
        wartotle |-> Pokemon,
        blastoise |-> Pokemon,
        elekid |-> Pokemon,
        electabuzz |-> Pokemon,
        electivire |-> Pokemon,
        energia_raio |-> Energia,
        energia_agua |-> Energia,
        pocao |-> Treinador
    } &
    estagio_pokemon = {
        squirtle |-> Basico,
        wartotle |-> Estagio1,
        blastoise |-> Estagio2,
        elekid |-> Basico,
        electabuzz |-> Estagio1,
        electivire |-> Estagio2
    } &
    hp_base = {
        squirtle |-> 60,
        wartotle |-> 100,
        blastoise |-> 150,
        elekid |-> 70,
        electabuzz |-> 110,
        electivire |-> 160
    } &
    dom(estagio_pokemon) = tipo_da_carta~[{Pokemon}] &
    dom(hp_base) = tipo_da_carta~[{Pokemon}]

VARIABLES
    dano,
    energia_ligada

INVARIANT
    dano : CARTA +-> NATURAL &
    energia_ligada : CARTA +-> NATURAL &
    dom(dano) <: dom(hp_base)

INITIALISATION
    dano := {} ||
    energia_ligada := {}

OPERATIONS
    aplicar_dano(cc, valor) =
    PRE
        cc : CARTA &
        cc : dom(hp_base) &
        valor : NAT1
    THEN
        IF cc : dom(dano) THEN
            dano(cc) := dano(cc) + valor
        ELSE
            dano(cc) := valor
        END
    END;

    adicionar_energia(cc) =
    PRE
        cc : CARTA
    THEN
        IF cc : dom(energia_ligada) THEN
            energia_ligada(cc) := energia_ligada(cc) + 1
        ELSE
            energia_ligada(cc) := 1
        END
    END;

    curar_dano(cc, valor_cura) =
    PRE
        cc : CARTA &
        cc : dom(dano) &
        valor_cura : NAT1
    THEN
        IF dano(cc) <= valor_cura THEN
            dano := {cc} <<| dano
        ELSE
            dano(cc) := dano(cc) - valor_cura
        END
    END;

    resetar_carta(cc) =
    PRE
        cc : CARTA
    THEN
        dano := {cc} <<| dano ||
        energia_ligada := {cc} <<| energia_ligada
    END;

    hp_restante <-- consultar_hp_restante(cc) =
    PRE
        cc : CARTA &
        cc : dom(hp_base)
    THEN
        IF cc : dom(dano) THEN
            IF hp_base(cc) > dano(cc) THEN
                hp_restante := hp_base(cc) - dano(cc)
            ELSE
                hp_restante := 0
            END
        ELSE
            hp_restante := hp_base(cc)
        END
    END
END