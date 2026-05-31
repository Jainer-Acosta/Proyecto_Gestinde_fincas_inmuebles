<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ganancias por Edificio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <style>
        .building-card {
            transition: transform 0.2s;
            cursor: pointer;
        }
        .building-card:hover {
            transform: translateY(-5px);
        }
        .total-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .detalle-row {
            cursor: pointer;
        }
        .detalle-row:hover {
            background-color: #f8f9fa;
        }
    </style>
</head>
<body class="bg-light">

<div class="container py-4">
    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="display-5 fw-semibold text-primary">
            <i class="bi bi-building me-2"></i>Ganancias por Edificio
        </h1>
        <div>
            <button onclick="window.print()" class="btn btn-outline-secondary">
                <i class="bi bi-printer me-2"></i>Imprimir
            </button>
            <a href="${pageContext.request.contextPath}/recibo?accion=listar" class="btn btn-outline-primary ms-2">
                <i class="bi bi-arrow-left me-2"></i>Volver
            </a>
        </div>
    </div>

    <!-- Tarjeta de resumen general -->
    <div class="row mb-4">
        <div class="col-md-4">
            <div class="card total-card text-white shadow-sm">
                <div class="card-body">
                    <h6 class="card-title">Total Ganancias</h6>
                    <h2 class="mb-0">
                        $ 
                        <%
                            List<Object[]> resumen = (List<Object[]>) request.getAttribute("resumenEdificios");
                            double totalGeneral = 0;
                            if (resumen != null) {
                                for (Object[] r : resumen) {
                                    totalGeneral += (double) r[2];
                                }
                            }
                            out.print(String.format("%,.2f", totalGeneral));
                        %>
                    </h2>
                    <small>Ingresos por recibos pagados</small>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-info text-white shadow-sm">
                <div class="card-body">
                    <h6 class="card-title">Edificios</h6>
                    <h2 class="mb-0"><%= (resumen != null) ? resumen.size() : 0 %></h2>
                    <small>Edificios registrados</small>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-success text-white shadow-sm">
                <div class="card-body">
                    <h6 class="card-title">Unidades con Ingresos</h6>
                    <h2 class="mb-0">
                        <%
                            int unidadesConIngresos = 0;
                            if (resumen != null) {
                                for (Object[] r : resumen) {
                                    unidadesConIngresos += (int) r[4];
                                }
                            }
                            out.print(unidadesConIngresos);
                        %>
                    </h2>
                    <small>Unidades que han generado ingresos</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Resumen por edificio (Cards) -->
    <div class="row mb-4" id="edificiosResumen">
        <%
            if (resumen != null && !resumen.isEmpty()) {
                for (Object[] r : resumen) {
                    int edificioId = (int) r[0];
                    String edificioNombre = (String) r[1];
                    double totalEdificio = (double) r[2];
                    int unidadesTotales = (int) r[3];
                    int unidadesConIngresosEdif = (int) r[4];
                    double porcentajeOcupacion = unidadesTotales > 0 ? (unidadesConIngresosEdif * 100.0 / unidadesTotales) : 0;
        %>
        <div class="col-md-4 mb-3">
            <div class="card building-card shadow-sm h-100" onclick="toggleEdificio(<%= edificioId %>)">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="bi bi-building me-2"></i><%= edificioNombre %></h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-6">
                            <small class="text-muted">Total Recaudado</small>
                            <h4 class="text-success">$ <%= String.format("%,.2f", totalEdificio) %></h4>
                        </div>
                        <div class="col-6">
                            <small class="text-muted">Ocupación</small>
                            <h4><%= String.format("%.0f", porcentajeOcupacion) %>%</h4>
                        </div>
                    </div>
                    <div class="progress mt-2" style="height: 8px;">
                        <div class="progress-bar bg-success" style="width: <%= porcentajeOcupacion %>%"></div>
                    </div>
                    <small class="text-muted mt-2 d-block">
                        <i class="bi bi-grid"></i> <%= unidadesConIngresosEdif %>/<%= unidadesTotales %> unidades con ingresos
                    </small>
                </div>
            </div>
        </div>
        <%
                }
            } else {
        %>
        <div class="col-12">
            <div class="alert alert-info">No hay datos de ganancias disponibles</div>
        </div>
        <% } %>
    </div>

    <!-- Detalle por unidad -->
    <div class="card shadow-sm border-0">
        <div class="card-header bg-dark text-white">
            <h5 class="mb-0"><i class="bi bi-list-ul me-2"></i>Detalle de Unidades</h5>
            <small class="text-muted">Haz clic en una tarjeta de edificio para filtrar sus unidades</small>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-striped mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>Edificio</th>
                            <th>Tipo</th>
                            <th>Ubicación</th>
                            <th>Total Recaudado</th>
                            <th>Recibos Pagados</th>
                            <th>Último Pago</th>
                        </tr>
                    </thead>
                    <tbody id="detalleTableBody">
                        <%
                            List<Object[]> detalle = (List<Object[]>) request.getAttribute("gananciasDetalle");
                            if (detalle != null && !detalle.isEmpty()) {
                                for (Object[] d : detalle) {
                                    int edificioId = (int) d[0];
                                    String edificioNombre = (String) d[1];
                                    String tipo = (String) d[3];
                                    String planta = (String) d[4];
                                    String letra = (String) d[5];
                                    double totalGanado = (double) d[6];
                                    int recibosPagados = (int) d[7];
                                    Object ultimoPago = d[8];
                                    
                                    String tipoIcon = "";
                                    if (tipo.equals("PISO")) tipoIcon = "door-closed";
                                    else if (tipo.equals("LOCAL")) tipoIcon = "shop";
                                    else tipoIcon = "briefcase";
                        %>
                        <tr data-edificio="<%= edificioId %>" class="detalle-row">
                            <td><strong><%= edificioNombre %></strong></td>
                            <td>
                                <span class="badge bg-info">
                                    <i class="bi bi-<%= tipoIcon %> me-1"></i>
                                    <%= tipo %>
                                </span>
                            </td>
                            <td>Planta <%= planta %>, Letra <%= letra %></td>
                            <td class="text-success fw-bold">$ <%= String.format("%,.2f", totalGanado) %></td>
                            <td class="text-center"><span class="badge bg-secondary"><%= recibosPagados %></span></td>
                            <td><%= (ultimoPago != null) ? ultimoPago.toString() : "Sin pagos" %></td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="6" class="text-center text-muted py-4">
                                <i class="bi bi-inbox fs-1 d-block mb-2"></i> No hay datos disponibles
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    

</div>

<script>
    var edificioSeleccionado = null;
    
    function toggleEdificio(edificioId) {
        var rows = document.querySelectorAll('.detalle-row');
        
        if (edificioSeleccionado === edificioId) {
            // Si ya está seleccionado, mostrar todos
            for (var i = 0; i < rows.length; i++) {
                rows[i].style.display = 'table-row';
            }
            edificioSeleccionado = null;
        } else {
            // Mostrar solo las filas del edificio seleccionado
            for (var i = 0; i < rows.length; i++) {
                if (parseInt(rows[i].getAttribute('data-edificio')) === edificioId) {
                    rows[i].style.display = 'table-row';
                } else {
                    rows[i].style.display = 'none';
                }
            }
            edificioSeleccionado = edificioId;
        }
    }
    
    function mostrarTodasUnidades() {
        var rows = document.querySelectorAll('.detalle-row');
        for (var i = 0; i < rows.length; i++) {
            rows[i].style.display = 'table-row';
        }
        edificioSeleccionado = null;
    }
    
    // Inicializar: mostrar todas las filas al cargar
    document.addEventListener('DOMContentLoaded', function() {
        var rows = document.querySelectorAll('.detalle-row');
        for (var i = 0; i < rows.length; i++) {
            rows[i].style.display = 'table-row';
        }
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>