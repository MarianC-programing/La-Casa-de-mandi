<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalle — La Casa de Mandi</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/detalle.css">
</head>
<body>

<% String paginaActiva = "catalogo"; %>
<%@ include file="/jsp/layouts/header.jsp" %>

<main class="detalle-wrapper">

    <!-- Migas de pan -->
    <nav class="breadcrumb">
        <a href="${pageContext.request.contextPath}/">Inicio</a>
        <span>&rsaquo;</span>
        <a href="${pageContext.request.contextPath}/jsp/public/catalogo.jsp">Pastelería Artesanal</a>
        <span>&rsaquo;</span>
        <span>Cheesecake Frutos del Bosque</span>
    </nav>

    <div class="detalle-grid">

        <!-- Columna izquierda: imágenes -->
        <div class="detalle-galeria">
            <div class="detalle-galeria__principal">
                <span class="badge-destacado">BESTSELLER</span>
                <!-- Imagen principal: agregar cuando esté disponible -->
                <div class="img-placeholder img-placeholder--grande"></div>
            </div>
            <!-- Miniaturas decorativas -->
            <div class="detalle-galeria__miniaturas">
                <div class="miniatura activa"></div>
                <div class="miniatura"></div>
                <div class="miniatura"></div>
                <div class="miniatura"></div>
            </div>
        </div>

        <!-- Columna derecha: info y pedido -->
        <div class="detalle-info">
            <span class="etiqueta">COLECCIÓN PRIMAVERA</span>
            <h1 class="detalle-info__titulo">Cheesecake Frutos del Bosque</h1>

            <!-- Estrellas decorativas (estáticas) -->
            <div class="detalle-info__estrellas">
                <span>★★★★☆</span>
                <span class="detalle-info__resenas">(12 Reseñas)</span>
            </div>

            <p class="detalle-info__desc">
                Nuestra tarta insignia elaborada sobre una crujiente base de galleta artesanal, rellena de una crema de queso suave y horneada a la perfección, coronada con una selección premium de frutos rojos frescos de temporada.
            </p>

            <!-- Panel de pedido -->
            <div class="detalle-pedido">

                <div class="campo">
                    <label class="campo__label" for="tamano">Tamaño del Pedido</label>
                    <select class="campo__input" id="tamano" name="tamano" onchange="actualizarPrecio(this)">
                        <option value="35" data-label='6" (pequeño)'>6" (pequeño) - $35.00</option>
                        <option value="45" data-label='8" (mediano)' selected>8" (mediano) - $45.00</option>
                        <option value="55" data-label='10" (grande)'>10" (grande) - $55.00</option>
                    </select>
                </div>

                <div class="campo">
                    <label class="campo__label" for="diseno">Detalles de personalización</label>
                    <textarea
                        class="campo__input"
                        id="diseno"
                        name="diseno"
                        rows="3"
                        placeholder="Ej: Incluir un mensaje de feliz cumpleaños, colores específicos o decoraciones adicionales."
                    ></textarea>
                    <small style="color:var(--outline); font-size:13px;">Personaliza tu pedido para hacerlo único.</small>
                </div>

                <div class="detalle-pedido__precio">
                    <span style="font-size:12px; font-weight:600; letter-spacing:0.08em; color:var(--outline);">PRECIO ESTIMADO</span>
                    <div class="detalle-pedido__monto">
                        $<span id="precio-mostrado">45.00</span>
                        <span style="font-size:14px; color:var(--outline);">USD</span>
                    </div>
                </div>

                <!-- Aviso precio dulces -->
                <div class="detalle-pedido__aviso">
                    <span>ℹ</span>
                    <p><strong>Dulces Personalizados:</strong> El precio final será confirmado por el administrador según tu diseño y requerimientos específicos.</p>
                </div>

                <!-- Botón: si hay sesión va a nuevo pedido, si no va a registro -->
                <%
                    boolean tieneSession = session.getAttribute("cliente") != null;
                %>
                <% if (tieneSession) { %>
                    <a href="${pageContext.request.contextPath}/jsp/cliente/nuevo-pedido.jsp?id=6"
                       class="btn btn--primario btn--bloque">
                        🛍 Hacer pedido
                    </a>
                <% } else { %>
                    <a href="${pageContext.request.contextPath}/jsp/public/registro.jsp"
                       class="btn btn--primario btn--bloque">
                        🛍 Hacer pedido
                    </a>
                <% } %>

            </div>

            <!-- Íconos de beneficios -->
            <div class="detalle-beneficios">
                <div class="beneficio">
                    <span>Recién Horneado</span>
                </div>
                <div class="beneficio">
                    <span>Envío Gourmet</span>
                </div>
                <div class="beneficio">
                    <span>Ingredientes Bio</span>
                </div>
                <div class="beneficio">
                    <span>Garantía Mandi</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Detalles técnicos -->
    <section class="detalle-tecnico">
        <div class="detalle-tecnico__intro">
            <h2>Detalles Técnicos</h2>
            <blockquote>"La perfección está en los detalles que nadie ve, pero todos saborean."</blockquote>
        </div>
        <div class="detalle-tecnico__grid">
            <div>
                <span class="etiqueta">INGREDIENTES</span>
                <p>Harina de trigo orgánica, huevos de campo, mantequilla artesanal, vainilla de Madagascar, frutos del bosque locales.</p>
            </div>
            <div>
                <span class="etiqueta">CONSERVACIÓN</span>
                <p>Mantener refrigerado entre 4°C y 8°C. Consumir preferentemente en las primeras 48 horas tras la entrega.</p>
            </div>
            <div>
                <span class="etiqueta">ALÉRGENOS</span>
                <p>Contiene gluten, lácteos y huevos. Puede contener trazas de frutos de cáscara.</p>
            </div>
            <div>
                <span class="etiqueta">PERSONALIZACIÓN</span>
                <p>Podemos incluir mensajes personalizados en chocolate o toppers temáticos bajo pedido previo.</p>
            </div>
        </div>
    </section>

</main>

<%@ include file="/jsp/layouts/footer.jsp" %>

<script>
    // Actualiza el precio mostrado cuando cambia el tamaño
    function actualizarPrecio(select) {
        var precio = select.value;
        document.getElementById('precio-mostrado').textContent = parseFloat(precio).toFixed(2);
    }
</script>

</body>
</html>
