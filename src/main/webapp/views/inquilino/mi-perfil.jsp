<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.entity.Usuario"%>
<%@page import="model.dao.InquilinoDAO"%>
<%@page import="model.entity.Inquilino"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mi Perfil</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    InquilinoDAO inquilinoDAO = new InquilinoDAO();
    Inquilino inquilino = inquilinoDAO.buscarPorUsuarioId(usuario.getId());
%>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/views/dashboard/dashboard.jsp">
            <i class="bi bi-building me-2"></i>InmoGest
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
            <i class="bi bi-person-circle me-2"></i>Mi Perfil
        </h1>
        <button onclick="window.print()" class="btn btn-outline-secondary">
            <i class="bi bi-printer me-2"></i>Imprimir
        </button>
    </div>

    <div class="row">
        <div class="col-md-4 mb-4">
            <div class="card shadow-sm border-0 text-center">
                <div class="card-body">
                    <div class="mb-3">
                        <img src="${pageContext.request.contextPath}/imagen?nombre=<%= inquilino != null ? inquilino.getFotografia() : "default.png" %>" 
                             class="rounded-circle border"
                             width="150" height="150"
                             style="object-fit: cover;">
                    </div>
                    <h4><%= inquilino != null ? inquilino.getNombre() + " " + inquilino.getApellido() : usuario.getNombre() %></h4>
                    <p class="text-muted"><%= usuario.getRol() %></p>
                </div>
            </div>
        </div>
        
        <div class="col-md-8">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="bi bi-person-badge me-2"></i>Datos Personales</h5>
                </div>
                <div class="card-body">
                    <table class="table table-borderless">
                        <tr>
                            <th width="150"><i class="bi bi-person"></i> Nombre:</th>
                            <td><%= inquilino != null ? inquilino.getNombre() : usuario.getNombre() %></td>
                        </tr>
                        <tr>
                            <th><i class="bi bi-person-badge"></i> Apellido:</th>
                            <td><%= inquilino != null ? inquilino.getApellido() : "" %></td>
                        </tr>
                        <tr>
                            <th><i class="bi bi-card-text"></i> DNI:</th>
                            <td><%= inquilino != null ? inquilino.getDni() : "" %></td>
                        </tr>
                        <tr>
                            <th><i class="bi bi-cake2"></i> Edad:</th>
                            <td><%= inquilino != null ? inquilino.getEdad() : "" %></td>
                        </tr>
                        <tr>
                            <th><i class="bi bi-gender-ambiguous"></i> Sexo:</th>
                            <td><%= inquilino != null ? inquilino.getSexo() : "" %></td>
                        </tr>
                        <tr>
                            <th><i class="bi bi-telephone"></i> Teléfono:</th>
                            <td><%= inquilino != null ? inquilino.getTelefono() : "" %></td>
                        </tr>
                        <tr>
                            <th><i class="bi bi-envelope"></i> Email:</th>
                            <td><%= inquilino != null ? inquilino.getEmail() : "" %></td>
                        </tr>
                        <tr>
                            <th><i class="bi bi-person-circle"></i> Usuario:</th>
                            <td><%= usuario.getUsername() %></td>
                        </tr>
                        <tr>
                            <th><i class="bi bi-calendar3"></i> Fecha Registro:</th>
                            <td><%= inquilino != null && inquilino.getFechaRegistro() != null ? inquilino.getFechaRegistro() : "No registrada" %></td>
                        </tr>
                    </table>
                    
                    <div class="alert alert-warning mt-3">
                        <i class="bi bi-exclamation-triangle me-2"></i>
                        <strong>Nota:</strong> Para modificar sus datos personales, debe comunicarse con la administración.
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>