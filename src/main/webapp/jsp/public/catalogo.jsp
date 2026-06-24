<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catálogo — La Casa de Mandi</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/catalogo.css">
</head>
<body>

<% String paginaActiva = "catalogo"; %>
<%@ include file="/jsp/layouts/header.jsp" %>

<main>

    <!-- Encabezado de la página -->
    <section class="catalogo-hero">
        <span class="etiqueta">TRADICIÓN &amp; SABOR</span>
        <h1>Nuestras Delicias Artesanales</h1>
        <p>Cada receta es un legado familiar, preparada con ingredientes orgánicos y el tiempo necesario para alcanzar la perfección.</p>
    </section>

    <!-- Tabs de categoría -->
    <div class="catalogo-tabs">
        <button class="tab activo" onclick="mostrarCategoria('dulces', this)">Dulces</button>
        <button class="tab" onclick="mostrarCategoria('postres', this)">Postres</button>
    </div>

    <!-- Sección Dulces -->
    <section id="seccion-dulces" class="catalogo-grid-wrapper">
        <div class="catalogo-grid">

            <div class="tarjeta-producto">
                <div class="tarjeta-producto__img-wrap">
                    <img src="${pageContext.request.contextPath}/img/tres-leches.jpg" alt="Delicia Tres Leches Frutal">
                </div>
                <div class="tarjeta-producto__cuerpo">
                    <span class="tarjeta-producto__cat">DULCE TRADICIONAL</span>
                    <h3 class="tarjeta-producto__nombre">Delicia Tres Leches Frutal</h3>
                    <p class="tarjeta-producto__desc">Bizcocho tres leches decorado con fresas frescas y melocotón, suave y húmedo.</p>
                    <div class="tarjeta-producto__pie">
                        <span>desde <strong class="precio">$35.00</strong></span>
                        <a href="${pageContext.request.contextPath}/jsp/public/detalle-dulce.jsp?id=1" class="enlace-detalle">Ver detalles</a>
                    </div>
                </div>
            </div>

            <div class="tarjeta-producto">
                <div class="tarjeta-producto__img-wrap">
                    <img src="${pageContext.request.contextPath}/img/cheesecake-maracuya.jpg" alt="Cheesecake Tropical de Maracuyá">
                </div>
                <div class="tarjeta-producto__cuerpo">
                    <span class="tarjeta-producto__cat">REPOSTERÍA FINA</span>
                    <h3 class="tarjeta-producto__nombre">Cheesecake Tropical de Maracuyá</h3>
                    <p class="tarjeta-producto__desc">Cheesecake cremoso con cobertura de maracuyá natural y sabor tropical.</p>
                    <div class="tarjeta-producto__pie">
                        <span>desde <strong class="precio">$18.00</strong></span>
                        <a href="${pageContext.request.contextPath}/jsp/public/detalle-dulce.jsp?id=2" class="enlace-detalle">Ver detalles</a>
                    </div>
                </div>
            </div>

            <div class="tarjeta-producto">
                <div class="tarjeta-producto__img-wrap">
                    <img src="${pageContext.request.contextPath}/img/fresas-crema.jpg" alt="Fresas y Crema">
                </div>
                <div class="tarjeta-producto__cuerpo">
                    <span class="tarjeta-producto__cat">GOURMET</span>
                    <h3 class="tarjeta-producto__nombre">Fresas &amp; Crema</h3>
                    <p class="tarjeta-producto__desc">Pastel relleno de fresas frescas y crema suave, ideal para celebraciones.</p>
                    <div class="tarjeta-producto__pie">
                        <span>desde <strong class="precio">$15.00</strong></span>
                        <a href="${pageContext.request.contextPath}/jsp/public/detalle-dulce.jsp?id=3" class="enlace-detalle">Ver detalles</a>
                    </div>
                </div>
            </div>

            <div class="tarjeta-producto">
                <div class="tarjeta-producto__img-wrap">
                    <img src="${pageContext.request.contextPath}/img/chocoflan.jpg" alt="Chocoflan de Fresas">
                </div>
                <div class="tarjeta-producto__cuerpo">
                    <span class="tarjeta-producto__cat">CLÁSICOS</span>
                    <h3 class="tarjeta-producto__nombre">Chocoflan de Fresas</h3>
                    <p class="tarjeta-producto__desc">Combinación de flan y pastel de chocolate decorado con fresas frescas.</p>
                    <div class="tarjeta-producto__pie">
                        <span>desde <strong class="precio">$15.00</strong></span>
                        <a href="${pageContext.request.contextPath}/jsp/public/detalle-dulce.jsp?id=4" class="enlace-detalle">Ver detalles</a>
                    </div>
                </div>
            </div>

            <div class="tarjeta-producto">
                <div class="tarjeta-producto__img-wrap">
                    <img src="${pageContext.request.contextPath}/img/melocoton-crema.jpg" alt="Melocotón y Crema">
                </div>
                <div class="tarjeta-producto__cuerpo">
                    <span class="tarjeta-producto__cat">CLÁSICOS</span>
                    <h3 class="tarjeta-producto__nombre">Melocotón &amp; Crema</h3>
                    <p class="tarjeta-producto__desc">Pastel relleno de melocotón y crema, con textura ligera y sabor delicado.</p>
                    <div class="tarjeta-producto__pie">
                        <span>desde <strong class="precio">$15.00</strong></span>
                        <a href="${pageContext.request.contextPath}/jsp/public/detalle-dulce.jsp?id=5" class="enlace-detalle">Ver detalles</a>
                    </div>
                </div>
            </div>

            <div class="tarjeta-producto">
                <div class="tarjeta-producto__img-wrap">
                    <img src="${pageContext.request.contextPath}/img/frutos-bosque.jpg" alt="Cheesecake Frutos del Bosque">
                </div>
                <div class="tarjeta-producto__cuerpo">
                    <span class="tarjeta-producto__cat">POSTRES INOLVIDABLES</span>
                    <h3 class="tarjeta-producto__nombre">Cheesecake Frutos del Bosque</h3>
                    <p class="tarjeta-producto__desc">Cheesecake cremoso cubierto con una selección de frutos rojos.</p>
                    <div class="tarjeta-producto__pie">
                        <span>desde <strong class="precio">$18.00</strong></span>
                        <a href="${pageContext.request.contextPath}/jsp/public/detalle-dulce.jsp?id=6" class="enlace-detalle">Ver detalles</a>
                    </div>
                </div>
            </div>

        </div>
    </section>

    <!-- Sección Postres (oculta por defecto) -->
    <section id="seccion-postres" class="catalogo-grid-wrapper" style="display:none;">
        <div class="catalogo-grid catalogo-grid--3">

            <div class="tarjeta-producto">
                <div class="tarjeta-producto__img-wrap">
                    <span class="badge-destacado">Destacado</span>
                    <img src="${pageContext.request.contextPath}/img/cheesecake-maracuya-porcion.jpg" alt="Cheesecake Tropical de Maracuyá">
                </div>
                <div class="tarjeta-producto__cuerpo">
                    <span class="tarjeta-producto__cat">REBANADAS TRIANGULARES</span>
                    <h3 class="tarjeta-producto__nombre">Cheesecake Tropical de Maracuyá</h3>
                    <p class="tarjeta-producto__desc">Porción individual de cheesecake con cobertura de maracuyá.</p>
                    <div class="tarjeta-producto__pie">
                        <span>Desde <strong class="precio">$3.00</strong></span>
                        <a href="${pageContext.request.contextPath}/jsp/public/detalle-postre.jsp?id=8" class="enlace-detalle">Ver detalles</a>
                    </div>
                </div>
            </div>

            <div class="tarjeta-producto">
                <div class="tarjeta-producto__img-wrap">
                    <img src="${pageContext.request.contextPath}/img/frutos-bosque-porcion.jpg" alt="Cheesecake Frutos del Bosque">
                </div>
                <div class="tarjeta-producto__cuerpo">
                    <span class="tarjeta-producto__cat">PORCIONES INDIVIDUALES</span>
                    <h3 class="tarjeta-producto__nombre">Cheesecake Frutos del Bosque</h3>
                    <p class="tarjeta-producto__desc">Porción individual de cheesecake cubierto con frutos rojos.</p>
                    <div class="tarjeta-producto__pie">
                        <span>Desde <strong class="precio">$3.00</strong></span>
                        <a href="${pageContext.request.contextPath}/jsp/public/detalle-postre.jsp?id=10" class="enlace-detalle">Ver detalles</a>
                    </div>
                </div>
            </div>

            <div class="tarjeta-producto">
                <div class="tarjeta-producto__img-wrap">
                    <img src="${pageContext.request.contextPath}/img/cheesecake-caramelo.jpg" alt="Cheesecake Caramelo de Maracuyá">
                </div>
                <div class="tarjeta-producto__cuerpo">
                    <span class="tarjeta-producto__cat">REGALOS &amp; DETALLES</span>
                    <h3 class="tarjeta-producto__nombre">Cheesecake Caramelo de Maracuyá</h3>
                    <p class="tarjeta-producto__desc">Porción individual de cheesecake con salsa de maracuyá y caramelo.</p>
                    <div class="tarjeta-producto__pie">
                        <span>Desde <strong class="precio">$3.00</strong></span>
                        <a href="${pageContext.request.contextPath}/jsp/public/detalle-postre.jsp?id=9" class="enlace-detalle">Ver detalles</a>
                    </div>
                </div>
            </div>

        </div>
    </section>

    <!-- Suscripción -->
    <section class="catalogo-suscripcion">
        <h2>¿Quieres probar algo especial?</h2>
        <p>Suscríbete para recibir noticias sobre nuevos lanzamientos y ofertas exclusivas de nuestra cocina.</p>
        <div class="catalogo-suscripcion__form">
            <input type="email" placeholder="Tu correo electrónico">
            <button class="btn btn--primario">Suscribirse</button>
        </div>
    </section>

</main>

<%@ include file="/jsp/layouts/footer.jsp" %>

<script>
    // Cambia entre la pestaña Dulces y Postres
    function mostrarCategoria(categoria, boton) {
        // Ocultar ambas secciones
        document.getElementById('seccion-dulces').style.display = 'none';
        document.getElementById('seccion-postres').style.display = 'none';

        // Mostrar la que corresponde
        document.getElementById('seccion-' + categoria).style.display = 'block';

        // Marcar el tab activo
        document.querySelectorAll('.tab').forEach(function(t) {
            t.classList.remove('activo');
        });
        boton.classList.add('activo');
    }
</script>

</body>
</html>
