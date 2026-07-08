import random

# Lista completa de disciplinas por semestre da grade
FLUXO_CURRICULAR = [
    ["Pensamento Computacional", "Algoritmos e Programação", "Introdução à Ciência da Computação", "CÁLCULO E GEOMETRIA ANALÍTICA I - A", "Lógica para Computação"],
    ["Teste e Verificação de Software", "MATEMÁTICA DISCRETA B", "Arquitetura de Computadores", "Estruturas de Dados", "PROBABILIDADE E ESTATÍSTICA", "CÁLCULO E GEOMETRIA ANALÍTICA II - A"],
    ["Teoria da Computação I - Linguagens Formais e Autômatos", "Projeto de Circuitos Digitais", "Projeto e Análise de Algoritmos I", "Desenvolvimento de Software", "Bancos de Dados"],
    ["Teoria da Computação II - Computabilidade e Complexidade", "Projeto e Análise de Algoritmos II", "Organização de Computadores", "ÁLGEBRA LINEAR I - A", "Engenharia de Software", "Interação Humano-Computador e Experiência do Usuário"],
    ["Sistemas Operacionais", "Inteligência Artificial", "CÁLCULO NUMÉRICO A", "Projeto em Ciência e Inovação", "Computação Gráfica e Visualização I"],
    ["Redes de Computadores", "Aprendizado de Máquina", "Processamento de Imagens e Visão Computacional I", "Programação Paralela", "Compiladores I"],
    ["Cibersegurança", "Sistemas Distribuídos e Tolerantes a Falhas", "Projeto e Análise de Algoritmos III", "Processamento de Linguagem Natural"]
]

def simular_sem_banco():
    mapeamento_disciplinas = {}
    id_fake = 1
    for semestre in FLUXO_CURRICULAR:
        for nome_disc in semestre:
            mapeamento_disciplinas[nome_disc.strip().upper()] = id_fake
            id_fake += 1
    
    todos_alunos_ids = list(range(1, 1251))
    periodos = [(ano, sem) for ano in range(2016, 2026) for sem in [1, 2]] + [(2026, 1)]
    historico_alunos = {}
    ponteiro_aluno = 0

    # Abre o arquivo de texto para escrita
    with open("arvore_historica.txt", "w", encoding="utf-8") as f:
        for ano, semestre in periodos:
            f.write(f"\n========================================\n")
            f.write(f" PERÍODO CALENDÁRIO: {ano}/{semestre}\n")
            f.write(f"========================================\n")

            novos = 0
            for _ in range(45):
                if ponteiro_aluno < len(todos_alunos_ids):
                    id_aluno = todos_alunos_ids[ponteiro_aluno]
                    historico_alunos[id_aluno] = {"semestre_atual": 1, "disciplinas_concluidas": set()}
                    ponteiro_aluno += 1
                    novos += 1
            f.write(f"- [Ingressantes]: {novos} novos alunos começaram (Ponteiro geral: {ponteiro_aluno}).\n")

            for num_semestre_grade, disciplinas_do_semestre in enumerate(FLUXO_CURRICULAR, start=1):
                for nome_disc in disciplinas_do_semestre:
                    id_disc = mapeamento_disciplinas.get(nome_disc.strip().upper())

                    alunos_aptos = [
                        id_aluno for id_aluno, dados in historico_alunos.items()
                        if dados["semestre_atual"] == num_semestre_grade and id_disc not in dados["disciplinas_concluidas"]
                    ]

                    if not alunos_aptos:
                        continue

                    qtd_turma = min(len(alunos_aptos), random.randint(33, 45))
                    alunos_turma = random.sample(alunos_aptos, qtd_turma)

                    f.write(f"\n   🏫 Turma: {nome_disc} ({num_semestre_grade}º Sem da Grade)\n")
                    f.write(f"      Matriculados: {len(alunos_turma)}\n")

                    aprovados, reprovados = 0, 0
                    for id_aluno in alunos_turma:
                        if random.random() < 0.90:
                            historico_alunos[id_aluno]["disciplinas_concluidas"].add(id_disc)
                            aprovados += 1
                        else:
                            reprovados += 1
                            f.write(f"      - Aluno ID {id_aluno} rodou e ficou retido nesta matéria.\n")

                    f.write(f"       Resultado: {aprovados} Aprovados | {reprovados} Reprovados\n")

            # Atualização de Semestre da Grade
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
                    dados["semestre_atual"] += 1
                    
    # --- ADICIONE ESTE BLOCO NO FINAL DO SEU SCRIPT (DENTRO DO WITH OPEN) ---
        f.write("\n\n========================================\n")
        f.write("🔍 AUDITORIA DE TRAJETÓRIA INDIVIDUAL (AMOSTRAGEM)\n")
        f.write("========================================\n")
        
        # Pega 3 alunos de períodos diferentes para auditar
        alunos_auditoria = [1, 200, 450] 
        
        for id_auditoria in alunos_auditoria:
            if id_auditoria in historico_alunos:
                dados = historico_alunos[id_auditoria]
                f.write(f"\n Histórico do Aluno ID: {id_auditoria}\n")
                f.write(f"   Último Semestre alcançado na Grade: {dados['semestre_atual']}º Sem\n")
                f.write(f"   Total de Disciplinas Concluídas: {len(dados['disciplinas_concluidas'])}\n")
                f.write(f"   IDs das matérias limpas: {sorted(list(dados['disciplinas_concluidas']))}\n")

    print(" Arquivo 'arvore_historica.txt' gerado com sucesso!")

if __name__ == "__main__":
    simular_sem_banco()