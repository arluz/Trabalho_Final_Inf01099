import pandas as pd

from app import app
from models import db, Disciplinas, Conteudos, Habilidades

file = 'tdc_e.xlsx'

tab_relacao = 'Disciplinas'
tab_disciplinas = 'Mapeamento para Departamentos'
tab_conteudos = 'Conteúdos Consolidados'
tab_habilidades = 'Habilidades Consolidadas'
tab_areas = 'Áreas'
tab_obrigatorias='Disciplinas-Obrigatórias'

df= pd.read_excel(
    file, 
    sheet_name= [tab_relacao, tab_disciplinas, tab_conteudos, tab_habilidades, tab_areas, tab_obrigatorias],
    header=7
)

#print(df[tab_relacao].head(20))
#print(df[tab_relacao].columns)

##########################################
def import_relacionamentos_D_C_H():
    # Mapeamento exato das colunas baseado na sua leitura
    col_dis_name = 6
    col_conteudos = 9
    col_habilidades = 10

    with app.app_context():
        for _, row in df[tab_relacao].iterrows():
            # Pula se o código da disciplina estiver vazio ou nulo
            if pd.isna(row.iloc[col_dis_name]):
                continue

            nome_disciplina = str(row.iloc[col_dis_name]).strip()

            disciplina = Disciplinas.query.filter(Disciplinas.nome.ilike(nome_disciplina)).first()
            
            if not disciplina:
                print(f"Disciplina '{nome_disciplina}' não encontrada no banco de dados. Pulando...")
                continue

# Associar Conteudos
            if pd.notna(row.iloc[col_conteudos]):
                codigos_cont = [c.strip() for c in str(row.iloc[col_conteudos]).split(',') if c.strip()]
                
                for c_cod in codigos_cont:
                    c_cod_limpo = c_cod.replace('*', '')
                    conteudo = Conteudos.query.filter_by(codigo=c_cod_limpo).first()
                    if conteudo and conteudo not in disciplina.conteudos:
                        disciplina.conteudos.append(conteudo)

# Associar Habilidades
            if pd.notna(row.iloc[col_habilidades]):
                codigos_hab = [h.strip() for h in str(row.iloc[col_habilidades]).split(',') if h.strip() and h.strip() != '-']
                
                for h_cod in codigos_hab:
                    habilidade = Habilidades.query.filter_by(codigo=h_cod).first()
                    if habilidade and habilidade not in disciplina.habilidades:
                        disciplina.habilidades.append(habilidade)

            print(f"🔗 Relacionamentos processados para: {nome_disciplina}")

        db.session.commit()
        
        print('Import success')

def solver_relacionamentos():
    with app.app_context():
        # 1. Pega a primeira linha para mapear os índices reais que o Pandas gerou
        colunas_reais = df[tab_relacao].columns.tolist()
        
        # 2. Imprime no terminal para você ver a numeração exata de cada uma:
        print("--- MAPEAMENTO DE ÍNDICES REAIS ---")
        for i, col in enumerate(colunas_reais):
            print(f"Índice [{i}]: {col}")
        print("-----------------------------------")

#solver_relacionamentos()
import_relacionamentos_D_C_H()
            

###########################################
#Importando Dicsiplinas
def import_disciplinas():
    col_nome = "Nome"
    col_cod = "Código"
    #col_area = ?;

    with app.app_context():
        for _, row in df[tab_obrigatorias].iterrows():
            if pd.isna(row[col_cod]):
                continue

            codigo = str(row[col_cod]).strip()
            nome = str(row[col_nome]).strip()
            
            disciplina_existente = Disciplinas.query.filter_by(codigo=codigo).first()

            if disciplina_existente:
                disciplina_existente.nome = nome
                print(f"Disciplina {disciplina_existente.codigo} já existe. Atualizando informações.")
            else:
                disciplina = Disciplinas(
                    nome=nome,
                    codigo=codigo,
                    area = "NI"
                )

                db.session.add(disciplina)
                print(f"Disciplina {disciplina.codigo} adicionada ao banco de dados.")
                
        db.session.commit()
        print('Import success')

# import_disciplinas()

##########################################
#Ligando as areas as disciplinas
def ligando_areas_disc():
    with app.app_context():
        print("Lendo as areas")
        # Busca todas as disciplinas que já estão cadastradas no banco
        disciplinas_no_banco = Disciplinas.query.all()

        print(f"Total de disciplinas encontradas no banco: {len(disciplinas_no_banco)}")
        contador_atualizados = 0

        for disciplina in disciplinas_no_banco:
            nome_disciplina_lower = disciplina.nome.lower()
            area_encontrada = None

    # Varre a planilha de áreas para ver em qual delas o nome da disciplina se encaixa
            for _, linha in df[tab_areas].iterrows():
                palavras_chave = str(linha['Nome completo']).split(',')
                
                # Limpa os espaços em branco de cada palavra-chave (ex: " IHC" vira "ihc")
                palavras_chave = [p.strip().lower() for p in palavras_chave if p.strip()]

                # Se alguma palavra-chave da área fizer parte do nome da disciplina, mapeia ela
                for palavra in palavras_chave:
                    if palavra in nome_disciplina_lower:
                        area_encontrada = str(linha['Área']).strip()
                        break
                
                if area_encontrada:
                    break
                
        # Se encontrou a correspondência, atualiza o campo no banco
            if area_encontrada:
                disciplina.area = area_encontrada
                contador_atualizados += 1
            else:
                # Caso não ache por palavra-chave, você pode definir uma área padrão (ex: 'OUTRA' ou 'XX')
                # para não quebrar a restrição de nullable=False do seu model.py
                print(f"⚠️ Não foi possível determinar a área da disciplina: {disciplina.nome}")
                disciplina.area = "NI" # NI = Não Informada

        try:
            db.session.commit()
            print(f"🎉 Sucesso! {contador_atualizados} disciplinas tiveram suas áreas atualizadas.")
        except Exception as e:
            db.session.rollback()
            print(f"🚨 Erro ao salvar as alterações no banco: {e}")

#ligando_areas_disc()
#############################################
'''
#Importando Conteudos
col_essencialidade = 'Essencialidade'
col_cod = 'ID'
col_descricao = 'Descrição do Conteúdo'

with app.app_context():
    print("Iniciando a importação...")
    for _, row in df[tab_conteudos].iterrows():

        if pd.isna(row["ID"]):
            continue

        conteudo = Conteudos(
            codigo=row[col_cod],
            essencialidade=row[col_essencialidade],
            descricao =row[col_descricao]
        )
        db.session.add(conteudo)
    try:
        db.session.commit()
        print("Todos os dados foram importados com sucesso!")
    except Exception as e:
        db.session.rollback()
        print(f"Erro ao inserir dados no banco: {e}")

    print('Import complete')


    ##########################################
#Importando Habilidades
col_essencialidade = 'Essencialidade'
col_cod = 'ID'
col_descricao = 'Descrição da Habilidade'
col_proficiencia='Nível de proficiência'

with app.app_context():
    print("Iniciando a importação...")
    for _, row in df[tab_habilidades].iterrows():

        if pd.isna(row["ID"]):
            continue

        habilidade = Habilidades(
            codigo=row[col_cod],
            essencialidade=row[col_essencialidade],
            descricao =row[col_descricao],
            proficiencia=row[col_proficiencia]
        )
        db.session.add(habilidade)
    try:
        db.session.commit()
        print("Todos os dados foram importados com sucesso!")
    except Exception as e:
        db.session.rollback()
        print(f"Erro ao inserir dados no banco: {e}")

    print('Import complete')'''

