<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.lacasademandi.modelo.Cliente" %>
<%@ page import="com.lacasademandi.modelo.Pedido" %>
<%@ page import="com.lacasademandi.modelo.Abono" %>
<%@ page import="com.lacasademandi.modelo.PagoFinal" %>
<%@ page import="com.lacasademandi.dao.PedidoDAO" %>
<%@ page import="com.lacasademandi.dao.AbonoDAO" %>
<%@ page import="com.lacasademandi.dao.PagoFinalDAO" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalle del Pedido — La Casa de Mandi</title>
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

    // Obtener el pedido por ID
    String idParam = request.getParameter("id");
    if (idParam == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/cliente/mis-pedidos.jsp");
        return;
    }

    int idPedido = Integer.parseInt(idParam);
    PedidoDAO pedidoDAO = new PedidoDAO();
    Pedido pedido = pedidoDAO.buscarPorId(idPedido);

    // Verificar que el pedido pertenece al cliente con sesión
    if (pedido == null || pedido.getIdCliente() != cliente.getIdCliente()) {
        response.sendRedirect(request.getContextPath() + "/jsp/cliente/mis-pedidos.jsp");
        return;
    }

    // Cargar abono y pago final si existen
    AbonoDAO abonoDAO = new AbonoDAO();
    Abono abono = abonoDAO.buscarPorPedido(idPedido);

    PagoFinalDAO pagoDAO = new PagoFinalDAO();
    PagoFinal pagoFinal = pagoDAO.buscarPorPedido(idPedido);

    // Estado actual
    String estado = pedido.getEstado();
    String estadoClase = "pendiente";
    if ("Aceptado".equals(estado))          estadoClase = "aceptado";
    else if ("En produccion".equals(estado)) estadoClase = "produccion";
    else if ("Listo".equals(estado))        estadoClase = "listo";
    else if ("Entregado".equals(estado))    estadoClase = "entregado";
    else if ("Rechazado".equals(estado))    estadoClase = "rechazado";
    else if ("Cancelado".equals(estado))    estadoClase = "cancelado";

    String paginaActiva = "pedidos";
%>

<%@ include file="/jsp/layouts/header.jsp" %>

<main class="cliente-wrapper">

    <!-- Breadcrumb -->
    <nav class="breadcrumb">
        <a href="${pageContext.request.contextPath}/jsp/cliente/mis-pedidos.jsp">Mis Pedidos</a>
        <span>&rsaquo;</span>
        <span>Detalle #LM-<%= pedido.getIdPedido() %></span>
    </nav>

    <!-- Encabezado -->
    <div class="detalle-pedido-header">
        <div>
            <h1 class="cliente-titulo">Detalle del Pedido</h1>
            <p style="color:var(--outline); font-size:14px;">Realizado el <%= pedido.getFechaPedido() %></p>
        </div>
        <div style="display:flex; gap:1rem; flex-wrap:wrap;">
            <%-- Mostrar botón de abono solo si el pedido está Aceptado y no hay abono registrado --%>
            <% if ("Aceptado".equals(estado) && abono == null) { %>
                <a href="${pageContext.request.contextPath}/jsp/cliente/registrar-abono.jsp?id=<%= idPedido %>"
                   class="btn btn--primario"> Registrar abono</a>
            <% } %>
            <%-- Mostrar botón de pago final solo si está Listo y no hay pago final --%>
            <% if ("Listo".equals(estado) && pagoFinal == null) { %>
                <a href="${pageContext.request.contextPath}/jsp/cliente/registrar-pago-final.jsp?id=<%= idPedido %>"
                   class="btn btn--primario"> Registrar pago final</a>
            <% } %>
        </div>
    </div>

    <div class="detalle-pedido-grid">

        <!-- Columna principal -->
        <div class="detalle-pedido-main">

            <!-- Estado del pedido (es solo una línea de tiempo simple) -->
            <div class="card">
                <h2 class="card__titulo">Estado del Pedido</h2>
                <div class="estado-timeline">
                    <% String[] estados = {"Pendiente", "Aceptado", "En produccion", "Listo", "Entregado"};
                       String[] labels  = {"Pendiente", "Aceptado", "En Preparación", "Listo", "Entregado"};
                       int estadoActualIdx = 0;
                       for (int i = 0; i < estados.length; i++) {
                           if (estados[i].equals(estado)) estadoActualIdx = i;
                       }
                       for (int i = 0; i < estados.length; i++) {
                           String clase = i < estadoActualIdx ? "completo" : (i == estadoActualIdx ? "activo" : "");
                    %>
                        <div class="timeline-paso <%= clase %>">
                            <div class="timeline-circulo"><%= i < estadoActualIdx ? "✓" : (i + 1) %></div>
                            <span><%= labels[i] %></span>
                        </div>
                        <% if (i < estados.length - 1) { %>
                            <div class="timeline-linea <%= i < estadoActualIdx ? "completa" : "" %>"></div>
                        <% } %>
                    <% } %>
                </div>
                <% if ("Rechazado".equals(estado) || "Cancelado".equals(estado)) { %>
                    <div style="margin-top:1rem;">
                        <span class="badge badge--<%= estadoClase %>"><%= estado %></span>
                    </div>
                <% } %>
            </div>

            <!-- Resumen de productos -->
            <div class="card">
                <h2 class="card__titulo">Resumen de Productos</h2>
                <div class="pedido-producto-item">
                    <div class="img-placeholder pedido-producto-img"></div>
                    <div>
                        <p style="font-weight:600;">Pedido #<%= pedido.getIdPedido() %></p>
                        <% if (pedido.getDescripcionDiseno() != null && !pedido.getDescripcionDiseno().isEmpty()) { %>
                            <p style="font-size:13px; color:var(--on-surface-variant);">
                                <%= pedido.getDescripcionDiseno() %>
                            </p>
                        <% } %>
                    </div>
                    <strong style="margin-left:auto;">$<%= String.format("%.2f", pedido.getPrecioTotal()) %></strong>
                </div>
            </div>

            <!-- Registro de pagos -->
            <div class="card">
                <h2 class="card__titulo">Registro de Pagos</h2>
                <div class="pagos-grid">

                    <!-- Abono -->
                    <div class="pago-card">
                        <div class="pago-card__header">
                            <span style="font-size:12px; font-weight:600; color:var(--outline);">
                                ABONO (50%)
                            </span>
                            <% if (abono == null) { %>
                                <span class="badge badge--pendiente">Pendiente</span>
                            <% } else if (!abono.isConfirmado()) { %>
                                <span class="badge badge--aceptado">Enviado</span>
                            <% } else { %>
                                <span class="badge badge--entregado">Confirmado</span>
                            <% } %>
                        </div>

                        <% if (abono != null) { %>
                            <strong class="pago-card__monto">$<%= String.format("%.2f", abono.getMonto()) %></strong>
                            <p style="font-size:13px; color:var(--outline);">
                                <%= abono.getMetodoPago() %> — <%= abono.getFechaPago() %>
                            </p>
                        <% } else { %>
                            <strong class="pago-card__monto">
                                $<%= String.format("%.2f", pedido.getPrecioTotal() * 0.5) %>
                            </strong>
                            <p style="font-size:13px; color:var(--on-surface-variant);">
                                Requerido para iniciar la preparación del pedido.
                            </p>
                        <% } %>

                        <% if ("Aceptado".equals(estado) && abono == null) { %>
                            <a href="${pageContext.request.contextPath}/jsp/cliente/registrar-abono.jsp?id=<%= idPedido %>"
                               class="btn btn--outline" style="margin-top:0.75rem; width:100%;">
                                Reportar Abono
                            </a>
                        <% } %>
                    </div>

                    <!-- Pago final -->
                    <div class="pago-card <%= pagoFinal == null && !"Listo".equals(estado) ? "pago-card--inactivo" : "" %>">
                        <div class="pago-card__header">
                            <span style="font-size:12px; font-weight:600; color:var(--outline);">PAGO FINAL</span>
                            <% if (pagoFinal == null) { %>
                                <span class="badge badge--cancelado">Inactivo</span>
                            <% } else if (!pagoFinal.isConfirmado()) { %>
                                <span class="badge badge--aceptado">Enviado</span>
                            <% } else { %>
                                <span class="badge badge--entregado">Confirmado</span>
                            <% } %>
                        </div>

                        <strong class="pago-card__monto">
                            $<%= String.format("%.2f", pedido.getPrecioTotal()) %>
                        </strong>

                        <% if (pagoFinal == null) { %>
                            <p style="font-size:13px; color:var(--on-surface-variant);">
                                Se habilitará una vez el pedido esté marcado como 'Listo'.
                            </p>
                        <% } %>

                        <% if ("Listo".equals(estado) && pagoFinal == null) { %>
                            <a href="${pageContext.request.contextPath}/jsp/cliente/registrar-pago-final.jsp?id=<%= idPedido %>"
                               class="btn btn--primario" style="margin-top:0.75rem; width:100%;">
                                Registrar pago final
                            </a>
                        <% } %>
                    </div>

                </div>
            </div>

        </div>

        <!-- Columna lateral -->
        <div class="detalle-pedido-lateral">

            <!-- Info de entrega -->
            <div class="card">
                <h2 class="card__titulo">Entrega</h2>
                <div class="entrega-fila">
                    <span> (Agregar img calendario)</span>
                    <div>
                        <strong>Fecha de Entrega</strong>
                        <p><%= pedido.getFechaEntrega() %></p>
                    </div>
                </div>
                <div class="entrega-fila">
                    <span>(Persona it)</span>
                    <div>
                        <strong>Contacto</strong>
                        <p><%= cliente.getNombre() %></p>
                        <p><%= cliente.getTelefono() %></p>
                    </div>
                </div>
            </div>

            <!-- Resumen total -->
            <div class="card">
                <h2 class="card__titulo">Resumen Total</h2>
                <div class="total-fila">
                    <span>Subtotal</span>
                    <span>$<%= String.format("%.2f", pedido.getPrecioTotal()) %></span>
                </div>
                <div class="total-fila">
                    <span>Costo de Envío</span>
                    <span>$0.00</span>
                </div>
                <div class="total-fila total-fila--total">
                    <strong>Total</strong>
                    <strong class="precio">$<%= String.format("%.2f", pedido.getPrecioTotal()) %></strong>
                </div>
            </div>

            <!-- Cancelar pedido solo si está Pendiente -->
            <% if ("Pendiente".equals(estado)) { %>
                <div class="card" style="text-align:center;">
                    <p style="font-size:13px; color:var(--on-surface-variant); margin-bottom:0.75rem;">
                        ¿Necesitas ayuda con tu pedido?
                    </p>
                    <a href="${pageContext.request.contextPath}/cancelar-pedido?id=<%= idPedido %>"
                       class="enlace-detalle"
                       onclick="return confirm('¿Seguro que deseas cancelar este pedido?')">
                        Cancelar Pedido
                    </a>
                </div>
            <% } %>

        </div>
    </div>

</main>

<%@ include file="/jsp/layouts/footer.jsp" %>

</body>
</html>
