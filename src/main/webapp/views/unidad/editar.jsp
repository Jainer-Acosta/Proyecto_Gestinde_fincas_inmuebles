<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.entity.Edificio"%>
<%@page import="model.entity.UnidadInmueble"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Unidad</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<%
    UnidadInmueble unidad = (UnidadInmueble) request.getAttribute("unidad");
%>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="card shadow-lg border-0">
                <div class="card-header bg-warning text-dark py-3">
                    <h2 class="h4 mb-0">
                        <i class="bi bi-pencil-square me-2"></i>Editar Unidad
                    </h2>
                </div>
                
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/unidad_inmueble" method="post">
                        <input type="hidden" name="accion" value="actualizar">
                        <input type="hidden" name="id" value="<%= unidad.getId()%>">
                        
                        <!-- Edificio -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-building me-1 text-primary"></i>Edificio
                            </label>
                            <select name="edificioId" class="form-select" required>
                                <%
                                    List<Edificio> edificios = (List<Edificio>) request.getAttribute("edificios");
                                    if (edificios != null) {
                                        for (Edificio e : edificios) {
                                %>
                                <option value="<%= e.getId()%>" 
                                    <%= unidad.getEdificioId() == e.getId() ? "selected" : "" %>>
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
                                <option value="PISO" <%= unidad.getTipo().equals("PISO") ? "selected" : "" %>>🏠 Piso</option>
                                <option value="LOCAL" <%= unidad.getTipo().equals("LOCAL") ? "selected" : "" %>>🏪 Local</option>
                                <option value="OFICINA" <%= unidad.getTipo().equals("OFICINA") ? "selected" : "" %>>🏢 Oficina</option>
                            </select>
                        </div>
                        
                        <div class="row">
                            <!-- Planta -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-diagram-2 me-1 text-primary"></i>Planta
                                </label>
                                <input type="text" name="planta" class="form-control" 
                                       value="<%= unidad.getPlanta()%>" required>
                            </div>
                            
                            <!-- Letra -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-type me-1 text-primary"></i>Letra / Número
                                </label>
                                <input type="text" name="letra" class="form-control" 
                                       value="<%= unidad.getLetra()%>" required>
                            </div>
                        </div>
                        
                        <!-- Descripción -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-card-text me-1 text-primary"></i>Descripción
                            </label>
                            <textarea name="descripcion" class="form-control" rows="3" 
                                      placeholder="Descripción de la unidad"><%= unidad.getDescripcion() != null ? unidad.getDescripcion() : "" %></textarea>
                            <div class="form-text text-muted">
                                <i class="bi bi-info-circle"></i> Descripción opcional de la unidad
                            </div>
                        </div>
                        
                        <!-- Estado -->
                        <div class="mb-4">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-toggle-on me-1 text-primary"></i>Estado
                            </label>
                            <select name="estado" class="form-select">
                                <option value="DISPONIBLE" <%= unidad.getEstado().equals("DISPONIBLE") ? "selected" : "" %>>✅ DISPONIBLE</option>
                                <option value="ALQUILADO" <%= unidad.getEstado().equals("ALQUILADO") ? "selected" : "" %>>🏠 ALQUILADO</option>
                                <option value="NO_DISPONIBLE" <%= unidad.getEstado().equals("NO_DISPONIBLE") ? "selected" : "" %>>❌ NO DISPONIBLE</option>
                            </select>
                            <div class="form-text text-muted">
                                <i class="bi bi-info-circle"></i> 
                                Las unidades ALQUILADAS no pueden ser asignadas a nuevos contratos
                            </div>
                        </div>
                        
                        <div class="d-flex gap-3 mt-4">
                            <button type="submit" class="btn btn-primary flex-grow-1">
                                <i class="bi bi-save me-2"></i>Actualizar Unidad
                            </button>
                            <a href="${pageContext.request.contextPath}/unidad_inmueble?accion=listar" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left me-2"></i>Cancelar
                            </a>
                        </div>
                    </form>
                </div>
            </div>
            
            <!-- Información adicional -->
            <div class="alert alert-secondary mt-4" role="alert">
                <i class="bi bi-info-circle me-2"></i>
                <strong>ID Unidad:</strong> <%= unidad.getId() %>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>