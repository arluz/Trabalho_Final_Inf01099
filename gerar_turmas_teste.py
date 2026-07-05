from app import app, models
from models import db, Alunos, Disciplinas, Turmas, ALunosTurmas
from sqlalchemy.exc import IntegrityError
    
def criar_turma(id_disciplina, codigo, ano, semestre):
    with app.app_context():
        disciplina = models.db.session.get(models.Disciplinas, id_disciplina)
        if not disciplina:
            print(f"Disciplina com ID: {id_disciplina} não encontrada, cadastramento cancelado.")
            return None
        
        nova_turma = models.Turmas(
            id_disciplina=id_disciplina,
            codigo=codigo,
            ano=ano,
            semestre=semestre
        )
        
        try:
            models.db.session.add(nova_turma)
            models.db.session.commit()
            print(f"Turma '{codigo}' criada com sucesso (ID: {nova_turma.id_turma}).")
            return nova_turma.id_turma
        except IntegrityError:
            models.db.session.rollback()
            print(f"Erro: O código de turma '{codigo}' já existe.")
            return None

def matricular_alunos(id_turma, lista_ids_alunos):
    with app.app_context():
        turma = models.db.session.get(models.Turmas, id_turma)
        if not turma:
            print(f"Erro: Turma com ID {id_turma} não encontrada.")
            return None
        
        matriculas_com_sucesso = 0
        
        for id_aluno in lista_ids_alunos:
            aluno = models.db.session.get(models.Alunos, id_aluno)
            if not aluno:
                print(f"Erro: Aluno com ID {id_aluno} não encontrada.")
                return None
            
            vinculo = models.ALunosTurmas(id_aluno=id_aluno, id_turma=id_turma, conceito=None)
            models.db.session.add(vinculo)
            
            try:
                models.db.session.commit()
                matriculas_com_sucesso += 1
            except IntegrityError:
                models.db.session.rollback()
                print(f"Aluno '{aluno.nome}' (ID: {id_aluno}) já está matriculado nesta turma.")

        print(f"Matrículas concluídas: {matriculas_com_sucesso} alunos adicionados à turma '{turma.codigo}'.")
        return True

if __name__ == "__main__":
    #id_teste = 4
    #criar_turma(id_disciplina=id_teste, codigo="A", ano=2026, semestre=1)
    
    nova_turma = criar_turma(id_disciplina=4, codigo="U", ano=2026, semestre=2)
    
    if nova_turma:
        alunos_teste = [ 4, 2, 3]
        matricular_alunos(nova_turma, alunos_teste)