<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista Alquileres</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body class="bg-light">

    <div class="container py-4">
        <!-- Header con título y botón -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1 class="display-5 fw-semibold text-primary">
                <i class="bi bi-file-text me-2"></i>Alquileres
            </h1>
            <a class="btn btn-success btn-lg" 
               href="${pageContext.request.contextPath}/alquiler?accion=nuevo">
                <i class="bi bi-plus-circle me-2"></i>Nuevo Alquiler
            </a>
        </div>

        <!-- Tabla responsive -->
        <div class="card shadow-sm border-0">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover table-striped mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>INQUILINO</th>
                                <th>EDIFICIO</th>
                                <th>TIPO</th>
                                <th>PLANTA</th>
                                <th>LETRA</th>
                                <th>FECHA INICIO</th>
                                <th>FECHA FIN</th>
                                <th>ESTADO</th>
                                <th>ACCIONES</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Object[]> lista = (List<Object[]>) request.getAttribute("listaAlquileres");
                                for (Object[] fila : lista) {
                                    String estado = fila[9].toString();
                            %>
                            <tr>
                                <td class="fw-bold">#<%= fila[0]%></td>
                                <td>
                                    <i class="bi bi-person-circle me-1 text-secondary"></i>
                                    <%= fila[1]%> <%= fila[2]%>
                                </td>
                                <td><i class="bi bi-building me-1"></i><%= fila[3]%></td>
                                <td><span class="badge bg-info"><%= fila[4]%></span></td>
                                <td><%= fila[5]%></td>
                                <td><%= fila[6]%></td>
                                <td><%= fila[7]%></td>
                                <td><%= fila[8]%></td>
                                <td>
                                    <% if(estado.equals("ACTIVO")){ %>
                                        <span class="badge bg-success fs-6 px-3 py-2">
                                            <i class="bi bi-check-circle me-1"></i>ACTIVO
                                        </span>
                                    <% } else { %>
                                        <span class="badge bg-danger fs-6 px-3 py-2">
                                            <i class="bi bi-x-circle me-1"></i>FINALIZADO
                                        </span>
                                    <% } %>
                                </td>
                                <td>
                                    <% if(estado.equals("ACTIVO")){ %>
                                        <div class="btn-group" role="group">
                                            <a class="btn btn-warning btn-sm" 
                                               href="${pageContext.request.contextPath}/alquiler?accion=finalizar&id=<%= fila[0]%>">
                                                <i class="bi bi-flag"></i> Finalizar
                                            </a>
                                            <a class="btn btn-danger btn-sm" 
                                               href="${pageContext.request.contextPath}/alquiler?accion=finalizar&id=<%= fila[0] %>&unidadId=<%= fila[5] %>">
                                                <i class="bi bi-building-x"></i> Desalquilar
                                            </a>
                                        </div>
                                    <% } else { %>
                                        <span class="text-muted">Sin acciones</span>
                                    <% } %>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        <!-- Botón volver al dashboard (opcional) -->
        <div class="mt-4">
            <a href="${pageContext.request.contextPath}/views/dashboard/dashboard.jsp" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left me-2"></i>Volver al Dashboard
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>