<%-- Header reutilizable. Antes del include declarar: String paginaActiva = "inicio"; --%>
<%@ page import="com.lacasademandi.modelo.Cliente, com.lacasademandi.modelo.Administrador" %>
<header class="header">
    <a href="${pageContext.request.contextPath}/" class="header__logo">La Casa de Mandi</a>
    <nav>
        <ul class="header__nav">
            <li><a href="${pageContext.request.contextPath}/"
                class="<%= "inicio".equals(paginaActiva) ? "activo" : "" %>">Inicio</a></li>
            <li><a href="${pageContext.request.contextPath}/jsp/public/catalogo.jsp"
                class="<%= "catalogo".equals(paginaActiva) ? "activo" : "" %>">Catálogo</a></li>
            <% if (session.getAttribute("cliente") != null) { %>
            <li><a href="${pageContext.request.contextPath}/jsp/cliente/mis-pedidos.jsp"
                class="<%= "pedidos".equals(paginaActiva) ? "activo" : "" %>">Pedidos</a></li>
            <% } %>
            <li><a href="${pageContext.request.contextPath}/jsp/public/nosotros.jsp"
                class="<%= "nosotros".equals(paginaActiva) ? "activo" : "" %>">Sobre Nosotros</a></li>
            <li><a href="${pageContext.request.contextPath}/jsp/public/contacto.jsp"
                class="<%= "contacto".equals(paginaActiva) ? "activo" : "" %>">Contacto</a></li>
        </ul>
    </nav>
    <div class="header__acciones">
        <%
            Cliente clienteActivo = (Cliente) session.getAttribute("cliente");
            Administrador adminActivo = (Administrador) session.getAttribute("admin");
            if (clienteActivo != null) { %>
            <div class="header__usuario">
                <span class="header__usuario-nombre"><%= clienteActivo.getNombre() %></span>
                <a href="${pageContext.request.contextPath}/logout"
                   class="btn btn--outline" style="padding:0.4rem 0.9rem;font-size:13px;">Salir</a>
            </div>
        <% } else if (adminActivo != null) { %>
            <a href="${pageContext.request.contextPath}/jsp/admin/dashboard.jsp"
               class="btn btn--primario">Panel admin</a>
        <% } else { %>
            <a href="${pageContext.request.contextPath}/login"
               class="btn btn--primario">Acceder</a>
        <% } %>
    </div>
</header>
