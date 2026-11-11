MACHINE
    jogoPokemon

INCLUDES
    cards,
    Jogadores
    
SETS
    FASE = {fase_compra, fase_principal, fase_batalha}

VARIABLES
    turno,
    energia_jogada_turno,
    fase_atual

INVARIANT
    turno : JOGADOR &
    energia_jogada_turno : BOOL &
    fase_atual : FASE

INITIALISATION
    turno := jogador1 ||
    energia_jogada_turno := FALSE ||
    fase_atual := fase_compra

OPERATIONS
    comprar_carta_turno(pp) =
    PRE
        pp : JOGADOR &
        pp = turno &
        size(decks_jogadores(pp)) > 0 &
        fase_atual = fase_compra
    THEN
        comprar_carta_jogador(pp) ||
        fase_atual := fase_principal
    END;

    baixar_pokemon(pp, cc) =
    PRE
        pp : JOGADOR &
        pp = turno &
        cc : CARTA &
        cc : ran(mao(pp)) &
        tipo_da_carta(cc) = Pokemon &
        cc : dom(estagio_pokemon) &
        estagio_pokemon(cc) = Basico &
        size(banco(pp)) < max_cartas_banco &
        fase_atual = fase_principal
    THEN
        mover_mao_para_banco(pp, cc)
    END;

    jogar_energia(pp, cc_energia, cc_alvo) =
    PRE
        pp : JOGADOR &
        pp = turno &
        cc_energia : CARTA &
        cc_energia : ran(mao(pp)) &
        cc_alvo : CARTA &
        tipo_da_carta(cc_energia) = Energia &
        energia_jogada_turno = FALSE &
        ((pp : dom(ativo) & cc_alvo = ativo(pp)) or cc_alvo : ran(banco(pp))) &
        fase_atual = fase_principal
    THEN
        adicionar_energia(cc_alvo) ||
        remover_carta_mao(pp, cc_energia) ||
        energia_jogada_turno := TRUE
    END;

    usar_treinador_cura(pp, cc_treinador, cc_alvo, valor_cura) =
    PRE
        pp : JOGADOR &
        pp = turno &
        cc_treinador : CARTA &
        cc_treinador : ran(mao(pp)) &
        tipo_da_carta(cc_treinador) = Treinador &
        cc_alvo : CARTA &
        cc_alvo : dom(dano) &
        valor_cura : NAT1 &
        ((pp : dom(ativo) & cc_alvo = ativo(pp)) or cc_alvo : ran(banco(pp))) &
        fase_atual = fase_principal
    THEN
        curar_dano(cc_alvo, valor_cura) ||
        remover_carta_mao(pp, cc_treinador)
    END;

    atacar_oponente(pp, valor_dano) =
    PRE
        pp : JOGADOR &
        pp = turno &
        valor_dano : NAT1 &
        pp : dom(ativo) &
        #(op).(op : JOGADOR & op /= pp & op : dom(ativo)) &
        fase_atual /= fase_compra
    THEN
        ANY oponente WHERE oponente : JOGADOR & oponente /= pp & oponente : dom(ativo) THEN
            aplicar_dano(ativo(oponente), valor_dano)
        END ||
        fase_atual := fase_batalha
    END;

    passar_turno(pp) =
    PRE
        pp : JOGADOR &
        pp = turno &
        fase_atual /= fase_compra
    THEN
        IF pp = jogador1 THEN
            turno := jogador2
        ELSE
            turno := jogador1
        END ||
        energia_jogada_turno := FALSE ||
        fase_atual := fase_compra
    END;

    vencedor <-- consultar_vencedor(pp) =
    PRE
        pp : JOGADOR
    THEN
        ANY oponente WHERE oponente : JOGADOR & oponente /= pp THEN
            IF size(premios(pp)) = 0 or size(decks_jogadores(oponente)) = 0 THEN
                vencedor := pp
            ELSE
                vencedor := oponente
            END
        END
    END
END