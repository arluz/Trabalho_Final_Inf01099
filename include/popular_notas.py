from app import app, models
import random

def gerar_nota_por_conceito(conceito):
    """
    Retorna uma nota numérica realista correspondente ao conceito.
    """
    if conceito == 'FF':
        return 0.0
    
    faixas = {
        'A': (8.5, 10.0),
        'B': (7.5, 8.4),
        'C': (6.0, 7.4),
        'D': (3.0, 5.9)
    }
    min_nota, max_nota = faixas.get(conceito, (0.0, 10.0))
    return round(random.uniform(min_nota, max_nota), 1)


def popular_notas_de_matriculas_existentes():
    print("\n========================================================")
    print("INICIANDO PREENCHIMENTO DE NOTAS PARA MATRÍCULAS EXISTENTES")
    print(" (Consultas diretas via Joins - Sem alterar o models.py)")
    print("========================================================")
    
    with app.app_context():
        # 1. Busca todas as matrículas ativas com conceito
        matriculas = (
            models.db.session.query(models.ALunosTurmas)
            .filter(models.ALunosTurmas.conceito.isnot(None))
            .all()
        )
        
        total_matriculas = len(matriculas)
        print(f"Total de matrículas com conceitos encontradas no banco: {total_matriculas}")
        
        if total_matriculas == 0:
            print("Nenhuma matrícula encontrada para processar.")
            return

        notas_conteudo_criadas = 0
        notas_habilidade_criadas = 0
        matriculas_processadas = 0

        for mat in matriculas:
            with models.db.session.no_autoflush:
                # 2. Descobre o id_disciplina associado a essa matrícula fazendo join manual
                id_disciplina = (
                    models.db.session.query(models.Turmas.id_disciplina)
                    .filter(models.Turmas.id_turma == mat.id_turma)
                    .scalar()
                )
                
                if not id_disciplina:
                    continue

                # 3. Busca os Conteúdos associados a essa disciplina através da tabela de associação disciplinas_conteudos
                conteudos_da_disciplina = (
                    models.db.session.query(models.Conteudos)
                    .join(models.disciplinas_conteudos, models.Conteudos.id_conteudo == models.disciplinas_conteudos.c.id_conteudo)
                    .filter(models.disciplinas_conteudos.c.id_disciplina == id_disciplina)
                    .all()
                )

                # 4. Busca as Habilidades associadas a essa disciplina através da tabela de associação disciplinas_habilidades
                habilidades_da_disciplina = (
                    models.db.session.query(models.Habilidades)
                    .join(models.disciplinas_habilidades, models.Habilidades.id_habilidade == models.disciplinas_habilidades.c.id_habilidade)
                    .filter(models.disciplinas_habilidades.c.id_disciplina == id_disciplina)
                    .all()
                )

                # --- GERAR NOTAS DE CONTEÚDOS ---
                for cont in conteudos_da_disciplina:
                    # Evita duplicados verificando a existência prévia
                    existe = models.db.session.query(models.NotasConteudos).filter_by(
                        id_aluno_turma=mat.id_aluno_turma,
                        id_conteudo=cont.id_conteudo
                    ).first()
                    
                    if not existe:
                        nota_num = gerar_nota_por_conceito(mat.conceito)
                        models.db.session.add(models.NotasConteudos(
                            id_aluno_turma=mat.id_aluno_turma,
                            id_conteudo=cont.id_conteudo,
                            nota=nota_num
                        ))
                        notas_conteudo_criadas += 1

                # --- GERAR NOTAS DE HABILIDADES ---
                for hab in habilidades_da_disciplina:
                    # Evita duplicados verificando a existência prévia
                    existe = models.db.session.query(models.NotasHabilidades).filter_by(
                        id_aluno_turma=mat.id_aluno_turma,
                        id_habilidade=hab.id_habilidade
                    ).first()
                    
                    if not existe:
                        nota_num = gerar_nota_por_conceito(mat.conceito)
                        models.db.session.add(models.NotasHabilidades(
                            id_aluno_turma=mat.id_aluno_turma,
                            id_habilidade=hab.id_habilidade,
                            nota=nota_num
                        ))
                        notas_habilidade_criadas += 1
            
            matriculas_processadas += 1
            
            # Commit em blocos de 100 registros para garantir ótimo desempenho
            if matriculas_processadas % 100 == 0:
                models.db.session.commit()
                print(f" -> {matriculas_processadas}/{total_matriculas} matrículas processadas...")

        # Salva qualquer registro remanescente
        models.db.session.commit()
        
        print("\n========================================================")
        print("[SUCESSO] Processamento de Notas Concluído!")
        print(f" -> Matrículas analisadas: {matriculas_processadas}")
        print(f" -> Notas de Conteúdos criadas: {notas_conteudo_criadas}")
        print(f" -> Notas de Habilidades criadas: {notas_habilidade_criadas}")
        print("========================================================")


if __name__ == "__main__":
    popular_notas_de_matriculas_existentes()