<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>La Casa de Mandi — Dulces Hechos con Amor</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/inicio.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/catalogo.css">
</head>
<body>

<% String paginaActiva = "inicio"; %>
<%@ include file="/jsp/layouts/header.jsp" %>

<main>

    <!-- Hero -->
    <section class="hero">
        <div class="hero__contenido">
            <h1 class="hero__titulo">DULCES HECHOS<br>CON AMOR</h1>
            <p class="hero__desc">
                Descubre la magia de la repostería artesanal. Ingredientes frescos,
                recetas de toda la vida y mucho amor en cada bocado.
            </p>
            <div class="hero__botones">
                <a href="${pageContext.request.contextPath}/jsp/public/catalogo.jsp"
                   class="btn btn--primario">Ordenar Ahora</a>
                <a href="${pageContext.request.contextPath}/jsp/public/catalogo.jsp"
                   class="btn btn--outline">Ver Catálogo</a>
            </div>
        </div>
        <div class="hero__imagen">
            <!-- Imagen principal del hero: agregar cuando esté disponible -->
            <div class="img-placeholder hero__img-placeholder"></div>
        </div>
    </section>

    <!-- Productos destacados -->
    <section class="seccion">
        <span class="etiqueta">NUESTROS FAVORITOS</span>
        <h2 class="seccion__titulo">Dulces y Postres Destacados</h2>

        <div class="catalogo-grid" style="max-width:var(--container-max); margin:0 auto;">

            <div class="tarjeta-producto">
                <div class="tarjeta-producto__img-wrap">
                    <div class="img-placeholder" style="height:200px;"></div>
                </div>
                <div class="tarjeta-producto__cuerpo">
                    <span class="tarjeta-producto__cat">DULCE TRADICIONAL</span>
                    <h3 class="tarjeta-producto__nombre">Delicia Tres Leches Frutal</h3>
                    <div class="tarjeta-producto__pie">
                        <span>desde <strong class="precio">$35.00</strong></span>
                        <a href="${pageContext.request.contextPath}/jsp/public/detalle-dulce.jsp?id=1"
                           class="enlace-detalle">Ver detalles</a>
                    </div>
                </div>
            </div>

            <div class="tarjeta-producto">
                <div class="tarjeta-producto__img-wrap">
                    <div class="img-placeholder" style="height:200px;"></div>
                </div>
                <div class="tarjeta-producto__cuerpo">
                    <span class="tarjeta-producto__cat">REPOSTERÍA FINA</span>
                    <h3 class="tarjeta-producto__nombre">Cheesecake Tropical de Maracuyá</h3>
                    <div class="tarjeta-producto__pie">
                        <span>desde <strong class="precio">$18.00</strong></span>
                        <a href="${pageContext.request.contextPath}/jsp/public/detalle-dulce.jsp?id=2"
                           class="enlace-detalle">Ver detalles</a>
                    </div>
                </div>
            </div>

            <div class="tarjeta-producto">
                <div class="tarjeta-producto__img-wrap">
                    <div class="img-placeholder" style="height:200px;"></div>
                </div>
                <div class="tarjeta-producto__cuerpo">
                    <span class="tarjeta-producto__cat">REBANADAS TRIANGULARES</span>
                    <h3 class="tarjeta-producto__nombre">Cheesecake Frutos del Bosque</h3>
                    <div class="tarjeta-producto__pie">
                        <span>desde <strong class="precio">$3.00</strong></span>
                        <a href="${pageContext.request.contextPath}/jsp/public/detalle-postre.jsp?id=10"
                           class="enlace-detalle">Ver detalles</a>
                    </div>
                </div>
            </div>

        </div>

        <div style="text-align:center; margin-top:2rem;">
            <a href="${pageContext.request.contextPath}/jsp/public/catalogo.jsp"
               class="btn btn--primario">Explorar todos los dulces</a>
        </div>
    </section>

    <!-- Noticias y Novedades -->
    <section class="seccion seccion--alterna">
        <span class="etiqueta">NOTICIAS Y NOVEDADES</span>
        <h2 class="seccion__titulo">
            Mantente al tanto de nuestras últimas<br>historias y secretos culinarios.
        </h2>

        <div class="noticias-grid">

            <div class="tarjeta-noticia">
                <div class="tarjeta-noticia__img img-placeholder"></div>
                <div class="tarjeta-noticia__cuerpo">
                    <h3 class="tarjeta-noticia__titulo">El Secreto de la Masa Madre</h3>
                    <p class="tarjeta-noticia__texto">
                        Descubre las técnicas ancestrales que dan vida a nuestro pan más especial.
                    </p>
                    <a href="#" class="enlace-detalle">Leer más →</a>
                </div>
            </div>

            <div class="tarjeta-noticia">
                <div class="tarjeta-noticia__img img-placeholder"></div>
                <div class="tarjeta-noticia__cuerpo">
                    <h3 class="tarjeta-noticia__titulo">El Arte de la Decoración</h3>
                    <p class="tarjeta-noticia__texto">
                        Un vistazo a la precisión y creatividad detrás de nuestras tartas personalizadas.
                    </p>
                    <a href="#" class="enlace-detalle">Leer más →</a>
                </div>
            </div>

            <div class="tarjeta-noticia">
                <div class="tarjeta-noticia__img img-placeholder"></div>
                <div class="tarjeta-noticia__cuerpo">
                    <h3 class="tarjeta-noticia__titulo">Un día en nuestra cocina</h3>
                    <p class="tarjeta-noticia__texto">
                        Acompáñanos en el proceso diario de creación de nuestros dulces artesanales.
                    </p>
                    <a href="#" class="enlace-detalle">Ver video →</a>
                </div>
            </div>

        </div>
    </section>

    <!-- Proceso de compra -->
    <section class="seccion">
        <span class="etiqueta">PROCESO DE COMPRA</span>
        <h2 class="seccion__titulo">¿Cómo hacer tu pedido?</h2>

        <div class="pasos">

            <div class="paso">
                <div class="paso__numero">1</div>
                <h3 class="paso__titulo">Elige</h3>
                <p class="paso__desc">Selecciona tus dulces favoritos de nuestro catálogo.</p>
            </div>

            <div class="paso">
                <div class="paso__numero">2</div>
                <h3 class="paso__titulo">Confirma</h3>
                <p class="paso__desc">Contáctanos para validar disponibilidad y fecha.</p>
            </div>

            <div class="paso">
                <div class="paso__numero">3</div>
                <h3 class="paso__titulo">Abona</h3>
                <p class="paso__desc">Realiza el pago del abono para asegurar tu pedido.</p>
            </div>

            <div class="paso">
                <div class="paso__numero">4</div>
                <h3 class="paso__titulo">Disfruta</h3>
                <p class="paso__desc">Recoge tu pedido y disfruta en casa.</p>
            </div>

        </div>
    </section>

</main>

<%@ include file="/jsp/layouts/footer.jsp" %>

</body>
</html>
