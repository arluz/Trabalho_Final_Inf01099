from flask import Flask, Blueprint, request, render_template, redirect, url_for, abort, flash
from sqlalchemy.exc import IntegrityError
import models

disciplinas_bp = Blueprint('disciplinas', __name__, url_prefix='/disciplinas')

@disciplinas_bp.route("")
def list_disciplinas():
    disciplinas = models.Disciplinas.query.all()
    return render_template('/Disciplinas/list_disciplinas.html', disciplinas=disciplinas)

@disciplinas_bp.route("/create", methods=['GET', 'POST'])
def create_disciplinas():
    if request.method == 'GET':
        return render_template('Disciplinas/create_disciplinas.html')
        
    if request.method == 'POST':
        nome = request.form.get('nome', '').strip()
        codigo = request.form.get('codigo', '').strip()
        area = request.form.get('area')

        if not nome or not codigo:
            flash("Nome e código são obrigatórios.", "error")
            return render_template('Disciplinas/create_disciplinas.html')

        try:
            disciplina = models.Disciplinas(nome=nome, codigo=codigo, area=area)
            models.db.session.add(disciplina)
            models.db.session.commit()
            flash(f"Disciplina {nome} criada com sucesso!", "success")
            return redirect(url_for('disciplinas.list_disciplinas'))
        except IntegrityError:
            models.db.session.rollback()
            flash(f"Erro ao criar {nome}. Esta Disciplina já existe ou este código pertence a outra disciplina.", "error")
            return render_template('Disciplinas/create_disciplinas.html')

@disciplinas_bp.route("/<int:id_disciplina>")
def get_disciplina(id_disciplina):
    disciplina = models.Disciplinas.query.get(id_disciplina)
    if disciplina is None:
        abort(404, description="Disciplina não encontrada")
    return render_template('Disciplinas/get_disciplina.html', disciplina=disciplina)

@disciplinas_bp.route("/<int:id_disciplina>/update", methods=['GET', 'POST'])
def update_disciplina(id_disciplina):
    disciplina = models.Disciplinas.query.get(id_disciplina)
    if disciplina is None:
        abort(404, description="Disciplina não encontrada")

    if request.method == 'GET':
        return render_template('Disciplinas/update_disciplina.html', disciplina=disciplina)

    if request.method == 'POST':
        disciplina.nome = request.form.get('nome')
        disciplina.codigo = request.form.get('codigo')
        disciplina.area = request.form.get('area')
        models.db.session.commit()
        flash(f"Disciplina {disciplina.nome} atualizada com sucesso!", "success")
        return render_template('Disciplinas/get_disciplina.html', disciplina=disciplina)
    
@disciplinas_bp.route("/<int:id_disciplina>/delete", methods=['GET', 'POST'])
def delete_disciplina(id_disciplina):
    disciplina = models.Disciplinas.query.get(id_disciplina)
    if disciplina is None:
        abort(404, description="Disciplina não encontrada")

    if request.method == 'GET':
        return render_template('Disciplinas/delete_disciplina.html', disciplina=disciplina)

    if request.method == 'POST':
        models.db.session.delete(disciplina)
        models.db.session.commit()
        flash(f"Disciplina {disciplina.nome} deletada com sucesso!", "success")
        return redirect(url_for('disciplinas.list_disciplinas'))
