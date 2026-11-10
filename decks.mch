MACHINE
    decks

SEES
    cards

CONSTANTS
    deck_1,
    deck_2

PROPERTIES
    deck_1 : seq(CARTA) &
    deck_2 : seq(CARTA) &
    deck_1 = [squirtle, energia_agua, energia_agua, wartotle, energia_agua] &
    deck_2 = [elekid, energia_raio, energia_raio, wartotle, energia_raio]

SETS
    JOGADOR = {jogador1, jogador2}
    
VARIABLES
    decks_jogadores

INVARIANT
    decks_jogadores : JOGADOR --> seq(CARTA)

INITIALISATION
    decks_jogadores := { jogador1 |-> deck_1, jogador2 |-> deck_2 }

OPERATIONS
    puxar_carta_deck(pp) =
    PRE
        pp : JOGADOR &
        size(decks_jogadores(pp)) > 0
    THEN
        decks_jogadores(pp) := tail(decks_jogadores(pp))
    END
END
