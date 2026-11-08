MACHINE
    cards

SETS
    TIPO_CARTA = { Pokemon , Energia , Treinador } ;
    ESTAGIO = { Basico , Estagio1 , Estagio2 } ;
    CARTA

CONCRETE_CONSTANTS
    tipo_da_carta ,
    estagio_pokemon ,
    hp_base

PROPERTIES
    tipo_da_carta : CARTA --> TIPO_CARTA &
    estagio_pokemon : CARTA +-> ESTAGIO &
    hp_base : CARTA +-> NAT1 &
    dom ( estagio_pokemon ) = tipo_da_carta ~ [ { Pokemon } ] &
    dom ( hp_base ) = tipo_da_carta ~ [ { Pokemon } ]

ABSTRACT_VARIABLES
    dano ,
    energia_ligada

INVARIANT
    dano : CARTA +-> NAT &
    energia_ligada : CARTA +-> NAT &
    dom ( dano ) <: dom ( hp_base )

INITIALISATION
    dano := {} ||
    energia_ligada := {}

OPERATIONS
    aplicar_dano ( cc , valor ) =
    PRE
        cc : CARTA &
        cc : dom ( hp_base ) &
        valor : NAT1
    THEN
        IF cc : dom ( dano ) THEN
            dano ( cc ) := dano ( cc ) + valor
        ELSE
            dano ( cc ) := valor
        END
    END ;

    adicionar_energia ( cc ) =
    PRE
        cc : CARTA
    THEN
        IF cc : dom ( energia_ligada ) THEN
            energia_ligada ( cc ) := energia_ligada ( cc ) + 1
        ELSE
            energia_ligada ( cc ) := 1
        END
    END ;

    curar_dano ( cc , valor_cura ) =
    PRE
        cc : CARTA &
        cc : dom ( dano ) &
        valor_cura : NAT1
    THEN
        IF dano ( cc ) <= valor_cura THEN
            dano := { cc } <<| dano
        ELSE
            dano ( cc ) := dano ( cc ) - valor_cura
        END
    END ;

    resetar_carta ( cc ) =
    PRE
        cc : CARTA
    THEN
        dano := { cc } <<| dano ||
        energia_ligada := { cc } <<| energia_ligada
    END ;

    hp_restante <-- consultar_hp_restante ( cc ) =
    PRE
        cc : CARTA &
        cc : dom ( hp_base )
    THEN
        IF cc : dom ( dano ) THEN
            IF hp_base ( cc ) > dano ( cc ) THEN
                hp_restante := hp_base ( cc ) - dano ( cc )
            ELSE
                hp_restante := 0
            END
        ELSE
            hp_restante := hp_base ( cc )
        END
    END
END
