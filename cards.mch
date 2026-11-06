/* cards
 * Author: felip
 * Creation date: 06/11/2026
 */
MACHINE
    cards

SETS
    TIPO_CARTA = {Pokemon, Energia, Treinador};
    ESTAGIO = {Basico, Estagio1, Estagio2};
    CARTA // Conjunto abstrato com todas as cartas do jogo

CONSTANTS
    tipo_da_carta,
    estagio_pokemon,
    hp_base

PROPERTIES
    tipo_da_carta : CARTA --> TIPO_CARTA &
    estagio_pokemon : CARTA +-> ESTAGIO &
    hp_base : CARTA +-> NAT1 &
    dom(estagio_pokemon) = tipo_da_carta~[{Pokemon}] &
    dom(hp_base) = tipo_da_carta~[{Pokemon}]

VARIABLES
    dano,
    energia_ligada

INVARIANT
    dano : CARTA +-> NAT &
    energia_ligada : CARTA +-> NAT

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

    resetar_carta(cc) =
    PRE
        cc : CARTA
    THEN
        dano := {cc} <<| dano ||
        energia_ligada := {cc} <<| energia_ligada
    END
END

