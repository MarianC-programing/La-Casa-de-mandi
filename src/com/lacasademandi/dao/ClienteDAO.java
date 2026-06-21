package com.lacasademandi.dao;

import com.lacasademandi.modelo.Cliente;
import com.lacasademandi.util.ConexionBD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * DAO (Data Access Object) para la tabla Cliente.
 * Aquí va toda la lógica de "hablar con la base de datos" para esta entidad.
 * Los Servlets llaman a estos métodos, nunca escriben SQL directamente.
 *
 * Este archivo es un EJEMPLO del patrón a seguir para las demás entidades
 * (ProductoDAO, PedidoDAO, AbonoDAO, etc.)
 */
public class ClienteDAO {

    /**
     * Busca un cliente por correo O por whatsapp (login con doble identificador).
     * Devuelve null si no existe ninguno con ese identificador.
     */
    public Cliente buscarPorCorreoOWhatsapp(String identificador) throws SQLException {
        String sql = "SELECT * FROM Cliente WHERE correo = ? OR whatsapp = ?";

        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setString(1, identificador);
            stmt.setString(2, identificador);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapearCliente(rs);
                }
            }
        }
        return null;
    }

    /**
     * Inserta un nuevo cliente. El password que llega aquí YA debe venir
     * hasheado (BCrypt) desde el Servlet — este DAO no hashea nada.
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
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return -1;
    }

    private Cliente mapearCliente(ResultSet rs) throws SQLException {
        Cliente cliente = new Cliente();
        cliente.setIdCliente(rs.getInt("id_cliente"));
        cliente.setNombre(rs.getString("nombre"));
        cliente.setTelefono(rs.getString("telefono"));
        cliente.setWhatsapp(rs.getString("whatsapp"));
        cliente.setCorreo(rs.getString("correo"));
        cliente.setPassword(rs.getString("password"));
        return cliente;
    }
}
