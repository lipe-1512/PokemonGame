MACHINE
    cards

SETS
    TIPO_CARTA = {Pokemon, Energia, Treinador};
    ESTAGIO = {Basico, Estagio1, Estagio2};
    CARTA = {squirtle, wartotle, blastoise, elekid, electabuzz, electivire, energia_raio, energia_agua, pocao}

CONSTANTS
    tipo_da_carta,
    estagio_pokemon,
    hp_base,
    dano_ataque,
    custo_dano,
    id_evolutivo

PROPERTIES
    tipo_da_carta : CARTA --> TIPO_CARTA &
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
    estagio_pokemon : tipo_da_carta~[{Pokemon}] --> ESTAGIO &
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
    dano_ataque = {
        squirtle |-> 30,
        wartotle |-> 50,
        blastoise |-> 150,
        elekid |-> 40,
        electabuzz |-> 80,
        electivire |-> 150
    } &
    custo_dano = {
        squirtle |-> 1,
        wartotle |-> 2,
        blastoise |-> 2,
        elekid |-> 1,
        electabuzz |-> 2,
        electivire |-> 2
    } &
    id_evolutivo = {
        squirtle |-> 1,
        wartotle |-> 1,
        blastoise |-> 1,
        elekid |-> 2,
        electabuzz |-> 2,
        electivire |-> 2
    } &
    dom(hp_base) = tipo_da_carta~[{Pokemon}] &
    dom(dano_ataque) = tipo_da_carta~[{Pokemon}] &
    dom(custo_dano) = tipo_da_carta~[{Pokemon}] &
    dom(id_evolutivo) = tipo_da_carta~[{Pokemon}]

END