import random, pandas as pd
import kagglehub

from app import app
from models import db, Alunos

def salva_alunos_no_banco():
    with app.app_context():
        df = pd.read_csv("alunos_siteticos.csv")

        amostra_df = df.sample(n=1250, random_state=42)

        for _, row in amostra_df.iterrows():
            aluno = Alunos(
                nome=row['nome'],
                matricula=row['matricula']
            )
            db.session.add(aluno)
        try:
            db.session.commit()
            print("Todos os alunos foram salvos com sucesso!")
        except Exception as e:
            db.session.rollback()
            print(f"Erro ao inserir alunos no banco: {e}")

salva_alunos_no_banco()

def download_dataset(dataset_name, version=None):
    # Download latest version
    path = "/home/codespace/.cache/kagglehub/datasets/kaggle/us-baby-names/versions/2"
    #kagglehub.dataset_download("kaggle/us-baby-names")


    print("Path to dataset files:", path)

    df = pd.read_csv(path+"/NationalNames.csv")

    lista_de_nomes = df['Name'].dropna().unique().tolist()

    total_nomes = len(lista_de_nomes)
    sufixos_unicos = random.sample(range(0, 1000000), total_nomes)
    matriculas = [f"00{sufixo:06d}" for sufixo in sufixos_unicos]


    df_final = pd.DataFrame({
        'nome': lista_de_nomes,
        'matricula': matriculas
    })

    # Exibe o resultado e salva em CSV
    print(df_final.head())
    df_final.to_csv("alunos_siteticos.csv", index=False)