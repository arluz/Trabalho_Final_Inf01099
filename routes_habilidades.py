from flask import Flask, Blueprint, request, render_template, redirect, url_for, abort, flash
from sqlalchemy.exc import IntegrityError
import models
import re

habilidades_bp = Blueprint('habilidades', __name__)



@habilidades_bp.route("")
def list_habilidades():
    habilidades = models.Habilidades.query.all()
    return render_template('Habilidades/list_habilidades.html', habilidades=habilidades)

@habilidades_bp.route("/create", methods=['GET', 'POST'])
def create_habilidades():
    if request.method == 'GET':
        return render_template('Habilidades/create_habilidades.html')
        
    if request.method == 'POST':
        codigo = request.form.get('codigo', '').strip()
        nivel = request.form.get('nivel', '').strip()
        descricao = request.form.get('descricao', '').strip()
        proficiencia = request.form.get('proficiencia', '').strip()

        if not codigo or not nivel or not descricao or not proficiencia:
            flash("Todos os campos são obrigatórios.", "error")
            return render_template('Habilidades/create_habilidades.html')

        try:
            habilidade = models.Habilidades(codigo=codigo, nivel=nivel, descricao=descricao, proficiencia=proficiencia)
            models.db.session.add(habilidade)
            models.db.session.commit()
            flash(f"Habilidade {codigo} criada com sucesso!", "success")
            return redirect(url_for('habilidades.list_habilidades'))
        except IntegrityError:
            models.db.session.rollback()
            flash(f"Erro ao criar habilidade {codigo}. Verifique os dados e tente novamente.", "error")
            return render_template('Habilidades/create_habilidades.html')

@habilidades_bp.route("/<int:id_habilidade>")
def get_habilidade(id_habilidade):
    habilidade = models.Habilidades.query.get(id_habilidade)
    if habilidade is None:
        abort(404, description="Habilidade não encontrada")
    return render_template('Habilidades/get_habilidade.html', habilidade=habilidade)

@habilidades_bp.route("/<int:id_habilidade>/update", methods=['GET', 'POST'])
def update_habilidade(id_habilidade):
    habilidade = models.Habilidades.query.get(id_habilidade)
    if habilidade is None:
        abort(404, description="Habilidade não encontrada")

    if request.method == 'GET':
        return render_template('Habilidades/update_habilidade.html', habilidade=habilidade)

    if request.method == 'POST':
        habilidade.codigo = request.form.get('codigo')
        habilidade.nivel = request.form.get('nivel')
        habilidade.descricao = request.form.get('descricao')
        habilidade.proficiencia = request.form.get('proficiencia')
        models.db.session.commit()
        flash(f"Habilidade {habilidade.codigo} atualizada com sucesso!", "success")
        return redirect(url_for('habilidades.list_habilidades'))

@habilidades_bp.route("/<int:id_habilidade>/delete", methods=['GET', 'POST'])
def delete_habilidade(id_habilidade):
    habilidade = models.Habilidades.query.get(id_habilidade)
    if habilidade is None:
        abort(404, description="Habilidade não encontrada")

    if request.method == 'GET':
        return render_template('Habilidades/delete_habilidade.html', habilidade=habilidade)

    try:
        models.db.session.delete(habilidade)
        models.db.session.commit()
        flash(f"Habilidade {habilidade.codigo} deletada com sucesso!", "success")
        return redirect(url_for('habilidades.list_habilidades'))
    except IntegrityError:
        models.db.session.rollback()
        flash(f"Erro ao deletar habilidade {habilidade.codigo}. Verifique se ela esta associada a alguma disciplina.", "error")