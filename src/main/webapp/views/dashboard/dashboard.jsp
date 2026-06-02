<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.entity.Usuario"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | Sistema Gestión Inmobiliaria</title>
    
    <!-- Bootstrap 5 CSS + Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard-style.css">
</head>
<body>

<div class="container-fluid px-0">
    <div class="row g-0">
        <!-- ============ SIDEBAR ============= -->
        <div class="col-auto col-md-3 col-lg-2 sidebar-dark p-3 p-md-4">
            <div class="d-flex flex-column h-100">
                <div class="sidebar-heading text-white">
                    <i class="bi bi-building me-2"></i> PGFI
                </div>
                
                <div class="sidebar-nav-scroll">
                    <nav class="nav flex-column">
                        <% 
                            Usuario usuario = (Usuario) session.getAttribute("usuario");
                            String rol = (usuario != null) ? usuario.getRol() : "";
                        %>
                        
                        <!-- ADMIN: Menú completo -->
                        <% if(rol.equals("ADMIN")) { %>
                            <a href="${pageContext.request.contextPath}/edificio?accion=listar" class="nav-link">
                                <i class="bi bi-buildings"></i> Gestión Edificios
                            </a>
                            <a href="${pageContext.request.contextPath}/unidad_inmueble?accion=listar" class="nav-link">
                                <i class="bi bi-grid-3x3-gap-fill"></i> Gestión Unidades
                            </a>
                            <a href="${pageContext.request.contextPath}/inquilino?accion=listar" class="nav-link">
                                <i class="bi bi-people"></i> Gestión Inquilinos
                            </a>
                            <a href="${pageContext.request.contextPath}/alquiler?accion=listar" class="nav-link">
                                <i class="bi bi-file-text"></i> Alquileres
                            </a>
                            <a href="${pageContext.request.contextPath}/recibo?accion=listar" class="nav-link">
                                <i class="bi bi-receipt"></i> Recibos
                            </a>
                            <a href="${pageContext.request.contextPath}/movimiento?accion=listar" class="nav-link">
                                <i class="bi bi-bank2"></i> Movimientos Bancarios
                            </a>
                            <a href="${pageContext.request.contextPath}/cuenta?accion=listar" class="nav-link">
                                <i class="bi bi-wallet2"></i> Cuentas Bancarias
                            </a>
                            <a href="${pageContext.request.contextPath}/financiero" class="nav-link">
                                <i class="bi bi-graph-up"></i> Reportes Financieros
                            </a>
                            <a href="${pageContext.request.contextPath}/recibo?accion=pendientes" class="nav-link">
                                <i class="bi bi-clock-history"></i> Recibos Pendientes
                            </a>
                            <a href="${pageContext.request.contextPath}/recibo?accion=pagados" class="nav-link">
                                <i class="bi bi-check2-circle"></i> Recibos Pagados
                            </a>
                            <a href="${pageContext.request.contextPath}/inquilino?accion=reporte" class="nav-link">
                                <i class="bi bi-person-badge"></i> Reporte Inquilinos
                            </a>
                            <a href="${pageContext.request.contextPath}/recibo?accion=gananciasEdificio" class="nav-link">
                                <i class="bi bi-building me-2"></i> Ganancias por Edificio
                            </a>
                        <% } %>
                        
                        <!-- SECRETARIO: Menú específico -->
                        <% if(rol.equals("SECRETARIO")) { %>
                            <a href="${pageContext.request.contextPath}/edificio?accion=listar" class="nav-link">
                                <i class="bi bi-buildings"></i> Gestión Edificios
                            </a>
                            <a href="${pageContext.request.contextPath}/unidad_inmueble?accion=listar" class="nav-link">
                                <i class="bi bi-grid-3x3-gap-fill"></i> Gestión Unidades
                            </a>
                            <a href="${pageContext.request.contextPath}/inquilino?accion=listar" class="nav-link">
                                <i class="bi bi-people"></i> Gestión Inquilinos
                            </a>
                            <a href="${pageContext.request.contextPath}/alquiler?accion=listar" class="nav-link">
                                <i class="bi bi-file-text"></i> Alquileres
                            </a>
                            <a href="${pageContext.request.contextPath}/recibo?accion=listar" class="nav-link">
                                <i class="bi bi-receipt"></i> Recibos
                            </a>
                            <a href="${pageContext.request.contextPath}/recibo?accion=pendientes" class="nav-link">
                                <i class="bi bi-clock-history"></i> Recibos Pendientes
                            </a>
                            <a href="${pageContext.request.contextPath}/recibo?accion=pagados" class="nav-link">
                                <i class="bi bi-check2-circle"></i> Recibos Pagados
                            </a>
                            <a href="${pageContext.request.contextPath}/inquilino?accion=reporte" class="nav-link">
                                <i class="bi bi-person-badge"></i> Reporte Inquilinos
                            </a>
                            <a href="${pageContext.request.contextPath}/recibo?accion=gananciasEdificio" class="nav-link">
                                <i class="bi bi-building me-2"></i> Ganancias por Edificio
                            </a>
                            <a href="${pageContext.request.contextPath}/movimiento?accion=listar" class="nav-link">
                                <i class="bi bi-bank2"></i> Movimientos Bancarios
                            </a>
                        <% } %>
                        
                        <!-- INQUILINO: versión restringida -->
                        <% if(rol.equals("INQUILINO")) { %>
                            <a href="${pageContext.request.contextPath}/mis-recibos" class="nav-link">
                                <i class="bi bi-receipt"></i> Mis Recibos
                            </a>
                            <a href="${pageContext.request.contextPath}/mi-alquiler" class="nav-link">
                                <i class="bi bi-house-door"></i> Mi Alquiler
                            </a>
                            <a href="${pageContext.request.contextPath}/mi-perfil" class="nav-link">
                                <i class="bi bi-person-circle"></i> Mi Perfil
                            </a>
                        <% } %>
                        
                        <!-- Separador + logout -->
                        <hr class="my-3 text-white-50">
                        <a href="${pageContext.request.contextPath}/logout" class="nav-link text-danger">
                            <i class="bi bi-box-arrow-right"></i> Cerrar sesión
                        </a>
                    </nav>
                </div>
            </div>
        </div>
        
        <!-- ============ MAIN CONTENT ============= -->
        <div class="col-md-9 col-lg-10 main-content p-3 p-md-4">
            <!-- Top bar con bienvenida -->
            <div class="top-bar-custom d-flex flex-wrap justify-content-between align-items-center">
                <div>
                    <h4 class="mb-0 fw-semibold"><i class="bi bi-house-door-fill me-2 text-primary"></i>Panel de control</h4>
                    <p class="text-muted mb-0 small">Gestión integral de inmuebles</p>
                </div>
                <div class="user-badge mt-2 mt-sm-0">
                    <i class="bi bi-person-circle fs-5"></i>
                    <span>Bienvenido, <strong><%= (usuario != null) ? usuario.getNombre() : "Invitado" %></strong></span>
                    <span class="badge bg-secondary rounded-pill"><%= rol %></span>
                </div>
            </div>
            
            <!-- Hero Banner -->
            <div class="mb-4">
                <div class="dashboard-card p-4">
                    <div class="d-flex align-items-center justify-content-between flex-wrap">
                        <div>
                            <h1 class="display-6 fw-semibold">Sistema Gestión Inmobiliaria</h1>
                            <p class="text-secondary mt-2">Centraliza edificios, unidades, inquilinos y finanzas en un solo lugar</p>
                        </div>
                        <div class="mt-2 mt-md-0">
                            <i class="bi bi-building fs-1 text-primary opacity-50"></i>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- ========== CARDS PARA ADMIN / SECRETARIO ========== -->
            <% if (rol.equals("ADMIN") || rol.equals("SECRETARIO")) { %>
                <div class="row g-4">
                    <div class="col-sm-6 col-lg-4">
                        <div class="dashboard-card h-100 p-3 p-lg-4">
                            <div class="card-icon">
                                <i class="bi bi-building"></i>
                            </div>
                            <h3 class="h5 fw-bold">🏢 Edificios</h3>
                            <p class="text-secondary small">Gestión de edificios registrados, direcciones y datos clave.</p>
                            <a href="${pageContext.request.contextPath}/edificio?accion=listar" class="text-decoration-none small fw-semibold">Administrar <i class="bi bi-arrow-right-short"></i></a>
                        </div>
                    </div>
                    
                    <div class="col-sm-6 col-lg-4">
                        <div class="dashboard-card h-100 p-3 p-lg-4">
                            <div class="card-icon">
                                <i class="bi bi-grid-3x3-gap-fill"></i>
                            </div>
                            <h3 class="h5 fw-bold">🏠 Unidades</h3>
                            <p class="text-secondary small">Control de pisos, locales comerciales, estado y disponibilidad.</p>
                            <a href="${pageContext.request.contextPath}/unidad_inmueble?accion=listar" class="text-decoration-none small fw-semibold">Ver unidades <i class="bi bi-arrow-right-short"></i></a>
                        </div>
                    </div>
                    
                    <div class="col-sm-6 col-lg-4">
                        <div class="dashboard-card h-100 p-3 p-lg-4">
                            <div class="card-icon">
                                <i class="bi bi-people"></i>
                            </div>
                            <h3 class="h5 fw-bold">👤 Inquilinos</h3>
                            <p class="text-secondary small">Administración de inquilinos, contratos y datos de contacto.</p>
                            <a href="${pageContext.request.contextPath}/inquilino?accion=listar" class="text-decoration-none small fw-semibold">Gestionar <i class="bi bi-arrow-right-short"></i></a>
                        </div>
                    </div>
                    
                    <div class="col-sm-6 col-lg-4">
                        <div class="dashboard-card h-100 p-3 p-lg-4">
                            <div class="card-icon">
                                <i class="bi bi-receipt"></i>
                            </div>
                            <h3 class="h5 fw-bold">📄 Recibos</h3>
                            <p class="text-secondary small">Control de pagos, estados pendientes y emisión de comprobantes.</p>
                            <a href="${pageContext.request.contextPath}/recibo?accion=listar" class="text-decoration-none small fw-semibold">Ver recibos <i class="bi bi-arrow-right-short"></i></a>
                        </div>
                    </div>
                    
                    <div class="col-sm-6 col-lg-4">
                        <div class="dashboard-card h-100 p-3 p-lg-4">
                            <div class="card-icon">
                                <i class="bi bi-graph-up"></i>
                            </div>
                            <h3 class="h5 fw-bold">💰 Finanzas</h3>
                            <p class="text-secondary small">Movimientos bancarios, cuentas y reportes financieros ejecutivos.</p>
                            <a href="${pageContext.request.contextPath}/movimiento?accion=listar" class="text-decoration-none small fw-semibold">Ir a finanzas <i class="bi bi-arrow-right-short"></i></a>
                        </div>
                    </div>
                    
                    <div class="col-sm-6 col-lg-4">
                        <div class="dashboard-card h-100 p-3 p-lg-4">
                            <div class="card-icon">
                                <i class="bi bi-bar-chart-steps"></i>
                            </div>
                            <h3 class="h5 fw-bold">📊 Reportes</h3>
                            <p class="text-secondary small">Consultas estadísticas, reporte de unidades, inquilinos y recibos.</p>
                            <a href="${pageContext.request.contextPath}/recibo?accion=gananciasEdificio" class="text-decoration-none small fw-semibold">Ver reportes <i class="bi bi-arrow-right-short"></i></a>
                        </div>
                    </div>
                </div>
                
                <!-- Accesos rápidos para ADMIN/SECRETARIO -->
                <div class="row mt-4 g-3">
                    <div class="col-md-6">
                        <div class="dashboard-card p-3 d-flex align-items-center justify-content-between">
                            <div>
                                <i class="bi bi-cash-coin fs-3 text-success"></i>
                                <span class="fw-semibold ms-2">Últimos movimientos bancarios</span>
                            </div>
                            <a href="${pageContext.request.contextPath}/movimiento?accion=listar" class="btn btn-sm btn-outline-primary rounded-pill">Registrar <i class="bi bi-plus-lg"></i></a>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="dashboard-card p-3 d-flex align-items-center justify-content-between">
                            <div>
                                <i class="bi bi-bell fs-3 text-warning"></i>
                                <span class="fw-semibold ms-2">Recibos Pendientes de pago</span>
                            </div>
                            <a href="${pageContext.request.contextPath}/recibo?accion=pendientes" class="btn btn-sm btn-outline-danger rounded-pill">Revisar <i class="bi bi-eye"></i></a>
                        </div>
                    </div>
                </div>
            <% } %>

            <!-- ========== CARDS PARA INQUILINO ========== -->
            <% if (rol.equals("INQUILINO")) { %>
                <div class="row g-4">
                    <div class="col-sm-6 col-lg-4">
                        <div class="dashboard-card h-100 p-3 p-lg-4">
                            <div class="card-icon">
                                <i class="bi bi-receipt"></i>
                            </div>
                            <h3 class="h5 fw-bold">📄 Mis Recibos</h3>
                            <p class="text-secondary small">Consulta tus recibos de alquiler, estados de pago y descarga tus comprobantes.</p>
                            <a href="${pageContext.request.contextPath}/mis-recibos" class="text-decoration-none small fw-semibold">Ver recibos <i class="bi bi-arrow-right-short"></i></a>
                        </div>
                    </div>
                    
                    <div class="col-sm-6 col-lg-4">
                        <div class="dashboard-card h-100 p-3 p-lg-4">
                            <div class="card-icon">
                                <i class="bi bi-house-door"></i>
                            </div>
                            <h3 class="h5 fw-bold">🏠 Mi Alquiler</h3>
                            <p class="text-secondary small">Información de tu contrato de alquiler, unidad arrendada y detalles.</p>
                            <a href="${pageContext.request.contextPath}/mi-alquiler" class="text-decoration-none small fw-semibold">Ver alquiler <i class="bi bi-arrow-right-short"></i></a>
                        </div>
                    </div>
                    
                    <div class="col-sm-6 col-lg-4">
                        <div class="dashboard-card h-100 p-3 p-lg-4">
                            <div class="card-icon">
                                <i class="bi bi-person-circle"></i>
                            </div>
                            <h3 class="h5 fw-bold">👤 Mi Perfil</h3>
                            <p class="text-secondary small">Consulta y actualiza tus datos personales de contacto.</p>
                            <a href="${pageContext.request.contextPath}/mi-perfil" class="text-decoration-none small fw-semibold">Ver perfil <i class="bi bi-arrow-right-short"></i></a>
                        </div>
                    </div>
                </div>
            <% } %>
            
            <!-- Footer -->
            <div class="footer-clean mt-4">
                <i class="bi bi-c-circle me-1"></i> Sistema Gestión Inmobiliaria — Panel unificado | Todos los derechos reservados © 2026
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>