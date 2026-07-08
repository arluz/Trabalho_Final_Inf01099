from app import app, models
from sqlalchemy import func, case

def extrair_dados_cr():
    with app.app_context():
        # Mapeia conceitos para valores numéricos (A=4, B=3, C=2, D=1, FF=0)
        conceito_numerico = case(
            (models.ALunosTurmas.conceito == 'A', 9.0),
            (models.ALunosTurmas.conceito == 'B', 8.0),
            (models.ALunosTurmas.conceito == 'C', 6.0),
            (models.ALunosTurmas.conceito == 'D', 3.0),
            (models.ALunosTurmas.conceito == 'FF', 0.0),
            else_=0.0
        )

        # Consulta agitando por Ano e Semestre
        dados = models.db.session.query(
            models.Turmas.ano,
            models.Turmas.semestre,
            func.avg(conceito_numerico).label('cr_medio')
        ).join(models.ALunosTurmas, models.Turmas.id_turma == models.ALunosTurmas.id_turma)\
         .group_by(models.Turmas.ano, models.Turmas.semestre)\
         .order_by(models.Turmas.ano, models.Turmas.semestre).all()

        # Formata o resultado para o gráfico: ['2016/1', '2016/2', ...] e [3.1, 2.9, ...]
        periodos = [f"{d.ano}/{d.semestre}" for d in dados]
        valores_cr = [round(d.cr_medio, 2) for d in dados]

        return periodos, valores_cr

if __name__ == "__main__":
    periodos, valores = extrair_dados_cr()
    print("Períodos:", periodos)
    print("Valores de CR:", valores)