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
                                if (lista != null && !lista.isEmpty()) {
                                    for (Object[] fila : lista) {
                                        // Índices: [0]=idAlquiler, [1]=nombre, [2]=apellido, [3]=edificio, [4]=tipo, [5]=planta, [6]=letra, [7]=fechaInicio, [8]=fechaFin, [9]=estado, [10]=unidadId
                                        String estado = fila[9].toString();
                                        int idAlquiler = Integer.parseInt(fila[0].toString());
                                        int unidadId = Integer.parseInt(fila[10].toString());
                            %>
                            <tr>
                                <td class="fw-bold">#<%= idAlquiler %></td>
                                <td>
                                    <i class="bi bi-person-circle me-1 text-secondary"></i>
                                    <%= fila[1]%> <%= fila[2]%>
                                </td>
                                <td><i class="bi bi-building me-1"></i><%= fila[3]%></td>
                                <td><span class="badge bg-info"><%= fila[4]%></span></td>
                                <td><%= fila[5]%></td>
                                <td><%= fila[6]%></td>
                                <td><%= fila[7]%></td>
                                <td><%= (fila[8] != null) ? fila[8] : "Vigente" %></td>
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
                                        <a class="btn btn-danger btn-sm" 
                                           href="${pageContext.request.contextPath}/alquiler?accion=desalquilar&id=<%= idAlquiler %>&unidadId=<%= unidadId %>"
                                           onclick="return confirm('¿Está seguro de desalquilar esta unidad? La unidad quedará disponible para nuevos alquileres.')">
                                            <i class="bi bi-building-x"></i> Desalquilar
                                        </a>
                                    <% } else { %>
                                        <span class="text-muted">Finalizado</span>
                                    <% } %>
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="10" class="text-center text-muted py-4">
                                    <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                    No hay alquileres registrados
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
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