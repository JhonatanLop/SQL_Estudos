package JavaFiles;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Statement;

public class QueryLibs {

    public static void simpleSelect(Connection conexao) throws SQLException {
        // método que executa um select simples
        // recebe como parâmetro uma conexão com o banco de dados
        // e pode lançar uma exceção SQLException

        // string que carrega o comando em sql
        String sql = "SELECT * FROM tabela";

        // execução da query
        try (PreparedStatement statement = conexao.prepareStatement(sql)) {
            // prepara a declaração SQL para ser executada usando a conexão fornecida
            // e executa a consulta
            ResultSet result = statement.executeQuery();

            // processa o resultado aqui...
            while (result.next()) {
                // itera sobre cada linha retornada pela consulta
                // e extrai os valores das colunas necessárias
                String coluna1 = result.getString("nome_da_coluna_1");
                int coluna2 = result.getInt("nome_da_coluna_2");
                double coluna3 = result.getDouble("nome_da_coluna_3");

                // imprime os valores das colunas no terminal
                System.out.println(coluna1 + " - " + coluna2 + " - " + coluna3);
            }
        }
    }

    public static void insertTable(Connection conexao) throws SQLException {
        String sql = "INSERT INTO tabela (col1, col2) value (?, ?)";
        try (PreparedStatement statement = conexao.prepareStatement(sql)) {
            statement.setString(1, "valor 1");
            statement.setString(2, "valor 2");
            int foo = statement.executeUpdate();

        } catch (Exception ex) {
            System.out.println("Erro ao executar a query: " + ex.getMessage());
        }
    }

    public static void executeSqlFile(Connection conexao, String arquivoSql) throws SQLException, IOException {
        try (BufferedReader br = new BufferedReader(new FileReader(arquivoSql))) {
            String linha;
            StringBuilder sb = new StringBuilder();
            while ((linha = br.readLine()) != null) {
                // adiciona a linha ao StringBuilder
                sb.append(linha);
                sb.append(System.lineSeparator());
            }
            String sql = sb.toString();
            try (Statement statement = conexao.createStatement()) {
                // executa as instruções SQL contidas no arquivo
                statement.execute(sql);
            }
        }
    }
}
