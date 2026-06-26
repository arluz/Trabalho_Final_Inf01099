from flask import Flask, Blueprint, request, render_template, redirect, url_for, abort, flash
from sqlalchemy.exc import IntegrityError
import models
import re

alunos_bp = Blueprint('alunos', __name__, url_prefix='/alunos') 

@alunos_bp.route("")
def list_alunos():
    alunos = models.Alunos.query.all()
    return render_template('/Alunos/list_alunos.html', alunos=alunos)

@alunos_bp.route("/create", methods=['GET', 'POST'])
def create_alunos():
    if request.method == 'GET':
        return render_template('Alunos/create_alunos.html')
        
    if request.method == 'POST':
        nome = request.form.get('nome', '').strip()
        matricula = request.form.get('matricula', '').strip()

        if not nome or not matricula:
            flash("Nome e matrícula são campos obrigatórios.", "error")
            return render_template('Alunos/create_alunos.html')

        try:
            aluno = models.Alunos(nome=nome, matricula=matricula)
            models.db.session.add(aluno)
            models.db.session.commit()
            flash(f"Aluno {nome} criado com sucesso!", "success")
            return redirect(url_for('alunos.list_alunos'))
        
        except IntegrityError:
            models.db.session.rollback()
            flash(f"Erro ao criar aluno {nome}. Esta Matrícula já existe.", "error")
            return render_template('Alunos/create_alunos.html')
        
@alunos_bp.route("/<int:id_aluno>")
def get_aluno(id_aluno):
    aluno = models.Alunos.query.get(id_aluno)
    if aluno is None:
        abort(404, description="Aluno não encontrado")
    return render_template('Alunos/get_aluno.html', aluno=aluno)

@alunos_bp.route("/<int:id_aluno>/update", methods=['GET', 'POST'])
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
        return redirect(url_for('alunos.list_alunos'))

@alunos_bp.route("/<int:id_aluno>/delete", methods=['GET', 'POST'])
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
        return redirect(url_for('alunos.list_alunos'))
    except IntegrityError:
        models.db.session.rollback()
        flash(f"Erro ao deletar aluno {aluno.nome}.", "error")
        return redirect(url_for('alunos.get_aluno', id_aluno=id_aluno))