from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()


class Aluno(db.Model):
    __tablename__ = "alunos"

    id_aluno = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100), nullable=False)
    matricula = db.Column(db.String(50), unique=True, nullable=False)


class Disciplina(db.Model):
    __tablename__ = "disciplinas"

    id_disciplina = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100), nullable=False)
    codigo = db.Column(db.String(30), unique=True, nullable=False)
    area = db.Column(db.String(100))

class Turma(db.Model):
    __tablename__ = "turmas"

    id_turma = db.Column(db.Integer, primary_key=True)
    id_disciplina = db.Column(db.Integer, db.ForeignKey("disciplinas.id_disciplina"), nullable=False)
    semestre = db.Column(db.String(20), nullable=False)
    ano = db.Column(db.Integer, nullable=False)
    nome_turma = db.Column(db.String(50), nullable=False)


class AlunoTurma(db.Model):
    __tablename__ = "alunos_turmas"

    id_aluno_turma = db.Column(db.Integer, primary_key=True)
    id_aluno = db.Column(db.Integer, db.ForeignKey("alunos.id_aluno"), nullable=False)
    id_turma = db.Column(db.Integer, db.ForeignKey("turmas.id_turma"), nullable=False)
    conceito_final = db.Column(db.String(2))


class Conteudo(db.Model):
    __tablename__ = "conteudos"

    id_conteudo = db.Column(db.Integer, primary_key=True)
    id_disciplina = db.Column(db.Integer, db.ForeignKey("disciplinas.id_disciplina"), nullable=False)
    codigo = db.Column(db.String(20), nullable=False)
    nivel = db.Column(db.String(50), nullable=False)
    descricao = db.Column(db.Text, nullable=False)


class Habilidade(db.Model):
    __tablename__ = "habilidades"

    id_habilidade = db.Column(db.Integer, primary_key=True)
    id_disciplina = db.Column(db.Integer, db.ForeignKey("disciplinas.id_disciplina"), nullable=False)
    codigo = db.Column(db.String(20), nullable=False)
    nivel = db.Column(db.String(50), nullable=False)
    proficiencia = db.Column(db.String(50), nullable=False)
    descricao = db.Column(db.Text, nullable=False)


class NotaConteudo(db.Model):
    __tablename__ = "notas_conteudos"

    id = db.Column(db.Integer, primary_key=True)
    id_aluno_turma = db.Column(db.Integer, db.ForeignKey("alunos_turmas.id_aluno_turma"), nullable=False)
    id_conteudo = db.Column(db.Integer, db.ForeignKey("conteudos.id_conteudo"), nullable=False)
    nota = db.Column(db.Numeric(4, 2), nullable=False)


class NotaHabilidade(db.Model):
    __tablename__ = "notas_habilidades"

    id = db.Column(db.Integer, primary_key=True)
    id_aluno_turma = db.Column(db.Integer, db.ForeignKey("alunos_turmas.id_aluno_turma"), nullable=False)
    id_habilidade = db.Column(db.Integer, db.ForeignKey("habilidades.id_habilidade"), nullable=False)
    nota = db.Column(db.Numeric(4, 2), nullable=False)