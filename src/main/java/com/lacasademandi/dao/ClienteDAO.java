package com.lacasademandi.dao;

import com.lacasademandi.modelo.Cliente;
import com.lacasademandi.util.ConexionBD;

import java.sql.*;

// DAO = Data Access Object.
// Esta clase hace todas las consultas SQL relacionadas con la tabla Cliente.
// Los Servlets nunca escriben SQL directamente, siempre usan esta clase.
public class ClienteDAO {

    // Busca un cliente por correo O por whatsapp (para el login)
    public Cliente buscarPorCorreoOWhatsapp(String identificador) throws SQLException {
        String sql = "SELECT * FROM Cliente WHERE correo = ? OR whatsapp = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, identificador);
            stmt.setString(2, identificador);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return mapear(rs);
            }
        }
        return null;
    }

    // Verifica si ya existe un cliente con ese correo
    public boolean existeCorreo(String correo) throws SQLException {
        String sql = "SELECT 1 FROM Cliente WHERE correo = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, correo.trim().toLowerCase());
            try (ResultSet rs = stmt.executeQuery()) { return rs.next(); }
        }
    }

    // Verifica si ya existe un cliente con ese WhatsApp
    public boolean existeWhatsapp(String whatsapp) throws SQLException {
        String sql = "SELECT 1 FROM Cliente WHERE whatsapp = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, whatsapp.trim());
            try (ResultSet rs = stmt.executeQuery()) { return rs.next(); }
        }
    }

    // Inserta un nuevo cliente y devuelve el ID generado
    // El password que llega ya viene hasheado desde el Servlet
    public int registrar(Cliente c) throws SQLException {
        String sql = "INSERT INTO Cliente (nombre, telefono, whatsapp, correo, password) VALUES (?,?,?,?,?)";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement stmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, c.getNombre());
            stmt.setString(2, c.getTelefono());
            stmt.setString(3, c.getWhatsapp());
            stmt.setString(4, c.getCorreo());
            stmt.setString(5, c.getPassword());
            stmt.executeUpdate();
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return -1;
    }

    // Convierte una fila del ResultSet en un objeto Cliente
    private Cliente mapear(ResultSet rs) throws SQLException {
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
