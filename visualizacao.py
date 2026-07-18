import plotly.graph_objects as go
import models
from flask import current_app

def gerar_grafico_trajetoria(id_aluno):
    """
    Busca o histórico do aluno e gera um componente HTML interativo 
    usando Plotly representando sua trajetória acadêmica.
    """
    # Mapeamento de conceitos para o Eixo Y
    mapeamento_conceitos = {
        'FF': 0,
        'D': 1,
        'C': 2,
        'B': 3,
        'A': 4
    }
    
    with current_app.app_context():
        # 1. Consulta as matrículas do aluno ordenadas cronologicamente
        historico = (
            models.db.session.query(
                models.ALunosTurmas.conceito,
                models.Turmas.ano,
                models.Turmas.semestre,
                models.Turmas.codigo.label("codigo_turma"),
                models.Disciplinas.nome.label("nome_disciplina")
            )
            .join(models.Turmas, models.ALunosTurmas.id_turma == models.Turmas.id_turma)
            .join(models.Disciplinas, models.Turmas.id_disciplina == models.Disciplinas.id_disciplina)
            .filter(models.ALunosTurmas.id_aluno == id_aluno)
            .order_by(models.Turmas.ano, models.Turmas.semestre, models.Disciplinas.nome)
            .all()
        )
        
        if not historico:
            return "<p class='text-danger'>Nenhum histórico de matrículas encontrado para este aluno.</p>"
            
        # 2. Processa os dados para o gráfico
        eixo_x = []
        eixo_y = []
        hover_text = []
        colors = []
        
        for registro in historico:
            conceito = registro.conceito or 'FF'
            valor_y = mapeamento_conceitos.get(conceito, 0)
            
            # Monta o rótulo do eixo X (Nome da Disciplina + Período)
            label_x = f"{registro.nome_disciplina}<br>({registro.ano}/{registro.semestre})"
            eixo_x.append(label_x)
            eixo_y.append(valor_y)
            
            # Informações detalhadas que aparecem ao passar o mouse (Hover)
            hover = (
                f"<b>Disciplina:</b> {registro.nome_disciplina}<br>"
                f"<b>Período:</b> {registro.ano}/{registro.semestre}<br>"
                f"<b>Turma:</b> {registro.codigo_turma}<br>"
                f"<b>Conceito:</b> {conceito}"
            )
            hover_text.append(hover)
            
            # Define cores lógicas para os nós (Verde para aprovação, Vermelho para reprovação)
            if conceito in ['A', 'B', 'C']:
                colors.append('#2ecc71') # Verde
            else:
                colors.append('#e74c3c') # Vermelho
                
        # 3. Cria o gráfico no Plotly
        fig = go.Figure()
        
        # Linha que conecta a trajetória
        fig.add_trace(go.Scatter(
            x=eixo_x,
            y=eixo_y,
            mode='lines+markers',
            name='Trajetória',
            line=dict(color='#3498db', width=2),
            marker=dict(
                size=12,
                color=colors,
                line=dict(color='#ffffff', width=2)
            ),
            text=hover_text,
            hoverinfo='text'
        ))
        
        # 4. Estilização do Layout
        fig.update_layout(
            title=dict(
                text="<b>Trajetória Acadêmica Individual por Período</b>",
                font=dict(size=18, color='#2c3e50')
            ),
            xaxis=dict(
                title="Disciplinas Cursadas (Ordem Cronológica)",
                tickangle=45,
                gridcolor='#f0f0f0'
            ),
            yaxis=dict(
                title="Desempenho (Conceitos)",
                tickvals=[0, 1, 2, 3, 4],
                ticktext=['FF (0)', 'D (1)', 'C (2)', 'B (3)', 'A (4)'],
                range=[-0.5, 4.5],
                gridcolor='#e0e0e0'
            ),
            plot_bgcolor='white',
            paper_bgcolor='white',
            height=500,
            margin=dict(l=60, r=30, t=80, b=120)
        )
        
        # Exporta o gráfico diretamente como um bloco de div HTML auto-executável
        # include_plotlyjs='cdn' faz o Flask carregar o script do Plotly de forma leve
        div_html = fig.to_html(full_html=False, include_plotlyjs='cdn')
        return div_html

def gerar_grafico_historico_semestral():
    """
    Gera um gráfico de barras lado a lado mostrando o total de 
    aprovados vs reprovados por semestre (2016 a 2026).
    """
    with current_app.app_context():
        # Agrupa e conta matrículas por ano, semestre e tipo de resultado
        resultados = (
            models.db.session.query(
                models.Turmas.ano,
                models.Turmas.semestre,
                models.ALunosTurmas.conceito,
                models.db.func.count(models.ALunosTurmas.id_aluno_turma).label('total')
            )
            .join(models.Turmas, models.ALunosTurmas.id_turma == models.Turmas.id_turma)
            .group_by(models.Turmas.ano, models.Turmas.semestre, models.ALunosTurmas.conceito)
            .order_by(models.Turmas.ano, models.Turmas.semestre)
            .all()
        )

        # Processa os dados agregando em Aprovados (A, B, C) e Reprovados (D, FF)
        dados_processados = {}
        for ano, sem, conc, total in resultados:
            periodo = f"{ano}/{sem}"
            if periodo not in dados_processados:
                dados_processados[periodo] = {'aprovados': 0, 'reprovados': 0}
            
            if conc in ['A', 'B', 'C']:
                dados_processados[periodo]['aprovados'] += total
            else:
                dados_processados[periodo]['reprovados'] += total

        periodos = list(dados_processados.keys())
        aprovados = [dados_processados[p]['aprovados'] for p in periodos]
        reprovados = [dados_processados[p]['reprovados'] for p in periodos]

        # Monta o gráfico de barras lado a lado
        fig = go.Figure()
        fig.add_trace(go.Bar(x=periodos, y=reprovados, name='Reprovados', marker_color="#be675e"))
        fig.add_trace(go.Bar(x=periodos, y=aprovados, name='Aprovados', marker_color="#6ab489"))
        

        fig.update_layout(
            title="<b>Evolução Aprovações e Reprovações por Semestre</b>",
            barmode='group',
            xaxis=dict(title="Semestre Letivo", tickangle=45),
            yaxis=dict(title="Quantidade de Alunos"),
            plot_bgcolor='white',
            height=450
        )

        return fig.to_html(full_html=False, include_plotlyjs='cdn')
    
''' 
#Gráfico Heatmap
def gerar_heatmap_desempenho_global():
    """
    Gera um Heatmap cruzando Disciplinas (Y) e Semestres (X).
    A intensidade da cor representa a nota média geral da célula.
    """
    with current_app.app_context():
        # Consulta a nota média agrupada por Disciplina e por Período Letivo
        dados = (
            models.db.session.query(
                models.Turmas.ano,
                models.Turmas.semestre,
                models.Disciplinas.nome.label("disciplina"),
                models.db.func.avg(models.NotasConteudos.nota).label("media_nota")
            )
            .select_from(models.ALunosTurmas)  # Define a tabela central como ponto de partida
            .join(models.Turmas, models.ALunosTurmas.id_turma == models.Turmas.id_turma)
            .join(models.Disciplinas, models.Turmas.id_disciplina == models.Disciplinas.id_disciplina)
            .join(models.NotasConteudos, models.NotasConteudos.id_aluno_turma == models.ALunosTurmas.id_aluno_turma)
            .group_by(models.Turmas.ano, models.Turmas.semestre, models.Disciplinas.nome)
            .order_by(models.Turmas.ano, models.Turmas.semestre, models.Disciplinas.nome)
            .all()
        )

        if not dados:
            return "<p class='text-danger'>Dados insuficientes para gerar o Heatmap.</p>"

        # Organiza estruturas para o formato matriz exigido pelo Plotly Heatmap
        semestres_set = sorted(list({f"{d.ano}/{d.semestre}" for d in dados}))
        disciplinas_set = sorted(list({d.disciplina for d in dados}))

        # Inicializa a matriz com None (ou 0)
        matriz_notas = [[None for _ in semestres_set] for _ in disciplinas_set]

        # Mapeia os índices para preenchimento rápido
        semestre_idx = {sem: i for i, sem in enumerate(semestres_set)}
        disciplina_idx = {disc: i for i, disc in enumerate(disciplinas_set)}

        for d in dados:
            p_id = f"{d.ano}/{d.semestre}"
            x = semestre_idx[p_id]
            y = disciplina_idx[d.disciplina]
            matriz_notas[y][x] = round(d.media_nota, 2) if d.media_nota is not None else 0

        # Monta o gráfico de calor
        fig = go.Figure(data=go.Heatmap(
            z=matriz_notas,
            x=semestres_set,
            y=disciplinas_set,
            colorscale='RdYlGn',  # Vermelho (notas baixas) para Verde (notas altas)
            colorbar=dict(title='Nota Média'),
            hovertemplate='<b>Disciplina:</b> %{y}<br><b>Semestre:</b> %{x}<br><b>Média:</b> %{z}<extra></extra>'
        ))

        fig.update_layout(
            title="<b>Mapa de Calor: Desempenho Médio por Disciplina ao Longo dos Anos</b>",
            xaxis=dict(title="Semestre Letivo", tickangle=45),
            yaxis=dict(title="Disciplinas"),
            height=600,
            plot_bgcolor='white'
        )

        return fig.to_html(full_html=False, include_plotlyjs='cdn')

#Gráfico de Dispersão com Jitter e Densidade
def gerar_heatmap_desempenho_global():
    """
    Gera um Gráfico de Dispersão com Jitter e Transparência mostrando 
    a distribuição de todas as notas por semestre usando go.Box.
    """
    with current_app.app_context():
        dados = (
            models.db.session.query(
                models.Turmas.ano,
                models.Turmas.semestre,
                models.NotasConteudos.nota
            )
            .select_from(models.ALunosTurmas)
            .join(models.Turmas, models.ALunosTurmas.id_turma == models.Turmas.id_turma)
            .join(models.NotasConteudos, models.NotasConteudos.id_aluno_turma == models.ALunosTurmas.id_aluno_turma)
            .order_by(models.Turmas.ano, models.Turmas.semestre)
            .all()
        )

        if not dados:
            return "<p class='text-danger'>Dados insuficientes para gerar o gráfico.</p>"

        eixo_x = [f"{d.ano}/{d.semestre}" for d in dados]
        eixo_y = [float(d.nota) for d in dados]

        fig = go.Figure()

        # Usamos go.Box configurado para esconder a caixa e exibir apenas os pontos com jitter
        fig.add_trace(go.Box(
            x=eixo_x,
            y=eixo_y,
            boxpoints='all',      # Força a exibição de todos os pontos
            jitter=0.3,           # Agora o parâmetro jitter é válido aqui
            pointpos=0,           # Centraliza os pontos na linha do eixo X
            fillcolor='rgba(0,0,0,0)', # Torna a caixa invisível
            line=dict(color='rgba(0,0,0,0)'), # Torna as linhas da caixa invisíveis
            marker=dict(
                color='#34495e',
                opacity=0.15,     # Mantém o efeito de densidade
                size=5
            ),
            name='Notas'
        ))

        fig.update_layout(
            title="<b>Distribuição e Densidade de Notas por Semestre Letivo</b>",
            xaxis=dict(title="Semestre Letivo", tickangle=45),
            yaxis=dict(title="Notas (0 a 10)", range=[-0.5, 10.5]),
            plot_bgcolor='white',
            showlegend=False,
            height=550
        )

        return fig.to_html(full_html=False, include_plotlyjs='cdn')'''

#Bloxplot
def gerar_heatmap_desempenho_global():
    """
    Gera um Boxplot Coletivo mostrando a distribuição estatística 
    das notas por semestre letivo.
    """
    with current_app.app_context():
        dados = (
            models.db.session.query(
                models.Turmas.ano,
                models.Turmas.semestre,
                models.NotasConteudos.nota
            )
            .select_from(models.ALunosTurmas)
            .join(models.Turmas, models.ALunosTurmas.id_turma == models.Turmas.id_turma)
            .join(models.NotasConteudos, models.NotasConteudos.id_aluno_turma == models.ALunosTurmas.id_aluno_turma)
            .order_by(models.Turmas.ano, models.Turmas.semestre)
            .all()
        )

        if not dados:
            return "<p class='text-danger'>Dados insuficientes para gerar o Boxplot.</p>"

        eixo_x = [f"{d.ano}/{d.semestre}" for d in dados]
        eixo_y = [float(d.nota) for d in dados]

        fig = go.Figure()

        # Adiciona os boxplots coletivos por período
        fig.add_trace(go.Box(
            x=eixo_x,
            y=eixo_y,
            boxpoints=False,         # Oculta pontos individuais para focar na estatística limpa
            marker_color="#4686b1",  # Cor azul sólida para as caixas
            line=dict(width=1.5),
            name='Desempenho'
        ))

        fig.update_layout(
            title="<b>Análise Boxplot de Notas por Semestre Letivo</b>",
            xaxis=dict(title="Semestre Letivo", tickangle=45),
            yaxis=dict(title="Notas (0 a 10)", range=[-0.5, 10.5]),
            plot_bgcolor='white',
            showlegend=False,
            height=550
        )

        return fig.to_html(full_html=False, include_plotlyjs='cdn')
    
def gerar_grafico_volume_matriculas():
    """
    Gera um gráfico de linha mostrando a evolução da 
    quantidade total de matrículas por semestre.
    """
    with current_app.app_context():
        # Conta o total de matrículas agrupadas por período letivo
        dados = (
            models.db.session.query(
                models.Turmas.ano,
                models.Turmas.semestre,
                models.db.func.count(models.ALunosTurmas.id_aluno_turma).label('total_matriculas')
            )
            .join(models.Turmas, models.ALunosTurmas.id_turma == models.Turmas.id_turma)
            .group_by(models.Turmas.ano, models.Turmas.semestre)
            .order_by(models.Turmas.ano, models.Turmas.semestre)
            .all()
        )

        if not dados:
            return "<p class='text-danger'>Dados insuficientes para gerar o gráfico de matrículas.</p>"

        periodos = [f"{d.ano}/{d.semestre}" for d in dados]
        totais = [d.total_matriculas for d in dados]

        fig = go.Figure()

        # Adiciona a linha de evolução
        fig.add_trace(go.Scatter(
            x=periodos,
            y=totais,
            mode='lines+markers',
            line=dict(color="#88559c", width=3), # Cor roxa para diferenciar dos outros
            marker=dict(size=8),
            name='Matrículas'
        ))

        fig.update_layout(
            title="<b>Volume de Matrículas Ativas por Semestre</b>",
            xaxis=dict(title="Semestre Letivo", tickangle=45),
            yaxis=dict(title="Quantidade de Matrículas"),
            plot_bgcolor='white',
            height=450
        )

        return fig.to_html(full_html=False, include_plotlyjs='cdn')