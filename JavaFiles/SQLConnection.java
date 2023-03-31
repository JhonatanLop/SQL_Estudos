package JavaFiles;

import java.io.IOException;
// importando pacotes para conexão sql
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class SQLConnection {

    // Dados para conexão com banco
    private String host = "localhost"; // endereço do servidor
    private String port = "5432"; // porta de conexão do servidor
    private String userName = "postgres"; // nome do usuário para acesso ao banco
    private String password = "Postgres!1@2#3"; // senha do usuário para acesso ao banco
    private String database = "api"; // nome do banco de dados a ser utilizado
    // driver de conexão
    private String driver = "jdbc:postgresql://" + host + ":" + port + "/" + database;
    static Connection conexao;

    // método de conexão com banco
    public void connect(){
        Connection conexao = null;
        try {
            //carrega a classe do driver do PostgreSQL na memória permitindo comunicação com o banco de dados
            Class.forName("org.postgresql.Driver");

            // objeto "conexao" para execução de comandos SQL
            conexao = DriverManager.getConnection(driver, userName, password);

        // tratamento de erros
        } catch (ClassNotFoundException ex) {
            System.out.println("Driver do banco de dados não localizado!");
        } catch (SQLException ex) {
            System.out.println("Erro ao conectar com o banco de dados: " + ex.getMessage());
        } 
        // encerra conexão com banco
        finally{
            // tratamento de erros ao fechar conexão
            try {
                if (conexao != null && !conexao.isClosed()) {
                    conexao.close();
                }
            } catch (SQLException ex) {
                System.out.println("Falha ao fechar conexão: " + ex.getMessage());
            }
        }
    }

    public static void main(String[] args) throws SQLException, IOException {
        String arquivoSql = "caminho para o arquivo sql";
        QueryLibs.executeSqlFile(conexao, arquivoSql);
    }
}