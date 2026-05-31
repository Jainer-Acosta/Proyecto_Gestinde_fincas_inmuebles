<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.entity.Edificio"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrar Unidad</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="card shadow-lg border-0">
                <div class="card-header bg-primary text-white py-3">
                    <h2 class="h4 mb-0">
                        <i class="bi bi-plus-square me-2"></i>Registrar Piso / Local
                    </h2>
                </div>
                
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/unidad_inmueble" method="post">
                        <input type="hidden" name="accion" value="guardar">
                        
                        <!-- Edificio -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-building me-1 text-primary"></i>Edificio
                            </label>
                            <select name="edificioId" class="form-select" required>
                                <option value="" disabled selected>-- Seleccione un edificio --</option>
                                <%
                                    List<Edificio> edificios = (List<Edificio>) request.getAttribute("edificios");
                                    if (edificios != null) {
                                        for (Edificio e : edificios) {
                                %>
                                <option value="<%= e.getId()%>">
                                    🏢 <%= e.getNombre()%> - <%= e.getCiudad()%>
                                </option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                        
                        <!-- Tipo -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-tag me-1 text-primary"></i>Tipo
                            </label>
                            <select name="tipo" class="form-select" required>
                                <option value="PISO">🏠 Piso</option>
                                <option value="LOCAL">🏪 Local</option>
                                <option value="OFICINA">🏢 Oficina</option>
                            </select>
                        </div>
                        
                        <div class="row">
                            <!-- Planta -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-diagram-2 me-1 text-primary"></i>Planta
                                </label>
                                <input type="text" name="planta" class="form-control" 
                                       placeholder="Ej: 1, 2, PB, -1" required>
                            </div>
                            
                            <!-- Letra -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-type me-1 text-primary"></i>Letra / Número
                                </label>
                                <input type="text" name="letra" class="form-control" 
                                       placeholder="Ej: A, B, 101" required>
                            </div>
                        </div>
                        
                        <!-- Descripción (NUEVO CAMPO) -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-card-text me-1 text-primary"></i>Descripción
                            </label>
                            <textarea name="descripcion" class="form-control" rows="3" 
                                      placeholder="Ej: Habitación amplia con vista al mar, Local comercial esquinero, Oficina con recepción..."></textarea>
                            <div class="form-text text-muted">
                                <i class="bi bi-info-circle"></i> Descripción opcional de la unidad
                            </div>
                        </div>
                        
                        <!-- Estado oculto (por defecto DISPONIBLE) -->
                        <input type="hidden" name="estado" value="DISPONIBLE">
                        
                        <div class="d-flex gap-3 mt-4">
                            <button type="submit" class="btn btn-success flex-grow-1">
                                <i class="bi bi-save me-2"></i>Guardar Unidad
                            </button>
                            <a href="${pageContext.request.contextPath}/unidad_inmueble?accion=listar" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left me-2"></i>Cancelar
                            </a>
                        </div>
                    </form>
                </div>
            </div>
            
            <!-- Información adicional -->
            <div class="alert alert-info mt-4" role="alert">
                <i class="bi bi-lightbulb me-2"></i>
                <strong>Nota:</strong> La unidad se registrará automáticamente como DISPONIBLE. Podrá alquilarla desde el módulo de Alquileres.
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>