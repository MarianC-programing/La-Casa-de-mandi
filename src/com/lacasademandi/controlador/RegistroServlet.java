package com.lacasademandi.controlador;

import com.lacasademandi.dao.ClienteDAO;
import com.lacasademandi.modelo.Cliente;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Servlet de registro de nuevos clientes.
 *
 * Flujo:
 *  1. GET  /registro → muestra registro.jsp
 *  2. POST /registro → valida campos, hashea contraseña, inserta en BD
 *      - Éxito → inicia sesión automáticamente y redirige a mis-pedidos
 *      - Error → vuelve al formulario con mensaje y campos pre-llenados
 *
 * Requiere jBCrypt en WebContent/WEB-INF/lib para hashear la contraseña.
 */
@WebServlet("/registro")
public class RegistroServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final ClienteDAO clienteDAO = new ClienteDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("/jsp/public/registro.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String nombre    = req.getParameter("nombre");
        String telefono  = req.getParameter("telefono");
        String whatsapp  = req.getParameter("whatsapp");
        String correo    = req.getParameter("correo");
        String password  = req.getParameter("password");
        String confirmar = req.getParameter("confirmar");

        // ── Validaciones ────────────────────────────────────────────────────
        String error = validar(nombre, telefono, whatsapp, correo, password, confirmar);

        if (error != null) {
            req.setAttribute("error", error);
            // Conservar campos para no borrar lo que el usuario escribió
            req.setAttribute("nombre",   nombre);
            req.setAttribute("telefono", telefono);
            req.setAttribute("whatsapp", whatsapp);
            req.setAttribute("correo",   correo);
            req.getRequestDispatcher("/jsp/public/registro.jsp").forward(req, res);
            return;
        }

        try {
            // Verificar que correo y whatsapp no estén ya registrados
            if (clienteDAO.existeCorreo(correo)) {
                req.setAttribute("error", "Ya existe una cuenta con ese correo electrónico.");
                prepararAtributos(req, nombre, telefono, whatsapp, correo);
                req.getRequestDispatcher("/jsp/public/registro.jsp").forward(req, res);
                return;
            }

            if (clienteDAO.existeWhatsapp(whatsapp)) {
                req.setAttribute("error", "Ya existe una cuenta con ese número de WhatsApp.");
                prepararAtributos(req, nombre, telefono, whatsapp, correo);
                req.getRequestDispatcher("/jsp/public/registro.jsp").forward(req, res);
                return;
            }

            // Hashear contraseña con BCrypt antes de guardar
            String passwordHash = BCrypt.hashpw(password, BCrypt.gensalt());

            Cliente cliente = new Cliente(
                nombre.trim(), telefono.trim(), whatsapp.trim(),
                correo.trim().toLowerCase(), passwordHash
            );

            int idNuevo = clienteDAO.registrar(cliente);
            cliente.setIdCliente(idNuevo);

            // Iniciar sesión automáticamente tras el registro
            HttpSession sesion = req.getSession();
            sesion.setAttribute("cliente", cliente);
            sesion.setMaxInactiveInterval(60 * 60);

            res.sendRedirect(req.getContextPath() + "/jsp/cliente/mis-pedidos.jsp");

        } catch (SQLException e) {
            throw new ServletException("Error al registrar el cliente en la base de datos.", e);
        }
    }

    private String validar(String nombre, String telefono, String whatsapp,
                            String correo, String password, String confirmar) {
        if (nombre == null || nombre.isBlank())    return "El nombre es obligatorio.";
        if (telefono == null || telefono.isBlank()) return "El teléfono es obligatorio.";
        if (whatsapp == null || whatsapp.isBlank()) return "El número de WhatsApp es obligatorio.";
        if (correo == null || correo.isBlank())    return "El correo electrónico es obligatorio.";
        if (password == null || password.length() < 6) return "La contraseña debe tener al menos 6 caracteres.";
        if (!password.equals(confirmar))           return "Las contraseñas no coinciden.";
        if (!correo.contains("@"))                 return "Ingresa un correo electrónico válido.";
        return null;
    }

    private void prepararAtributos(HttpServletRequest req, String nombre,
                                    String telefono, String whatsapp, String correo) {
        req.setAttribute("nombre",   nombre);
        req.setAttribute("telefono", telefono);
        req.setAttribute("whatsapp", whatsapp);
        req.setAttribute("correo",   correo);
    }
}
