import random
from app import app
from models import db, Alunos, Disciplinas, Turmas, ALunosTurmas

def gerar_turmas_sinteticas():
    with app.app_context():
        print('Comecando a criação de turmas sinteticas...')

    disciplinas = Disciplinas.query.all()
    alunos = Alunos.query.all()

    semestres = [20161, 20162, 20171, 20172, 20181, 20182, 20191, 20192, 20201, 20202, 20211, 20212, 20221, 20222, 20231, 20232, 20241, 20242, 20251, 20252, 20261]
    codigos_turmas = ['A', 'B', 'U']
    conceitos_possiveis = ['A', 'B', 'C', 'D', 'FF', None]

    turmas_criadas = []

    print(f"Gerando turmas para {len(disciplinas)} disciplinas...")

    for disc in disciplinas:
        num_semestres = random.randint(1, 3)
        semestres_escolhidos = random.sample(semestres, min(num_semestres, len(semestres)))
        
        for sem in semestres_escolhidos:
            ano_num = int(str(sem)[:4])
            sem_num = int(str(sem)[4:])

        tipo_semestre = random.choice(['UNICA', 'REGULAR'])

        codigos_a_criar = []
        if tipo_semestre == 'UNICA':
            codigos_a_criar.append('U')
        else:
            codigos_a_criar.append('A')

            if random.choice([True, False]):
                codigos_a_criar.append('B')
        
        for codigo_t in codigos_a_criar:
            turma_existe = Turmas.query.filter_by(
                id_disciplina=disc.id_disciplina,
                codigo=codigo_t,
                ano=ano_num,
                semestre=sem_num
            )db.session.add(nova_turma)
            turmas_criadas.append(nova_turma)

db.session.commit()
print(f"")