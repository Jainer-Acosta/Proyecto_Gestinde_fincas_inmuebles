<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Configurar Parámetros</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="display-5 fw-semibold text-primary">
            <i class="bi bi-gear me-2"></i>Configuración de Parámetros
        </h1>
        <a href="${pageContext.request.contextPath}/recibo?accion=listar" class="btn btn-outline-secondary">
            <i class="bi bi-arrow-left me-2"></i>Volver
        </a>
    </div>

    <% if (request.getAttribute("mensaje") != null) { %>
        <div class="alert alert-success alert-dismissible fade show">
            <i class="bi bi-check-circle me-2"></i> <%= request.getAttribute("mensaje") %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <div class="row">
        <!-- Configuración IVA -->
        <div class="col-md-6 mb-4">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-danger text-white">
                    <h5 class="mb-0"><i class="bi bi-percent me-2"></i>IVA (Impuesto al Valor Agregado)</h5>
                </div>
                <div class="card-body">
                    <div class="alert alert-info">
                        <i class="bi bi-info-circle me-2"></i>
                        El IVA es un impuesto fijo definido por ley (actualmente 19% en Colombia).
                    </div>
                    <form method="post" action="${pageContext.request.contextPath}/configuracion">
                        <input type="hidden" name="accion" value="actualizarIVA">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Porcentaje IVA (%)</label>
                            <div class="input-group">
                                <input type="number" step="0.01" name="iva" class="form-control" 
                                       value="<%= request.getAttribute("ivaActual") != null ? request.getAttribute("ivaActual") : "19" %>" required>
                                <span class="input-group-text">%</span>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-danger w-100">
                            <i class="bi bi-save me-2"></i>Actualizar IVA
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Configuración IPC -->
        <div class="col-md-6 mb-4">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="bi bi-graph-up me-2"></i>IPC (Índice de Precios al Consumidor)</h5>
                </div>
                <div class="card-body">
                    <div class="alert alert-info">
                        <i class="bi bi-info-circle me-2"></i>
                        El IPC se aplica anualmente a la renta. Configure el porcentaje para cada año.
                    </div>
                    <form method="post" action="${pageContext.request.contextPath}/configuracion">
                        <input type="hidden" name="accion" value="actualizarIPC">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">Año</label>
                                <select name="anio" class="form-select" required>
                                    <option value="2024">2024</option>
                                    <option value="2025">2025</option>
                                    <option value="2026" selected>2026</option>
                                    <option value="2027">2027</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">IPC (%)</label>
                                <div class="input-group">
                                    <input type="number" step="0.1" name="ipc" class="form-control" 
                                           placeholder="Ej: 2.5" required>
                                    <span class="input-group-text">%</span>
                                </div>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">
                            <i class="bi bi-save me-2"></i>Actualizar IPC
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Historial de configuraciones -->
    <div class="card shadow-sm border-0 mt-2">
        <div class="card-header bg-secondary text-white">
            <h5 class="mb-0"><i class="bi bi-clock-history me-2"></i>Historial de Configuraciones</h5>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>Parámetro</th>
                            <th>Valor</th>
                            <th>Descripción</th>
                            <th>Última Actualización</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            model.dao.ReciboDAO reciboDAO = new model.dao.ReciboDAO();
                            java.util.List<Object[]> configs = reciboDAO.obtenerConfiguraciones();
                            for (Object[] c : configs) {
                                String clave = c[0].toString();
                                String badgeClass = clave.equals("IVA") ? "bg-danger" : "bg-info";
                        %>
                        <tr>
                            <td><strong><%= clave %></strong></td>
                            <td><span class="badge <%= badgeClass %>"><%= c[1] %>%</span></td>
                            <td><%= c[2] %></td>
                            <td><%= c[3] %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>