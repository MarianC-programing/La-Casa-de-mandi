<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalle Postre — La Casa de Mandi</title>
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
        <a href="${pageContext.request.contextPath}/jsp/public/catalogo.jsp">Catálogo</a>
        <span>&rsaquo;</span>
        <span>Postres</span>
        <span>&rsaquo;</span>
        <span>Cheesecake Frutos del Bosque</span>
    </nav>

    <div class="detalle-grid">

        <!-- Columna izquierda: imágenes -->
        <div class="detalle-galeria">
            <div class="detalle-galeria__principal">
                <div class="img-placeholder img-placeholder--grande"></div>
            </div>
            <div class="detalle-galeria__miniaturas">
                <div class="miniatura activa"></div>
                <div class="miniatura"></div>
                <div class="miniatura"></div>
            </div>
        </div>

        <!-- Columna derecha: info y pedido -->
        <div class="detalle-info">
            <span class="etiqueta">POSTRES DEL CATÁLOGO</span>
            <h1 class="detalle-info__titulo">Cheesecake Frutos del Bosque</h1>

            <div class="detalle-postre__precio">
                <span class="detalle-postre__monto">$3.00</span>
                <span style="color:var(--outline); font-size:14px;">Precio Base</span>
            </div>

            <p class="detalle-info__desc">
                Porción individual de nuestra tarta insignia elaborada sobre una crujiente base de galleta artesanal, rellena de una crema de queso suave y horneada a la perfección.
            </p>

            <hr style="border:none; border-top:1px solid var(--outline-variant); margin: 1.5rem 0;">

            <!-- Selector de cantidad -->
            <div class="campo">
                <label class="campo__label">Cantidad</label>
                <div class="cantidad-control">
                    <button type="button" onclick="cambiarCantidad(-1)">−</button>
                    <input type="number" id="cantidad" value="1" min="1" max="20" readonly>
                    <button type="button" onclick="cambiarCantidad(1)">+</button>
                </div>
            </div>

            <!-- Precio total calculado -->
            <div class="detalle-postre__total">
                Total: <strong>$<span id="total">3.00</span></strong>
            </div>

            <!-- Botón: si hay sesión va a nuevo pedido, si no va a registro -->
            <%
                boolean tieneSession = session.getAttribute("cliente") != null;
            %>
            <% if (tieneSession) { %>
                <a href="${pageContext.request.contextPath}/jsp/cliente/nuevo-pedido.jsp?id=10"
                   class="btn btn--primario btn--bloque" style="margin-top:1rem;">
                    Hacer pedido
                </a>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/jsp/public/registro.jsp"
                   class="btn btn--primario btn--bloque" style="margin-top:1rem;">
                    Hacer pedido
                </a>
            <% } %>

            <!-- Beneficios -->
            <div class="detalle-beneficios" style="margin-top:1.5rem;">
                <div class="beneficio">
                    <span>Envío en 24h</span>
                </div>
                <div class="beneficio">
                    <span>Garantía de frescura</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Ingredientes, alérgenos, conservación -->
    <section class="detalle-tecnico">
        <div class="detalle-tecnico__grid">
            <div>
                <span class="etiqueta">Ingredientes</span>
                <p>Queso crema premium, galletas artesanales de mantequilla, frutos del bosque frescos (arándanos, frambuesas, moras), azúcar de caña orgánica, extracto de vainilla puro y huevos de granja.</p>
            </div>
            <div>
                <span class="etiqueta">⚠ Alérgenos</span>
                <div style="display:flex; gap:0.5rem; flex-wrap:wrap; margin-top:0.5rem;">
                    <span class="badge-alergeno">LÁCTEOS</span>
                    <span class="badge-alergeno">GLUTEN</span>
                    <span class="badge-alergeno">HUEVO</span>
                </div>
                <p style="margin-top:0.5rem;">Puede contener trazas de frutos de cáscara.</p>
            </div>
            <div>
                <span class="etiqueta">❄ Conservación</span>
                <p>Mantener refrigerado entre 4°C y 6°C. Se recomienda consumir antes de 4 días para disfrutar de su textura y sabor óptimos.</p>
            </div>
        </div>
    </section>

    <!-- Otros postres -->
    <section class="detalle-relacionados">
        <div class="detalle-relacionados__header">
            <div>
                <span class="etiqueta">EXPLORA MÁS</span>
                <h2>Otros Postres del Catálogo</h2>
            </div>
            <a href="${pageContext.request.contextPath}/jsp/public/catalogo.jsp" class="enlace-detalle">
                Ver catálogo completo →
            </a>
        </div>
        <div class="relacionados-grid">
            <div class="tarjeta-relacionado">
                <div class="tarjeta-relacionado__img img-placeholder"></div>
                <span class="tarjeta-relacionado__cat">REBANADAS TRIANGULARES</span>
                <h4>Cheesecake Tropical de Maracuyá</h4>
            </div>
            <div class="tarjeta-relacionado">
                <div class="tarjeta-relacionado__img img-placeholder"></div>
                <span class="tarjeta-relacionado__cat">REGALOS &amp; DETALLES</span>
                <h4>Cheesecake Caramelo de Maracuyá</h4>
            </div>
        </div>
    </section>

</main>

<%@ include file="/jsp/layouts/footer.jsp" %>

<script>
    var precioUnitario = 3.00;

    function cambiarCantidad(cambio) {
        var input = document.getElementById('cantidad');
        var nueva = parseInt(input.value) + cambio;
        // No bajar de 1 ni subir de 20
        if (nueva < 1) nueva = 1;
        if (nueva > 20) nueva = 20;
        input.value = nueva;
        // Actualizar el total
        document.getElementById('total').textContent = (nueva * precioUnitario).toFixed(2);
    }
</script>

</body>
</html>
