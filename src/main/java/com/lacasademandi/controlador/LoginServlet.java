package com.lacasademandi.controlador;

import com.lacasademandi.dao.AdministradorDAO;
import com.lacasademandi.dao.ClienteDAO;
import com.lacasademandi.modelo.Administrador;
import com.lacasademandi.modelo.Cliente;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

// Este Servlet maneja el formulario de login.
// Recibe correo/whatsapp + contraseña, verifica en la BD y redirige según el rol.
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    private final ClienteDAO       clienteDAO = new ClienteDAO();
    private final AdministradorDAO adminDAO   = new AdministradorDAO();

    // GET: muestra la página de login
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        // Si ya tiene sesión activa, redirigir directamente
        HttpSession s = req.getSession(false);
        if (s != null) {
            if (s.getAttribute("admin")   != null) { res.sendRedirect(req.getContextPath() + "/jsp/admin/dashboard.jsp"); return; }
            if (s.getAttribute("cliente") != null) { res.sendRedirect(req.getContextPath() + "/jsp/cliente/mis-pedidos.jsp"); return; }
        }
        req.getRequestDispatcher("/jsp/public/login.jsp").forward(req, res);
    }

    // POST: procesa el formulario
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String identificador = req.getParameter("identificador");
        String password      = req.getParameter("password");

        if (identificador == null || identificador.isBlank() || password == null || password.isBlank()) {
            req.setAttribute("error", "Por favor completa todos los campos.");
            req.getRequestDispatcher("/jsp/public/login.jsp").forward(req, res);
            return;
        }

        try {
            // 1. Verificar si es admin
            Administrador admin = adminDAO.buscarPorCorreo(identificador.trim());
            if (admin != null && BCrypt.checkpw(password, admin.getPassword())) {
                HttpSession sesion = req.getSession();
                sesion.setAttribute("admin", admin);
                sesion.setMaxInactiveInterval(3600);
                res.sendRedirect(req.getContextPath() + "/jsp/admin/dashboard.jsp");
                return;
            }

            // 2. Verificar si es cliente
            Cliente cliente = clienteDAO.buscarPorCorreoOWhatsapp(identificador.trim());
            if (cliente != null && BCrypt.checkpw(password, cliente.getPassword())) {
                HttpSession sesion = req.getSession();
                sesion.setAttribute("cliente", cliente);
                sesion.setMaxInactiveInterval(3600);
                res.sendRedirect(req.getContextPath() + "/jsp/cliente/mis-pedidos.jsp");
                return;
            }

            // 3. Credenciales incorrectas
            req.setAttribute("error", "Correo, WhatsApp o contraseña incorrectos.");
            req.setAttribute("identificador", identificador);
            req.getRequestDispatcher("/jsp/public/login.jsp").forward(req, res);

        } catch (SQLException e) {
            throw new ServletException("Error en la base de datos al hacer login.", e);
        }
    }
}
