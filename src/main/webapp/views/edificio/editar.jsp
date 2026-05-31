<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.entity.Edificio"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Edificio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<%
    Edificio edificio = (Edificio) request.getAttribute("edificio");
%>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <!-- Tarjeta del formulario -->
            <div class="card shadow-lg border-0">
                <div class="card-header bg-warning text-dark py-3">
                    <h2 class="h4 mb-0">
                        <i class="bi bi-pencil-square me-2"></i>Editar Edificio
                    </h2>
                </div>
                
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/edificio" method="post">
                        <input type="hidden" name="accion" value="actualizar">
                        <input type="hidden" name="id" value="<%= edificio.getId()%>">
                        
                        <!-- Nombre -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-tag me-1 text-primary"></i>Nombre
                            </label>
                            <input type="text" 
                                   name="nombre" 
                                   class="form-control" 
                                   value="<%= edificio.getNombre()%>"
                                   required>
                        </div>
                        
                        <!-- Dirección -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-geo-alt me-1 text-primary"></i>Dirección
                            </label>
                            <input type="text" 
                                   name="direccion" 
                                   class="form-control" 
                                   value="<%= edificio.getDireccion()%>"
                                   required>
                        </div>
                        
                        <!-- Ciudad -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-building me-1 text-primary"></i>Ciudad
                            </label>
                            <input type="text" 
                                   name="ciudad" 
                                   class="form-control" 
                                   value="<%= edificio.getCiudad()%>"
                                   required>
                        </div>
                        
                        <!-- Código Postal -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-envelope me-1 text-primary"></i>Código Postal
                            </label>
                            <input type="text" 
                                   name="codigoPostal" 
                                   class="form-control" 
                                   value="<%= edificio.getCodigoPostal()%>"
                                   required>
                        </div>
                        
                        <!-- Estado -->
                        <div class="mb-4">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-toggle-on me-1 text-primary"></i>Estado
                            </label>
                            <select name="estado" class="form-select">
                                <option value="DISPONIBLE" 
                                    <%= edificio.getEstado().equals("DISPONIBLE") ? "selected" : "" %>>
                                    <i class="bi bi-check-circle"></i> DISPONIBLE
                                </option>
                                <option value="NO_DISPONIBLE" 
                                    <%= edificio.getEstado().equals("NO_DISPONIBLE") ? "selected" : "" %>>
                                    <i class="bi bi-x-circle"></i> NO DISPONIBLE
                                </option>
                            </select>
                            <div class="form-text text-muted">
                                <i class="bi bi-info-circle"></i> 
                                Los edificios NO DISPONIBLES no pueden ser asignados a nuevos alquileres
                            </div>
                        </div>
                        
                        <!-- Botones -->
                        <div class="d-flex gap-3 mt-4">
                            <button type="submit" class="btn btn-primary flex-grow-1">
                                <i class="bi bi-save me-2"></i>Actualizar Cambios
                            </button>
                            <a href="${pageContext.request.contextPath}/edificio?accion=listar" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left me-2"></i>Cancelar
                            </a>
                        </div>
                    </form>
                </div>
            </div>
            
            <!-- Información de ayuda -->
            <div class="alert alert-secondary mt-4" role="alert">
                <i class="bi bi-info-circle me-2"></i>
                <strong>ID del Edificio:</strong> <%= edificio.getId() %> 
                <span class="mx-2">|</span>
                <i class="bi bi-calendar"></i> Última modificación
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>