from flask import Flask, Blueprint, request, render_template, redirect, url_for, abort, flash
from sqlalchemy.exc import IntegrityError
import models

conteudos_bp = Blueprint('conteudos', __name__, url_prefix='/conteudos')

@conteudos_bp.route("")
def list_conteudos():
    conteudos = models.Conteudos.query.all()
    return render_template('Conteudos/list_conteudos.html', conteudos=conteudos)

@conteudos_bp.route("/create", methods=['GET', 'POST'])
def create_conteudos():
    if request.method == 'GET':
        return render_template('Conteudos/create_conteudos.html')
        
    if request.method == 'POST':
        codigo = request.form.get('codigo', '').strip()
        essencialidade = request.form.get('essencialidade', '').strip()
        descricao = request.form.get('descricao', '').strip()

        if not codigo or not essencialidade or not descricao:
            flash("Todos os campos são obrigatórios.", "error")
            return render_template('Conteudos/create_conteudos.html')

        try:
            conteudo = models.Conteudos(codigo=codigo, essencialidade=essencialidade, descricao=descricao)
            models.db.session.add(conteudo)
            models.db.session.commit()
            flash(f"Conteúdo {codigo} criado com sucesso!", "success")
            return redirect(url_for('conteudos.list_conteudos'))
        except IntegrityError:
            models.db.session.rollback()
            flash(f"Erro ao criar conteúdo {codigo}. Verifique os dados e tente novamente.", "error")
            return render_template('Conteudos/create_conteudos.html')

@conteudos_bp.route("/<int:id_conteudo>")
def get_conteudo(id_conteudo):
    conteudo = models.Conteudos.query.get(id_conteudo)
    if conteudo is None:
        abort(404, description="Conteúdo não encontrado")
    return render_template('Conteudos/get_conteudo.html', conteudo=conteudo)

@conteudos_bp.route("/<int:id_conteudo>/update", methods=['GET', 'POST'])
def update_conteudo(id_conteudo):
    conteudo = models.Conteudos.query.get(id_conteudo)
    if conteudo is None:
        abort(404, description="Conteúdo não encontrado")

    if request.method == 'GET':
        return render_template('Conteudos/update_conteudo.html', conteudo=conteudo)

    if request.method == 'POST':
        conteudo.codigo = request.form.get('codigo')
        conteudo.essencialidade = request.form.get('essencialidade')
        conteudo.descricao = request.form.get('descricao')
        models.db.session.commit()
        flash(f"Conteúdo {conteudo.codigo} atualizado com sucesso!", "success")
        return redirect(url_for('conteudos.list_conteudos'))

@conteudos_bp.route("/<int:id_conteudo>/delete", methods=['GET', 'POST'])
def delete_conteudo(id_conteudo):
    conteudo = models.Conteudos.query.get(id_conteudo)
    if conteudo is None:
        abort(404, description="Conteúdo não encontrado")
    
    if request.method == 'GET':
        return render_template('Conteudos/delete_conteudo.html', conteudo=conteudo)

    try:
        models.db.session.delete(conteudo)
        models.db.session.commit()
        flash(f"Conteúdo {conteudo.codigo} deletado com sucesso!", "success")
        return redirect(url_for('conteudos.list_conteudos'))
    except IntegrityError:
        models.db.session.rollback()
        flash(f"Erro ao deletar conteúdo {conteudo.codigo}. Verifique se ele esta associado a alguma disciplina.", "error")