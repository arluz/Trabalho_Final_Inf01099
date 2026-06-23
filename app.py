"""from flask import Flask
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = (
    "postgresql://postgres:12345678@localhost:5432/dados_cic"
)

app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

db = SQLAlchemy(app)


@app.route("/")
def home():
    return "Flask conectado ao PostgreSQL!"


if __name__ == "__main__":
    app.run(debug=True)

"""

from flask import Flask
from models import db
from models import Aluno

app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = "postgresql://postgres:12345678@localhost:5432/dados_cic"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

db.init_app(app)


@app.route("/")
def home():
    return "OK"

@app.route("/add_aluno")
def add_aluno():
    aluno = Aluno(nome="Teste", matricula="0001")
    db.session.add(aluno)
    db.session.commit()
    return "Aluno criado"

@app.route("/alunos")
def listar_alunos():
    alunos = Aluno.query.all()

    return {
        "alunos": [
            {"id": a.id_aluno, "nome": a.nome, "matricula": a.matricula}
            for a in alunos
        ]
    }

@app.route("/alunos/<int:id>")
def atualizar_aluno(id):
    aluno = Aluno.query.get(id)

    aluno.nome = "Atualizado"
    db.session.commit()

    return "Aluno atualizado"

@app.route("/alunos/delete/<int:id>")
def deletar_aluno(id):
    aluno = Aluno.query.get(id)

    db.session.delete(aluno)
    db.session.commit()

    return "Aluno deletado"

if __name__ == "__main__":
    with app.app_context():
        db.create_all()
    app.run(debug=True)

