MACHINE
    jogoPokemon

INCLUDES
    Jogadores

SEES
    cards

SETS
    FASE = {fase_compra, fase_principal, fase_batalha, fase_reposicao, fase_encerrada}

DEFINITIONS
    VISB_JSON_FILE == "visualizacao/pokemon.json"

VARIABLES
    turno,
    energia_jogada_turno,
    fase_atual,
    dano_ativo,
    energia_ativa,
    dano_banco,
    energia_banco,
    ganhador

INVARIANT
    ganhador <: JOGADOR &
    card(ganhador) <= 1 &
    (fase_atual = fase_encerrada <=> ganhador /= {}) &
    turno : JOGADOR &
    energia_jogada_turno : BOOL &
    fase_atual : FASE &
    dano_ativo : JOGADOR +-> NATURAL &
    energia_ativa : JOGADOR +-> NATURAL &
    dano_banco : JOGADOR * NAT1 +-> NATURAL &
    energia_banco : JOGADOR * NAT1 +-> NATURAL &
    dom(dano_ativo) <: dom(ativo) &
    dom(energia_ativa) <: dom(ativo) &
    !(pp, idx).(pp : JOGADOR & idx: NAT1 & (pp |-> idx) : dom(dano_banco) => (idx : dom(banco(pp)))) &
    !(pp, idx).(pp : JOGADOR & idx: NAT1 & (pp |-> idx) : dom(energia_banco) => (idx : dom(banco(pp))))

INITIALISATION
    turno := jogador1 ||
    energia_jogada_turno := FALSE ||
    fase_atual := fase_compra ||
    dano_ativo := {} ||
    energia_ativa := {} ||
    dano_banco := {} ||
    energia_banco := {} ||
    ganhador := {}

OPERATIONS
    comprar_carta_turno(pp) =
    PRE
        pp : JOGADOR &
        pp = turno &
        fase_atual = fase_compra
    THEN
        IF size(decks_jogadores(pp)) = 0 THEN
            ganhador := JOGADOR - {pp} ||
            fase_atual := fase_encerrada
        ELSE
            comprar_carta_jogador(pp) ||
            fase_atual := fase_principal
        END
    END;

    definir_pokemon_ativo(pp, cc) =
    PRE
        pp : JOGADOR &
        pp = turno &
        pp /: dom(ativo) &
        cc : CARTA &
        cc : ran(mao(pp)) &
        tipo_da_carta(cc) = Pokemon &
        cc : dom(hp_base) &
        estagio_pokemon(cc) = Basico &
        fase_atual = fase_principal
    THEN
        definir_ativo(pp, cc)
    END;

    baixar_pokemon_banco(pp, cc) =
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

    jogar_energia_ativo(pp, cc_energia) =
    PRE
        pp : JOGADOR &
        pp = turno &
        cc_energia : CARTA &
        cc_energia : ran(mao(pp)) &
        tipo_da_carta(cc_energia) = Energia &
        energia_jogada_turno = FALSE &
        pp : dom(ativo) &
        fase_atual = fase_principal
    THEN
        IF pp : dom(energia_ativa) THEN
            energia_ativa(pp) := energia_ativa(pp) + 1
        ELSE
            energia_ativa(pp) := 1
        END ||
        remover_carta_mao(pp, cc_energia) ||
        energia_jogada_turno := TRUE
    END;

    jogar_energia_banco(pp, cc_energia, idx) =
    PRE
        pp : JOGADOR &
        pp = turno &
        cc_energia : CARTA &
        cc_energia : ran(mao(pp)) &
        tipo_da_carta(cc_energia) = Energia &
        energia_jogada_turno = FALSE &
        idx : NAT1 &
        idx : dom(banco(pp)) &
        fase_atual = fase_principal
    THEN
        IF (pp |-> idx) : dom(energia_banco) THEN
            energia_banco(pp |-> idx) := energia_banco(pp |-> idx) + 1
        ELSE
            energia_banco(pp |-> idx) := 1
        END ||
        remover_carta_mao(pp, cc_energia) ||
        energia_jogada_turno := TRUE
    END;

    usar_pocao_ativo(pp, cc_treinador) =
    PRE
        pp : JOGADOR &
        pp = turno &
        cc_treinador : CARTA &
        cc_treinador : ran(mao(pp)) &
        tipo_da_carta(cc_treinador) = Treinador &
        pp : dom(dano_ativo) &
        fase_atual = fase_principal
    THEN
        dano_ativo := {pp} <<| dano_ativo ||
        remover_carta_mao(pp, cc_treinador)
    END;

    usar_pocao_banco(pp, cc_treinador, idx) =
    PRE
        pp : JOGADOR &
        pp = turno &
        cc_treinador : CARTA &
        cc_treinador : ran(mao(pp)) &
        tipo_da_carta(cc_treinador) = Treinador &
        idx : NAT1 &
        idx : dom(banco(pp)) &
        (pp |-> idx) : dom(dano_banco) &
        fase_atual = fase_principal
    THEN
        dano_banco := {pp |-> idx} <<| dano_banco ||
        remover_carta_mao(pp, cc_treinador)
    END;

    atacar_oponente(pp) =
    PRE
        pp : JOGADOR &
        pp = turno &
        pp : dom(ativo) &
        ativo(pp) : dom(dano_ataque) &
        ativo(pp) : dom(custo_dano) &
        fase_atual = fase_principal &
        #(op).(op : JOGADOR & op /= pp & op : dom(ativo)) &
        (pp : dom(energia_ativa) & energia_ativa(pp) >= custo_dano(ativo(pp)))
    THEN
        ANY oponente WHERE oponente : JOGADOR & oponente /= pp & oponente : dom(ativo) THEN
            IF oponente : dom(dano_ativo) THEN
                dano_ativo(oponente) := dano_ativo(oponente) + dano_ataque(ativo(pp))
            ELSE
                dano_ativo(oponente) := dano_ataque(ativo(pp))
            END
        END ||
        fase_atual := fase_batalha
    END;

    evoluir_banco(pp, idx, cc_nova) =
    PRE
        pp : JOGADOR &
        pp = turno &
        fase_atual = fase_principal &
        idx : dom(banco(pp)) &
        cc_nova : CARTA &
        cc_nova : ran(mao(pp)) &
        tipo_da_carta(cc_nova) = Pokemon &
        banco(pp)(idx) : dom(id_evolutivo) &
        cc_nova : dom(id_evolutivo) &
        id_evolutivo(banco(pp)(idx)) = id_evolutivo(cc_nova) &
        ((estagio_pokemon(banco(pp)(idx)) = Basico   & estagio_pokemon(cc_nova) = Estagio1) or
         (estagio_pokemon(banco(pp)(idx)) = Estagio1 & estagio_pokemon(cc_nova) = Estagio2))
    THEN
        evoluir_pokemon_banco(pp, idx, cc_nova)
    END;

    evoluir_ativo(pp, cc_nova) =
    PRE
        pp : JOGADOR &
        pp = turno &
        fase_atual = fase_principal &
        pp : dom(ativo) &
        cc_nova : CARTA &
        cc_nova : ran(mao(pp)) &
        tipo_da_carta(cc_nova) = Pokemon &
        ativo(pp) : dom(id_evolutivo) &
        cc_nova : dom(id_evolutivo) &
        id_evolutivo(ativo(pp)) = id_evolutivo(cc_nova) &
        ((estagio_pokemon(ativo(pp)) = Basico   & estagio_pokemon(cc_nova) = Estagio1) or
         (estagio_pokemon(ativo(pp)) = Estagio1 & estagio_pokemon(cc_nova) = Estagio2))
    THEN
        evoluir_pokemon_ativo(pp, cc_nova)
    END;

    passar_turno(pp) =
    PRE
        pp : JOGADOR &
        pp = turno &
        pp : dom(ativo) &
        fase_atual : {fase_principal, fase_batalha} &
        !(op).(op : JOGADOR & op /= pp & op : dom(ativo) & op : dom(dano_ativo) =>
            dano_ativo(op) < hp_base(ativo(op)))
    THEN
        IF pp = jogador1 THEN
            turno := jogador2
        ELSE
            turno := jogador1
        END ||
        energia_jogada_turno := FALSE ||
        fase_atual := fase_compra
    END;

    resolver_nocaute(pp) =
    PRE
        pp : JOGADOR &
        pp = turno &
        fase_atual = fase_batalha &
        size(premios(pp)) > 0 &
        #(op).(op : JOGADOR & op /= pp & op : dom(ativo) &
            op : dom(dano_ativo) & dano_ativo(op) >= hp_base(ativo(op)))
    THEN
        ANY oponente WHERE
            oponente : JOGADOR & oponente /= pp & oponente : dom(ativo) &
            oponente : dom(dano_ativo) & dano_ativo(oponente) >= hp_base(ativo(oponente))
        THEN
            remover_ativo(oponente) ||
            coletar_premio(pp) ||
            dano_ativo := {oponente} <<| dano_ativo ||
            energia_ativa := {oponente} <<| energia_ativa ||
            energia_jogada_turno := FALSE ||
            IF size(premios(pp)) = 1 or size(banco(oponente)) = 0 THEN
                ganhador := {pp} ||
                fase_atual := fase_encerrada
            ELSE
                turno := oponente ||
                fase_atual := fase_reposicao
            END
        END
    END;

    repor_pokemon_ativo(pp, idx) =
    PRE
        pp : JOGADOR &
        pp = turno &
        fase_atual : {fase_reposicao, fase_principal} &
        pp /: dom(ativo) &
        idx : dom(banco(pp))
    THEN
        LET remapeamento BE
            remapeamento =
                id((JOGADOR - {pp}) * (1..max_cartas_banco)) \/
                id({pp} * (1..(idx - 1))) \/
                %(jj, kk).(jj : JOGADOR & jj = pp &
                    kk : idx..(size(banco(pp)) - 1) | jj |-> (kk + 1))
        IN
            promover_banco_para_ativo(pp, idx) ||
            IF (pp |-> idx) : dom(dano_banco) THEN
                dano_ativo(pp) := dano_banco(pp |-> idx)
            END ||
            IF (pp |-> idx) : dom(energia_banco) THEN
                energia_ativa(pp) := energia_banco(pp |-> idx)
            END ||
            dano_banco := (remapeamento ; dano_banco) ||
            energia_banco := (remapeamento ; energia_banco) ||
            IF fase_atual = fase_reposicao THEN
                fase_atual := fase_compra
            END
        END
    END;

    vencedor <-- consultar_vencedor(pp) =
    PRE
        pp : JOGADOR &
        ganhador /= {}
    THEN
        vencedor :: ganhador
    END
END
