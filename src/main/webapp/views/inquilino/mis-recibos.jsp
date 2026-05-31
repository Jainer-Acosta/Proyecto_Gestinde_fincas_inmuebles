<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.entity.Usuario"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mis Recibos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
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
            <i class="bi bi-receipt me-2"></i>Mis Recibos
        </h1>
        <button onclick="window.print()" class="btn btn-outline-secondary">
            <i class="bi bi-printer me-2"></i>Imprimir
        </button>
    </div>

    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-striped mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th><i class="bi bi-hash"></i> N° RECIBO</th>
                            <th><i class="bi bi-building"></i> EDIFICIO</th>
                            <th><i class="bi bi-grid"></i> TIPO</th>
                            <th><i class="bi bi-diagram-2"></i> PLANTA</th>
                            <th><i class="bi bi-type"></i> LETRA</th>
                            <th><i class="bi bi-calendar3"></i> FECHA</th>
                            <th><i class="bi bi-calculator"></i> TOTAL</th>
                            <th><i class="bi bi-toggle-on"></i> ESTADO</th>
                            <th><i class="bi bi-tools"></i> ACCIONES</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Object[]> lista = (List<Object[]>) request.getAttribute("listaRecibos");
                            if (lista != null && !lista.isEmpty()) {
                                for(Object[] r : lista){
                                    String numeroRecibo = (r[0] != null) ? r[0].toString() : "N/A";
                                    String edificio = (r[1] != null) ? r[1].toString() : "";
                                    String tipo = (r[2] != null) ? r[2].toString() : "";
                                    String planta = (r[3] != null) ? r[3].toString() : "";
                                    String letra = (r[4] != null) ? r[4].toString() : "";
                                    String fecha = (r[5] != null) ? r[5].toString() : "";
                                    double total = Double.parseDouble(r[6].toString());
                                    String estado = r[7].toString();
                                    
                                    String estadoBadge = estado.equals("PAGADO") ? "bg-success" : "bg-warning text-dark";
                                    String estadoIcon = estado.equals("PAGADO") ? "check-circle" : "clock";
                        %>
                        <tr>
                            <td class="fw-bold font-monospace"><%= numeroRecibo %></td>
                            <td><%= edificio %></td>
                            <td><span class="badge bg-info"><%= tipo %></span></td>
                            <td><%= planta %></td>
                            <td><strong><%= letra %></strong></td>
                            <td><%= fecha %></td>
                            <td class="fw-semibold text-success">$ <%= String.format("%,.2f", total) %></td>
                            <td>
                                <span class="badge <%= estadoBadge %> px-3 py-2">
                                    <i class="bi bi-<%= estadoIcon %> me-1"></i>
                                    <%= estado %>
                                </span>
                            </td>
                            <td>
                                <a class="btn btn-info btn-sm" 
                                   href="${pageContext.request.contextPath}/recibo?accion=ver&numeroRecibo=<%= numeroRecibo %>">
                                    <i class="bi bi-eye"></i> Ver
                                </a>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="9" class="text-center text-muted py-4">
                                <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                No tienes recibos registrados
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <!-- Información adicional -->
    <div class="alert alert-info mt-4">
        <i class="bi bi-info-circle me-2"></i>
        <strong>Nota:</strong> Para ver el detalle de un recibo y descargarlo en PDF, haga clic en el botón <strong>"Ver"</strong>.
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>