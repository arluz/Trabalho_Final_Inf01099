import random
from app import app, models

def mapear_nota_por_conceito(conceito):
    """Gera notas numéricas com 8% de chance de comportamentos inesperados (zebras)."""
    if random.random() < 0.08:
        return random.uniform(0.0, 10.0)
    
    mapeamento = {
        'A': random.uniform(9.0, 10.0),
        'B': random.uniform(7.5, 8.9),
        'C': random.uniform(6.0, 7.4),
        'D': random.uniform(3.0, 5.9),
        'FF': random.uniform(0.0, 2.9),
    }
    return mapeamento.get(conceito, random.uniform(0.0, 6.0))

def popular_notas_conteudos_habilidades():
    with app.app_context():
        print("📊 Iniciando a geração de notas com base no models.py...")

        # 1. Carrega as matrículas
        matriculas = models.db.session.query(models.ALunosTurmas).all()
        print(f"Total de matrículas (aluno_turma) para processar: {len(matriculas)}")

        total_notas_inseridas = 0
        contador_lote = 0

        for matricula in matriculas:
            # 2. Busca a turma e a disciplina correspondente usando os relacionamentos corretos
            turma = models.db.session.get(models.Turmas, matricula.id_turma)
            if not turma:
                continue

            disciplina = models.db.session.get(models.Disciplinas, turma.id_disciplina)
            if not disciplina:
                continue

            # 3. Lê as coleções many-to-many configuradas no models.py direto do objeto Disciplina
            conteudos = disciplina.conteudos
            habilidades = disciplina.habilidades

            # 4. Grava notas de Conteúdos usando a chave estrangeira correta: id_aluno_turma
            for cont in conteudos:
                nota_num = mapear_nota_por_conceito(matricula.conceito)
                nova_nota_cont = models.NotasConteudos(
                    id_aluno_turma=matricula.id_aluno_turma, # Campo corrigido
                    id_conteudo=cont.id_conteudo,
                    nota=round(nota_num, 1)
                )
                models.db.session.add(nova_nota_cont)
                total_notas_inseridas += 1

            # 5. Grava notas de Habilidades usando a chave estrangeira correta: id_aluno_turma
            for hab in habilidades:
                nota_num = mapear_nota_por_conceito(matricula.conceito)
                nova_nota_hab = models.NotasHabilidades(
                    id_aluno_turma=matricula.id_aluno_turma, # Campo corrigido
                    id_habilidade=hab.id_habilidade,
                    nota=round(nota_num, 1)
                )
                models.db.session.add(nova_nota_hab)
                total_notas_inseridas += 1

            # Otimização de commits em lote de 200 em 200 registros
            contador_lote += 1
            if contador_lote % 200 == 0:
                models.db.session.commit()
                print(f"💾 Progresso: {contador_lote} matrículas salvas... ({total_notas_inseridas} notas criadas)")

        # Salva o restante dos dados
        models.db.session.commit()
        print(f"\n🏁 Sucesso absoluto! Total de {total_notas_inseridas} notas geradas com nuances reais e consistentes.")

if __name__ == "__main__":
    popular_notas_conteudos_habilidades()