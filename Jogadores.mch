MACHINE
    Jogadores

SEES
    cards

SETS
    JOGADOR = {jogador1, jogador2}

CONSTANTS
    max_cartas_deck,
    max_cartas_banco,
    max_cartas_premio

PROPERTIES
    max_cartas_deck = 60 &
    max_cartas_banco = 5 &
    max_cartas_premio = 6

VARIABLES
    deck,
    mao,
    ativo,
    banco,
    premios,
    descarte

INVARIANT
    deck : JOGADOR --> seq(CARTA) &
    mao : JOGADOR --> POW(CARTA) &
    ativo : JOGADOR +-> CARTA &
    banco : JOGADOR --> seq(CARTA) &
    premios : JOGADOR --> seq(CARTA) &
    descarte : JOGADOR --> seq(CARTA) &
    ran(ativo) <: dom(hp_base) &
    !(pp).(pp : JOGADOR => size(banco(pp)) <= max_cartas_banco) &
    !(pp).(pp : JOGADOR => size(premios(pp)) <= max_cartas_premio)

INITIALISATION
    deck :: JOGADOR --> {ss | ss : seq(CARTA) & size(ss) = max_cartas_deck} ||
    mao := {jogador1 |-> {}, jogador2 |-> {}} ||
    ativo := {} ||
    banco := {jogador1 |-> [], jogador2 |-> []} ||
    premios :: JOGADOR --> {ss | ss : seq(CARTA) & size(ss) = max_cartas_premio} ||
    descarte := {jogador1 |-> [], jogador2 |-> []}

OPERATIONS
    comprar_carta_jogador(pp) =
    PRE
        pp : JOGADOR &
        size(deck(pp)) > 0
    THEN
        mao(pp) := mao(pp) \/ {first(deck(pp))} ||
        deck(pp) := tail(deck(pp))
    END;

    mover_mao_para_banco(pp, cc) =
    PRE
        pp : JOGADOR &
        cc : CARTA &
        cc : mao(pp) &
        tipo_da_carta(cc) = Pokemon &
        cc : dom(estagio_pokemon) &
        estagio_pokemon(cc) = Basico &
        size(banco(pp)) < max_cartas_banco
    THEN
        banco(pp) := banco(pp) ^ [cc] ||
        mao(pp) := mao(pp) - {cc}
    END;

    remover_carta_mao(pp, cc) =
    PRE
        pp : JOGADOR &
        cc : CARTA &
        cc : mao(pp)
    THEN
        mao(pp) := mao(pp) - {cc}
    END;

    definir_ativo(pp, cc) =
    PRE
        pp : JOGADOR &
        pp /: dom(ativo) &
        cc : CARTA &
        cc : mao(pp) &
        tipo_da_carta(cc) = Pokemon &
        cc : dom(hp_base)
    THEN
        ativo(pp) := cc ||
        mao(pp) := mao(pp) - {cc}
    END;

    evoluir_pokemon_banco(pp, idx, cc_nova) =
    PRE
        pp : JOGADOR &
        idx : dom(banco(pp)) &
        cc_nova : CARTA &
        cc_nova : mao(pp) &
        tipo_da_carta(cc_nova) = Pokemon &
        cc_nova : dom(estagio_pokemon) &
        estagio_pokemon(cc_nova) /= Basico
    THEN
        LET cc_antiga BE cc_antiga = banco(pp)(idx) IN
            banco(pp) := banco(pp) <+ {idx |-> cc_nova} ||
            mao(pp) := mao(pp) - {cc_nova} ||
            descarte(pp) := descarte(pp) ^ [cc_antiga]
        END
    END;

    coletar_premio(pp) =
    PRE
        pp : JOGADOR &
        size(premios(pp)) > 0
    THEN
        mao(pp) := mao(pp) \/ {first(premios(pp))} ||
        premios(pp) := tail(premios(pp))
    END
END