<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crear cuenta — La Casa de Mandi</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
    <style>
        .registro-titulo-lateral { font-family:var(--font-display); font-size:40px; font-weight:700; line-height:1.2; color:var(--on-surface); margin-bottom:var(--space-2); }
        .registro-titulo-lateral em { color:var(--secondary); font-style:italic; }
        .registro-imagen-lateral { margin:var(--space-4); border-radius:var(--radius-lg); overflow:hidden; aspect-ratio:4/3; background-color:var(--surface-container-high); position:relative; }
        .registro-imagen-lateral__tag { position:absolute; bottom:var(--space-2); left:var(--space-2); }
        .registro-imagen-lateral__tag-label { font-size:10px; font-weight:600; letter-spacing:0.1em; text-transform:uppercase; color:rgba(255,255,255,0.8); }
        .registro-imagen-lateral__tag-frase { font-family:var(--font-display); font-size:18px; font-weight:700; color:#fff; line-height:1.3; }
        .pantalla-auth__panel { align-items:flex-start; overflow-y:auto; padding-top:var(--space-6); padding-bottom:var(--space-6); }
    </style>
</head>
<body>
<%
    if (session.getAttribute("cliente") != null) { response.sendRedirect(request.getContextPath() + "/jsp/cliente/mis-pedidos.jsp"); return; }
    if (session.getAttribute("admin")   != null) { response.sendRedirect(request.getContextPath() + "/jsp/admin/dashboard.jsp"); return; }
    String paginaActiva = "login";
%>
<%@ include file="/jsp/layouts/header.jsp" %>

<main class="pantalla-auth">
    <!-- Panel izquierdo -->
    <div class="pantalla-auth__lateral" style="background-color:var(--surface-container-low);display:block;overflow-y:auto;">
        <div class="registro-titulo-lateral" style="padding:var(--space-6) var(--space-4) 0;">
            Únete a nuestra<br><em>familia artesana</em>
        </div>
        <p style="font-size:16px;color:var(--on-surface-variant);line-height:24px;max-width:360px;padding:var(--space-2) var(--space-4) 0;">
            Crea tu cuenta para disfrutar de beneficios exclusivos, seguimiento de pedidos y el aroma de lo recién horneado directo a tu hogar.
        </p>
        <div class="registro-imagen-lateral">
            <div style="width:100%;height:100%;background-color:var(--surface-container-high);"></div>
            <div class="registro-imagen-lateral__tag">
                <div class="registro-imagen-lateral__tag-label">Recetas con alma</div>
                <div class="registro-imagen-lateral__tag-frase">Hecho a mano,<br>pensado para ti.</div>
            </div>
        </div>
    </div>

    <!-- Panel derecho: formulario -->
    <div class="pantalla-auth__panel">
        <div class="tarjeta-auth">
            <h1 class="tarjeta-auth__titulo">Crear Cuenta</h1>
            <p class="tarjeta-auth__subtitulo">¿Ya tienes cuenta? <a href="${pageContext.request.contextPath}/login">Inicia sesión aquí</a></p>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alerta-error"><span>⚠</span><span><%= request.getAttribute("error") %></span></div>
            <% } %>

            <form action="${pageContext.request.contextPath}/registro" method="post" novalidate>
                <div class="campo">
                    <label class="campo__label" for="nombre">Nombre completo</label>
                    <input class="campo__input" type="text" id="nombre" name="nombre" placeholder="Ej. Mandi Pineda" required
                           value="<%= request.getAttribute("nombre") != null ? request.getAttribute("nombre") : "" %>">
                </div>
                <div class="campo--doble">
                    <div class="campo">
                        <label class="campo__label" for="telefono">Teléfono</label>
                        <input class="campo__input" type="tel" id="telefono" name="telefono" placeholder="+507..." required
                               value="<%= request.getAttribute("telefono") != null ? request.getAttribute("telefono") : "" %>">
                    </div>
                    <div class="campo">
                        <label class="campo__label" for="whatsapp">WhatsApp</label>
                        <input class="campo__input" type="tel" id="whatsapp" name="whatsapp" placeholder="Nro. WhatsApp" required
                               value="<%= request.getAttribute("whatsapp") != null ? request.getAttribute("whatsapp") : "" %>">
                    </div>
                </div>
                <div class="campo">
                    <label class="campo__label" for="correo">Correo electrónico</label>
                    <input class="campo__input" type="email" id="correo" name="correo" placeholder="hola@ejemplo.com" required
                           value="<%= request.getAttribute("correo") != null ? request.getAttribute("correo") : "" %>">
                </div>
                <div class="campo--doble">
                    <div class="campo">
                        <label class="campo__label" for="password">Contraseña</label>
                        <input class="campo__input" type="password" id="password" name="password" placeholder="••••••••" required>
                    </div>
                    <div class="campo">
                        <label class="campo__label" for="confirmar">Confirmar contraseña</label>
                        <input class="campo__input" type="password" id="confirmar" name="confirmar" placeholder="••••••••" required>
                    </div>
                </div>
                <div class="campo-check">
                    <input type="checkbox" id="terminos" name="terminos" required>
                    <label class="campo-check__label" for="terminos">Acepto los <a href="#">términos y condiciones</a> y la política de privacidad.</label>
                </div>
                <button type="submit" class="btn btn--primario btn--bloque">Registrarse</button>
                <p style="text-align:center;font-size:13px;color:var(--outline);margin-top:var(--space-2);">Al registrarte, recibirás nuestras mejores recetas y ofertas.</p>
            </form>
        </div>
    </div>
</main>

<%@ include file="/jsp/layouts/footer.jsp" %>
<script>
    document.querySelector('form').addEventListener('submit', function(e) {
        if (document.getElementById('password').value !== document.getElementById('confirmar').value) {
            e.preventDefault();
            alert('Las contraseñas no coinciden.');
        }
    });
</script>
</body>
</html>
