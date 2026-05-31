<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reporte Unidades</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<div class="container py-4">
    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="display-5 fw-semibold text-primary">
            <i class="bi bi-bar-chart-steps me-2"></i>Pisos y Locales por Edificio
        </h1>
        <button onclick="window.print()" class="btn btn-outline-secondary">
            <i class="bi bi-printer me-2"></i>Imprimir Reporte
        </button>
    </div>

    <!-- Tabla de unidades -->
    <div class="card shadow-sm border-0 mb-4">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-striped mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th><i class="bi bi-building"></i> EDIFICIO</th>
                            <th><i class="bi bi-tag"></i> TIPO</th>
                            <th><i class="bi bi-diagram-2"></i> PLANTA</th>
                            <th><i class="bi bi-type"></i> LETRA</th>
                            <th><i class="bi bi-card-text"></i> DESCRIPCIÓN</th>
                            <th><i class="bi bi-toggle-on"></i> ESTADO</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Object[]> lista = (List<Object[]>) request.getAttribute("listaReporte");
                            if (lista != null && !lista.isEmpty()) {
                                for(Object[] r : lista){
                                    String estado = r[5].toString();
                                    String estadoBadge = "";
                                    if(estado.equals("DISPONIBLE")){
                                        estadoBadge = "bg-success";
                                    } else if(estado.equals("ALQUILADO")){
                                        estadoBadge = "bg-warning text-dark";
                                    } else {
                                        estadoBadge = "bg-danger";
                                    }
                        %>
                        <tr>
                            <td><strong><i class="bi bi-building me-1"></i><%= r[0] %></strong></td>
                            <td><span class="badge bg-info"><%= r[1] %></span></td>
                            <td><%= r[2] %></td>
                            <td><strong><%= r[3] %></strong></td>
                            <td><%= r[4] %></td>
                            <td>
                                <span class="badge <%= estadoBadge %> px-3 py-2">
                                    <i class="bi bi-<%= estado.equals("DISPONIBLE") ? "check-circle" : (estado.equals("ALQUILADO") ? "house-door" : "x-circle") %> me-1"></i>
                                    <%= estado %>
                                </span>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="6" class="text-center text-muted py-4">
                                <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                No hay unidades registradas
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Sección de reporte financiero -->
    <div class="card shadow-sm border-0">
        <div class="card-header bg-success text-white">
            <h3 class="h5 mb-0">
                <i class="bi bi-cash-stack me-2"></i>Reporte Financiero
            </h3>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-4">
                    <div class="card bg-primary text-white shadow-sm">
                        <div class="card-body">
                            <h6 class="card-title">
                                <i class="bi bi-arrow-up-circle me-1"></i> Total Ingresos
                            </h6>
                            <h3 class="mb-0">$ ${ingresos}</h3>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card bg-danger text-white shadow-sm">
                        <div class="card-body">
                            <h6 class="card-title">
                                <i class="bi bi-arrow-down-circle me-1"></i> Total Gastos
                            </h6>
                            <h3 class="mb-0">$ ${gastos}</h3>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card ${balance >= 0 ? 'bg-info' : 'bg-warning'} text-white shadow-sm">
                        <div class="card-body">
                            <h6 class="card-title">
                                <i class="bi bi-pie-chart me-1"></i> Balance
                            </h6>
                            <h3 class="mb-0">$ ${balance}</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Botón volver -->
    <div class="mt-4">
        <a href="${pageContext.request.contextPath}/unidad_inmueble?accion=listar" class="btn btn-outline-secondary">
            <i class="bi bi-arrow-left me-2"></i>Volver a Unidades
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>