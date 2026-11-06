/* jogoPokemon
 * Author: felip
 * Creation date: 06/11/2026
 */
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
        pp = turno
    THEN
        comprar_carta_jogador ( pp )
    END ;

    baixar_pokemon ( pp , cc ) =
    PRE
        pp : JOGADOR &
        pp = turno &
        cc : CARTA &
        cc : mao ( pp )
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
        ( cc_alvo = ativo ( pp ) or cc_alvo : banco ( pp ) )
    THEN
        adicionar_energia ( cc_alvo ) ||
        remover_carta_mao ( pp , cc_energia ) ||
        energia_jogada_turno := TRUE
    END ;

    atacar_oponente ( pp , valor_dano ) =
    PRE
        pp : JOGADOR &
        pp = turno &
        valor_dano : NAT1 &
        pp : dom ( ativo )
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
    END

END
