<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Movimientos Bancarios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body class="bg-light">

    <div class="container py-4">
        <!-- Header con título y botón -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1 class="display-5 fw-semibold text-primary">
                <i class="bi bi-bank2 me-2"></i>Movimientos Bancarios
            </h1>
            <a class="btn btn-success btn-lg" 
               href="${pageContext.request.contextPath}/movimiento?accion=nuevo">
                <i class="bi bi-plus-circle me-2"></i>Nuevo Movimiento
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
                                <th><i class="bi bi-bank"></i> CUENTA</th>
                                <th><i class="bi bi-building"></i> EDIFICIO</th>
                                <th><i class="bi bi-arrow-left-right"></i> TIPO</th>
                                <th><i class="bi bi-tag"></i> CONCEPTO</th>
                                <th><i class="bi bi-currency-dollar"></i> MONTO</th>
                                <th><i class="bi bi-calendar3"></i> FECHA</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Object[]> lista = (List<Object[]>) request.getAttribute("listaMovimientos");
                                if (lista != null && !lista.isEmpty()) {
                                    for(Object[] m : lista){
                                        String tipo = m[4].toString();
                                        String tipoBadge = tipo.equals("INGRESO") ? "bg-success" : "bg-danger";
                                        String tipoIcon = tipo.equals("INGRESO") ? "arrow-up-circle" : "arrow-down-circle";
                                        double monto = Double.parseDouble(m[6].toString());
                            %>
                            <tr>
                                <td class="fw-bold">#<%= m[0] %></td>
                                <td><i class="bi bi-credit-card me-1"></i><%= m[1] %></td>
                                <td><i class="bi bi-building me-1"></i><%= m[2] %></td>
                                <td>
                                    <span class="badge <%= tipoBadge %> px-3 py-2">
                                        <i class="bi bi-<%= tipoIcon %> me-1"></i>
                                        <%= tipo %>
                                    </span>
                                </td>
                                <td><%= m[5] %></td>
                                <td class="fw-semibold <%= tipo.equals("INGRESO") ? "text-success" : "text-danger" %>">
                                    <i class="bi bi-currency-dollar"></i> <%= String.format("%,.2f", monto) %>
                                </td>
                                <td><i class="bi bi-calendar-date me-1"></i><%= m[7] %></td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="7" class="text-center text-muted py-4">
                                    <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                    No hay movimientos bancarios registrados
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        <!-- Resumen financiero -->
        <%
            if (lista != null && !lista.isEmpty()) {
                double totalIngresos = 0;
                double totalGastos = 0;
                for(Object[] m : lista){
                    double monto = Double.parseDouble(m[6].toString());
                    if(m[4].toString().equals("INGRESO")){
                        totalIngresos += monto;
                    } else {
                        totalGastos += monto;
                    }
                }
                double saldo = totalIngresos - totalGastos;
        %>
        <div class="row mt-4">
            <div class="col-md-4">
                <div class="card bg-success text-white shadow-sm">
                    <div class="card-body">
                        <h6 class="card-title">
                            <i class="bi bi-arrow-up-circle me-1"></i> Total Ingresos
                        </h6>
                        <h3 class="mb-0">$ <%= String.format("%,.2f", totalIngresos) %></h3>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card bg-danger text-white shadow-sm">
                    <div class="card-body">
                        <h6 class="card-title">
                            <i class="bi bi-arrow-down-circle me-1"></i> Total Gastos
                        </h6>
                        <h3 class="mb-0">$ <%= String.format("%,.2f", totalGastos) %></h3>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card <%= saldo >= 0 ? "bg-info" : "bg-warning" %> text-white shadow-sm">
                    <div class="card-body">
                        <h6 class="card-title">
                            <i class="bi bi-pie-chart me-1"></i> Saldo Neto
                        </h6>
                        <h3 class="mb-0">$ <%= String.format("%,.2f", saldo) %></h3>
                    </div>
                </div>
            </div>
        </div>
        <% } %>
        
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