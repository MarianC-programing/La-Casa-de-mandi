package com.lacasademandi.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Utilidad para obtener una conexión a la base de datos MySQL.
 *
 * Requiere el driver JDBC de MySQL (mysql-connector-j-X.X.X.jar)
 * dentro de WebContent/WEB-INF/lib para que Tomcat lo encuentre en tiempo de ejecución.
 *
 * Ajustar USUARIO y PASSWORD según tu configuración local de MySQL/XAMPP.
 */
public class ConexionBD {

    private static final String URL = "jdbc:mysql://localhost:3306/la_casa_de_mandi?useSSL=false&serverTimezone=America/Panama";
    private static final String USUARIO = "root";
    private static final String PASSWORD = ""; // XAMPP por defecto no trae password en root

    public static Connection obtenerConexion() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("No se encontró el driver JDBC de MySQL. "
                    + "Verifica que el .jar esté en WebContent/WEB-INF/lib", e);
        }
        return DriverManager.getConnection(URL, USUARIO, PASSWORD);
    }
}
