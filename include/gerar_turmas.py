from sqlalchemy.exc import IntegrityError
from sqlalchemy import func
from app import app, models
import random

GRADE_CURRICULAR = [
"ALGORÍTMOS E PROGRAMAÇÃO - CIC",
"CÁLCULO E GEOMETRIA ANALÍTICA I - A",
"INTRODUÇÃO À CIÊNCIA DA COMPUTAÇÃO",
"LÓGICA PARA COMPUTAÇÃO",
"PENSAMENTO COMPUTACIONAL N",

"ARQUITETURA DE COMPUTADORES",
"CÁLCULO E GEOMETRIA ANALÍTICA II - A",
"ESTRUTURAS DE DADOS",
"MATEMÁTICA DISCRETA B",
"PROBABILIDADE E ESTATÍSTICA",
"TESTE E VERIFICAÇÃO DE SOFTWARE",

"BANCOS DE DADOS",
"DESENVOLVIMENTO DE SOFTWARE",
"PROJETO DE CIRCUITOS DIGITAIS",
"PROJETO E ANÁLISE DE ALGORITMOS I",
"TEORIA DA COMPUTAÇÃO I",

"ÁLGEBRA LINEAR I - A",
"ENGENHARIA DE SOFTWARE N",
"INTERAÇÃO HUMANO-COMPUTADOR E EXPERIÊNCIA DO USUÁRIO",
"ORGANIZAÇÃO DE COMPUTADORES",
"PROJETO E ANÁLISE DE ALGORITMOS II",
"TEORIA DA COMPUTAÇÃO II",

"CÁLCULO NUMÉRICO A",
"COMPUTAÇÃO GRÁFICA E VISUALIZAÇÃO I",
"INTELIGÊNCIA ARTIFICIAL",
"PROJETO EM CIÊNCIA E INOVAÇÃO",
"SISTEMAS OPERACIONAIS I N",

"APRENDIZADO DE MÁQUINA",
"LINGUAGENS DE PROGRAMAÇÃO I",
"PROCESSAMENTO DE IMAGENS E VISÃO COMPUTACIONAL I",
"PROGRAMAÇÃO PARALELA",
"REDES DE COMPUTADORES E INTERNET",

"CIBERSEGURANÇA",
"LINGUAGENS DE PROGRAMAÇÃO II",
"OTIMIZAÇÃO COMBINATÓRIA",
"PROCESSAMENTO DE LINGUAGEM NATURAL",
"SISTEMAS DISTRIBUÍDOS E TOLERANTES A FALHAS",

"PROJETO INTEGRADOR EM COMPUTAÇÃO"
]

from models import db, Alunos, Disciplinas, Turmas, ALunosTurmas
    
def criar_turma(id_disciplina, codigo, ano, semestre):
    with app.app_context():
        disciplina = models.db.session.get(models.Disciplinas, id_disciplina)
        if not disciplina:
            print(f"Disciplina com ID: {id_disciplina} não encontrada, cadastramento cancelado.")
            return None
        
        nova_turma = models.Turmas(
            id_disciplina=id_disciplina,
            codigo=codigo,
            ano=ano,
            semestre=semestre
        )
        
        try:
            models.db.session.add(nova_turma)
            models.db.session.commit()
            print(f"Turma '{codigo}' criada com sucesso (ID: {nova_turma.id_turma}).")
            return nova_turma.id_turma
        except IntegrityError:
            models.db.session.rollback()
            print(f"Erro: O código de turma '{codigo}' já existe.")
            return None

def obter_id_disciplina(nome_disciplina):
    with app.app_context():
        disciplina = models.db.session.query(models.Disciplinas).filter(
            func.lower(models.Disciplinas.nome) == func.lower(nome_disciplina.strip())
        ).first()
        
        if not disciplina:
            print(f"Aviso: Disciplina '{nome_disciplina}' não encontrada.")
            return None
            
        return disciplina.id_disciplina

def mapear_nome_id_disciplinas(lista_nomes_disciplinas):
    with app.app_context():
        nomes_limpos = [nome.strip().lower() for nome in lista_nomes_disciplinas]
        
        disciplinas = models.db.session.query(models.Disciplinas).filter(
            func.lower(models.Disciplinas.nome).in_(nomes_limpos)
        ).all()
        
        mapa_aux = {d.nome.strip().lower(): d.id_disciplina for d in disciplinas}
        
        # Identifica os nomes que não foram encontrados no mapeamento
        nao_encontrados = [nome for nome in lista_nomes_disciplinas if nome.strip().lower() not in mapa_aux]
        
        if nao_encontrados:
            print(f"Aviso: As seguintes disciplinas não foram encontradas no banco: {nao_encontrados}")
            
        return [mapa_aux.get(nome.strip().lower()) for nome in lista_nomes_disciplinas]
    
def determinar_codigos_turma():
    return ['A', 'B'] if random.random() < 0.75 else ['U']

def gerar_turmas():
    lista_ids_disciplinas = mapear_nome_id_disciplinas(GRADE_CURRICULAR)
    
    for ano in range(2016,2027):
        for semestre in [ 1, 2]:
            
            for id_disc in lista_ids_disciplinas:
                codigos = determinar_codigos_turma()
                for cod in codigos:
                    criar_turma(id_disc, cod, ano, semestre)
    print(f"Ano de {ano} criado")


if __name__ == "__main__":
    gerar_turmas()