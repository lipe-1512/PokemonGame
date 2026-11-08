MACHINE
    jogoPokemon

INCLUDES
    cards ,
    Jogadores

ABSTRACT_VARIABLES
    turno ,
    energia_jogada_turno

INVARIANT
    turno : JOGADOR &
    energia_jogada_turno : BOOL

INITIALISATION
    turno := jogador1 ||
    energia_jogada_turno := FALSE

OPERATIONS
    comprar_carta_turno ( pp ) =
    PRE
        pp : JOGADOR &
        pp = turno &
        size ( deck ( pp ) ) > 0
    THEN
        comprar_carta_jogador ( pp )
    END ;

    baixar_pokemon ( pp , cc ) =
    PRE
        pp : JOGADOR &
        pp = turno &
        cc : CARTA &
        cc : mao ( pp ) &
        tipo_da_carta ( cc ) = Pokemon &
        cc : dom ( estagio_pokemon ) &
        estagio_pokemon ( cc ) = Basico &
        size ( banco ( pp ) ) < max_cartas_banco
    THEN
        mover_mao_para_banco ( pp , cc )
    END ;

    jogar_energia ( pp , cc_energia , cc_alvo ) =
    PRE
        pp : JOGADOR &
        pp = turno &
        cc_energia : CARTA &
        cc_energia : mao ( pp ) &
        cc_alvo : CARTA &
        tipo_da_carta ( cc_energia ) = Energia &
        energia_jogada_turno = FALSE &
        ( ( pp : dom ( ativo ) & cc_alvo = ativo ( pp ) ) or cc_alvo : ran ( banco ( pp ) ) )
    THEN
        adicionar_energia ( cc_alvo ) ||
        remover_carta_mao ( pp , cc_energia ) ||
        energia_jogada_turno := TRUE
    END ;

    usar_treinador_cura ( pp , cc_treinador , cc_alvo , valor_cura ) =
    PRE
        pp : JOGADOR &
        pp = turno &
        cc_treinador : CARTA &
        cc_treinador : mao ( pp ) &
        tipo_da_carta ( cc_treinador ) = Treinador &
        cc_alvo : CARTA &
        cc_alvo : dom ( dano ) &
        valor_cura : NAT1 &
        ( ( pp : dom ( ativo ) & cc_alvo = ativo ( pp ) ) or cc_alvo : ran ( banco ( pp ) ) )
    THEN
        curar_dano ( cc_alvo , valor_cura ) ||
        remover_carta_mao ( pp , cc_treinador )
    END ;

    atacar_oponente ( pp , valor_dano ) =
    PRE
        pp : JOGADOR &
        pp = turno &
        valor_dano : NAT1 &
        pp : dom ( ativo ) &
        # ( op ) . ( op : JOGADOR & op /= pp & op : dom ( ativo ) )
    THEN
        ANY oponente WHERE oponente : JOGADOR & oponente /= pp & oponente : dom ( ativo ) THEN
            aplicar_dano ( ativo ( oponente ) , valor_dano )
        END
    END ;

    passar_turno ( pp ) =
    PRE
        pp : JOGADOR &
        pp = turno
    THEN
        IF pp = jogador1 THEN
            turno := jogador2
        ELSE
            turno := jogador1
        END ||
        energia_jogada_turno := FALSE
    END ;

    vencedor <-- consultar_vencedor ( pp ) =
    PRE
        pp : JOGADOR
    THEN
        ANY oponente WHERE oponente : JOGADOR & oponente /= pp THEN
            IF size ( premios ( pp ) ) = 0 or size ( deck ( oponente ) ) = 0 THEN
                vencedor := pp
            ELSE
                vencedor := oponente
            END
        END
    END
END
