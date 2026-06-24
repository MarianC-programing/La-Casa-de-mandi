<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.lacasademandi.modelo.Cliente" %>
<%@ page import="com.lacasademandi.modelo.Pedido" %>
<%@ page import="com.lacasademandi.dao.PedidoDAO" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mis Pedidos — La Casa de Mandi</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cliente.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mis-pedidos.css">
</head>
<body>

<%
    // Si no hay sesión, redirigir al login
    Cliente cliente = (Cliente) session.getAttribute("cliente");
    if (cliente == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    // Cargar pedidos del cliente desde la base de datos
    PedidoDAO pedidoDAO = new PedidoDAO();
    List<Pedido> pedidos = pedidoDAO.listarPorCliente(cliente.getIdCliente());

    String paginaActiva = "pedidos";
%>

<%@ include file="/jsp/layouts/header.jsp" %>

<main class="cliente-wrapper">

    <h1 class="cliente-titulo">Mis Pedidos</h1>
    <p class="cliente-subtitulo">Gestiona y revisa el historial de tus dulces momentos.</p>

    <!-- Filtros -->
    <div class="pedidos-filtros">
        <div class="pedidos-busqueda">
            <span>(agregar img busquda)</span>
            <input type="text" id="busqueda" placeholder="Buscar por número o producto..."
                   oninput="filtrarPedidos()">
        </div>
        <div class="pedidos-tabs">
            <button class="tab activo" onclick="filtrarEstado('todos', this)">Todos</button>
            <button class="tab" onclick="filtrarEstado('proceso', this)">En Proceso</button>
            <button class="tab" onclick="filtrarEstado('completados', this)">Completados</button>
        </div>
    </div>

    <!-- Lista de pedidos -->
    <div class="pedidos-lista" id="lista-pedidos">

        <% if (pedidos == null || pedidos.isEmpty()) { %>
            <div class="pedidos-vacio">
                <p>Aún no tienes pedidos. <a href="${pageContext.request.contextPath}/jsp/public/catalogo.jsp">Ver catálogo</a></p>
            </div>
        <% } else {
            for (Pedido p : pedidos) {
                // Determinar la clase CSS del badge según el estado
                String estadoClase = "pendiente";
                String estadoLabel = p.getEstado();
                if ("Aceptado".equals(p.getEstado())) estadoClase = "aceptado";
                else if ("En produccion".equals(p.getEstado())) estadoClase = "produccion";
                else if ("Listo".equals(p.getEstado())) estadoClase = "listo";
                else if ("Entregado".equals(p.getEstado())) estadoClase = "entregado";
                else if ("Rechazado".equals(p.getEstado())) estadoClase = "rechazado";
                else if ("Cancelado".equals(p.getEstado())) estadoClase = "cancelado";
        %>
            <div class="pedido-fila" data-estado="<%= estadoClase %>">
                <!-- Imagen placeholder del producto -->
                <div class="pedido-fila__img img-placeholder"></div>

                <div class="pedido-fila__info">
                    <div style="display:flex; align-items:center; gap:0.75rem; flex-wrap:wrap;">
                        <span style="font-size:13px; color:var(--outline);">#PED-<%= p.getIdPedido() %></span>
                        <span class="badge badge--<%= estadoClase %>"><%= estadoLabel %></span>
                    </div>
                    <h3 class="pedido-fila__nombre">Pedido #<%= p.getIdPedido() %></h3>
                    <p class="pedido-fila__fecha">Realizado el <%= p.getFechaPedido() %></p>
                </div>

                <div class="pedido-fila__total">
                    <span style="font-size:12px; color:var(--outline);">Total</span>
                    <strong>$<%= String.format("%.2f", p.getPrecioTotal()) %></strong>
                </div>

                <a href="${pageContext.request.contextPath}/jsp/cliente/detalle-pedido.jsp?id=<%= p.getIdPedido() %>"
                   class="btn btn--primario">
                    Ver detalle →
                </a>
            </div>
        <%
            }
        } %>

    </div>

</main>

<%@ include file="/jsp/layouts/footer.jsp" %>

<script>
    // Filtra por estado al hacer clic en los tabs
    function filtrarEstado(estado, boton) {
        document.querySelectorAll('.tab').forEach(function(t) { t.classList.remove('activo'); });
        boton.classList.add('activo');

        document.querySelectorAll('.pedido-fila').forEach(function(fila) {
            if (estado === 'todos') {
                fila.style.display = '';
            } else if (estado === 'proceso') {
                // En proceso = pendiente, aceptado, produccion, listo
                var s = fila.dataset.estado;
                fila.style.display = (s === 'pendiente' || s === 'aceptado' || s === 'produccion' || s === 'listo') ? '' : 'none';
            } else if (estado === 'completados') {
                var s = fila.dataset.estado;
                fila.style.display = (s === 'entregado' || s === 'cancelado' || s === 'rechazado') ? '' : 'none';
            }
        });
    }

    // Filtra por texto del buscador
    function filtrarPedidos() {
        var texto = document.getElementById('busqueda').value.toLowerCase();
        document.querySelectorAll('.pedido-fila').forEach(function(fila) {
            fila.style.display = fila.innerText.toLowerCase().includes(texto) ? '' : 'none';
        });
    }
</script>

</body>
</html>
