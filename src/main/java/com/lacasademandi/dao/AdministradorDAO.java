package com.lacasademandi.dao;

import com.lacasademandi.modelo.Administrador;
import com.lacasademandi.util.ConexionBD;

import java.sql.*;

// Consultas SQL para la tabla Administrador.
public class AdministradorDAO {

    // Busca un admin por correo (para el login del panel admin)
    public Administrador buscarPorCorreo(String correo) throws SQLException {
        String sql = "SELECT * FROM Administrador WHERE correo = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, correo);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Administrador a = new Administrador();
                    a.setIdAdmin(rs.getInt("id_admin"));
                    a.setNombre(rs.getString("nombre"));
                    a.setCorreo(rs.getString("correo"));
                    a.setPassword(rs.getString("password"));
                    return a;
                }
            }
        }
        return null;
    }
}
