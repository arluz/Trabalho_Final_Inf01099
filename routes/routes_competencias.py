from flask import Blueprint, request, render_template, redirect, url_for, flash, abort
from sqlalchemy.exc import IntegrityError
import models

competencias_bp = Blueprint('competencias', __name__, url_prefix='/disciplinas')

@competencias_bp.route("/<int:id_disciplina>/gerenciar_competencias", methods=['GET', 'POST'])
def gerenciar_competencias(id_disciplina):
    disciplina = models.Disciplinas.query.get(id_disciplina)
    if disciplina is None:
        abort(404, description="Disciplina não encontrada")
    
    if request.method == 'GET':
        todos_conteudos = models.Conteudos.query.all()
        todas_habilidades = models.Habilidades.query.all()

        return render_template(
            'Disciplinas/gerenciar_competencias.html',
            disciplina=disciplina, 
            conteudos=todos_conteudos, 
            habilidades=todas_habilidades
        )

    if request.method == 'POST':
        conteudos_ids = request.form.getlist('conteudos_ids')
        habilidades_ids = request.form.getlist('habilidades_ids')

        try:
            disciplina.conteudos = models.Conteudos.query.filter(
                models.Conteudos.id_conteudo.in_(conteudos_ids)).all()
                
            disciplina.habilidades = models.Habilidades.query.filter(
                models.Habilidades.id_habilidade.in_(habilidades_ids)).all()
            
            models.db.session.commit()
            flash('Competências atualizadas com sucesso!', 'success')
            return redirect(url_for('disciplinas.get_disciplina', id_disciplina=id_disciplina))
        
        except IntegrityError:
            models.db.session.rollback()
            flash('Erro ao atualizar competências. Por favor, tente novamente.', 'danger')
            return redirect(url_for('competencias.gerenciar_competencias', id_disciplina=id_disciplina))