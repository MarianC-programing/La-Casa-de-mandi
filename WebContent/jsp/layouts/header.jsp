<%-- Fragmento reutilizable: Header
     Uso: <%@ include file="/jsp/layouts/header.jsp" %>
     Variable esperada: String paginaActiva (ej: "inicio", "catalogo", "login")
--%>
<header class="header">
    <a href="${pageContext.request.contextPath}/" class="header__logo">La Casa de Mandi</a>

    <nav>
        <ul class="header__nav">
            <li><a href="${pageContext.request.contextPath}/"
                   class="${paginaActiva == 'inicio' ? 'activo' : ''}">Inicio</a></li>
            <li><a href="${pageContext.request.contextPath}/jsp/public/catalogo.jsp"
                   class="${paginaActiva == 'catalogo' ? 'activo' : ''}">Catálogo</a></li>
            <li><a href="${pageContext.request.contextPath}/jsp/public/nosotros.jsp"
                   class="${paginaActiva == 'nosotros' ? 'activo' : ''}">Sobre Nosotros</a></li>
            <li><a href="${pageContext.request.contextPath}/jsp/public/contacto.jsp"
                   class="${paginaActiva == 'contacto' ? 'activo' : ''}">Contacto</a></li>
        </ul>
    </nav>

    <div>
        <% if (session.getAttribute("cliente") != null) { %>
            <a href="${pageContext.request.contextPath}/jsp/cliente/mis-pedidos.jsp"
               class="btn btn--primario">Mi cuenta</a>
        <% } else { %>
            <a href="${pageContext.request.contextPath}/login"
               class="btn btn--primario">Acceder</a>
        <% } %>
    </div>
</header>
