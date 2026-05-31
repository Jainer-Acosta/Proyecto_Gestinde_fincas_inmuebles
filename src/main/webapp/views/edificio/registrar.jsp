<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrar Edificio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body class="bg-light">

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <!-- Tarjeta del formulario -->
                <div class="card shadow-lg border-0">
                    <div class="card-header bg-primary text-white py-3">
                        <h2 class="h4 mb-0">
                            <i class="bi bi-building-add me-2"></i>Registrar Edificio
                        </h2>
                    </div>
                    
                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/edificio" method="post">
                            
                            <!-- Nombre -->
                            <div class="mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-tag me-1 text-primary"></i>Nombre
                                </label>
                                <input type="text" 
                                       name="nombre" 
                                       class="form-control" 
                                       placeholder="Ej: Torre Central, Edificio Plaza"
                                       required>
                                <div class="form-text text-muted">Nombre identificativo del edificio</div>
                            </div>
                            
                            <!-- Dirección -->
                            <div class="mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-geo-alt me-1 text-primary"></i>Dirección
                                </label>
                                <input type="text" 
                                       name="direccion" 
                                       class="form-control" 
                                       placeholder="Ej: Av. Principal #123"
                                       required>
                            </div>
                            
                            <!-- Número -->
                            <div class="mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-hash me-1 text-primary"></i>Número
                                </label>
                                <input type="text" 
                                       name="numero" 
                                       class="form-control" 
                                       placeholder="Número exterior/interior (opcional)">
                                <div class="form-text text-muted">Número de identificación del inmueble</div>
                            </div>
                            
                            <!-- Ciudad -->
                            <div class="mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-building me-1 text-primary"></i>Ciudad
                                </label>
                                <input type="text" 
                                       name="ciudad" 
                                       class="form-control" 
                                       placeholder="Ej: Madrid, Barcelona, Valencia">
                            </div>
                            
                            <!-- Código Postal -->
                            <div class="mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-envelope me-1 text-primary"></i>Código Postal
                                </label>
                                <input type="text" 
                                       name="codigoPostal" 
                                       class="form-control" 
                                       placeholder="Ej: 28001, 08001">
                            </div>
                            
                            <!-- Estado oculto siempre DISPONIBLE al registrar -->
                            <input type="hidden" name="estado" value="DISPONIBLE">
                            
                            <!-- Botones -->
                            <div class="d-flex gap-3 mt-4">
                                <button type="submit" class="btn btn-success flex-grow-1">
                                    <i class="bi bi-save me-2"></i>Guardar Edificio
                                </button>
                                <a href="${pageContext.request.contextPath}/edificio?accion=listar" class="btn btn-outline-secondary">
                                    <i class="bi bi-arrow-left me-2"></i>Cancelar
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
                
                <!-- Información adicional -->
                <div class="alert alert-info mt-4" role="alert">
                    <i class="bi bi-lightbulb me-2"></i>
                    <strong>Nota:</strong> El edificio se registrará automáticamente como DISPONIBLE. Podrá cambiar su estado más tarde desde la lista de edificios.
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>