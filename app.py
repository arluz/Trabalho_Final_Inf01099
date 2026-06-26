from flask import Flask, request, render_template, redirect, url_for, abort, flash
from sqlalchemy.exc import IntegrityError
import models

from routes_alunos import alunos_bp
from routes_disciplinas import disciplinas_bp
from routes_turmas import turmas_bp
from routes_conteudos import conteudos_bp
from routes_habilidades import habilidades_bp

app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = "postgresql://postgres:12345678@localhost:5432/dados_cic"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

app.secret_key = "your_secret_key"  # Substitua por uma chave secreta real em produção

models.db.init_app(app)

app.register_blueprint(alunos_bp)
app.register_blueprint(disciplinas_bp)
app.register_blueprint(turmas_bp)
app.register_blueprint(conteudos_bp)
app.register_blueprint(habilidades_bp)

with app.app_context():
    models.db.create_all()

@app.route("/")
def index():
    return render_template('index.html')

@app.errorhandler(404)
def page_not_found(e):
    mensagem = getattr(e, 'description', 'Página não encontrada')
    return render_template('errors/404.html', mensagem=mensagem), 404

if __name__ == "__main__":
    app.run(debug=True)