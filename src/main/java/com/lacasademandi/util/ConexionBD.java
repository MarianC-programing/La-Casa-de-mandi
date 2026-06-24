package com.lacasademandi.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

// Esta clase abre la conexión a la base de datos MySQL.
// Todos los DAOs la usan para hacer sus consultas.
public class ConexionBD {

    private static final String URL      = "jdbc:mysql://localhost:3306/la_casa_de_mandi?useSSL=false&serverTimezone=America/Panama";
    private static final String USUARIO  = "root";
    private static final String PASSWORD = ""; // XAMPP no tiene password por defecto

    public static Connection obtenerConexion() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("No se encontró el driver de MySQL.", e);
        }
        return DriverManager.getConnection(URL, USUARIO, PASSWORD);
    }
}
