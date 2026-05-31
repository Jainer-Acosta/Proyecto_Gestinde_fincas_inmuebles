<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista Recibos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<div class="container py-4">
    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="display-5 fw-semibold text-primary">
            <i class="bi bi-receipt me-2"></i>Recibos
        </h1>
        <div>
            <a class="btn btn-success btn-lg" href="${pageContext.request.contextPath}/recibo?accion=nuevo">
                <i class="bi bi-plus-circle me-2"></i>Nuevo Recibo
            </a>
            <button type="button" class="btn btn-info btn-lg ms-2" data-bs-toggle="modal" data-bs-target="#modalClonar">
                <i class="bi bi-copy me-2"></i>Clonar Recibos
            </button>
        </div>
    </div>

    <!-- Mensajes -->
    <% if (request.getAttribute("mensaje") != null) { %>
        <div class="alert alert-success alert-dismissible fade show">
            <i class="bi bi-check-circle me-2"></i> <%= request.getAttribute("mensaje") %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>
    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger alert-dismissible fade show">
            <i class="bi bi-exclamation-triangle me-2"></i> <%= request.getAttribute("error") %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <!-- Modal Clonar -->
    <div class="modal fade" id="modalClonar" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-info text-white">
                    <h5 class="modal-title"><i class="bi bi-copy me-2"></i>Clonar Recibos</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/recibo" method="get">
                    <input type="hidden" name="accion" value="clonar">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="alert alert-info">
                                    <i class="bi bi-arrow-right-circle me-2"></i>
                                    <strong>CLONAR DESDE</strong>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Mes Origen</label>
                                    <select name="mes" class="form-select" required>
                                        <option value="1">Enero</option><option value="2">Febrero</option>
                                        <option value="3">Marzo</option><option value="4">Abril</option>
                                        <option value="5">Mayo</option><option value="6">Junio</option>
                                        <option value="7">Julio</option><option value="8">Agosto</option>
                                        <option value="9">Septiembre</option><option value="10">Octubre</option>
                                        <option value="11">Noviembre</option><option value="12">Diciembre</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Año Origen</label>
                                    <input type="number" name="anio" class="form-control" value="2026" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="alert alert-success">
                                    <i class="bi bi-arrow-left-circle me-2"></i>
                                    <strong>CLONAR HACIA</strong>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Mes Destino</label>
                                    <select name="mesDestino" class="form-select" required>
                                        <option value="1">Enero</option><option value="2">Febrero</option>
                                        <option value="3">Marzo</option><option value="4">Abril</option>
                                        <option value="5">Mayo</option><option value="6">Junio</option>
                                        <option value="7">Julio</option><option value="8">Agosto</option>
                                        <option value="9">Septiembre</option><option value="10">Octubre</option>
                                        <option value="11">Noviembre</option><option value="12">Diciembre</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Año Destino</label>
                                    <input type="number" name="anioDestino" class="form-control" value="2026" required>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-info">Clonar Recibos</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Filtro con botón Eliminar -->
    <div class="card shadow-sm border-0 mb-4">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="card-title mb-0">
                    <i class="bi bi-funnel me-2"></i>Filtrar Recibos
                </h5>
                <!-- Botón Eliminar Filtro (solo visible si hay filtros activos) -->
                <% 
                    String estadoFiltro = request.getParameter("estado");
                    String inicioFiltro = request.getParameter("inicio");
                    String finFiltro = request.getParameter("fin");
                    boolean hayFiltro = (estadoFiltro != null || inicioFiltro != null || finFiltro != null);
                %>
                <% if (hayFiltro) { %>
                    <a href="${pageContext.request.contextPath}/recibo?accion=listar" class="btn btn-sm btn-outline-danger">
                        <i class="bi bi-x-circle me-1"></i> Eliminar Filtro
                    </a>
                <% } %>
            </div>
            <form method="get" action="${pageContext.request.contextPath}/recibo" class="row g-3">
                <input type="hidden" name="accion" value="filtrar">
                
                <div class="col-md-3">
                    <label class="form-label fw-semibold">Estado</label>
                    <select name="estado" class="form-select">
                        <option value="">-- Todos --</option>
                        <option value="PAGADO" <%= "PAGADO".equals(estadoFiltro) ? "selected" : "" %>>✅ PAGADO</option>
                        <option value="PENDIENTE" <%= "PENDIENTE".equals(estadoFiltro) ? "selected" : "" %>>⏳ PENDIENTE</option>
                    </select>
                </div>
                
                <div class="col-md-3">
                    <label class="form-label fw-semibold">Fecha Inicio</label>
                    <input type="date" name="inicio" class="form-control" value="<%= inicioFiltro != null ? inicioFiltro : "" %>">
                </div>
                
                <div class="col-md-3">
                    <label class="form-label fw-semibold">Fecha Fin</label>
                    <input type="date" name="fin" class="form-control" value="<%= finFiltro != null ? finFiltro : "" %>">
                </div>
                
                <div class="col-md-3 d-flex align-items-end gap-2">
                    <button type="submit" class="btn btn-primary w-100">
                        <i class="bi bi-search me-2"></i>Filtrar
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Mostrar badge de filtro activo -->
    <% if (hayFiltro) { %>
        <div class="alert alert-info alert-dismissible fade show py-2">
            <i class="bi bi-info-circle me-2"></i>
            Filtro activo:
            <% if (estadoFiltro != null && !estadoFiltro.isEmpty()) { %>
                <span class="badge bg-secondary">Estado: <%= estadoFiltro %></span>
            <% } %>
            <% if (inicioFiltro != null && !inicioFiltro.isEmpty()) { %>
                <span class="badge bg-secondary">Desde: <%= inicioFiltro %></span>
            <% } %>
            <% if (finFiltro != null && !finFiltro.isEmpty()) { %>
                <span class="badge bg-secondary">Hasta: <%= finFiltro %></span>
            <% } %>
            <a href="${pageContext.request.contextPath}/recibo?accion=listar" class="float-end text-danger">
                <i class="bi bi-x-circle"></i> Limpiar
            </a>
        </div>
    <% } %>

    <!-- Tabla -->
    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-striped mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th><i class="bi bi-hash"></i> N° RECIBO</th>
                            <th><i class="bi bi-person"></i> INQUILINO</th>
                            <th><i class="bi bi-building"></i> EDIFICIO</th>
                            <th><i class="bi bi-tag"></i> TIPO</th>
                            <th><i class="bi bi-diagram-2"></i> PLANTA</th>
                            <th><i class="bi bi-type"></i> LETRA</th>
                            <th><i class="bi bi-calendar3"></i> FECHA</th>
                            <th><i class="bi bi-calculator"></i> TOTAL</th>
                            <th><i class="bi bi-toggle-on"></i> ESTADO</th>
                            <th><i class="bi bi-tools"></i> ACCIONES</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Object[]> lista = (List<Object[]>) request.getAttribute("listaRecibos");
                            if (lista != null && !lista.isEmpty()) {
                                for (Object[] r : lista) {
                                    int length = r.length;
                                    
                                    String numeroRecibo = "";
                                    String nombreCompleto = "";
                                    String edificio = "";
                                    String tipo = "";
                                    String planta = "";
                                    String letra = "";
                                    String fecha = "";
                                    double total = 0;
                                    String estado = "";
                                    
                                    if (length == 10) {
                                        numeroRecibo = (r[0] != null) ? r[0].toString() : "N/A";
                                        nombreCompleto = (r[1] != null ? r[1].toString() : "") + " " + (r[2] != null ? r[2].toString() : "");
                                        edificio = (r[3] != null) ? r[3].toString() : "";
                                        tipo = (r[4] != null) ? r[4].toString() : "";
                                        planta = (r[5] != null) ? r[5].toString() : "";
                                        letra = (r[6] != null) ? r[6].toString() : "";
                                        fecha = (r[7] != null) ? r[7].toString() : "";
                                        total = Double.parseDouble(r[8].toString());
                                        estado = r[9].toString();
                                    } else if (length == 8) {
                                        numeroRecibo = (r[0] != null) ? r[0].toString() : "N/A";
                                        nombreCompleto = (r[1] != null ? r[1].toString() : "") + " " + (r[2] != null ? r[2].toString() : "");
                                        edificio = (r[3] != null) ? r[3].toString() : "";
                                        tipo = (r[4] != null) ? r[4].toString() : "";
                                        planta = "—";
                                        letra = "—";
                                        fecha = (r[5] != null) ? r[5].toString() : "";
                                        total = Double.parseDouble(r[6].toString());
                                        estado = r[7].toString();
                                    }
                                    
                                    String estadoBadge = estado.equals("PAGADO") ? "bg-success" : "bg-warning text-dark";
                                    String estadoIcon = estado.equals("PAGADO") ? "check-circle" : "clock";
                        %>
                        <tr>
                            <td class="fw-bold font-monospace"><%= numeroRecibo %></td>
                            <td><i class="bi bi-person-circle me-1"></i><%= nombreCompleto %></td>
                            <td><i class="bi bi-building me-1"></i><%= edificio %></td>
                            <td><span class="badge bg-info"><%= tipo %></span></td>
                            <td><%= planta %></td>
                            <td><strong><%= letra %></strong></td>
                            <td><i class="bi bi-calendar-date me-1"></i><%= fecha %></td>
                            <td class="fw-semibold text-success">$ <%= String.format("%,.2f", total) %></td>
                            <td>
                                <span class="badge <%= estadoBadge %> px-3 py-2">
                                    <i class="bi bi-<%= estadoIcon %> me-1"></i> <%= estado %>
                                </span>
                            </td>
                            <td>
                                <div class="btn-group" role="group">
                                    <a class="btn btn-info btn-sm" href="${pageContext.request.contextPath}/recibo?accion=ver&numeroRecibo=<%= numeroRecibo %>">
                                        <i class="bi bi-eye"></i> Ver
                                    </a>
                                    <a class="btn btn-warning btn-sm" href="${pageContext.request.contextPath}/recibo?accion=editar&numeroRecibo=<%= numeroRecibo %>">
                                        <i class="bi bi-pencil"></i> Editar
                                    </a>
                                    <% if (estado.equals("PENDIENTE")) { %>
                                        <a class="btn btn-success btn-sm" href="${pageContext.request.contextPath}/recibo?accion=pagar&numeroRecibo=<%= numeroRecibo %>" onclick="return confirm('¿Confirmar pago de este recibo?')">
                                            <i class="bi bi-cash"></i> Pagar
                                        </a>
                                    <% } %>
                                </div>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="10" class="text-center text-muted py-4">
                                <i class="bi bi-inbox fs-1 d-block mb-2"></i> No hay recibos registrados
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <div class="mt-4">
        <a href="${pageContext.request.contextPath}/views/dashboard/dashboard.jsp" class="btn btn-outline-secondary">
            <i class="bi bi-arrow-left me-2"></i>Volver al Dashboard
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>