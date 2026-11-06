/* Jogadores
 * Author: felip
 * Creation date: 06/11/2026
 */
MACHINE
    Jogadores

SEES
    cards

SETS
    JOGADOR = { jogador1 , jogador2 }

CONCRETE_CONSTANTS
    max_cartas_deck ,
    max_cartas_banco ,
    max_cartas_premio

PROPERTIES
    max_cartas_deck = 60 &
    max_cartas_banco = 5 &
    max_cartas_premio = 6

ABSTRACT_VARIABLES
    deck ,
    mao ,
    ativo ,
    banco ,
    premios ,
    descarte

INVARIANT
    deck : JOGADOR --> seq ( CARTA ) &
    mao : JOGADOR --> POW ( CARTA ) &
    ativo : JOGADOR +-> CARTA &
    banco : JOGADOR --> POW ( CARTA ) &
    premios : JOGADOR --> POW ( CARTA ) &
    descarte : JOGADOR --> seq ( CARTA ) &
    ! ( pp ) . ( pp : JOGADOR => card ( banco ( pp ) ) <= max_cartas_banco ) &
    ! ( pp ) . ( pp : JOGADOR => card ( premios ( pp ) ) <= max_cartas_premio )

INITIALISATION
    deck :: JOGADOR --> { ss | ss : seq ( CARTA ) & size ( ss ) = max_cartas_deck } ||
    mao := { jogador1 |-> {} , jogador2 |-> {} } ||
    ativo := {} ||
    banco := { jogador1 |-> {} , jogador2 |-> {} } ||
    premios := { jogador1 |-> {} , jogador2 |-> {} } ||
    descarte := { jogador1 |-> <> , jogador2 |-> <> }

OPERATIONS
    comprar_carta_jogador ( pp ) =
    PRE
        pp : JOGADOR &
        size ( deck ( pp ) ) > 0
    THEN
        mao ( pp ) := mao ( pp ) \/ { first ( deck ( pp ) ) } ||
        deck ( pp ) := tail ( deck ( pp ) )
    END ;

    mover_mao_para_banco ( pp , cc ) =
    PRE
        pp : JOGADOR &
        cc : mao ( pp ) &
        tipo_da_carta ( cc ) = Pokemon &
        estagio_pokemon ( cc ) = Basico &
        card ( banco ( pp ) ) < max_cartas_banco
    THEN
        banco ( pp ) := banco ( pp ) \/ { cc } ||
        mao ( pp ) := mao ( pp ) - { cc }
    END ;

    remover_carta_mao ( pp , cc ) =
    PRE
        pp : JOGADOR &
        cc : mao ( pp )
    THEN
        mao ( pp ) := mao ( pp ) - { cc }
    END ;

    definir_ativo ( pp , cc ) =
    PRE
        pp : JOGADOR &
        pp /: dom ( ativo ) &
        cc : mao ( pp ) &
        tipo_da_carta ( cc ) = Pokemon
    THEN
        ativo ( pp ) := cc ||
        mao ( pp ) := mao ( pp ) - { cc }
    END

END
