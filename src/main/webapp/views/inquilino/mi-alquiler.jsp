<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.entity.Usuario"%>
<%@page import="model.dao.AlquilerDAO"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mi Alquiler</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    AlquilerDAO alquilerDAO = new AlquilerDAO();
    Object[] alquiler = alquilerDAO.obtenerAlquilerActivoPorUsuario(usuario.getId());
%>

<!-- Navbar -->
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
                    <a class="nav-link" href="${pageContext.request.contextPath}/views/dashboard/dashboard.jsp">
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
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="display-5 fw-semibold text-primary">
            <i class="bi bi-house-door me-2"></i>Mi Alquiler
        </h1>
        <button onclick="window.print()" class="btn btn-outline-secondary">
            <i class="bi bi-printer me-2"></i>Imprimir
        </button>
    </div>

    <% if (alquiler != null) { %>
        <div class="card shadow-sm border-0">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0"><i class="bi bi-info-circle me-2"></i>Información del Contrato</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <table class="table table-borderless">
                            <tr>
                                <th><i class="bi bi-building"></i> Edificio:</th>
                                <td><%= alquiler[0] %></td>
                            </tr>
                            <tr>
                                <th><i class="bi bi-tag"></i> Tipo de Unidad:</th>
                                <td><%= alquiler[1] %></td>
                            </tr>
                            <tr>
                                <th><i class="bi bi-diagram-2"></i> Planta:</th>
                                <td><%= alquiler[2] %></td>
                            </tr>
                            <tr>
                                <th><i class="bi bi-type"></i> Letra/Número:</th>
                                <td><%= alquiler[3] %></td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-md-6">
                        <table class="table table-borderless">
                            <tr>
                                <th><i class="bi bi-calendar-check"></i> Fecha Inicio:</th>
                                <td><%= alquiler[4] %></td>
                            </tr>
                            <tr>
                                <th><i class="bi bi-calendar-x"></i> Fecha Fin:</th>
                                <td><%= (alquiler[5] != null) ? alquiler[5] : "Contrato vigente" %></td>
                            </tr>
                            <tr>
                                <th><i class="bi bi-toggle-on"></i> Estado:</th>
                                <td>
                                    <span class="badge bg-success">ACTIVO</span>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                
                <hr>
                
                <div class="alert alert-info mt-3">
                    <i class="bi bi-info-circle me-2"></i>
                    <strong>Información importante:</strong>
                    <ul class="mb-0 mt-2">
                        <li>Su contrato se renueva automáticamente cada mes.</li>
                        <li>Los recibos se generan mensualmente y puede consultarlos en "Mis Recibos".</li>
                        <li>Para cualquier consulta, comuníquese con la administración.</li>
                    </ul>
                </div>
            </div>
        </div>
    <% } else { %>
        <div class="card shadow-sm border-0">
            <div class="card-body text-center py-5">
                <i class="bi bi-building-slash fs-1 text-muted"></i>
                <h4 class="mt-3">No tiene un alquiler activo</h4>
                <p class="text-muted">Actualmente no tiene ningún contrato de alquiler vigente.</p>
                <a href="${pageContext.request.contextPath}/views/dashboard/dashboard.jsp" class="btn btn-primary">
                    <i class="bi bi-arrow-left me-2"></i>Volver al Dashboard
                </a>
            </div>
        </div>
    <% } %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>