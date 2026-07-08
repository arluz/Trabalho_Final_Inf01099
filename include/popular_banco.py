import random
from app import app, models

# 1. Definição da Grade Curricular
FLUXO_CURRICULAR = [
    # 1º Semestre
    [
        "PENSAMENTO COMPUTACIONAL", 
        "ALGORITMOS E PROGRAMAÇÃO", 
        "INTRODUÇÃO À CIÊNCIA DA COMPUTAÇÃO", 
        "CÁLCULO E GEOMETRIA ANALÍTICA I - A", 
        "LÓGICA PARA COMPUTAÇÃO"
    ],
    # 2º Semestre
    [
        "TESTE E VERIFICAÇÃO DE SOFTWARE", 
        "MATEMÁTICA DISCRETA B", 
        "ARQUITETURA DE COMPUTADORES", 
        "ESTRUTURAS DE DADOS", 
        "PROBABILIDADE E ESTATÍSTICA", 
        "CÁLCULO E GEOMETRIA ANALÍTICA II - A"
    ],
    # 3º Semestre
    [
        "TEORIA DA COMPUTAÇÃO I - LINGUAGENS FORMAIS E AUTÔMATOS", 
        "PROJETO DE CIRCUITOS DIGITAIS", 
        "PROJETO E ANÁLISE DE ALGORITMOS I", 
        "DESENVOLVIMENTO DE SOFTWARE", 
        "BANCOS DE DADOS"
    ],
    # 4º Semestre
    [
        "TEORIA DA COMPUTAÇÃO II - COMPUTABILIDADE E COMPLEXIDADE", 
        "PROJETO E ANÁLISE DE ALGORITMOS II", 
        "ORGANIZAÇÃO DE COMPUTADORES", 
        "ÁLGEBRA LINEAR I - A", 
        "ENGENHARIA DE SOFTWARE", 
        "INTERAÇÃO HUMANO-COMPUTADOR E EXPERIÊNCIA DO USUÁRIO"
    ],
    # 5º Semestre
    [
        "SISTEMAS OPERACIONAIS", 
        "INTELIGÊNCIA ARTIFICIAL", 
        "CÁLCULO NUMÉRICO A", 
        "PROJETO EM CIÊNCIA E INOVAÇÃO", 
        "COMPUTAÇÃO GRÁFICA E VISUALIZAÇÃO I"
    ],
    # 6º Semestre
    [
        "REDES DE COMPUTADORES", 
        "APRENDIZADO DE MÁQUINA", 
        "PROCESSAMENTO DE IMAGENS E VISÃO COMPUTACIONAL I", 
        "PROGRAMAÇÃO PARALELA", 
        "COMPILADORES"  # Ajustado: removido o "I" que não existia no banco
    ],
    # 7º Semestre
    [
        "CIBERSEGURANÇA", 
        "SISTEMAS DISTRIBUÍDOS E TOLERANTES A FALHAS", 
        "PROJETO E ANÁLISE DE ALGORITMOS III", 
        "PROCESSAMENTO DE LINGUAGEM NATURAL"
    ]
]

def determinar_proximo_codigo(ano, semestre, codigos_gerados_no_periodo):
    """Define a próxima letra baseado no banco E no que já foi gerado na memória."""
    # Busca o que já existe consolidado no banco
    turmas_no_banco = models.db.session.query(models.Turmas.codigo)\
        .filter_by(ano=ano, semestre=semestre).all()
    
    # Une os códigos do banco com os códigos gerados na memória nesta rodada
    codigos_totais = [t.codigo for t in turmas_no_banco] + codigos_gerados_no_periodo

    if not codigos_totais:
        return 'A' 
    if 'A' in codigos_totais and 'B' not in codigos_totais:
        return 'B'
    
    # Se já tem A e B (ou se começou com U), mantém 'U'
    return 'U'

def rodar_simulacao_completa():
    with app.app_context():
        # 1. Carrega dados do banco
        mapeamento_disciplinas = {d.nome.strip().upper(): d.id_disciplina for d in models.db.session.query(models.Disciplinas).all()}
        todos_alunos = models.db.session.query(models.Alunos).order_by(models.Alunos.id_aluno).all()
        
        print(f" [INFO] Alunos carregados: {len(todos_alunos)} | Disciplinas carregadas: {len(mapeamento_disciplinas)}")
        
        periodos = [(ano, sem) for ano in range(2016, 2026) for sem in [1, 2]] + [(2026, 1)]
        historico_alunos = {}
        ponteiro_aluno = 0

        # Contador global para sabermos se algo chegou a ser gerado na memória
        total_turmas_geradas = 0
        total_matriculas_geradas = 0

        for ano, semestre in periodos:
            codigos_gerados_no_periodo = []

            # Ingressantes (45 alunos)
            for _ in range(45):
                if ponteiro_aluno < len(todos_alunos):
                    aluno = todos_alunos[ponteiro_aluno]
                    historico_alunos[aluno.id_aluno] = {"semestre_atual": 1, "disciplinas_concluidas": set()}
                    ponteiro_aluno += 1

            print(f" Processando Período: {ano}/{semestre} | Alunos ativos no sistema: {len(historico_alunos)}")

            # Distribuição nas turmas
            for num_semestre_grade, disciplinas_do_semestre in enumerate(FLUXO_CURRICULAR, start=1):
                for nome_disc in disciplinas_do_semestre:
                    id_disc = mapeamento_disciplinas.get(nome_disc.strip().upper())
                    if not id_disc:
                        # Se o print abaixo aparecer, a string ainda está desalinhada
                        # print(f" Alerta: Disciplina '{nome_disc}' não encontrada no banco.")
                        continue

                    alunos_aptos = [
                        id_aluno for id_aluno, dados in historico_alunos.items()
                        if dados["semestre_atual"] == num_semestre_grade and id_disc not in dados["disciplinas_concluidas"]
                    ]

                    if not alunos_aptos:
                        continue

                    qtd_turma = min(len(alunos_aptos), random.randint(28, 45))
                    alunos_turma = random.sample(alunos_aptos, qtd_turma)

                    codigo_turma = determinar_proximo_codigo(ano, semestre, codigos_gerados_no_periodo)
                    codigos_gerados_no_periodo.append(codigo_turma)

                    # Tenta criar a turma
                    try:
                        nova_turma = models.Turmas(id_disciplina=id_disc, codigo=codigo_turma, ano=ano, semestre=semestre)
                        models.db.session.add(nova_turma)
                        models.db.session.flush() # Força o banco a gerar o id_turma
                        total_turmas_geradas += 1

                        for id_aluno in alunos_turma:
                            if random.random() < 0.85:
                                conceito = random.choice(['A', 'B', 'C'])
                                historico_alunos[id_aluno]["disciplinas_concluidas"].add(id_disc)
                            else:
                                conceito = random.choice(['D', 'FF'])

                            vinculo = models.ALunosTurmas(id_aluno=id_aluno, id_turma=nova_turma.id_turma, conceito=conceito)
                            models.db.session.add(vinculo)
                            total_matriculas_geradas += 1

                    except Exception as e:
                        print(f" Erro ao estruturar turma/matrícula na memória: {e}")
                        models.db.session.rollback()

            # Força o commit do semestre corrente
            try:
                models.db.session.commit()
                print(f"   Semestre {ano}/{semestre} gravado com sucesso no banco!")
            except Exception as e:
                print(f" ERRO CRÍTICO NO COMMIT de {ano}/{semestre}: {e}")
                models.db.session.rollback()

            # Progressão dos alunos
            for id_aluno, dados in list(historico_alunos.items()):
                sem_atual = dados["semestre_atual"]
                if sem_atual > len(FLUXO_CURRICULAR):
                    continue

                disciplinas_esperadas = [
                    mapeamento_disciplinas[n.strip().upper()] 
                    for n in FLUXO_CURRICULAR[sem_atual - 1] 
                    if n.strip().upper() in mapeamento_disciplinas
                ]
                
                if all(d_id in dados["disciplinas_concluidas"] for d_id in disciplinas_esperadas):
                    historico_alunos[id_aluno]["semestre_atual"] += 1

        print(f"\n Resumo Final da Execução:")
        print(f"   - Total de Turmas enviadas ao banco: {total_turmas_geradas}")
        print(f"   - Total de Matrículas enviadas ao banco: {total_matriculas_geradas}")
        
if __name__ == "__main__":
    rodar_simulacao_completa()