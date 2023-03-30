package JavaFiles;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class QueryExecutor {

    // método que executa um selec simples
    public static void executeSimpleQuery(Connection conexao) throws SQLException {
        // string que carrega o comando em sql
        String sql = "SELECT * FROM tabela";
        // execução da query
        try (PreparedStatement statement = conexao.prepareStatement(sql)) {
            ResultSet result = statement.executeQuery();
            // processa o resultado aqui...
        }
    }
}
