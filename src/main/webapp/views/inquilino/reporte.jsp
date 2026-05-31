<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.entity.Inquilino"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reporte Inquilinos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<div class="container py-4">
    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="display-5 fw-semibold text-primary">
            <i class="bi bi-file-spreadsheet me-2"></i>Reporte de Inquilinos
        </h1>
        <button onclick="window.print()" class="btn btn-outline-secondary">
            <i class="bi bi-printer me-2"></i>Imprimir Reporte
        </button>
    </div>

    <!-- Formulario de búsqueda -->
    <div class="card shadow-sm border-0 mb-4">
        <div class="card-body">
            <h5 class="card-title mb-3">
                <i class="bi bi-funnel me-2"></i>Filtrar por fecha
            </h5>
            <form method="get" action="${pageContext.request.contextPath}/inquilino" class="row g-3">
                <input type="hidden" name="accion" value="reporte">
                
                <div class="col-md-5">
                    <label class="form-label fw-semibold">
                        <i class="bi bi-calendar-start"></i> Desde
                    </label>
                    <input type="date" name="desde" class="form-control" required>
                </div>
                
                <div class="col-md-5">
                    <label class="form-label fw-semibold">
                        <i class="bi bi-calendar-end"></i> Hasta
                    </label>
                    <input type="date" name="hasta" class="form-control" required>
                </div>
                
                <div class="col-md-2 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary w-100">
                        <i class="bi bi-search me-2"></i>Buscar
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Tabla de resultados -->
    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-striped mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th><i class="bi bi-hash"></i> ID</th>
                            <th><i class="bi bi-person"></i> NOMBRE COMPLETO</th>
                            <th><i class="bi bi-card-text"></i> DNI</th>
                            <th><i class="bi bi-calendar3"></i> FECHA REGISTRO</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Inquilino> lista = (List<Inquilino>) request.getAttribute("listaReporte");
                            if (lista != null && !lista.isEmpty()) {
                                for(Inquilino i : lista){
                        %>
                        <tr>
                            <td class="fw-bold"><%= i.getId() %></td>
                            <td>
                                <i class="bi bi-person-circle me-2 text-primary"></i>
                                <%= i.getNombre() %> <%= i.getApellido() %>
                            </td>
                            <td><code><%= i.getDni() %></code></td>
                            <td>
                                <i class="bi bi-calendar-date me-1"></i>
                                <%= i.getFechaRegistro() %>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="4" class="text-center text-muted py-4">
                                <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                No hay inquilinos registrados en el rango de fechas seleccionado
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <!-- Resumen y botón volver -->
    <div class="row mt-4">
        <div class="col-md-6">
            <div class="card bg-info text-white shadow-sm">
                <div class="card-body">
                    <h6 class="card-title">Total de registros</h6>
                    <h3 class="mb-0">
                        <%= (lista != null) ? lista.size() : 0 %>
                    </h3>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card bg-primary text-white shadow-sm">
                <div class="card-body">
                    <h6 class="card-title">Acción rápida</h6>
                    <a href="${pageContext.request.contextPath}/inquilino?accion=listar" 
                       class="btn btn-light w-100">
                        <i class="bi bi-arrow-left me-2"></i>Volver al Listado
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>