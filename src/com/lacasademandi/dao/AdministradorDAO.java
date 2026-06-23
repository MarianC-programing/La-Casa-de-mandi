package com.lacasademandi.dao;

import com.lacasademandi.modelo.Administrador;
import com.lacasademandi.util.ConexionBD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdministradorDAO {

    public Administrador buscarPorCorreo(String correo) throws SQLException {
        String sql = "SELECT * FROM Administrador WHERE correo = ?";

        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setString(1, correo);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Administrador admin = new Administrador();
                    admin.setIdAdmin(rs.getInt("id_admin"));
                    admin.setNombre(rs.getString("nombre"));
                    admin.setCorreo(rs.getString("correo"));
                    admin.setPassword(rs.getString("password"));
                    return admin;
                }
            }
        }
        return null;
    }
}
