<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reporte Recibos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="display-5 fw-semibold text-primary">
            <i class="bi bi-file-spreadsheet me-2"></i>Reporte de Recibos
        </h1>
        <button onclick="window.print()" class="btn btn-outline-secondary">
            <i class="bi bi-printer me-2"></i>Imprimir
        </button>
    </div>

    <!-- Filtro -->
    <div class="card shadow-sm border-0 mb-4">
        <div class="card-body">
            <h5 class="card-title mb-3">
                <i class="bi bi-funnel me-2"></i>Filtrar Reporte
            </h5>
            <form method="get" action="${pageContext.request.contextPath}/recibo" class="row g-3">
                <input type="hidden" name="accion" value="reporte">
                
                <div class="col-md-3">
                    <label class="form-label fw-semibold">Estado</label>
                    <select name="estado" class="form-select">
                        <option value="PAGADO">✅ PAGADO</option>
                        <option value="PENDIENTE">⏳ PENDIENTE</option>
                    </select>
                </div>
                
                <div class="col-md-3">
                    <label class="form-label fw-semibold">Desde</label>
                    <input type="date" name="desde" class="form-control" required>
                </div>
                
                <div class="col-md-3">
                    <label class="form-label fw-semibold">Hasta</label>
                    <input type="date" name="hasta" class="form-control" required>
                </div>
                
                <div class="col-md-3 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary w-100">
                        <i class="bi bi-search me-2"></i>Buscar
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Resultados -->
    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-striped mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th><i class="bi bi-hash"></i> ID</th>
                            <th><i class="bi bi-person"></i> INQUILINO</th>
                            <th><i class="bi bi-building"></i> EDIFICIO</th>
                            <th><i class="bi bi-grid"></i> TIPO</th>
                            <th><i class="bi bi-calendar3"></i> FECHA</th>
                            <th><i class="bi bi-calculator"></i> TOTAL</th>
                            <th><i class="bi bi-toggle-on"></i> ESTADO</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Object[]> lista = (List<Object[]>) request.getAttribute("listaReporte");
                            if (lista != null && !lista.isEmpty()) {
                                double totalGeneral = 0;
                                for(Object[] r : lista){
                                    double total = Double.parseDouble(r[6].toString());
                                    totalGeneral += total;
                                    String estado = r[7].toString();
                                    String estadoBadge = estado.equals("PAGADO") ? "bg-success" : "bg-warning text-dark";
                        %>
                        <tr>
                            <td class="fw-bold">#<%= r[0] %></td>
                            <td><i class="bi bi-person-circle me-1"></i><%= r[1] %> <%= r[2] %></td>
                            <td><%= r[3] %></td>
                            <td><span class="badge bg-info"><%= r[4] %></span></td>
                            <td><%= r[5] %></td>
                            <td class="fw-semibold text-success">$ <%= String.format("%,.2f", total) %></td>
                            <td>
                                <span class="badge <%= estadoBadge %> px-3 py-2">
                                    <i class="bi bi-<%= estado.equals("PAGADO") ? "check-circle" : "clock" %> me-1"></i>
                                    <%= estado %>
                                </span>
                            </td>
                        </tr>
                        <%
                                }
                        %>
                        <tr class="table-dark">
                            <td colspan="5" class="text-end fw-bold">TOTAL GENERAL:</td>
                            <td class="fw-bold text-success">$ <%= String.format("%,.2f", totalGeneral) %></td>
                            <td></td>
                        </tr>
                        <%
                            } else {
                        %>
                        <tr>
                            <td colspan="7" class="text-center text-muted py-4">
                                <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                No hay recibos en el rango seleccionado
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <div class="mt-4">
        <a href="${pageContext.request.contextPath}/recibo?accion=listar" class="btn btn-outline-secondary">
            <i class="bi bi-arrow-left me-2"></i>Volver a Recibos
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>