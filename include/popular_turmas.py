from app import app, models
from sqlalchemy import func
from sqlalchemy.exc import IntegrityError
import random

DISCIPLINAS_ETAPA_1 = [
    "ALGORÍTMOS E PROGRAMAÇÃO - CIC",
    "CÁLCULO E GEOMETRIA ANALÍTICA I - A",
    "INTRODUÇÃO À CIÊNCIA DA COMPUTAÇÃO",
    "LÓGICA PARA COMPUTAÇÃO",
    "PENSAMENTO COMPUTACIONAL N"
]

# Mapeamento oficial baseado na sua grade curricular
PRE_REQUISITOS = {
    # Etapa 2
    "ARQUITETURA DE COMPUTADORES": [
        "INTRODUÇÃO À CIÊNCIA DA COMPUTAÇÃO",
        "ALGORÍTMOS E PROGRAMAÇÃO - CIC"
    ],
    "CÁLCULO E GEOMETRIA ANALÍTICA II - A": [
        "CÁLCULO E GEOMETRIA ANALÍTICA I - A"
    ],
    "ESTRUTURAS DE DADOS": [
        "ALGORÍTMOS E PROGRAMAÇÃO - CIC",
        "PENSAMENTO COMPUTACIONAL N"
    ],
    "PROBABILIDADE E ESTATÍSTICA": [
        "CÁLCULO E GEOMETRIA ANALÍTICA I - A"
    ],
    "TESTE E VERIFICAÇÃO DE SOFTWARE": [
        "ALGORÍTMOS E PROGRAMAÇÃO - CIC",
        "LÓGICA PARA COMPUTAÇÃO"
    ],
    
    # Etapa 3
    "BANCOS DE DADOS": ["ESTRUTURAS DE DADOS"],
    "DESENVOLVIMENTO DE SOFTWARE": ["ESTRUTURAS DE DADOS"],
    "PROJETO DE CIRCUITOS DIGITAIS": ["ARQUITETURA DE COMPUTADORES"],
    "PROJETO E ANÁLISE DE ALGORITMOS I": [
        "ESTRUTURAS DE DADOS",
        "CÁLCULO E GEOMETRIA ANALÍTICA I - A",
        "MATEMÁTICA DISCRETA B"
    ],
    "TEORIA DA COMPUTAÇÃO I": [
        "LÓGICA PARA COMPUTAÇÃO",
        "MATEMÁTICA DISCRETA B"
    ],
    
    # Etapa 4
    "ÁLGEBRA LINEAR I - A": ["CÁLCULO E GEOMETRIA ANALÍTICA I - A"],
    "ENGENHARIA DE SOFTWARE N": ["DESENVOLVIMENTO DE SOFTWARE"],
    "INTERAÇÃO HUMANO-COMPUTADOR E EXPERIÊNCIA DO USUÁRIO": ["DESENVOLVIMENTO DE SOFTWARE"],
    "ORGANIZAÇÃO DE COMPUTADORES": ["PROJETO DE CIRCUITOS DIGITAIS"],
    "PROJETO E ANÁLISE DE ALGORITMOS II": ["PROJETO E ANÁLISE DE ALGORITMOS I"],
    "TEORIA DA COMPUTAÇÃO II": ["TEORIA DA COMPUTAÇÃO I"],
    
    # Etapa 5
    "CÁLCULO NUMÉRICO A": [
        "ALGORÍTMOS E PROGRAMAÇÃO - CIC",
        "ÁLGEBRA LINEAR I - A"
    ],
    "COMPUTAÇÃO GRÁFICA E VISUALIZAÇÃO I": [
        "ESTRUTURAS DE DADOS",
        "CÁLCULO E GEOMETRIA ANALÍTICA II - A",
        "ÁLGEBRA LINEAR I - A"
    ],
    "INTELIGÊNCIA ARTIFICIAL": [
        "PROJETO E ANÁLISE DE ALGORITMOS I",
        "PROBABILIDADE E ESTATÍSTICA"
    ],
    "PROJETO EM CIÊNCIA E INOVAÇÃO": [
        "INTRODUÇÃO À CIÊNCIA DA COMPUTAÇÃO",
        "DESENVOLVIMENTO DE SOFTWARE",
        "PROJETO E ANÁLISE DE ALGORITMOS I",
        "PROBABILIDADE E ESTATÍSTICA"
    ],
    "SISTEMAS OPERACIONAIS I N": [
        "ARQUITETURA DE COMPUTADORES",
        "ESTRUTURAS DE DADOS"
    ],
    
    # Etapa 6
    "APRENDIZADO DE MÁQUINA": [
        "ESTRUTURAS DE DADOS",
        "CÁLCULO E GEOMETRIA ANALÍTICA II - A",
        "ÁLGEBRA LINEAR I - A",
        "PROBABILIDADE E ESTATÍSTICA"
    ],
    "LINGUAGENS DE PROGRAMAÇÃO I": [
        "ESTRUTURAS DE DADOS",
        "TEORIA DA COMPUTAÇÃO I"
    ],
    "PROCESSAMENTO DE IMAGENS E VISÃO COMPUTACIONAL I": [
        "ESTRUTURAS DE DADOS",
        "CÁLCULO E GEOMETRIA ANALÍTICA II - A",
        "ÁLGEBRA LINEAR I - A"
    ],
    "PROGRAMAÇÃO PARALELA": ["SISTEMAS OPERACIONAIS I N"],
    "REDES DE COMPUTADORES E INTERNET": ["ARQUITETURA DE COMPUTADORES"],
    
    # Etapa 7
    "CIBERSEGURANÇA": [
        "ALGORÍTMOS E PROGRAMAÇÃO - CIC",
        "MATEMÁTICA DISCRETA B",
        "PROBABILIDADE E ESTATÍSTICA"
    ],
    "LINGUAGENS DE PROGRAMAÇÃO II": [
        "ARQUITETURA DE COMPUTADORES",
        "LINGUAGENS DE PROGRAMAÇÃO I"
    ],
    "OTIMIZAÇÃO COMBINATÓRIA": [
        "PROJETO E ANÁLISE DE ALGORITMOS I",
        "TEORIA DA COMPUTAÇÃO II",
        "ÁLGEBRA LINEAR I - A"
    ],
    "PROCESSAMENTO DE LINGUAGEM NATURAL": ["APRENDIZADO DE MÁQUINA"],
    "SISTEMAS DISTRIBUÍDOS E TOLERANTES A FALHAS": ["SISTEMAS OPERACIONAIS I N"],
    
    # Etapa 8
    "PROJETO INTEGRADOR EM COMPUTAÇÃO": ["PROJETO EM CIÊNCIA E INOVAÇÃO"]
}

# Disciplinas sem pré-requisitos (Etapa 1 + Matemática Discreta B que é isolada)
DISCIPLINAS_LIVRES = {
    "ALGORÍTMOS E PROGRAMAÇÃO - CIC",
    "CÁLCULO E GEOMETRIA ANALÍTICA I - A",
    "INTRODUÇÃO À CIÊNCIA DA COMPUTAÇÃO",
    "LÓGICA PARA COMPUTAÇÃO",
    "PENSAMENTO COMPUTACIONAL N",
    "MATEMÁTICA DISCRETA B"
}

def matricular_aluno(id_aluno, id_turma, conceito):
    # Verifica se a matrícula já existe
    ja_matriculado = models.db.session.query(models.ALunosTurmas).filter_by(
        id_aluno=id_aluno, 
        id_turma=id_turma
    ).first()
    
    if ja_matriculado:
        # Se já existe mas está sem conceito, atualiza
        if conceito and ja_matriculado.conceito != conceito:
            ja_matriculado.conceito = conceito
            models.db.session.flush()
        return ja_matriculado.id_aluno_turma
    
    matricula = models.ALunosTurmas(
        id_aluno=id_aluno,
        id_turma=id_turma,
        conceito=conceito
    )
    
    try:
        models.db.session.add(matricula)
        models.db.session.flush()
        return matricula.id_aluno_turma
    except IntegrityError:
        models.db.session.rollback()
        print(f"Erro ao matricular aluno {id_aluno} na turma {id_turma}.")
        return None

def obter_id_disciplina(nome_disciplina):
    with app.app_context():
        disciplina = models.db.session.query(models.Disciplinas).filter(
            func.lower(models.Disciplinas.nome) == func.lower(nome_disciplina.strip())
        ).first()
        
        if not disciplina:
            print(f"Aviso: Disciplina '{nome_disciplina}' não encontrada.")
            return None
            
        return disciplina.id_disciplina

def sortear_conceito_etapa_1(nome_disciplina):   
    #Sorteia um conceito final com pesos baseados na dificuldade da disciplina.
    
    # Disciplinas com maior índice de reprovação (Cálculo e Algoritmos)
    if nome_disciplina in ["ALGORÍTMOS E PROGRAMAÇÃO - CIC", "CÁLCULO E GEOMETRIA ANALÍTICA I - A"]:
        pesos = {'A': 0.10, 'B': 0.20, 'C': 0.30, 'D': 0.25, 'FF': 0.15}
    else:
        pesos = {'A': 0.30, 'B': 0.40, 'C': 0.20, 'D': 0.07, 'FF': 0.03}
        
    return random.choices(list(pesos.keys()), weights=list(pesos.values()), k=1)[0]

def obter_mapeamento_ids_disciplinas(lista_nomes):
    #Recebe uma lista de nomes de disciplinas e retorna um dicionário 
    #mapeando {nome_disciplina: id_disciplina}.

    print("Mapeando nomes de disciplinas para seus IDs correspondentes...")
    mapa_ids = {}
    
    for nome in lista_nomes:
        id_disc = obter_id_disciplina(nome)
        if id_disc:
            mapa_ids[nome] = id_disc
            
    print(f"Mapeamento concluído! {len(mapa_ids)} de {len(lista_nomes)} disciplinas encontradas.")
    return mapa_ids

def obter_turmas_por_disciplinas(ano, semestre, ids_disciplinas):
    """
    Busca no banco as turmas abertas para o ano/semestre que pertençam
    aos IDs de disciplinas informados.
    Retorna um dicionário: {id_disciplina: [id_turma1, id_turma2, ...]}
    """
    with app.app_context():
        turmas = (
            models.db.session.query(models.Turmas.id_disciplina, models.Turmas.id_turma)
            .filter(
                models.Turmas.ano == ano,
                models.Turmas.semestre == semestre,
                models.Turmas.id_disciplina.in_(ids_disciplinas)
            )
            .all()
        )
        
        mapa_turmas = {}
        for id_disc, id_turma in turmas:
            if id_disc not in mapa_turmas:
                mapa_turmas[id_disc] = []
            mapa_turmas[id_disc].append(id_turma)
            
        return mapa_turmas

def matricular_lote_alunos(ano, semestre, lista_alunos, ids_disciplinas):
    """
    Matricula uma lista de alunos em um conjunto de disciplinas para um semestre específico,
    atribuindo conceitos de forma probabilística.
    """
    print(f"\nIniciando matrículas em lote para o período {ano}/{semestre}...")
    
    # 1. Mapeia quais turmas estão abertas para os IDs de disciplinas fornecidos
    mapa_turmas = obter_turmas_por_disciplinas(ano, semestre, ids_disciplinas)
    
    # Validação de segurança: todas as disciplinas precisam ter pelo menos uma turma aberta
    for id_disc in ids_disciplinas:
        if id_disc not in mapa_turmas:
            print(f"[ERRO] Não encontramos nenhuma turma aberta para a disciplina ID {id_disc} em {ano}/{semestre}.")
            print("O processo de matrícula em lote foi cancelado para evitar inconsistências.")
            return False

    # 2. Define os conceitos possíveis e pesos para o sorteio
    # (Usaremos uma média geral para simplificar este passo do loop)
    conceitos_possiveis = ['A', 'B', 'C', 'D', 'FF']
    pesos_conceito = [0.25, 0.35, 0.25, 0.10, 0.05] # Distribuição realista genérica

    matriculas_criadas = 0
    
    with app.app_context():
        try:
            for aluno in lista_alunos:
                for id_disc in ids_disciplinas:
                    # Se houver mais de uma turma para a mesma disciplina, escolhe uma aleatoriamente
                    id_turma_escolhida = random.choice(mapa_turmas[id_disc])
                    
                    # Sorteia o conceito
                    conceito_sorteado = random.choices(conceitos_possiveis, weights=pesos_conceito, k=1)[0]
                    
                    # Chama a função de matrícula que já validamos anteriormente
                    id_matricula = matricular_aluno(aluno.id_aluno, id_turma_escolhida, conceito_sorteado)
                    
                    if id_matricula:
                        matriculas_criadas += 1
            
            # Commita todo o lote com segurança após processar todos os alunos
            models.db.session.commit()
            print(f"[SUCESSO] Processamento finalizado para {ano}/{semestre}!")
            print(f" -> {len(lista_alunos)} alunos matriculados.")
            print(f" -> {matriculas_criadas} novos registros de matrículas/conceitos salvos.")
            return True
            
        except Exception as e:
            models.db.session.rollback()
            print(f"[ERRO] Falha crítica ao salvar lote de matrículas: {e}")
            return False

def selecionar_lote_alunos(offset, limite=40):
    """
    Busca uma quantidade fixa de alunos ordenada de forma determinística por ID.
    O offset serve para sabermos a partir de qual aluno estamos pegando.
    Exemplo: 
      - offset=0 pega os alunos de 1 a 40
      - offset=40 pega os alunos de 41 a 80
    """
    with app.app_context():
        alunos = (
            models.db.session.query(models.Alunos)
            .order_by(models.Alunos.id_aluno)
            .offset(offset)
            .limit(limite)
            .all()
        )
        return alunos

def testar_matricula_etapa_1():
    # 1. Lista com nomes das disciplinas da Etapa 1
    DISCIPLINAS_ETAPA_1 = [
        "ALGORÍTMOS E PROGRAMAÇÃO - CIC",
        "CÁLCULO E GEOMETRIA ANALÍTICA I - A",
        "INTRODUÇÃO À CIÊNCIA DA COMPUTAÇÃO",
        "LÓGICA PARA COMPUTAÇÃO",
        "PENSAMENTO COMPUTACIONAL N"
    ]
    
    # 2. Obter mapeamento de IDs dessas disciplinas
    # (Usando a função obter_mapeamento_ids_disciplinas que validamos antes)
    mapa_ids = obter_mapeamento_ids_disciplinas(DISCIPLINAS_ETAPA_1)
    ids_disciplinas = list(mapa_ids.values())
    
    # 3. Selecionar deterministicamente os primeiros 40 alunos (offset=0)
    lote_alunos = selecionar_lote_alunos(offset=0, limite=40)
    
    if not lote_alunos or len(lote_alunos) < 40:
        print(f"Aviso: Foram encontrados apenas {len(lote_alunos)} alunos no banco.")
        if not lote_alunos:
            return
            
    # Mostrar quem são os alunos do teste para controle
    print(f"\nAlunos selecionados para o teste controlado (IDs {lote_alunos[0].id_aluno} a {lote_alunos[-1].id_aluno}):")
    for a in lote_alunos[:5]:  # Mostra apenas os 5 primeiros no terminal para não poluir
        print(f" - ID: {a.id_aluno} | Nome: {a.nome}")
    print(" ...")

    # 4. Executar a matrícula deste lote de alunos em um período específico (ex: 2016/1)
    # Altere 2016, 1 para o período que você quer simular o início de tudo
    ano_teste = 2016
    semestre_teste = 1
    
    sucesso = matricular_lote_alunos(ano_teste, semestre_teste, lote_alunos, ids_disciplinas)
    
    if sucesso:
        print("\n[OK] Teste controlado finalizado com sucesso!")
    else:
        print("\n[FALHA] O teste de matrículas em lote falhou.")

def matricular_lote_generico(ano, semestre, offset, limite, ids_disciplinas):
    """
    Seleciona deterministicamente um lote de alunos e realiza as suas matrículas 
    nas disciplinas especificadas para um determinado ano/semestre, atribuindo conceitos.
    """
    print(f"\n==========================================")
    print(f"PROCESSANDO LOTE: {ano}/{semestre} | Alunos a partir do índice {offset} (Qtd: {limite})")
    print(f"==========================================")
    
    with app.app_context():
        # 1. Seleciona o grupo de alunos de forma determinística por ID
        lote_alunos = (
            models.db.session.query(models.Alunos)
            .order_by(models.Alunos.id_aluno)
            .offset(offset)
            .limit(limite)
            .all()
        )
        
        if not lote_alunos:
            print(f"[Aviso] Nenhum aluno encontrado para o offset {offset}. Fim da lista de alunos.")
            return False
            
        print(f"-> {len(lote_alunos)} alunos selecionados (IDs: {lote_alunos[0].id_aluno} a {lote_alunos[-1].id_aluno})")

        # 2. Busca as turmas abertas para as disciplinas indicadas neste período
        mapa_turmas = obter_turmas_por_disciplinas(ano, semestre, ids_disciplinas)
        
        # Validação de segurança: todas as disciplinas do lote precisam ter turmas abertas
        for id_disc in ids_disciplinas:
            if id_disc not in mapa_turmas:
                print(f"[ERRO] Nenhuma turma aberta para a disciplina ID {id_disc} em {ano}/{semestre}.")
                print("Lote cancelado para evitar inconsistência de dados.")
                return False

        # 3. Configura os conceitos e pesos para a simulação de notas
        conceitos_possiveis = ['A', 'B', 'C', 'D', 'FF']
        pesos_conceito = [0.25, 0.35, 0.25, 0.10, 0.05]

        matriculas_criadas = 0
        try:
            for aluno in lote_alunos:
                for id_disc in ids_disciplinas:
                    # Se houver múltiplas turmas para a mesma disciplina, escolhe uma aleatoriamente
                    id_turma_escolhida = random.choice(mapa_turmas[id_disc])
                    
                    # Sorteia o conceito final
                    conceito_sorteado = random.choices(conceitos_possiveis, weights=pesos_conceito, k=1)[0]
                    
                    # Realiza a matrícula usando a nossa função validada
                    id_matricula = matricular_aluno(aluno.id_aluno, id_turma_escolhida, conceito_sorteado)
                    
                    if id_matricula:
                        matriculas_criadas += 1
            
            # Commita todo o semestre de forma isolada e segura
            models.db.session.commit()
            print(f"[SUCESSO] Lote {ano}/{semestre} concluído com {matriculas_criadas} novas matrículas com conceitos.")
            return True
            
        except Exception as e:
            models.db.session.rollback()
            print(f"[ERRO] Falha crítica ao salvar o lote: {e}")
            return False

def obter_disciplinas_elegiveis(aprovadas):
    """
    Com base no conjunto de disciplinas já aprovadas pelo aluno (conceitos A, B, C),
    retorna a lista de todas as disciplinas da grade que ele está elegível para cursar.
    """
    elegiveis = []
    
    # 1. Checa disciplinas livres (sem pré-requisitos) nas quais ele ainda não passou
    for disc in DISCIPLINAS_LIVRES:
        if disc not in aprovadas:
            elegiveis.append(disc)
            
    # 2. Checa disciplinas com pré-requisitos
    for disc, reqs in PRE_REQUISITOS.items():
        # Se ele ainda não passou na matéria E já passou em TODOS os pré-requisitos dela:
        if disc not in aprovadas and all(r in aprovadas for r in reqs):
            elegiveis.append(disc)
            
    return elegiveis

def simular_trajetorias_completas(ano_inicio=2016, ano_fim=2026):
    print("Iniciando simulação estruturada...")
    
    # Mapeamento prévio de todas as disciplinas para IDs (evita consultas redundantes)
    todas_discs_grade = list(DISCIPLINAS_LIVRES) + list(PRE_REQUISITOS.keys())
    mapa_ids_disciplinas = obter_mapeamento_ids_disciplinas(todas_discs_grade)
    
    with app.app_context():
        # Busca a lista completa de alunos ordenada deterministicamente
        todos_alunos = models.db.session.query(models.Alunos).order_by(models.Alunos.id_aluno).all()
        if not todos_alunos:
            print("[ERRO] Nenhum aluno cadastrado no banco de dados!")
            return
            
        print(f"Total de alunos disponíveis para simulação: {len(todos_alunos)}")
        
        offset_ingressantes = 0
        alunos_ativos = [] # Lista que acumula os alunos que já entraram no curso
        
        # Loop cronológico pelos anos e semestres
        for ano in range(ano_inicio, ano_fim + 1):
            for semestre in [1, 2]:
                print(f"\n==================== SEMESTRE {ano}/{semestre} ====================")
                
                # 1. Novas Matrículas (Ingressantes da Etapa 1)
                # Pegamos um grupo novo de 40 alunos e adicionamos aos alunos ativos
                novos_ingressantes = todos_alunos[offset_ingressantes : offset_ingressantes + 40]
                if novos_ingressantes:
                    print(f"-> Ingressando novo lote de {len(novos_ingressantes)} alunos (IDs: {novos_ingressantes[0].id_aluno} a {novos_ingressantes[-1].id_aluno})")
                    alunos_ativos.extend(novos_ingressantes)
                    offset_ingressantes += 40
                else:
                    print("-> Aviso: Todos os alunos do banco já ingressaram em semestres anteriores.")
                
                # 2. Busca todas as turmas físicas cadastradas para este período letivo específico
                turmas_no_periodo = obter_turmas_disponiveis(ano, semestre)
                if not turmas_no_periodo:
                    print(f"[AVISO] Sem turmas registradas no banco para {ano}/{semestre}. Pulando período...")
                    continue
                
                # 3. Processa cada um dos alunos ativos no sistema até este momento
                matriculas_neste_semestre = 0
                for aluno in alunos_ativos:
                    # O que o aluno já passou?
                    aprovadas = obter_disciplinas_aprovadas(aluno.id_aluno)
                    
                    # O que ele está elegível para cursar com base na grade?
                    elegiveis = obter_disciplinas_elegiveis(aprovadas)
                    
                    # Dessas elegíveis, quais REALMENTE têm turma aberta no semestre atual?
                    elegiveis_com_turma = [d for d in elegiveis if d in turmas_no_periodo]
                    
                    if not elegiveis_com_turma:
                        continue # Aluno sem opções de matrícula neste período
                        
                    # Limita o número de matrículas (estudantes cursam em média de 3 a 5 disciplinas por período)
                    limite_aluno = min(len(elegiveis_com_turma), random.randint(4, 5))
                    escolhidas = random.sample(elegiveis_com_turma, limite_aluno)
                    
                    # Efetua as matrículas sorteando os conceitos
                    for disc_nome in escolhidas:
                        id_turma_escolhida = random.choice(turmas_no_periodo[disc_nome])
                        
                        # Sorteia um conceito (Dificuldade específica ou padrão)
                        conceito = sortear_conceito_etapa_1(disc_nome)
                        
                        id_matricula = matricular_aluno(aluno.id_aluno, id_turma_escolhida, conceito)
                        if id_matricula:
                            matriculas_neste_semestre += 1
                
                # Salva os progressos do semestre de forma atômica
                models.db.session.commit()
                print(f"[SUCESSO] Período {ano}/{semestre} concluído com {matriculas_neste_semestre} matrículas persistidas.")

def obter_turmas_disponiveis(ano, semestre):
    """
    Busca no banco todas as turmas abertas para o ano/semestre correspondente.
    Retorna um dicionário: { 'NOME_DA_DISCIPLINA': [id_turma1, id_turma2] }
    """
    turmas = (
        models.db.session.query(models.Disciplinas.nome, models.Turmas.id_turma)
        .join(models.Disciplinas, models.Turmas.id_disciplina == models.Disciplinas.id_disciplina)
        .filter(models.Turmas.ano == ano)
        .filter(models.Turmas.semestre == semestre)
        .all()
    )
    
    mapa_turmas = {}
    for nome_disciplina, id_turma in turmas:
        if nome_disciplina not in mapa_turmas:
            mapa_turmas[nome_disciplina] = []
        mapa_turmas[nome_disciplina].append(id_turma)
    return mapa_turmas

def obter_disciplinas_aprovadas(id_aluno):
    """
    Busca no banco de dados todas as disciplinas em que o aluno 
    obteve conceito aprovado (A, B ou C).
    """
    aprovacoes = (
        models.db.session.query(models.Disciplinas.nome)
        .join(models.Turmas, models.Disciplinas.id_disciplina == models.Turmas.id_disciplina)
        .join(models.ALunosTurmas, models.Turmas.id_turma == models.ALunosTurmas.id_turma)
        .filter(
            models.ALunosTurmas.id_aluno == id_aluno,
            models.ALunosTurmas.conceito.in_(['A', 'B', 'C'])
        )
        .all()
    )
    # Retorna um set com os nomes das disciplinas para busca rápida
    return {r[0] for r in aprovacoes}

def popular_notas_matricula(id_aluno_turma, id_turma, conceito):
    """
    Busca os conteúdos e habilidades vinculados a uma turma e gera
    as notas correspondentes com base no conceito do aluno.
    """
    # 1. Se o conceito for FF, as notas de tudo serão zero
    if conceito == 'FF':
        # Função auxiliar embutida para simplificar
        gerar_nota = lambda: 0.0
    else:
        # Define faixas de notas realistas por conceito
        faixas = {
            'A': (8.5, 10.0),
            'B': (7.5, 8.4),
            'C': (6.0, 7.4),
            'D': (3.0, 5.9)
        }
        min_nota, max_nota = faixas.get(conceito, (0.0, 10.0))
        gerar_nota = lambda: round(random.uniform(min_nota, max_nota), 1)

    try:
        # 2. Evita conflitos de escrita pendente na sessão do SQLAlchemy
        with models.db.session.no_autoflush:
            # Busca a turma e a disciplina associada
            turma_obj = models.db.session.query(models.Turmas).get(id_turma)
            disc_obj = turma_obj.disciplina if turma_obj else None
            
            if not disc_obj:
                return False

            # 3. Povoa as Notas de Conteúdos
            for cont in (disc_obj.conteudos if hasattr(disc_obj, "conteudos") else []):
                # Verifica se a nota já existe para não duplicar
                existe = models.db.session.query(models.NotasConteudos).filter_by(
                    id_aluno_turma=id_aluno_turma,
                    id_conteudo=cont.id_conteudo
                ).first()
                
                if not existe:
                    models.db.session.add(models.NotasConteudos(
                        id_aluno_turma=id_aluno_turma,
                        id_conteudo=cont.id_conteudo,
                        nota=gerar_nota()
                    ))
            
            # 4. Povoa as Notas de Habilidades
            for hab in (disc_obj.habilidades if hasattr(disc_obj, "habilidades") else []):
                # Verifica se a nota já existe para não duplicar
                existe = models.db.session.query(models.NotasHabilidades).filter_by(
                    id_aluno_turma=id_aluno_turma,
                    id_habilidade=hab.id_habilidade
                ).first()
                
                if not existe:
                    models.db.session.add(models.NotasHabilidades(
                        id_aluno_turma=id_aluno_turma,
                        id_habilidade=hab.id_habilidade,
                        nota=gerar_nota()
                    ))
            
            # Dá flush para enviar os comandos ao banco sem commitar a transação inteira ainda
            models.db.session.flush()
            return True

    except Exception as e:
        print(f"Erro ao gerar notas para matrícula {id_aluno_turma}: {e}")
        return False

if __name__ == "__main__":
    # Opcional: Se quiser limpar os testes anteriores antes de rodar
    # apagar_matriculas_e_notas() 
    
    # Executa a simulação de 2016 a 2026
    simular_trajetorias_completas(ano_inicio=2016, ano_fim=2026)