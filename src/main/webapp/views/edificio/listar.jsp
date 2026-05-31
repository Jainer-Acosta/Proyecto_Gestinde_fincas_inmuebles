<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.entity.Edificio"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edificios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body class="bg-light">

    <div class="container py-4">
        <!-- Header con título y botón -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1 class="display-5 fw-semibold text-primary">
                <i class="bi bi-buildings me-2"></i>Edificios
            </h1>
            <a class="btn btn-success btn-lg" 
               href="${pageContext.request.contextPath}/edificio?accion=nuevo">
                <i class="bi bi-plus-circle me-2"></i>Nuevo Edificio
            </a>
        </div>

        <!-- Tarjeta para la tabla -->
        <div class="card shadow-sm border-0">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover table-striped mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th><i class="bi bi-hash"></i> ID</th>
                                <th><i class="bi bi-building"></i> NOMBRE</th>
                                <th><i class="bi bi-geo-alt"></i> DIRECCIÓN</th>
                                <th><i class="bi bi-city"></i> CIUDAD</th>
                                <th><i class="bi bi-toggle-on"></i> ESTADO</th>
                                <th><i class="bi bi-tools"></i> ACCIONES</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Edificio> lista = (List<Edificio>) request.getAttribute("listaEdificios");
                                if (lista != null && !lista.isEmpty()) {
                                    for(Edificio e : lista){
                                        String estadoBadge = e.getEstado().equals("DISPONIBLE") ? 
                                            "bg-success" : "bg-danger";
                                        String estadoIcon = e.getEstado().equals("DISPONIBLE") ? 
                                            "check-circle" : "x-circle";
                            %>
                            <tr>
                                <td class="fw-bold">#<%= e.getId()%></td>
                                <td><%= e.getNombre()%></td>
                                <td><i class="bi bi-pin-map me-1"></i><%= e.getDireccion()%></td>
                                <td><i class="bi bi-geo-alt-fill me-1"></i><%= e.getCiudad()%></td>
                                <td>
                                    <span class="badge <%= estadoBadge %> fs-6 px-3 py-2">
                                        <i class="bi bi-<%= estadoIcon %> me-1"></i>
                                        <%= e.getEstado()%>
                                    </span>
                                </td>
                                <td>
                                    <div class="btn-group" role="group">
                                        <a href="${pageContext.request.contextPath}/edificio?accion=editar&id=<%= e.getId()%>" 
                                           class="btn btn-warning btn-sm">
                                            <i class="bi bi-pencil"></i> Editar
                                        </a>
                                        <a href="${pageContext.request.contextPath}/edificio?accion=desactivar&id=<%= e.getId()%>" 
                                           class="btn btn-danger btn-sm"
                                           onclick="return confirm('¿Está seguro de desactivar este edificio?')">
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
                                <td colspan="6" class="text-center text-muted py-4">
                                    <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                    No hay edificios registrados
                                 </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        <!-- Estadísticas rápidas -->
        <div class="row mt-4">
            <div class="col-md-4">
                <div class="card bg-primary text-white shadow-sm">
                    <div class="card-body">
                        <h6 class="card-title">Total Edificios</h6>
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
                                    for(Edificio e : lista){
                                        if(e.getEstado().equals("DISPONIBLE")) disponibles++;
                                    }
                                }
                                out.print(disponibles);
                            %>
                        </h3>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card bg-secondary text-white shadow-sm">
                    <div class="card-body">
                        <h6 class="card-title">Ocupados</h6>
                        <h3 class="mb-0">
                            <%= (lista != null) ? lista.size() - disponibles : 0 %>
                        </h3>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Botón volver al dashboard -->
        <div class="mt-4">
            <a href="${pageContext.request.contextPath}/views/dashboard/dashboard.jsp" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left me-2"></i>Volver al Dashboard
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>