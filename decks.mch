MACHINE
    decks

SEES
    cards

CONSTANTS
    deck_1,
    deck_2,
    ordem_1,
    ordem_2,
    baralho_1,
    baralho_2

DEFINITIONS
    POSICAO_AJUSTE(ss) == max({5, min((ss)~[estagio_pokemon~[{Basico}]])});
    AJUSTAR_MAO(ss) ==
        ((id(1..size(ss)) <+ {5 |-> POSICAO_AJUSTE(ss), POSICAO_AJUSTE(ss) |-> 5}) ; (ss))

PROPERTIES
    deck_1 : seq(CARTA) &
    deck_2 : seq(CARTA) &
    deck_1 = [squirtle, energia_agua, energia_agua, wartotle, energia_agua,
              squirtle, energia_agua, energia_agua, wartotle, energia_agua,
              squirtle, energia_agua, energia_agua, blastoise, energia_agua,
              squirtle, energia_agua, energia_agua, pocao, energia_agua] &
    deck_2 = [elekid, energia_raio, energia_raio, electabuzz, energia_raio,
              elekid, energia_raio, energia_raio, electabuzz, energia_raio,
              elekid, energia_raio, energia_raio, electivire, energia_raio,
              elekid, energia_raio, energia_raio, pocao, energia_raio] &
    ordem_1 : (1..size(deck_1)) >->> (1..size(deck_1)) &
    ordem_2 : (1..size(deck_2)) >->> (1..size(deck_2)) &
    baralho_1 : seq(CARTA) &
    baralho_2 : seq(CARTA) &
    baralho_1 = AJUSTAR_MAO((ordem_1 ; deck_1)) &
    baralho_2 = AJUSTAR_MAO((ordem_2 ; deck_2))

SETS
    JOGADOR = {jogador1, jogador2}

VARIABLES
    decks_jogadores

INVARIANT
    decks_jogadores : JOGADOR --> seq(CARTA)

/* Cinco cartas na mao e seis premios ficam fora da pilha de compra. */
INITIALISATION
    decks_jogadores := {
        jogador1 |-> (baralho_1 \|/ 11),
        jogador2 |-> (baralho_2 \|/ 11)
    }

OPERATIONS
    puxar_carta_deck(pp) =
    PRE
        pp : JOGADOR &
        size(decks_jogadores(pp)) > 0
    THEN
        decks_jogadores(pp) := tail(decks_jogadores(pp))
    END
END
