package com.lacasademandi.controlador;

import com.lacasademandi.dao.AdministradorDAO;
import com.lacasademandi.dao.ClienteDAO;
import com.lacasademandi.modelo.Administrador;
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
 * Servlet de login — maneja clientes y administrador en un solo flujo.
 *
 * Flujo:
 *  1. GET  /login → muestra login.jsp
 *  2. POST /login → valida credenciales
 *      - Si es admin (correo en tabla Administrador) → sesion "admin" → dashboard admin
 *      - Si es cliente (correo o whatsapp en tabla Cliente) → sesion "cliente" → mis-pedidos
 *      - Si no coincide → vuelve al login con mensaje de error
 *
 * Validación de contraseña: usa jBCrypt (BCrypt.checkpw).
 * Agregar el .jar de jBCrypt a WebContent/WEB-INF/lib antes de compilar.
 * Descarga: https://github.com/jeremyh/jBCrypt/releases
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final AdministradorDAO adminDAO = new AdministradorDAO();
    private final ClienteDAO clienteDAO = new ClienteDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // Si ya hay sesión activa, redirigir sin mostrar el login
        if (req.getSession(false) != null) {
            HttpSession s = req.getSession(false);
            if (s.getAttribute("admin") != null) {
                res.sendRedirect(req.getContextPath() + "/jsp/admin/dashboard.jsp");
                return;
            }
            if (s.getAttribute("cliente") != null) {
                res.sendRedirect(req.getContextPath() + "/jsp/cliente/mis-pedidos.jsp");
                return;
            }
        }

        req.getRequestDispatcher("/jsp/public/login.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String identificador = req.getParameter("identificador");
        String password      = req.getParameter("password");

        // Validación básica de campos vacíos
        if (identificador == null || identificador.isBlank()
                || password == null || password.isBlank()) {
            req.setAttribute("error", "Por favor completa todos los campos.");
            req.getRequestDispatcher("/jsp/public/login.jsp").forward(req, res);
            return;
        }

        identificador = identificador.trim();

        try {
            // ── 1. Verificar si es administrador (solo por correo) ──────────────
            Administrador admin = adminDAO.buscarPorCorreo(identificador);

            if (admin != null && BCrypt.checkpw(password, admin.getPassword())) {
                HttpSession sesion = req.getSession();
                sesion.setAttribute("admin", admin);
                sesion.setMaxInactiveInterval(60 * 60); // 1 hora
                res.sendRedirect(req.getContextPath() + "/jsp/admin/dashboard.jsp");
                return;
            }

            // ── 2. Verificar si es cliente (correo o whatsapp) ─────────────────
            Cliente cliente = clienteDAO.buscarPorCorreoOWhatsapp(identificador);

            if (cliente != null && BCrypt.checkpw(password, cliente.getPassword())) {
                HttpSession sesion = req.getSession();
                sesion.setAttribute("cliente", cliente);
                sesion.setMaxInactiveInterval(60 * 60); // 1 hora
                res.sendRedirect(req.getContextPath() + "/jsp/cliente/mis-pedidos.jsp");
                return;
            }

            // ── 3. Credenciales incorrectas ────────────────────────────────────
            req.setAttribute("error", "Correo, WhatsApp o contraseña incorrectos.");
            req.setAttribute("identificador", identificador); // conservar el campo
            req.getRequestDispatcher("/jsp/public/login.jsp").forward(req, res);

        } catch (SQLException e) {
            throw new ServletException("Error al consultar la base de datos durante el login.", e);
        }
    }
}
