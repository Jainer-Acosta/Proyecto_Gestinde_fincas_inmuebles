<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Reporte Financiero</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <style>
        .progress-bar-custom {
            transition: width 0.5s ease;
        }
        .progress-label {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
    </style>
</head>
<body class="bg-light">

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <!-- Tarjeta principal -->
                <div class="card shadow-lg border-0">
                    <div class="card-header bg-primary text-white py-3">
                        <h2 class="h4 mb-0 text-center">
                            <i class="bi bi-graph-up me-2"></i>Reporte Financiero
                        </h2>
                    </div>
                    
                    <div class="card-body p-4">
                        <!-- Resumen de indicadores -->
                        <div class="row g-3 mb-4">
                            <!-- Ingresos -->
                            <div class="col-12">
                                <div class="card bg-success bg-opacity-10 border-success">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <h6 class="text-success mb-1">
                                                    <i class="bi bi-arrow-up-circle"></i> Ingresos Totales
                                                </h6>
                                                <h3 class="text-success mb-0">
                                                    $ ${ingresos}
                                                </h3>
                                            </div>
                                            <div class="display-4 text-success opacity-50">
                                                <i class="bi bi-cash-stack"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Gastos -->
                            <div class="col-12">
                                <div class="card bg-danger bg-opacity-10 border-danger">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <h6 class="text-danger mb-1">
                                                    <i class="bi bi-arrow-down-circle"></i> Gastos Totales
                                                </h6>
                                                <h3 class="text-danger mb-0">
                                                    $ ${gastos}
                                                </h3>
                                            </div>
                                            <div class="display-4 text-danger opacity-50">
                                                <i class="bi bi-credit-card"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Saldo Neto -->
                            <div class="col-12">
                                <div class="card ${saldo >= 0 ? 'bg-info' : 'bg-warning'} bg-opacity-10 border-${saldo >= 0 ? 'info' : 'warning'}">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <h6 class="${saldo >= 0 ? 'text-info' : 'text-warning'} mb-1">
                                                    <i class="bi bi-pie-chart"></i> Saldo Neto
                                                </h6>
                                                <h3 class="${saldo >= 0 ? 'text-info' : 'text-warning'} mb-0">
                                                    $ ${saldo}
                                                </h3>
                                                <small class="text-muted">
                                                    ${saldo >= 0 ? 'Utilidad positiva' : 'Pérdida detectada'}
                                                </small>
                                            </div>
                                            <div class="display-4 ${saldo >= 0 ? 'text-info' : 'text-warning'} opacity-50">
                                                <i class="bi bi-${saldo >= 0 ? 'graph-up' : 'graph-down'}"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Barra de progreso visual mejorada -->
                        <div class="mt-4">
                            <label class="form-label fw-semibold mb-2">Distribución de Ingresos vs Gastos</label>
                            <%
                                double ingresos = 0;
                                double gastos = 0;
                                try {
                                    ingresos = (Double) request.getAttribute("ingresos");
                                    gastos = (Double) request.getAttribute("gastos");
                                } catch (Exception e) {
                                    ingresos = 0;
                                    gastos = 0;
                                }
                                double total = ingresos + gastos;
                                double porcentajeIngresos = total > 0 ? (ingresos / total) * 100 : 0;
                                double porcentajeGastos = total > 0 ? (gastos / total) * 100 : 0;
                            %>
                            
                            <!-- Leyenda -->
                            <div class="d-flex justify-content-between mb-2">
                                <div>
                                    <span class="badge bg-success">
                                        <i class="bi bi-arrow-up"></i> Ingresos
                                    </span>
                                    <span class="ms-2">$ <%= String.format("%,.2f", ingresos) %></span>
                                </div>
                                <div>
                                    <span class="badge bg-danger">
                                        <i class="bi bi-arrow-down"></i> Gastos
                                    </span>
                                    <span class="ms-2">$ <%= String.format("%,.2f", gastos) %></span>
                                </div>
                            </div>
                            
                            <!-- Barra de progreso -->
                            <div class="progress" style="height: 35px; border-radius: 8px; overflow: hidden;">
                                <div class="progress-bar progress-bar-custom bg-success" 
                                     style="width: <%= porcentajeIngresos %>%"
                                     role="progressbar">
                                    <% if (porcentajeIngresos >= 15) { %>
                                        <i class="bi bi-arrow-up me-1"></i> <%= String.format("%.1f", porcentajeIngresos) %>%
                                    <% } %>
                                </div>
                                <div class="progress-bar progress-bar-custom bg-danger" 
                                     style="width: <%= porcentajeGastos %>%"
                                     role="progressbar">
                                    <% if (porcentajeGastos >= 15) { %>
                                        <i class="bi bi-arrow-down me-1"></i> <%= String.format("%.1f", porcentajeGastos) %>%
                                    <% } %>
                                </div>
                            </div>
                            
                            <!-- Información adicional si el porcentaje es pequeño -->
                            <% if (porcentajeIngresos > 0 && porcentajeIngresos < 15) { %>
                                <div class="small text-success mt-1">
                                    <i class="bi bi-arrow-up"></i> Ingresos: <%= String.format("%.1f", porcentajeIngresos) %>%
                                </div>
                            <% } %>
                            <% if (porcentajeGastos > 0 && porcentajeGastos < 15) { %>
                                <div class="small text-danger">
                                    <i class="bi bi-arrow-down"></i> Gastos: <%= String.format("%.1f", porcentajeGastos) %>%
                                </div>
                            <% } %>
                        </div>
                        
                        <!-- Tabla de resumen -->
                        <div class="mt-4 pt-3 border-top">
                            <table class="table table-sm table-borderless">
                                <tbody>
                                    <tr class="text-success">
                                        <td><i class="bi bi-check-circle"></i> Total Ingresos:</td>
                                        <td class="text-end fw-bold">$ <%= String.format("%,.2f", ingresos) %></td>
                                    </tr>
                                    <tr class="text-danger">
                                        <td><i class="bi bi-x-circle"></i> Total Gastos:</td>
                                        <td class="text-end fw-bold">$ <%= String.format("%,.2f", gastos) %></td>
                                    </tr>
                                    <tr class="table-active">
                                        <td><strong><i class="bi bi-calculator"></i> Balance Final:</strong></td>
                                        <td class="text-end fw-bold <%= (ingresos - gastos) >= 0 ? "text-success" : "text-danger" %>">
                                            $ <%= String.format("%,.2f", ingresos - gastos) %>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                    <div class="card-footer bg-light">
                        <div class="d-flex justify-content-between align-items-center">
                            <small class="text-muted">
                                <i class="bi bi-calendar-week"></i> Reporte generado en tiempo real
                            </small>
                            <button onclick="window.print()" class="btn btn-sm btn-outline-primary">
                                <i class="bi bi-printer"></i> Imprimir Reporte
                            </button>
                        </div>
                    </div>
                </div>
                
                <!-- Botones de acción -->
                <div class="d-flex gap-3 mt-4">
                    <a href="${pageContext.request.contextPath}/views/dashboard/dashboard.jsp" class="btn btn-outline-secondary flex-grow-1">
                        <i class="bi bi-arrow-left me-2"></i>Volver al Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/movimiento?accion=nuevo" class="btn btn-primary flex-grow-1">
                        <i class="bi bi-plus-circle me-2"></i>Nuevo Movimiento
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>