<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.lacasademandi.modelo.Cliente" %>
<%@ page import="com.lacasademandi.modelo.Pedido" %>
<%@ page import="com.lacasademandi.dao.PedidoDAO" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Abono — La Casa de Mandi</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cliente.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/detalle-pedido.css">
</head>
<body>

<%
    // Verificar sesión
    Cliente cliente = (Cliente) session.getAttribute("cliente");
    if (cliente == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    // Obtener el pedido
    String idParam = request.getParameter("id");
    if (idParam == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/cliente/mis-pedidos.jsp");
        return;
    }

    int idPedido = Integer.parseInt(idParam);
    PedidoDAO pedidoDAO = new PedidoDAO();
    Pedido pedido = pedidoDAO.buscarPorId(idPedido);

    // Verificar que el pedido existe, es del cliente y está en estado Aceptado
    if (pedido == null || pedido.getIdCliente() != cliente.getIdCliente()
            || !"Aceptado".equals(pedido.getEstado())) {
        response.sendRedirect(request.getContextPath() + "/jsp/cliente/mis-pedidos.jsp");
        return;
    }

    double totalPedido = pedido.getPrecioTotal();
    double minimoAbono = totalPedido * 0.50;

    String paginaActiva = "pedidos";
%>

<%@ include file="/jsp/layouts/header.jsp" %>

<main class="cliente-wrapper">

    <!-- Breadcrumb -->
    <nav class="breadcrumb">
        <a href="${pageContext.request.contextPath}/jsp/cliente/mis-pedidos.jsp">Mis Pedidos</a>
        <span>&rsaquo;</span>
        <a href="${pageContext.request.contextPath}/jsp/cliente/detalle-pedido.jsp?id=<%= idPedido %>">
            Pedido #<%= idPedido %>
        </a>
        <span>&rsaquo;</span>
        <span>Registrar Abono</span>
    </nav>

    <div class="abono-grid">

        <!-- Formulario principal -->
        <div>
            <h1 class="cliente-titulo">Registrar Abono</h1>
            <p class="cliente-subtitulo">
                Completa los detalles de tu pago para confirmar tu reserva.
                Recuerda que se requiere un mínimo del 50%.
            </p>

            <!-- Resumen del total -->
            <div class="abono-resumen">
                <div>
                    <span class="abono-resumen__label">TOTAL DEL PEDIDO</span>
                    <strong class="abono-resumen__monto">
                        $<%= String.format("%.2f", totalPedido) %>
                    </strong>
                </div>
                <div>
                    <span class="abono-resumen__label">MÍNIMO REQUERIDO (50%)</span>
                    <strong class="abono-resumen__monto abono-resumen__monto--rojo">
                        $<%= String.format("%.2f", minimoAbono) %>
                    </strong>
                </div>
            </div>

            <%-- Mensaje de error si lo hay --%>
            <% if (request.getAttribute("error") != null) { %>
                <div class="alerta-error" style="margin-bottom:1.25rem;">
                    <span>⚠</span>
                    <span><%= request.getAttribute("error") %></span>
                </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/registrar-abono" method="post" novalidate>
                <input type="hidden" name="idPedido" value="<%= idPedido %>">

                <!-- Monto y porcentaje -->
                <div class="campo--doble">
                    <div class="campo">
                        <label class="campo__label" for="monto">Monto del Abono</label>
                        <div style="position:relative;">
                            <span style="position:absolute; left:0.75rem; top:50%; transform:translateY(-50%); color:var(--outline);">$</span>
                            <input class="campo__input" style="padding-left:1.75rem;"
                                   type="number" id="monto" name="monto"
                                   min="<%= minimoAbono %>" step="0.01"
                                   placeholder="0.00" required
                                   oninput="calcularPorcentaje(this.value)">
                        </div>
                    </div>
                    <div class="campo">
                        <label class="campo__label" for="porcentaje">Porcentaje del Total</label>
                        <div style="position:relative;">
                            <input class="campo__input" style="padding-right:2rem;"
                                   type="number" id="porcentaje" name="porcentaje"
                                   value="50" min="50" max="100" step="1" readonly>
                            <span style="position:absolute; right:0.75rem; top:50%; transform:translateY(-50%); color:var(--outline);">%</span>
                        </div>
                    </div>
                </div>

                <!-- Fecha y método -->
                <div class="campo--doble">
                    <div class="campo">
                        <label class="campo__label" for="fechaPago">Fecha de Pago</label>
                        <input class="campo__input" type="date"
                               id="fechaPago" name="fechaPago" required>
                    </div>
                    <div class="campo">
                        <label class="campo__label" for="metodoPago">Método de Pago</label>
                        <select class="campo__input" id="metodoPago" name="metodoPago"
                                onchange="actualizarReferencia(this.value)">
                            <option value="Yappy">Yappy</option>
                            <option value="Efectivo">Efectivo</option>
                            <option value="Transferencia">Transferencia</option>
                        </select>
                    </div>
                </div>

                <!-- Referencia (etiqueta cambia según método) -->
                <div class="campo" id="campo-referencia">
                    <label class="campo__label" id="label-referencia">
                        Número de confirmación (Yappy)
                    </label>
                    <input class="campo__input" type="text"
                           id="referencia" name="referencia"
                           placeholder="Ej: 123456">
                </div>

                <!-- Aviso -->
                <div class="abono-aviso">
                    <span>ℹ</span>
                    <p>Tu abono será verificado por nuestro equipo administrativo en un lapso de 2 a 4 horas hábiles. Recibirás una notificación una vez confirmado.</p>
                </div>

                <button type="submit" class="btn btn--primario btn--bloque">
                    Confirmar abono ✓
                </button>
            </form>
        </div>

        <!-- Panel lateral de ayuda -->
        <div class="abono-lateral">
            <div class="card">
                <h3 style="font-family:var(--font-display); font-size:20px; margin-bottom:1rem;">Ayuda</h3>
                <p style="font-size:14px; color:var(--on-surface-variant); margin-bottom:1rem;">
                    ¿Tienes problemas con tu pago?
                </p>
                <div style="display:flex; flex-direction:column; gap:0.75rem;">
                    <a href="#" class="enlace-detalle"> WhatsApp Soporte</a>
                    <a href="#" class="enlace-detalle">❓ Preguntas Frecuentes</a> <!--Podria poner un icono para whatsapp idk-->
                </div>
            </div>

            <!-- Imagen decorativa -->
            <div class="abono-lateral__img img-placeholder" style="aspect-ratio:4/3; border-radius:var(--radius-lg); margin-top:1rem; position:relative;">
                <div style="position:absolute; bottom:1rem; left:1rem; font-family:var(--font-display); font-size:16px; font-style:italic; color:rgba(255,255,255,0.85);">
                    Artesanía en cada detalle.
                </div>
            </div>
        </div>

    </div>

</main>

<%@ include file="/jsp/layouts/footer.jsp" %>

<script>
    var totalPedido = <%= totalPedido %>;

    // Calcula el porcentaje automáticamente cuando el usuario ingresa el monto
    function calcularPorcentaje(monto) {
        var pct = (parseFloat(monto) / totalPedido) * 100;
        document.getElementById('porcentaje').value = isNaN(pct) ? 50 : Math.round(pct);
    }

    // Cambia la etiqueta del campo referencia según el método de pago elegido
    function actualizarReferencia(metodo) {
        var label = document.getElementById('label-referencia');
        var input = document.getElementById('referencia');
        var campRef = document.getElementById('campo-referencia');

        if (metodo === 'Yappy') {
            label.textContent = 'Número de confirmación (Yappy)';
            input.placeholder = 'Ej: 123456';
            campRef.style.display = '';
        } else if (metodo === 'Transferencia') {
            label.textContent = 'Número de transferencia';
            input.placeholder = 'Ej: TRF-00123';
            campRef.style.display = '';
        } else {
            // Efectivo no necesita referencia
            campRef.style.display = 'none';
        }
    }
</script>

</body>
</html>
