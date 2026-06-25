from flask import Flask, request, render_template, redirect, url_for, abort, flash
from sqlalchemy.exc import IntegrityError
import models

app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = "postgresql://postgres:12345678@localhost:5432/dados_cic"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

app.secret_key = "your_secret_key"  # Substitua por uma chave secreta real em produção

models.db.init_app(app)

with app.app_context():
    models.db.create_all()

@app.route("/")
def index():
    return render_template('index.html')

@app.route("/alunos")
def list_alunos():
    alunos = models.Alunos.query.all()
    return render_template('Alunos/list_alunos.html', alunos=alunos)

@app.route("/alunos/create", methods=['GET', 'POST'])
def create_alunos():
    if request.method == 'GET':
        return render_template('Alunos/create_alunos.html')
        
    if request.method == 'POST':
        nome = request.form.get('nome', '').strip()
        matricula = request.form.get('matricula', '').strip()

        if not nome or not matricula:
            flash("Nome e matrícula são obrigatórios.", "error")
            return render_template('Alunos/create_alunos.html')

        try:
            aluno = models.Alunos(nome=nome, matricula=matricula)
            models.db.session.add(aluno)
            models.db.session.commit()
            flash(f"Aluno {nome} criado com sucesso!", "success")
            return redirect(url_for('list_alunos'))
        
        except IntegrityError:
            models.db.session.rollback()
            flash(f"Erro ao criar aluno {nome}. Nome ou Matrícula já existe.", "error")
            return render_template('Alunos/create_alunos.html')
        
@app.route("/alunos/<int:id_aluno>")
def get_aluno(id_aluno):
    aluno = models.Alunos.query.get(id_aluno)
    if aluno is None:
        abort(404, description="Aluno não encontrado")
    return render_template('Alunos/get_aluno.html', aluno=aluno)

@app.route("/alunos/<int:id_aluno>/update", methods=['GET', 'POST'])
def update_aluno(id_aluno):
    aluno = models.Alunos.query.get(id_aluno)
    if aluno is None:
        abort(404, description="Aluno não encontrado")

    if request.method == 'GET':
        return render_template('Alunos/update_aluno.html', aluno=aluno)

    if request.method == 'POST':
        aluno.nome = request.form.get('nome')
        aluno.matricula = request.form.get('matricula')
        models.db.session.commit()
        flash(f"Aluno {aluno.nome} atualizado com sucesso!", "success")
        return redirect(url_for('list_alunos'))

@app.route("/alunos/<int:id_aluno>/delete", methods=['GET', 'POST'])
def delete_aluno(id_aluno):
    aluno = models.Alunos.query.get(id_aluno)
    if aluno is None:
        abort(404, description="Aluno não encontrado")

    if request.method == 'GET':
        return render_template('Alunos/delete_aluno.html', aluno=aluno)
    
    try:
        models.db.session.delete(aluno)
        models.db.session.commit()
        flash(f"Aluno {aluno.nome} deletado com sucesso!", "success")
        return redirect(url_for('list_alunos'))
    except IntegrityError:
        models.db.session.rollback()
        flash(f"Erro ao deletar aluno {aluno.nome}.", "error")
        return redirect(url_for('get_aluno', id_aluno=id_aluno))

if __name__ == "__main__":
    app.run(debug=True)