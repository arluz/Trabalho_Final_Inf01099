from flask import Flask, Blueprint, request, render_template, redirect, url_for, abort, flash
from sqlalchemy.exc import IntegrityError
import models
from models import db, Turmas, Disciplinas, ALunosTurmas, Alunos

turmas_bp = Blueprint('turmas', __name__, url_prefix='/turmas')

@turmas_bp.route("")
def list_turmas():
    turmas_com_disciplinas = db.session.query(
        models.Turmas, models.Disciplinas).join(
        models.Disciplinas, models.Turmas.id_disciplina == models.Disciplinas.id_disciplina
    ).all()
    
    todas_disciplinas = models.Disciplinas.query.all()
    return render_template('Turmas/list_turmas.html', 
                           turmas=turmas_com_disciplinas, 
                           disciplinas=todas_disciplinas)

@turmas_bp.route("/create", methods=['GET', 'POST'])
def create_turma():
    disciplinas = models.Disciplinas.query.all()

    if request.method == 'GET':
        return render_template('/Turmas/create_turma.html', disciplinas=disciplinas)

    if request.method == 'POST':
        id_disciplina = request.form.get('id_disciplina')        
        codigo = request.form.get('codigo', '').strip().upper()
        #ano = request.form.get('ano', '').strip()
        semestre = request.form.get('semestre', '').strip()

        if not id_disciplina or not codigo or not semestre:
            flash("Todos os campos são obrigatórios.", "danger")
            return render_template('/Turmas/create_turma.html')
        
        # Busca a disciplina no banco para pegar o ID correto através do código vindo do HTML
        disciplina = models.Disciplinas.query.filter_by(codigo=id_disciplina).first()
        if not disciplina:
            flash("Disciplina selecionada inválida.", "danger")
            return render_template('/Turmas/create_turma.html', disciplinas=disciplinas)
        
        try:
            ano_str, sem_str = semestre.split('/')
            ano_str = int(ano_str)
            sem_str = int(sem_str)
        except ValueError:
            flash("Formato de semestre inválido. Use o padrão ANO/SEMESTRE (Ex: 2026/1).", "danger")
            return render_template('/Turmas/create_turma.html', disciplinas=disciplinas)
    
        try:
            nova_turma = models.Turmas(
                id_disciplina=disciplina.id_disciplina,
                codigo=codigo,
                ano=ano_str,
                semestre=sem_str
            )
            models.db.session.add(nova_turma)
            models.db.session.commit()
            flash(f"Turma {codigo} criada com sucesso!", "success")
            return redirect(url_for('turmas.list_turmas'))

        except IntegrityError:
            models.db.session.rollback()
            flash("Erro ao criar turma.", "danger")
            return render_template('/Turmas/create_turma.html', disciplinas=disciplinas)

@turmas_bp.route("/<int:id_turma>")
def get_turma(id_turma):
    #Busca disciplina e a turma correspondente usando JOIN
    resultado = db.session.query(models.Turmas, models.Disciplinas).join(
        models.Disciplinas, models.Turmas.id_disciplina == models.Disciplinas.id_disciplina
    ).filter(models.Turmas.id_turma == id_turma).first()

    if not resultado:
        abort(404, description="Turma não encontrada")

    turma, disciplina = resultado

    # Busca as matrículas desta turma trazendo os dados dos alunos associados
    lista_matriculas = db.session.query(ALunosTurmas, Alunos).join(
        Alunos, ALunosTurmas.id_aluno == Alunos.id_aluno
    ).filter(ALunosTurmas.id_turma == id_turma).all()

    return render_template('Turmas/get_turma.html', 
                           turma=turma,
                           disciplina=disciplina,
                           lista_matriculas=lista_matriculas)

@turmas_bp.route("/<int:id_turma>/update", methods=['GET', 'POST'])
def update_turma(id_turma):

    turma = models.Turmas.query.get_or_404(id_turma)
    disciplinas = models.Disciplinas.query.all()

    if request.method == 'GET':         
        disciplina_atual = models.Disciplinas.query.get(turma.id_disciplina)
        semestre_formatado = f"{turma.ano}/{turma.semestre}"
        return render_template('/Turmas/update_turma.html', 
                           turma=turma,  
                           disciplinas=disciplinas, 
                           disciplina_atual=disciplina_atual,
                           semestre_formatado=semestre_formatado)

    if request.method == 'POST':
        codigo_disciplina = request.form.get('id_disciplina', '').strip()        
        codigo = request.form.get('codigo', '').strip().upper()
        semestre_raw = request.form.get('semestre', '').strip()

        if not codigo_disciplina or not codigo or not semestre_raw:
            flash("Todos os campos são obrigatórios.", "danger")
            return redirect(url_for('turmas.update_turma', id_turma=id_turma))

        disciplina = models.Disciplinas.query.filter_by(codigo=codigo_disciplina).first()
        if not disciplina:
            flash("Disciplina selecionada inválida.", "danger")
            return redirect(url_for('turmas.update_turma', id_turma=id_turma))

        try:
            ano_str, sem_str = semestre_raw.split('/')
            ano_num = int(ano_str)
            sem_num = int(sem_str)
        except ValueError:
            flash("Formato de semestre inválido. Use o padrão ANO/SEMESTRE (Ex: 2026/1).", "danger")
            return redirect(url_for('turmas.update_turma', id_turma=id_turma))

        try:
            turma.id_disciplina = disciplina.id_disciplina
            turma.codigo = codigo
            turma.ano = ano_num
            turma.semestre = sem_num
            
            models.db.session.commit()
            flash(f"Turma {codigo} atualizada com sucesso!", "success")
            return redirect(url_for('turmas.list_turmas'))

        except IntegrityError:
            models.db.session.rollback()
            flash("Erro ao atualizar: O código informado já está em uso por outra turma.", "danger")
            return redirect(url_for('turmas.update_turma', id_turma=id_turma))
        
@turmas_bp.route("/<int:id_turma>/delete", methods=['GET', 'POST'])
def delete_turma(id_turma):
    turma = models.Turmas.query.get_or_404(id_turma)

    if request.method == 'GET':
        return render_template('/Turmas/delete_turma.html', turma=turma)

    if request.method == 'POST':
        try:
            models.db.session.delete(turma)
            models.db.session.commit()
            flash(f"Turma {turma.codigo} deletada com sucesso!", "success")
            return redirect(url_for('turmas.list_turmas'))
        except IntegrityError:
            models.db.session.rollback()
            flash("Erro ao deletar turma.", "danger")
            return redirect(url_for('turmas.list_turmas'))

@turmas_bp.route("/<int:id_turma>/gerenciar_alunos", methods=['GET', 'POST'])
def gerenciar_alunos(id_turma):
    turma = models.Turmas.query.get_or_404(id_turma)
    
    if request.method == 'GET':
        # Busca a disciplina para exibir bonito na página
        disciplina = models.Disciplinas.query.get(turma.id_disciplina)
        todos_alunos = models.Alunos.query.all()
        matriculados_ids = [
            a.id_aluno for a in models.ALunosTurmas.query.filter_by(id_turma=id_turma).all()
        ]
        return render_template(
            'Turmas/gerenciar_alunos.html',
            turma=turma,
            alunos=todos_alunos,
            matriculados_ids=matriculados_ids,
            disciplina=disciplina
        )

    if request.method == 'POST':
        # IDs que o usuário marcou na tela (desejados)
        ids_vinda_form = set(int(x) for x in request.form.getlist('alunos_ids'))
        
        # O que já existe no banco atualmente
        matriculas_atuais = models.ALunosTurmas.query.filter_by(id_turma=id_turma).all()
        ids_no_banco = set(m.id_aluno for m in matriculas_atuais)

        try:
            # 1. ADICIONAR: Quem está no form mas não está no banco
            for id_aluno in (ids_vinda_form - ids_no_banco):
                nova_matricula = models.ALunosTurmas(
                    id_turma=id_turma,
                    id_aluno=id_aluno,
                    conceito=None
                )
                models.db.session.add(nova_matricula)

            # 2. REMOVER: Quem está no banco mas foi desmarcado no form
            for matricula in matriculas_atuais:
                if matricula.id_aluno not in ids_vinda_form:
                    # Trava de segurança: Se já tiver nota, não deixa apagar por acidente
                    if matricula.conceito is not None:
                        flash(f"Não foi possível remover alguns alunos pois eles já possuem conceito lançado.", "warning")
                        continue
                    models.db.session.delete(matricula)

            models.db.session.commit()
            flash('Alunos da turma atualizados com segurança!', 'success')
            return redirect(url_for('turmas.get_turma', id_turma=id_turma))
        
        except IntegrityError:
            models.db.session.rollback()
            flash('Erro ao salvar as alterações.', 'danger')
            return redirect(url_for('turmas.gerenciar_alunos', id_turma=id_turma))