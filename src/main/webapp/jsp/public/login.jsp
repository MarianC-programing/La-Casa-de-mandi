<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar sesión — La Casa de Mandi</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>
<%
    if (session.getAttribute("cliente") != null) { response.sendRedirect(request.getContextPath() + "/jsp/cliente/mis-pedidos.jsp"); return; }
    if (session.getAttribute("admin")   != null) { response.sendRedirect(request.getContextPath() + "/jsp/admin/dashboard.jsp"); return; }
    String paginaActiva = "login";
%>
<%@ include file="/jsp/layouts/header.jsp" %>

<main class="pantalla-auth">
    <!-- Panel izquierdo: imagen decorativa -->
    <div class="pantalla-auth__lateral">
        <div class="pantalla-auth__lateral-img" style="background-color:#eae7e7;"></div>
        <div class="pantalla-auth__lateral-overlay">
            <span class="pantalla-auth__lateral-tag">Artesanal · Hecho a mano</span>
            <p class="pantalla-auth__lateral-frase">Hecho a mano,<br>con amor.</p>
            <p style="font-size:14px;color:rgba(255,255,255,0.75);margin-top:8px;line-height:1.5;">
                Redescubre el sabor de lo auténtico. Cada pieza en nuestra vitrina es una obra maestra de la panadería artesanal.
            </p>
        </div>
    </div>

    <!-- Panel derecho: formulario -->
    <div class="pantalla-auth__panel">
        <div class="tarjeta-auth">
            <h1 class="tarjeta-auth__titulo">Iniciar sesión</h1>
            <p class="tarjeta-auth__subtitulo">Bienvenido de nuevo a nuestra cocina.</p>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alerta-error"><span>⚠</span><span><%= request.getAttribute("error") %></span></div>
            <% } %>

            <form action="${pageContext.request.contextPath}/login" method="post" novalidate>
                <div class="campo">
                    <label class="campo__label" for="identificador">Correo electrónico o número de WhatsApp</label>
                    <input class="campo__input" type="text" id="identificador" name="identificador"
                           placeholder="ejemplo@correo.com" autocomplete="username" required
                           value="<%= request.getParameter("identificador") != null ? request.getParameter("identificador") : "" %>">
                </div>
                <div class="campo">
                    <div class="campo__label-fila">
                        <label for="password">Contraseña</label>
                        <a href="#" style="font-size:13px;color:var(--secondary);">¿Olvidaste tu contraseña?</a>
                    </div>
                    <div style="position:relative;">
                        <input class="campo__input" type="password" id="password" name="password"
                               placeholder="••••••••" autocomplete="current-password" required>
                        <button type="button" class="campo__icono-btn" onclick="togglePassword()" aria-label="Ver contraseña">
                            <svg id="icono-ojo" xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                                 viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                 stroke-linecap="round" stroke-linejoin="round">
                                <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
                                <circle cx="12" cy="12" r="3"/>
                            </svg>
                        </button>
                    </div>
                </div>
                <div class="campo-check">
                    <input type="checkbox" id="recordar" name="recordar">
                    <label class="campo-check__label" for="recordar">Recordarme en este dispositivo</label>
                </div>
                <button type="submit" class="btn btn--primario btn--bloque">Iniciar sesión</button>
            </form>

            <p class="texto-apoyo">¿No tienes cuenta?
                <a href="${pageContext.request.contextPath}/jsp/public/registro.jsp">Regístrate</a>
            </p>
        </div>
    </div>
</main>

<%@ include file="/jsp/layouts/footer.jsp" %>

<script>
    function togglePassword() {
        var input = document.getElementById('password');
        input.type = (input.type === 'password') ? 'text' : 'password';
    }
</script>
</body>
</html>
