<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrar Inquilino</title>
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
                            <i class="bi bi-person-plus me-2"></i>Registrar Inquilino
                        </h2>
                    </div>
                    
                    <div class="card-body p-4">
                        <!-- Mensaje de error -->
                        <%
                            String error = (String) request.getAttribute("error");
                            if (error != null) {
                        %>
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="bi bi-exclamation-triangle me-2"></i>
                                <%= error %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        <%
                            }
                        %>
                        
                        <form action="${pageContext.request.contextPath}/inquilino"
                              method="post"
                              enctype="multipart/form-data">
                            
                            <input type="hidden" name="accion" value="guardar">
                            
                            <div class="row">
                                <!-- Nombre -->
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-semibold">
                                        <i class="bi bi-person me-1 text-primary"></i>Nombre
                                    </label>
                                    <input type="text" name="nombre" class="form-control" placeholder="Nombre del inquilino" required>
                                </div>
                                
                                <!-- Apellido -->
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-semibold">
                                        <i class="bi bi-person-badge me-1 text-primary"></i>Apellido
                                    </label>
                                    <input type="text" name="apellido" class="form-control" placeholder="Apellido del inquilino" required>
                                </div>
                            </div>
                            
                            <div class="row">
                                <!-- DNI -->
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-semibold">
                                        <i class="bi bi-card-text me-1 text-primary"></i>DNI
                                    </label>
                                    <input type="text" name="dni" class="form-control" placeholder="Número de documento" required>
                                </div>
                                
                                <!-- Edad -->
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-semibold">
                                        <i class="bi bi-cake2 me-1 text-primary"></i>Edad
                                    </label>
                                    <input type="number" name="edad" class="form-control" placeholder="Edad" required>
                                </div>
                            </div>
                            
                            <div class="row">
                                <!-- Sexo -->
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-semibold">
                                        <i class="bi bi-gender-ambiguous me-1 text-primary"></i>Sexo
                                    </label>
                                    <select name="sexo" class="form-select">
                                        <option value="MASCULINO">Masculino</option>
                                        <option value="FEMENINO">Femenino</option>
                                    </select>
                                </div>
                                
                                <!-- Teléfono -->
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-semibold">
                                        <i class="bi bi-telephone me-1 text-primary"></i>Teléfono
                                    </label>
                                    <input type="text" name="telefono" class="form-control" placeholder="Número de contacto" required>
                                </div>
                            </div>
                            
                            <!-- Email -->
                            <div class="mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-envelope me-1 text-primary"></i>Email
                                </label>
                                <input type="email" name="email" class="form-control" placeholder="correo@ejemplo.com" required>
                            </div>
                            
                            <div class="row">
                                <!-- Usuario -->
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-semibold">
                                        <i class="bi bi-person-circle me-1 text-primary"></i>Usuario
                                    </label>
                                    <input type="text" name="usuario" class="form-control" placeholder="Nombre de usuario" required>
                                </div>
                                
                                <!-- Contraseña -->
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-semibold">
                                        <i class="bi bi-lock me-1 text-primary"></i>Contraseña
                                    </label>
                                    <input type="password" name="password" class="form-control" placeholder="Contraseña" required>
                                </div>
                            </div>
                            
                            <!-- Fotografía -->
                            <div class="mb-4">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-camera me-1 text-primary"></i>Fotografía
                                </label>
                                <input type="file" name="fotografia" class="form-control" accept="image/*" required>
                                <div class="form-text text-muted">
                                    <i class="bi bi-info-circle"></i> Formatos permitidos: JPG, PNG, GIF
                                </div>
                            </div>
                            
                            <!-- Botones -->
                            <div class="d-flex gap-3 mt-4">
                                <button type="submit" class="btn btn-success flex-grow-1">
                                    <i class="bi bi-save me-2"></i>Guardar Inquilino
                                </button>
                                <a href="${pageContext.request.contextPath}/inquilino?accion=listar" class="btn btn-outline-secondary">
                                    <i class="bi bi-arrow-left me-2"></i>Cancelar
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
                
                <!-- Información adicional -->
                <div class="alert alert-info mt-4" role="alert">
                    <i class="bi bi-lightbulb me-2"></i>
                    <strong>Nota:</strong> Al registrar un inquilino, se creará automáticamente una cuenta de usuario con el rol "INQUILINO".
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>