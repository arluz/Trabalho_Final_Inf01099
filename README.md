# Trabalho_Final_INF01006
Site desenvolvido em docker+postgres+flask/python para visualização de notas e competencias dos alunos ao longo do curso Ciência da Computação da UFRGS

Para rodar basta inserir os comandos no terminal:

iniciar o ambiente virtual:
source . venv/bin/activate

iniciar o container docker configurado para a porta 5432:
docker start cont_cic

iniciar o servidor web porta 5000:
python app.py
