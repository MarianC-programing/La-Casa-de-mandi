package com.lacasademandi.controlador;

import com.lacasademandi.dao.ClienteDAO;
import com.lacasademandi.modelo.Cliente;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

// Este Servlet procesa el formulario de registro de nuevos clientes.
@WebServlet("/registro")
public class RegistroServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    private final ClienteDAO clienteDAO = new ClienteDAO();

    // GET: muestra la página de registro
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("/jsp/public/registro.jsp").forward(req, res);
    }

    // POST: procesa el formulario
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

        // Validar campos
        String error = validar(nombre, telefono, whatsapp, correo, password, confirmar);
        if (error != null) {
            req.setAttribute("error", error);
            recargarCampos(req, nombre, telefono, whatsapp, correo);
            req.getRequestDispatcher("/jsp/public/registro.jsp").forward(req, res);
            return;
        }

        try {
            if (clienteDAO.existeCorreo(correo)) {
                req.setAttribute("error", "Ya existe una cuenta con ese correo.");
                recargarCampos(req, nombre, telefono, whatsapp, correo);
                req.getRequestDispatcher("/jsp/public/registro.jsp").forward(req, res);
                return;
            }
            if (clienteDAO.existeWhatsapp(whatsapp)) {
                req.setAttribute("error", "Ya existe una cuenta con ese número de WhatsApp.");
                recargarCampos(req, nombre, telefono, whatsapp, correo);
                req.getRequestDispatcher("/jsp/public/registro.jsp").forward(req, res);
                return;
            }

            // Hashear la contraseña antes de guardarla
            String hash = BCrypt.hashpw(password, BCrypt.gensalt());

            Cliente cliente = new Cliente(nombre.trim(), telefono.trim(),
                                          whatsapp.trim(), correo.trim().toLowerCase(), hash);
            int nuevoId = clienteDAO.registrar(cliente);
            cliente.setIdCliente(nuevoId);

            // Iniciar sesión automáticamente tras el registro
            HttpSession sesion = req.getSession();
            sesion.setAttribute("cliente", cliente);
            sesion.setMaxInactiveInterval(3600);

            res.sendRedirect(req.getContextPath() + "/jsp/cliente/mis-pedidos.jsp");

        } catch (SQLException e) {
            throw new ServletException("Error en la base de datos al registrar.", e);
        }
    }

    private String validar(String nombre, String telefono, String whatsapp,
                            String correo, String password, String confirmar) {
        if (nombre    == null || nombre.isBlank())    return "El nombre es obligatorio.";
        if (telefono  == null || telefono.isBlank())  return "El teléfono es obligatorio.";
        if (whatsapp  == null || whatsapp.isBlank())  return "El WhatsApp es obligatorio.";
        if (correo    == null || correo.isBlank())    return "El correo es obligatorio.";
        if (!correo.contains("@"))                    return "Ingresa un correo válido.";
        if (password  == null || password.length() < 6) return "La contraseña debe tener al menos 6 caracteres.";
        if (!password.equals(confirmar))              return "Las contraseñas no coinciden.";
        return null;
    }

    private void recargarCampos(HttpServletRequest req, String nombre,
                                 String telefono, String whatsapp, String correo) {
        req.setAttribute("nombre",   nombre);
        req.setAttribute("telefono", telefono);
        req.setAttribute("whatsapp", whatsapp);
        req.setAttribute("correo",   correo);
    }
}
