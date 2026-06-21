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
 * Servlet de EJEMPLO para el login de clientes.
 * Este es el patrón a seguir para los demás Servlets del proyecto:
 * recibe la petición, llama al DAO correspondiente, decide a qué JSP
 * reenviar (forward) o redirigir (redirect).
 *
 * Mapeado a la URL /login (ver web.xml o la anotación @WebServlet abajo).
 *
 * IMPORTANTE: este ejemplo todavía no valida el password contra un hash real
 * (eso requiere agregar una librería de BCrypt para Java, ej. jBCrypt).
 * Por ahora deja el flujo general listo para completar esa parte.
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final ClienteDAO clienteDAO = new ClienteDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Muestra el formulario de login
        request.getRequestDispatcher("/jsp/public/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String identificador = request.getParameter("identificador"); // correo o whatsapp
        String password = request.getParameter("password");

        try {
            Cliente cliente = clienteDAO.buscarPorCorreoOWhatsapp(identificador);

            // TODO: reemplazar esta comparación directa por BCrypt.checkpw(password, cliente.getPassword())
            if (cliente != null && cliente.getPassword().equals(password)) {
                HttpSession sesion = request.getSession();
                sesion.setAttribute("cliente", cliente);
                response.sendRedirect("jsp/cliente/mis-pedidos.jsp");
            } else {
                request.setAttribute("error", "Correo/WhatsApp o contraseña incorrectos.");
                request.getRequestDispatcher("/jsp/public/login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Error al consultar la base de datos", e);
        }
    }
}
