from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

# Association tables for many-to-many relationships
disciplinas_conteudos = db.Table(
    'disciplinas_conteudos',
    db.Column('id_disciplina', db.Integer, db.ForeignKey('disciplinas.id_disciplina'), primary_key=True),
    db.Column('id_conteudo', db.Integer, db.ForeignKey('conteudos.id_conteudo'), primary_key=True)
)

disciplinas_habilidades = db.Table(
    'disciplinas_habilidades',
    db.Column('id_disciplina', db.Integer, db.ForeignKey('disciplinas.id_disciplina'), primary_key=True),
    db.Column('id_habilidade', db.Integer, db.ForeignKey('habilidades.id_habilidade'), primary_key=True)
)

class Alunos(db.Model):
    __tablename__ = 'alunos'

    id_aluno = db.Column(db.Integer, primary_key=True, autoincrement=True)
    nome = db.Column(db.String(100), nullable=False)
    matricula = db.Column(db.Integer, unique=True, nullable=False)

class Disciplinas(db.Model):
    __tablename__ = 'disciplinas'

    id_disciplina = db.Column(db.Integer, primary_key=True, autoincrement=True)
    nome = db.Column(db.String(100), nullable=False)
    codigo = db.Column(db.String(20), unique=True, nullable=False)
    area = db.Column(db.String(2))

    conteudos = db.relationship(
        'Conteudos', 
        secondary= disciplinas_conteudos, 
        back_populates= 'disciplinas'
        )
    
    habilidades = db.relationship(
        'Habilidades', 
        secondary=disciplinas_habilidades, 
        back_populates='disciplinas'
        )

class Conteudos(db.Model):
    __tablename__ = 'conteudos'

    id_conteudo = db.Column(db.Integer, primary_key=True, autoincrement=True)
    codigo = db.Column(db.String(20), unique=True, nullable=False)
    essencialidade = db.Column(db.String(20), nullable=False)
    descricao = db.Column(db.String(500), nullable=False)

    disciplinas = db.relationship(
        'Disciplinas', 
        secondary=disciplinas_conteudos, 
        back_populates='conteudos'
        )

class Habilidades(db.Model):
    __tablename__ = 'habilidades'

    id_habilidade = db.Column(db.Integer, primary_key=True, autoincrement=True)
    codigo = db.Column(db.String(20), unique=True, nullable=False)
    essencialidade = db.Column(db.String(20), nullable=False)
    descricao = db.Column(db.String(500), nullable=False)
    proficiencia = db.Column(db.String(20), nullable=False)

    disciplinas = db.relationship(
        'Disciplinas', 
        secondary=disciplinas_habilidades, 
        back_populates='habilidades'
        )

'''
class DisciplinasConteudos(db.Model):
    __tablename__ = 'disciplinas_conteudos'

    id_disciplina = db.Column(db.Integer,
                              db.ForeignKey('disciplinas.id_disciplina'),
                              primary_key=True)
    id_conteudo = db.Column(db.Integer, 
                            db.ForeignKey('conteudos.id_conteudo'), 
                            primary_key=True)

class DisciplinasHabilidades(db.Model):
    __tablename__ = 'disciplinas_habilidades'

    id_disciplina = db.Column(db.Integer,
                              db.ForeignKey('disciplinas.id_disciplina'),
                              primary_key=True)
    id_habilidade = db.Column(db.Integer, 
                              db.ForeignKey('habilidades.id_habilidade'), 
                              primary_key=True)

'''

class Turmas(db.Model):
    __tablename__ = 'turmas'
    
    __table_args__ = (
        db.UniqueConstraint('codigo', 'ano', 'semestre', name='unique_codigo_periodo'),
    )

    id_turma = db.Column(db.Integer, primary_key=True, autoincrement=True)
    id_disciplina = db.Column(db.Integer, 
                              db.ForeignKey('disciplinas.id_disciplina'), 
                              nullable=False)
    codigo = db.Column(db.String(20), unique=False, nullable=False)
    ano = db.Column(db.Integer, nullable=False)
    semestre = db.Column(db.Integer, nullable=False)

class ALunosTurmas(db.Model):
    __tablename__ = 'aluno_turma'

    __table_args__ = (
        db.UniqueConstraint('id_turma', 'id_aluno', name='unique_aluno_turma'),
    )

    id_aluno_turma = db.Column(db.Integer, primary_key=True, autoincrement=True)
    id_aluno = db.Column(db.Integer,
                         db.ForeignKey('alunos.id_aluno'),
                         nullable=False)
    id_turma = db.Column(db.Integer,
                         db.ForeignKey('turmas.id_turma'),
                         nullable=False)    
    conceito = db.Column(db.String(2), nullable=True)

class NotasConteudos(db.Model):
    __tablename__ = 'notas_conteudos'

    __table_args__ = (
        db.UniqueConstraint('id_aluno_turma', 'id_conteudo', name='unique_nota_conteudo'),
    )

    id_nota_conteudo = db.Column(db.Integer, primary_key=True, autoincrement=True)
    id_aluno_turma = db.Column(db.Integer,
                               db.ForeignKey('aluno_turma.id_aluno_turma'),
                               nullable=False)
    id_conteudo = db.Column(db.Integer,
                            db.ForeignKey('conteudos.id_conteudo'),
                            nullable=False)
    nota = db.Column(db.Float, nullable=True)

class NotasHabilidades(db.Model):
    __tablename__ = 'notas_habilidades'

    __table_args__ = (
        db.UniqueConstraint('id_aluno_turma', 'id_habilidade', name='unique_nota_habilidade'),
    )

    id_nota_habilidade = db.Column(db.Integer, primary_key=True, autoincrement=True)
    id_aluno_turma = db.Column(db.Integer,
                               db.ForeignKey('aluno_turma.id_aluno_turma'),
                               nullable=False)
    id_habilidade = db.Column(db.Integer,
                              db.ForeignKey('habilidades.id_habilidade'),
                              nullable=False)
    nota = db.Column(db.Float, nullable=True)