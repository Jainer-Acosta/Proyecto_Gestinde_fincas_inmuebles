<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.entity.Inquilino"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Inquilino</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<%
    Inquilino i = (Inquilino) request.getAttribute("inquilino");
%>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-7">
            <!-- Tarjeta del formulario -->
            <div class="card shadow-lg border-0">
                <div class="card-header bg-warning text-dark py-3">
                    <h2 class="h4 mb-0">
                        <i class="bi bi-pencil-square me-2"></i>Editar Inquilino
                    </h2>
                </div>
                
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/inquilino" method="post">
                        <input type="hidden" name="accion" value="actualizar">
                        <input type="hidden" name="id" value="<%= i.getId()%>">
                        
                        <div class="row">
                            <!-- Nombre -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-person me-1 text-primary"></i>Nombre
                                </label>
                                <input type="text" name="nombre" class="form-control" 
                                       value="<%= i.getNombre()%>" required>
                            </div>
                            
                            <!-- Apellido -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-person-badge me-1 text-primary"></i>Apellido
                                </label>
                                <input type="text" name="apellido" class="form-control" 
                                       value="<%= i.getApellido()%>" required>
                            </div>
                        </div>
                        
                        <div class="row">
                            <!-- DNI -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-card-text me-1 text-primary"></i>DNI
                                </label>
                                <input type="text" name="dni" class="form-control" 
                                       value="<%= i.getDni()%>" required>
                            </div>
                            
                            <!-- Edad -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-cake2 me-1 text-primary"></i>Edad
                                </label>
                                <input type="number" name="edad" class="form-control" 
                                       value="<%= i.getEdad()%>" required>
                            </div>
                        </div>
                        
                        <div class="row">
                            <!-- Sexo -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-gender-ambiguous me-1 text-primary"></i>Sexo
                                </label>
                                <select name="sexo" class="form-select">
                                    <option value="MASCULINO" <%= i.getSexo().equals("MASCULINO") ? "selected" : "" %>>
                                        Masculino
                                    </option>
                                    <option value="FEMENINO" <%= i.getSexo().equals("FEMENINO") ? "selected" : "" %>>
                                        Femenino
                                    </option>
                                </select>
                            </div>
                            
                            <!-- Teléfono -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-telephone me-1 text-primary"></i>Teléfono
                                </label>
                                <input type="text" name="telefono" class="form-control" 
                                       value="<%= i.getTelefono()%>" required>
                            </div>
                        </div>
                        
                        <!-- Email -->
                        <div class="mb-4">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-envelope me-1 text-primary"></i>Email
                            </label>
                            <input type="email" name="email" class="form-control" 
                                   value="<%= i.getEmail()%>" required>
                        </div>
                        
                        <!-- Botones -->
                        <div class="d-flex gap-3 mt-4">
                            <button type="submit" class="btn btn-primary flex-grow-1">
                                <i class="bi bi-save me-2"></i>Actualizar Cambios
                            </button>
                            <a href="${pageContext.request.contextPath}/inquilino?accion=listar" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left me-2"></i>Cancelar
                            </a>
                        </div>
                    </form>
                </div>
            </div>
            
            <!-- Información de ayuda -->
            <div class="alert alert-secondary mt-4" role="alert">
                <i class="bi bi-info-circle me-2"></i>
                <strong>ID:</strong> <%= i.getId() %> 
                <span class="mx-2">|</span>
                <i class="bi bi-calendar"></i> Fecha Registro: <%= i.getFechaRegistro() %>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>