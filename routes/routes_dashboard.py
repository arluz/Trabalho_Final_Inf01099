from flask import Flask, Blueprint, render_template, current_app
from sqlalchemy import func, case
from sqlalchemy.exc import IntegrityError
import models


import io
import base64
import matplotlib

matplotlib.use('Agg') #para impedir o matplot de tentar abrir janelas
import matplotlib.pyplot as plt
import seaborn as sns

dashboard_bp = Blueprint('dashboard', __name__, url_prefix='/dashboard')



def fig_to_base64(fig):
    """Converte um gráfico do Matplotlib para string Base64."""
    img = io.BytesIO()
    fig.savefig(img, format='png', bbox_inches='tight')
    img.seek(0)
    plt.close(fig)
    return base64.b64encode(img.getvalue()).decode('utf-8')

@dashboard_bp.route("")
def index():
    with current_app.app_context():
        # --- 1. ALUNOS EM DECLÍNIO (Alunos com múltiplos D/FF no último período) ---
        # Responde: Quando e quais alunos precisam de auxílio?
        fig, ax = plt.subplots(figsize=(6, 4))
        subquery_reprovacoes = models.db.session.query(
            models.ALunosTurmas.id_aluno,
            func.count(models.ALunosTurmas.id_aluno_turma).label('qtd_reprovacoes')
        ).join(models.Turmas).filter(models.ALunosTurmas.conceito.in_(['D', 'FF']))\
         .filter(models.Turmas.ano == 2026, models.Turmas.semestre == 1)\
         .group_by(models.ALunosTurmas.id_aluno).subquery()

        criticos = models.db.session.query(models.Alunos.nome, subquery_reprovacoes.c.qtd_reprovacoes)\
            .join(subquery_reprovacoes, models.Alunos.id_aluno == subquery_reprovacoes.c.id_aluno)\
            .order_by(subquery_reprovacoes.c.qtd_reprovacoes.desc()).limit(5).all()
        
        nomes = [c[0][:15] for c in criticos] if criticos else ['Nenhum']
        qtds = [c[1] for c in criticos] if criticos else [0]
        sns.barplot(x=qtds, y=nomes, ax=ax, palette='Reds_r')
        ax.set_title('Top 5 Alunos Críticos (2026/1)\n(Mais Reprovações no Semestre)')
        ax.set_xlabel('Quantidade de Reprovações')
        graph_declinio = fig_to_base64(fig)

        # --- 2. OSCILAÇÕES E SOBRECARGA (Média de CR por Semestre Letivo) ---
        # Responde: As quedas nas notas estão relacionadas com a etapa do curso?
        fig, ax = plt.subplots(figsize=(6, 4))
        # Mapeamento para CR
        mapeamento = case((models.ALunosTurmas.conceito == 'A', 4.0), (models.ALunosTurmas.conceito == 'B', 3.0),
                          (models.ALunosTurmas.conceito == 'C', 2.0), (models.ALunosTurmas.conceito == 'D', 1.0),
                          else_=0.0)
        oscilacao_dados = models.db.session.query(
            models.Turmas.ano, models.Turmas.semestre, func.avg(mapeamento).label('media')
        ).join(models.ALunosTurmas).group_by(models.Turmas.ano, models.Turmas.semestre)\
         .order_by(models.Turmas.ano, models.Turmas.semestre).all()
        
        periodos = [f"{d.ano}/{d.semestre}" for d in oscilacao_dados]
        medias_cr = [float(d.media) for d in oscilacao_dados]
        sns.lineplot(x=periodos, y=medias_cr, marker='o', ax=ax, color='orange')
        ax.set_title('Oscilação de Desempenho Histórico (CR Médio)')
        ax.set_xticklabels(periodos, rotation=45, ha='right')
        ax.set_ylabel('Maturidade/CR')
        graph_oscilacao = fig_to_base64(fig)

        # --- 3. ALTERAÇÕES CURRICULARES (Disciplinas Gargalo) ---
        # Responde: Onde devem haver alterações curriculares?
        fig, ax = plt.subplots(figsize=(6, 4))
        gargalos = models.db.session.query(
            models.Disciplinas.nome, func.count(models.ALunosTurmas.id_aluno_turma).label('reprovacoes')
        ).join(models.Turmas, models.Disciplinas.id_disciplina == models.Turmas.id_disciplina)\
         .join(models.ALunosTurmas, models.Turmas.id_turma == models.ALunosTurmas.id_turma)\
         .filter(models.ALunosTurmas.conceito.in_(['D', 'FF']))\
         .group_by(models.Disciplinas.nome).order_by(func.count(models.ALunosTurmas.id_aluno_turma).desc()).limit(5).all()

        disc_nomes = [g[0][:20] for g in gargalos] if gargalos else ['Nenhuma']
        disc_reprov = [g[1] for g in gargalos] if gargalos else [0]
        sns.barplot(x=disc_reprov, y=disc_nomes, ax=ax, palette='inferno')
        ax.set_title('Gargalos do Currículo\n(Total de Reprovações Históricas)')
        graph_curriculo = fig_to_base64(fig)

        # --- 4. EVOLUÇÃO DAS TURMAS AO LONGO DO TEMPO (Média Geral de Conteúdos) ---
        # Responde: Como o desempenho das turmas vem mudando ao longo do tempo?
        fig, ax = plt.subplots(figsize=(6, 4))
        evolucao_notas = models.db.session.query(
            models.Turmas.ano, func.avg(models.NotasConteudos.nota).label('nota_media')
        ).join(models.ALunosTurmas, models.Turmas.id_turma == models.ALunosTurmas.id_turma)\
         .join(models.NotasConteudos, models.ALunosTurmas.id_aluno_turma == models.NotasConteudos.id_aluno_turma)\
         .group_by(models.Turmas.ano).order_by(models.Turmas.ano).all()

        anos = [str(e.ano) for e in evolucao_notas]
        notas_ano = [float(e.nota_media) for e in evolucao_notas]
        sns.barplot(x=anos, y=notas_ano, ax=ax, color='skyblue')
        ax.set_title('Evolução do Domínio de Conteúdo por Ano')
        ax.set_ylabel('Nota Média (0-10)')
        ax.set_ylim(0, 10)
        graph_evolucao = fig_to_base64(fig)

    return render_template(
        'dashboard.html',
        graph_declinio=graph_declinio,
        graph_oscilacao=graph_oscilacao,
        graph_curriculo=graph_curriculo,
        graph_evolucao=graph_evolucao
    )

import json
import plotly.graph_objects as go
import plotly.utils
from flask import Blueprint, render_template, current_app
import models
from sqlalchemy import case

# Reutilizando seu Blueprint existente (ou dashboard_bp)
@dashboard_bp.route('/trajetoria')
def trajetoria_3d():
    # 1. Mapeamento numérico dos períodos para o eixo X
    def converter_periodo_para_num(ano, semestre):
        return ano + (0.5 if semestre == 2 else 0.0)

    # 2. Definição do Fluxo Curricular para rastrear o eixo Y
    FLUXO = [
        ["PENSAMENTO COMPUTACIONAL", "ALGORITMOS E PROGRAMAÇÃO", "INTRODUÇÃO À CIÊNCIA DA COMPUTAÇÃO", "CÁLCULO E GEOMETRIA ANALÍTICA I - A", "LÓGICA PARA COMPUTAÇÃO"],
        ["TESTE E VERIFICAÇÃO DE SOFTWARE", "MATEMÁTICA DISCRETA B", "ARQUITETURA DE COMPUTADORES", "ESTRUTURAS DE DADOS", "PROBABILIDADE E ESTATÍSTICA", "CÁLCULO E GEOMETRIA ANALÍTICA II - A"],
        ["TEORIA DA COMPUTAÇÃO I - LINGUAGENS FORMAIS E AUTÔMATOS", "PROJETO DE CIRCUITOS DIGITAIS", "PROJETO E ANÁLISE DE ALGORITMOS I", "DESENVOLVIMENTO DE SOFTWARE", "BANCOS DE DADOS"],
        ["TEORIA DA COMPUTAÇÃO II - COMPUTABILIDADE E COMPLEXIDADE", "PROJETO E ANÁLISE DE ALGORITMOS II", "ORGANIZAÇÃO DE COMPUTADORES", "ÁLGEBRA LINEAR I - A", "ENGENHARIA DE SOFTWARE", "INTERAÇÃO HUMANO-COMPUTADOR E EXPERIÊNCIA DO USUÁRIO"],
        ["SISTEMAS OPERACIONAIS", "INTELIGÊNCIA ARTIFICIAL", "CÁLCULO NUMÉRICO A", "PROJETO EM CIÊNCIA E INOVAÇÃO", "COMPUTAÇÃO GRÁFICA E VISUALIZAÇÃO I"],
        ["REDES DE COMPUTADORES", "APRENDIZADO DE MÁQUINA", "PROCESSAMENTO DE IMAGENS E VISÃO COMPUTACIONAL I", "PROGRAMAÇÃO PARALELA", "COMPILADORES"],
        ["CIBERSEGURANÇA", "SISTEMAS DISTRIBUÍDOS E TOLERANTES A FALHAS", "PROJETO E ANÁLISE DE ALGORITMOS III", "PROCESSAMENTO DE LINGUAGEM NATURAL"]
    ]
    
    # Dicionário reverso: Nome da disciplina -> Número do Semestre na Grade
    mapa_grade = {}
    for num_sem, lista in enumerate(FLUXO, start=1):
        for disc in lista:
            mapa_grade[disc.strip().upper()] = num_sem

    # 3. Consulta os dados brutos de histórico do banco
    mapeamento_cr = case(
        (models.ALunosTurmas.conceito == 'A', 9.0),
        (models.ALunosTurmas.conceito == 'B', 8.0),
        (models.ALunosTurmas.conceito == 'C', 6.0),
        (models.ALunosTurmas.conceito == 'D', 4.0),
        else_=0.0
    )

    historicos = models.db.session.query(
        models.Alunos.id_aluno,
        models.Alunos.nome.label('aluno_nome'),
        models.Turmas.ano,
        models.Turmas.semestre,
        models.Disciplinas.nome.label('disc_nome'),
        mapeamento_cr.label('nota_num')
    ).join(models.ALunosTurmas, models.Alunos.id_aluno == models.ALunosTurmas.id_aluno)\
     .join(models.Turmas, models.ALunosTurmas.id_turma == models.Turmas.id_turma)\
     .join(models.Disciplinas, models.Turmas.id_disciplina == models.Disciplinas.id_disciplina)\
     .order_by(models.Alunos.id_aluno, models.Turmas.ano, models.Turmas.semestre).all()

    # 4. Agrupa os dados por aluno na memória
    dados_alunos = {}
    for h in historicos:
        if h.id_aluno not in dados_alunos:
            dados_alunos[h.id_aluno] = {'nome': h.aluno_nome, 'x': [], 'y': [], 'z': [], 'text': []}
        
        disc_limpa = h.disc_nome.strip().upper()
        semestre_grade = mapa_grade.get(disc_limpa, 1) # Fallback para 1º sem caso falhe a string
        
        pos_x = converter_periodo_para_num(h.ano, h.semestre)
        
        dados_alunos[h.id_aluno]['x'].append(pos_x)
        dados_alunos[h.id_aluno]['y'].append(semestre_grade)
        dados_alunos[h.id_aluno]['z'].append(float(h.nota_num))
        dados_alunos[h.id_aluno]['text'].append(f"{h.disc_nome}<br>Período: {h.ano}/{h.semestre}<br>CR: {h.nota_num}")

    # 5. Monta o gráfico com as trajetórias em 3D (limitado a 30 alunos para performance)
    fig = go.Figure()
    for id_aluno, dados in list(dados_alunos.items())[:30]:
        fig.add_trace(go.Scatter3d(
            x=dados['x'],
            y=dados['y'],
            z=dados['z'],
            mode='lines+markers',
            marker=dict(size=4, opacity=0.7),
            line=dict(width=3),
            name=dados['nome'],
            hovertext=dados['text'],
            hoverinfo='text'
        ))

    fig.update_layout(
        title="Navegação Tridimensional das Trajetórias Acadêmicas (2016 - 2026)",
        scene=dict(
            xaxis_title='Linha do Tempo (Anos)',
            yaxis_title='Etapa Curricular (Semestre)',
            zaxis_title='Desempenho (CR)',
            zaxis=dict(range=[0, 4])
        ),
        margin=dict(l=0, r=0, b=0, t=40),
        template="plotly_white"
    )

    # Converte o objeto do Plotly para JSON para renderizar via JavaScript de forma leve
    graph_json = json.dumps(fig, cls=plotly.utils.PlotlyJSONEncoder)
    return render_template('trajetoria.html', graph_json=graph_json)