<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sobre Nosotros — La Casa de Mandi</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/nosotros.css">
</head>
<body>

<% String paginaActiva = "nosotros"; %>
<%@ include file="/jsp/layouts/header.jsp" %>

<main>

    <!-- Historia -->
    <section class="nosotros-historia">
        <span class="etiqueta">NUESTRA HISTORIA</span>
        <h1>Tradición y Pasión en Cada Bocado</h1>
        <hr class="nosotros-divisor">
        <p>
            Nacimos del deseo de compartir el calor de un hogar panameño a través de la repostería artesanal.
            En La Casa de Mandi, cada ingrediente es seleccionado con rigor técnico y amor casero,
            fusionando la precisión de la ingeniería con la dulzura de la tradición.
        </p>
    </section>

    <!-- Equipo -->
    <section class="nosotros-equipo">
        <h2>Nuestro Equipo</h2>
        <p class="nosotros-equipo__subtitulo">El talento detrás de la innovación y el sabor.</p>

        <div class="equipo-grid">

            <div class="tarjeta-miembro">
                <div class="tarjeta-miembro__foto img-placeholder"></div>
                <span class="tarjeta-miembro__carrera">LIC. INGENIERÍA DE SOFTWARE</span>
                <h3 class="tarjeta-miembro__nombre">Marian Barba</h3>
                <span class="tarjeta-miembro__cedula">8-1012-213</span>
                <p class="tarjeta-miembro__desc">Líder de desarrollo y arquitectura de soluciones, enfocada en la optimización de procesos digitales para la gestión de pedidos artesanales.</p>
            </div>

            <div class="tarjeta-miembro">
                <div class="tarjeta-miembro__foto img-placeholder"></div>
                <span class="tarjeta-miembro__carrera">LIC. INGENIERÍA DE SOFTWARE</span>
                <h3 class="tarjeta-miembro__nombre">Gabriela Fuentes</h3>
                <span class="tarjeta-miembro__cedula">8-1042-245</span>
                <p class="tarjeta-miembro__desc">Especialista en experiencia de usuario y diseño de interfaces intuitivas que conectan la calidez de lo casero con la facilidad de lo digital.</p>
            </div>

            <div class="tarjeta-miembro">
                <div class="tarjeta-miembro__foto img-placeholder"></div>
                <span class="tarjeta-miembro__carrera">LIC. INGENIERÍA DE SOFTWARE</span>
                <h3 class="tarjeta-miembro__nombre">Laura Orellana</h3>
                <span class="tarjeta-miembro__cedula">E-8-221893</span>
                <p class="tarjeta-miembro__desc">Encargada de la lógica de negocio y escalabilidad del sistema, garantizando que cada transacción sea tan fluida como nuestra crema pastelera.</p>
            </div>

            <div class="tarjeta-miembro">
                <div class="tarjeta-miembro__foto img-placeholder"></div>
                <span class="tarjeta-miembro__carrera">LIC. INGENIERÍA DE SOFTWARE</span>
                <h3 class="tarjeta-miembro__nombre">Evelin Pineda</h3>
                <span class="tarjeta-miembro__cedula">8-1031-1126</span>
                <p class="tarjeta-miembro__desc">Responsable de control de calidad y pruebas integrales, asegurando la robustez tecnológica de nuestra plataforma de ventas.</p>
            </div>

        </div>
    </section>

    <!-- CTA final -->
    <section class="nosotros-cta">
        <div class="nosotros-cta__texto">
            <h2>¿Listo para probar la tradición?</h2>
            <p>Descubre nuestra selección de dulces caseros hoy mismo.</p>
        </div>
        <div class="nosotros-cta__botones">
            <a href="${pageContext.request.contextPath}/jsp/public/catalogo.jsp"
               class="btn btn--primario">Ver Catálogo</a>
            <a href="${pageContext.request.contextPath}/jsp/public/contacto.jsp"
               class="btn btn--outline">Contáctanos</a>
        </div>
    </section>

</main>

<%@ include file="/jsp/layouts/footer.jsp" %>

</body>
</html>
