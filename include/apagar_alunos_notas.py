from app import app, models

def apagar_matriculas_e_notas():
    """
    Remove todos os registros de notas de conteúdos, notas de habilidades
    e matrículas da tabela AlunosTurmas de forma segura.
    """
    print("\n==========================================")
    print("ATENÇÃO: Iniciando a limpeza das tabelas...")
    print("==========================================")
    
    with app.app_context():
        try:
            # 1. Remove primeiro as tabelas filhas (que dependem de AlunosTurmas)
            print(" -> Removendo notas de conteúdos...")
            models.db.session.query(models.NotasConteudos).delete()
            
            print(" -> Removendo notas de habilidades...")
            models.db.session.query(models.NotasHabilidades).delete()
            
            # 2. Remove as matrículas da tabela AlunosTurmas
            print(" -> Removendo matrículas dos alunos...")
            total_removido = models.db.session.query(models.ALunosTurmas).delete()
            
            # 3. Salva as alterações definitivamente
            models.db.session.commit()
            print(f"\n[SUCESSO] Banco de dados limpo!")
            print(f" -> {total_removido} matrículas foram apagadas.")
            print(" -> Todas as notas associadas foram removidas.")
            return True
            
        except Exception as e:
            models.db.session.rollback()
            print(f"\n[ERRO] Falha ao limpar o banco de dados: {e}")
            return False

if __name__ == "__main__":
    # Executa a limpeza se o script for chamado diretamente
    apagar_matriculas_e_notas()