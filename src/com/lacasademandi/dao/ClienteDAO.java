package com.lacasademandi.dao;

import com.lacasademandi.modelo.Cliente;
import com.lacasademandi.util.ConexionBD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ClienteDAO {

    /** Login: busca por correo O por whatsapp */
    public Cliente buscarPorCorreoOWhatsapp(String identificador) throws SQLException {
        String sql = "SELECT * FROM Cliente WHERE correo = ? OR whatsapp = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, identificador);
            stmt.setString(2, identificador);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return mapearCliente(rs);
            }
        }
        return null;
    }

    /** Registro: verifica si el correo ya existe */
    public boolean existeCorreo(String correo) throws SQLException {
        String sql = "SELECT 1 FROM Cliente WHERE correo = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, correo.trim().toLowerCase());
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    /** Registro: verifica si el WhatsApp ya existe */
    public boolean existeWhatsapp(String whatsapp) throws SQLException {
        String sql = "SELECT 1 FROM Cliente WHERE whatsapp = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, whatsapp.trim());
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    /**
     * Inserta un nuevo cliente.
     * El password que llega aquí YA viene hasheado con BCrypt desde el Servlet.
     * Devuelve el id generado, o -1 si falló.
     */
    public int registrar(Cliente cliente) throws SQLException {
        String sql = "INSERT INTO Cliente (nombre, telefono, whatsapp, correo, password) "
                   + "VALUES (?, ?, ?, ?, ?)";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement stmt = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, cliente.getNombre());
            stmt.setString(2, cliente.getTelefono());
            stmt.setString(3, cliente.getWhatsapp());
            stmt.setString(4, cliente.getCorreo());
            stmt.setString(5, cliente.getPassword());
            stmt.executeUpdate();
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return -1;
    }

    private Cliente mapearCliente(ResultSet rs) throws SQLException {
        Cliente c = new Cliente();
        c.setIdCliente(rs.getInt("id_cliente"));
        c.setNombre(rs.getString("nombre"));
        c.setTelefono(rs.getString("telefono"));
        c.setWhatsapp(rs.getString("whatsapp"));
        c.setCorreo(rs.getString("correo"));
        c.setPassword(rs.getString("password"));
        return c;
    }
}
