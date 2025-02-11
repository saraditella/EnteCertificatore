package model;

import java.sql.SQLException;
import java.sql.DriverManager;
import java.sql.Connection;

public class ConnessioneDatabase {
    private static final String URL = "jdbc:mysql://localhost:3306/entecertificatore";
    public static final String USR = "root";
    private static final String PASSWORD = "74739.Sara";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("ClassNotFoundException: " + e.getMessage());
            throw new SQLException("Impossibile trovare il driver JDBC", e);
        }

        return DriverManager.getConnection(URL, USR, PASSWORD);
    }
}
