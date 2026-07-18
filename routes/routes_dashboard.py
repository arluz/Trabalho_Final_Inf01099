from flask import Flask, Blueprint, request, render_template, redirect, url_for, abort, flash
from sqlalchemy.exc import IntegrityError
import models
import visualizacao
#from visualizacao import gerar_grafico_trajetoria

dashboard_bp = Blueprint('dashboard', __name__, url_prefix='/dashboard')

@dashboard_bp.route("")
def dashboard():
    # Gera o HTML interativo de ambos os gráficos
    grafico_barras_html = visualizacao.gerar_grafico_historico_semestral()
    grafico_heatmap_html = visualizacao.gerar_heatmap_desempenho_global()
    grafico_matriculas_html = visualizacao.gerar_grafico_volume_matriculas()
    
    # Renderiza o template passando as variáveis dos gráficos
    return render_template(
        'dashboard.html',
        grafico_barras=grafico_barras_html,
        grafico_heatmap=grafico_heatmap_html, #Na verdade é o Bloxplot
        grafico_matriculas=grafico_matriculas_html
    )
    
'''
@dashboard_bp.route('/trajetoria')
def ver_trajetoria():
    # Obtém o id_aluno vindo da URL (ex: /trajetoria?aluno_id=42)
    id_aluno = request.args.get('aluno_id', type=int)
    
    # Busca a lista de alunos ordenada para alimentar o seletor (dropdown) no HTML
    alunos = models.db.session.query(models.Alunos).order_by(models.Alunos.nome).all()
    
    grafico_html = None
    aluno_selecionado = None
    
    if id_aluno:
        aluno_selecionado = models.db.session.query(models.Alunos).get(id_aluno)
        if aluno_selecionado:
            # Chama a função que criamos para renderizar o div interativo
            grafico_html = visualizacao.gerar_grafico_trajetoria(id_aluno)
            
    return render_template(
        'trajetoria.html', 
        alunos=alunos, 
        grafico_html=grafico_html,
        aluno_selecionado=aluno_selecionado
    )'''
    
@dashboard_bp.route('/trajetoria')
def ver_trajetoria():
    # Obtém o id_aluno e o critério de ordenação (padrão é 'nome')
    id_aluno = request.args.get('aluno_id', type=int)
    ordem = request.args.get('ordenar_por', default='nome')
    
    # Define a ordenação do banco de dados dinamicamente
    if ordem == 'id':
        query_ordem = models.Alunos.id_aluno
    else:
        query_ordem = models.Alunos.nome

    # Busca a lista de alunos com a ordenação escolhida
    alunos = models.db.session.query(models.Alunos).order_by(query_ordem).all()
    
    grafico_html = None
    aluno_selecionado = None
    
    if id_aluno:
        aluno_selecionado = models.db.session.query(models.Alunos).get(id_aluno)
        if aluno_selecionado:
            grafico_html = visualizacao.gerar_grafico_trajetoria(id_aluno)
            
    return render_template(
        'trajetoria.html', 
        alunos=alunos, 
        grafico_html=grafico_html,
        aluno_selecionado=aluno_selecionado,
        ordem_atual=ordem 
    )