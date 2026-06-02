<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.entity.Inquilino"%>
<%@page import="model.entity.Usuario"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista Inquilinos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
%>

<!-- Navbar superior -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/views/dashboard/dashboard.jsp">
            <i class="bi bi-building me-2"></i>PGFI
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <span class="nav-link">
                        <i class="bi bi-person-circle me-1"></i>
                        Bienvenido, <strong><%= usuario.getNombre()%></strong>
                    </span>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/views/dashboard/dashboard.jsp" style="color: black">
                        <i class="bi bi-speedometer2 me-1"></i>Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-danger" href="${pageContext.request.contextPath}/logout">
                        <i class="bi bi-box-arrow-right me-1"></i>Cerrar sesión
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container py-4">
    <!-- Header con título y botón -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="display-5 fw-semibold text-primary">
            <i class="bi bi-people me-2"></i>Lista de Inquilinos
        </h1>
        <a class="btn btn-success btn-lg" 
           href="${pageContext.request.contextPath}/inquilino?accion=nuevo">
            <i class="bi bi-plus-circle me-2"></i>Nuevo Inquilino
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
                            <th><i class="bi bi-camera"></i> FOTO</th>
                            <th><i class="bi bi-person"></i> NOMBRE</th>
                            <th><i class="bi bi-person-badge"></i> APELLIDO</th>
                            <th><i class="bi bi-card-text"></i> DNI</th>
                            <th><i class="bi bi-cake2"></i> EDAD</th>
                            <th><i class="bi bi-gender-ambiguous"></i> SEXO</th>
                            <th><i class="bi bi-telephone"></i> TELÉFONO</th>
                            <th><i class="bi bi-envelope"></i> EMAIL</th>
                            <th><i class="bi bi-toggle-on"></i> ESTADO</th>
                            <th><i class="bi bi-tools"></i> ACCIONES</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Inquilino> lista = (List<Inquilino>) request.getAttribute("listaInquilinos");
                            if (lista != null && !lista.isEmpty()) {
                                for (Inquilino i : lista) {
                                    String estadoActual = i.getEstado();
                                    String estadoBadge = estadoActual.equals("ACTIVO") ? "bg-success" : "bg-secondary";
                                    String estadoIcon = estadoActual.equals("ACTIVO") ? "check-circle" : "x-circle";
                        %>
                        <tr>
                            <td class="fw-bold"><%= i.getId()%></td>
                            <td>
                                <img src="${pageContext.request.contextPath}/imagen?nombre=<%= i.getFotografia()%>"
                                     class="rounded-circle border"
                                     width="50" 
                                     height="50"
                                     style="object-fit: cover;">
                            </td>
                            <td><%= i.getNombre()%></td>
                            <td><%= i.getApellido()%></td>
                            <td><code><%= i.getDni()%></code></td>
                            <td><%= i.getEdad()%> años</td>
                            <td>
                                <span class="badge bg-info">
                                    <i class="bi bi-<%= i.getSexo().equals("MASCULINO") ? "gender-male" : "gender-female" %>"></i>
                                    <%= i.getSexo().equals("MASCULINO") ? "Masculino" : "Femenino" %>
                                </span>
                            </td>
                            <td><%= i.getTelefono()%></td>
                            <td><%= i.getEmail()%></td>
                            <td>
                                <span class="badge <%= estadoBadge %> px-3 py-2">
                                    <i class="bi bi-<%= estadoIcon %> me-1"></i>
                                    <%= estadoActual %>
                                </span>
                            </td>
                            <td>
                                <div class="btn-group" role="group">
                                    <!-- Botón Editar -->
                                    <a href="${pageContext.request.contextPath}/inquilino?accion=editar&id=<%= i.getId()%>" 
                                       class="btn btn-warning btn-sm">
                                        <i class="bi bi-pencil"></i> Editar
                                    </a>
                                    
                                    <!-- Botón Activar/Desactivar según el estado -->
                                    <% if (estadoActual.equals("ACTIVO")) { %>
                                        <a href="${pageContext.request.contextPath}/inquilino?accion=desactivar&id=<%= i.getId()%>" 
                                           class="btn btn-danger btn-sm"
                                           onclick="return confirm('¿Está seguro de desactivar este inquilino? El inquilino no podrá acceder al sistema ni realizar nuevos alquileres.')">
                                            <i class="bi bi-person-x"></i> Desactivar
                                        </a>
                                    <% } else { %>
                                        <a href="${pageContext.request.contextPath}/inquilino?accion=activar&id=<%= i.getId()%>" 
                                           class="btn btn-success btn-sm"
                                           onclick="return confirm('¿Está seguro de activar este inquilino? El inquilino podrá acceder nuevamente al sistema.')">
                                            <i class="bi bi-person-check"></i> Activar
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
                            <td colspan="11" class="text-center text-muted py-4">
                                <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                No hay inquilinos registrados
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
                    <h6 class="card-title">Total Inquilinos</h6>
                    <h3 class="mb-0">
                        <%= (lista != null) ? lista.size() : 0 %>
                    </h3>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-success text-white shadow-sm">
                <div class="card-body">
                    <h6 class="card-title">Activos</h6>
                    <h3 class="mb-0">
                        <%
                            int activos = 0;
                            if (lista != null) {
                                for(Inquilino i : lista){
                                    if(i.getEstado().equals("ACTIVO")) activos++;
                                }
                            }
                            out.print(activos);
                        %>
                    </h3>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-secondary text-white shadow-sm">
                <div class="card-body">
                    <h6 class="card-title">Inactivos</h6>
                    <h3 class="mb-0">
                                <%= (lista != null) ? lista.size() - activos : 0 %>
                    </h3>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>