<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cuentas Bancarias</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body class="bg-light">

    <div class="container py-4">
        <!-- Header con título y botón -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1 class="display-5 fw-semibold text-primary">
                <i class="bi bi-bank2 me-2"></i>Cuentas Bancarias
            </h1>
            <a class="btn btn-success btn-lg" 
               href="${pageContext.request.contextPath}/cuenta?accion=nuevo">
                <i class="bi bi-plus-circle me-2"></i>Nueva Cuenta
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
                                <th><i class="bi bi-building"></i> BANCO</th>
                                <th><i class="bi bi-credit-card"></i> NÚMERO CUENTA</th>
                                <th><i class="bi bi-cash-stack"></i> SALDO</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Object[]> lista = (List<Object[]>) request.getAttribute("listaCuentas");
                                if (lista != null && !lista.isEmpty()) {
                                    for(Object[] c : lista){
                            %>
                            <tr>
                                <td class="fw-bold">#<%= c[0]%></td>
                                <td>
                                    <i class="bi bi-bank text-primary me-2"></i>
                                    <%= c[1]%>
                                </td>
                                <td>
                                    <code><%= c[2]%></code>
                                </td>
                                <td class="fw-semibold text-success">
                                    <i class="bi bi-currency-dollar"></i> <%= String.format("%,.2f", c[3])%>
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="4" class="text-center text-muted py-4">
                                    <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                    No hay cuentas bancarias registradas
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        <!-- Tarjeta de resumen financiero (opcional) -->
        <div class="row mt-4">
            <div class="col-md-4">
                <div class="card bg-primary text-white shadow-sm">
                    <div class="card-body">
                        <h6 class="card-title">Total Cuentas</h6>
                        <h3 class="mb-0">
                            <%= (lista != null) ? lista.size() : 0 %>
                        </h3>
                    </div>
                </div>
            </div>
            <div class="col-md-8">
                <div class="card bg-success text-white shadow-sm">
                    <div class="card-body">
                        <h6 class="card-title">Saldo Total</h6>
                        <h3 class="mb-0">
                            <i class="bi bi-currency-dollar"></i> 
                            <%
                                double totalSaldo = 0;
                                if (lista != null) {
                                    for(Object[] c : lista){
                                        totalSaldo += Double.parseDouble(c[3].toString());
                                    }
                                }
                                out.print(String.format("%,.2f", totalSaldo));
                            %>
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