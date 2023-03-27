package JavaFiles;

// importando pacotes para conexão sql
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class SQLConnection {

    // Dados para conexão com banco
    private String host = "localhost"; // endereço do servidor
    private String port = "5432"; // porta de conexão do servidor
    private String userName = "nome de usuário"; // nome do usuário para acesso ao banco
    private String password = "senha de usuário"; // senha do usuário para acesso ao banco
    private String database = "nome do banco"; // nome do banco de dados a ser utilizado
    // driver de conexão
    private String driver = "jdbc:postgresql://" + host + ":" + port + "/" + database;

    // método de conexão com banco
    public void connect() {
        try {
            Class.forName("org.postgresql.Driver");

            // objeto "conexao" para execução de comandos SQL
            Connection conexao = DriverManager.getConnection(driver, userName, password);
            
            // tratamento de erros
        } catch (ClassNotFoundException ex) {
            System.out.println("Driver do banco de dados não localizado!");
        } catch (SQLException ex) {
            System.out.println("Erro ao conectar com o banco de dados: " + ex.getMessage());
        }
    }
}