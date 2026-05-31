<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.entity.Inquilino"%>
<%@page import="java.lang.Object"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrar Alquiler</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body class="bg-light">

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-7">
                <!-- Tarjeta del formulario -->
                <div class="card shadow-lg border-0">
                    <div class="card-header bg-primary text-white py-3">
                        <h2 class="h4 mb-0">
                            <i class="bi bi-file-earmark-plus me-2"></i>Registrar Alquiler
                        </h2>
                    </div>
                    
                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/alquiler" method="post">
                            <input type="hidden" name="accion" value="guardar">
                            
                            <!-- Select Inquilino -->
                            <div class="mb-4">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-person-badge me-1 text-primary"></i>Inquilino
                                </label>
                                <select name="inquilinoId" class="form-select form-select-lg" required>
                                    <option value="" disabled selected>-- Seleccione un inquilino --</option>
                                    <%
                                        List<Inquilino> inquilinos = (List<Inquilino>) request.getAttribute("inquilinos");
                                        for (Inquilino i : inquilinos) {
                                    %>
                                    <option value="<%= i.getId()%>">
                                        <%= i.getNombre()%> <%= i.getApellido()%>
                                    </option>
                                    <% } %>
                                </select>
                            </div>
                            
                            <!-- Select Unidad -->
                            <div class="mb-4">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-building me-1 text-primary"></i>Unidad
                                </label>
                                <select name="unidadId" class="form-select form-select-lg" required>
                                    <option value="" disabled selected>-- Seleccione una unidad --</option>
                                    <%
                                        List<Object[]> unidades = (List<Object[]>) request.getAttribute("unidades");
                                        for(Object[] u : unidades){
                                    %>
                                    <option value="<%= u[0]%>">
                                        🏢 Edificio: <%= u[1]%> - 📋 Tipo: <%= u[2]%> - 📍 Planta: <%= u[3]%> - 🔤 Letra: <%= u[4]%>
                                    </option>
                                    <% } %>
                                </select>
                                <div class="form-text text-muted">
                                    <i class="bi bi-info-circle"></i> Solo se muestran unidades disponibles
                                </div>
                            </div>
                            
                            <!-- Fecha Inicio -->
                            <div class="mb-4">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-calendar-check me-1 text-primary"></i>Fecha Inicio
                                </label>
                                <input type="date" name="fechaInicio" class="form-control form-control-lg" required>
                            </div>
                            
                            <!-- Fecha Fin -->
                            <div class="mb-4">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-calendar-x me-1 text-primary"></i>Fecha Fin
                                </label>
                                <input type="date" name="fechaFin" class="form-control form-control-lg">
                                <div class="form-text text-muted">Opcional - Dejar en blanco si es indefinido</div>
                            </div>
                            
                            <!-- Botones -->
                            <div class="d-flex gap-3 mt-4">
                                <button type="submit" class="btn btn-success btn-lg flex-grow-1">
                                    <i class="bi bi-save me-2"></i>Guardar Alquiler
                                </button>
                                <a href="${pageContext.request.contextPath}/alquiler?accion=listar" class="btn btn-outline-secondary btn-lg">
                                    <i class="bi bi-arrow-left me-2"></i>Cancelar
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
                
                <!-- Información adicional -->
                <div class="alert alert-info mt-4" role="alert">
                    <i class="bi bi-lightbulb me-2"></i>
                    <strong>Nota:</strong> Al registrar un alquiler, la unidad quedará automáticamente como OCUPADA y no estará disponible para nuevos alquileres.
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>