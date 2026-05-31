<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Iniciar Sesión</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="row justify-content-center align-items-center min-vh-100">
            <div class="col-md-6 col-lg-5">
                <!-- Tarjeta de login -->
                <div class="card shadow-lg border-0">
                    <div class="card-header bg-primary text-white text-center py-4">
                        <i class="bi bi-building fs-1"></i>
                        <h2 class="h4 mt-2 mb-0">Sistema Gestión Inmobiliaria</h2>
                    </div>
                    
                    <div class="card-body p-4">
                        <p class="text-center text-muted mb-4">
                            Administración de edificios, alquileres y recibos
                        </p>
                        
                        <h3 class="h5 text-center mb-4">
                            <i class="bi bi-key me-2"></i>Iniciar Sesión
                        </h3>
                        
                        <form action="${pageContext.request.contextPath}/login" method="post">
                            <!-- Campo Usuario -->
                            <div class="mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-person me-1"></i>Usuario
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-person-circle"></i>
                                    </span>
                                    <input type="text" 
                                           name="username" 
                                           class="form-control" 
                                           placeholder="Ingrese su usuario"
                                           required>
                                </div>
                            </div>
                            
                            <!-- Campo Contraseña -->
                            <div class="mb-4">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-lock me-1"></i>Contraseña
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-shield-lock"></i>
                                    </span>
                                    <input type="password" 
                                           name="password" 
                                           class="form-control" 
                                           placeholder="Ingrese su contraseña"
                                           required>
                                </div>
                            </div>
                            
                            <!-- Botón Ingresar -->
                            <button type="submit" class="btn btn-primary w-100 py-2 mb-3">
                                <i class="bi bi-box-arrow-in-right me-2"></i>Ingresar al Sistema
                            </button>
                            
                            <!-- Mensaje de error -->
                            <%
                                String error = request.getParameter("error");
                                if(error != null){
                            %>
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="bi bi-exclamation-triangle me-2"></i>
                                    Usuario o contraseña incorrectos
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            <%
                                }
                            %>
                        </form>
                        
                        <!-- Información de ayuda -->
                        <div class="mt-4 pt-3 border-top">
                            <div class="row text-center small text-muted">
                                <div class="col-4">
                                    <i class="bi bi-shield-check d-block mb-1"></i>
                                    Sistema Seguro
                                </div>
                                <div class="col-4">
                                    <i class="bi bi-clock-history d-block mb-1"></i>
                                    Soporte 24/7
                                </div>
                                <div class="col-4">
                                    <i class="bi bi-database d-block mb-1"></i>
                                    Datos Protegidos
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card-footer bg-light text-center py-3">
                        <small class="text-muted">
                            <i class="bi bi-c-circle"></i> 2026 Sistema Gestión Inmobiliaria
                        </small>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>