<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista Unidades</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<div class="container py-4">
    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="display-5 fw-semibold text-primary">
            <i class="bi bi-grid-3x3-gap-fill me-2"></i>Pisos y Locales
        </h1>
        <a class="btn btn-success btn-lg" href="${pageContext.request.contextPath}/unidad_inmueble?accion=nuevo">
            <i class="bi bi-plus-circle me-2"></i>Nueva Unidad
        </a>
    </div>

    <!-- Tarjeta tabla -->
    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-striped mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th><i class="bi bi-hash"></i> ID</th>
                            <th><i class="bi bi-building"></i> EDIFICIO</th>
                            <th><i class="bi bi-tag"></i> TIPO</th>
                            <th><i class="bi bi-diagram-2"></i> PLANTA</th>
                            <th><i class="bi bi-type"></i> LETRA</th>
                            <th><i class="bi bi-card-text"></i> DESCRIPCIÓN</th>
                            <th><i class="bi bi-toggle-on"></i> ESTADO</th>
                            <th><i class="bi bi-tools"></i> ACCIONES</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Object[]> lista = (List<Object[]>) request.getAttribute("listaUnidades");
                            if (lista != null && !lista.isEmpty()) {
                                for (Object[] fila : lista) {
                                    String estado = (fila[6] != null) ? fila[6].toString() : "SIN ESTADO";
                                    
                                    String estadoBadge = "";
                                    String estadoIcon = "";
                                    if(estado.equals("DISPONIBLE")){
                                        estadoBadge = "bg-success";
                                        estadoIcon = "check-circle";
                                    } else if(estado.equals("ALQUILADO")){
                                        estadoBadge = "bg-warning text-dark";
                                        estadoIcon = "house-door";
                                    } else if(estado.equals("NO_DISPONIBLE")){
                                        estadoBadge = "bg-danger";
                                        estadoIcon = "x-circle";
                                    } else {
                                        estadoBadge = "bg-secondary";
                                        estadoIcon = "question-circle";
                                    }
                                    
                                    String descripcion = (fila[5] != null) ? fila[5].toString() : "Sin descripción";
                        %>
                        <tr>
                            <td class="fw-bold">#<%= fila[0]%></td>
                            <td><i class="bi bi-building me-1"></i><%= fila[1]%></td>
                            <td>
                                <span class="badge bg-info">
                                    <i class="bi bi-<%= fila[2].toString().equals("PISO") ? "door-closed" : (fila[2].toString().equals("LOCAL") ? "shop" : "briefcase") %> me-1"></i>
                                    <%= fila[2]%>
                                </span>
                            </td>
                            <td><%= fila[3]%></td>
                            <td><strong><%= fila[4]%></strong></td>
                            <td><small class="text-muted"><%= descripcion %></small></td>
                            <td>
                                <span class="badge <%= estadoBadge %> px-3 py-2">
                                    <i class="bi bi-<%= estadoIcon %> me-1"></i>
                                    <%= estado %>
                                </span>
                            </td>
                            <td>
                                <div class="btn-group" role="group">
                                    <a href="${pageContext.request.contextPath}/unidad_inmueble?accion=editar&id=<%= fila[0]%>" 
                                       class="btn btn-warning btn-sm">
                                        <i class="bi bi-pencil"></i> Editar
                                    </a>
                                    <a href="${pageContext.request.contextPath}/unidad_inmueble?accion=desactivar&id=<%= fila[0]%>" 
                                       class="btn btn-danger btn-sm"
                                       onclick="return confirm('¿Está seguro de desactivar esta unidad?')">
                                        <i class="bi bi-trash"></i> Desactivar
                                    </a>
                                </div>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="8" class="text-center text-muted py-4">
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
    
    <!-- Estadísticas -->
    <div class="row mt-4">
        <div class="col-md-4">
            <div class="card bg-primary text-white shadow-sm">
                <div class="card-body">
                    <h6 class="card-title">Total Unidades</h6>
                    <h3 class="mb-0">
                        <%= (lista != null) ? lista.size() : 0 %>
                    </h3>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-success text-white shadow-sm">
                <div class="card-body">
                    <h6 class="card-title">Disponibles</h6>
                    <h3 class="mb-0">
                        <%
                            int disponibles = 0;
                            if (lista != null) {
                                for (Object[] fila : lista) {
                                    String estadoFila = (fila[6] != null) ? fila[6].toString() : "";
                                    if(estadoFila.equals("DISPONIBLE")) disponibles++;
                                }
                            }
                            out.print(disponibles);
                        %>
                    </h3>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-warning text-dark shadow-sm">
                <div class="card-body">
                    <h6 class="card-title">Alquiladas</h6>
                    <h3 class="mb-0">
                        <%
                            int alquiladas = 0;
                            if (lista != null) {
                                for (Object[] fila : lista) {
                                    String estadoFila = (fila[6] != null) ? fila[6].toString() : "";
                                    if(estadoFila.equals("ALQUILADO")) alquiladas++;
                                }
                            }
                            out.print(alquiladas);
                        %>
                    </h3>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Botón volver -->
    <div class="mt-4">
        <a href="${pageContext.request.contextPath}/views/dashboard/dashboard.jsp" class="btn btn-outline-secondary">
            <i class="bi bi-arrow-left me-2"></i>Volver al Dashboard
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>