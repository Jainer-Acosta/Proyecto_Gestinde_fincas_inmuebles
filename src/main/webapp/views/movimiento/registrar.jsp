<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrar Movimiento</title>
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
                            <i class="bi bi-cash-stack me-2"></i>Registrar Movimiento Bancario
                        </h2>
                    </div>
                    
                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/movimiento" method="post">
                            
                            <!-- Cuenta Bancaria -->
                            <div class="mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-bank me-1 text-primary"></i>Cuenta Bancaria
                                </label>
                                <select name="cuentaId" class="form-select" required>
                                    <option value="" disabled selected>-- Seleccione una cuenta --</option>
                                    <%
                                        List<Object[]> cuentas = (List<Object[]>) request.getAttribute("cuentas");
                                        if (cuentas != null) {
                                            for(Object[] c : cuentas){
                                    %>
                                    <option value="<%= c[0] %>">
                                        <i class="bi bi-credit-card"></i> <%= c[1] %>
                                    </option>
                                    <%
                                            }
                                        }
                                    %>
                                </select>
                            </div>
                            
                            <!-- Unidad (opcional) -->
                            <div class="mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-building me-1 text-primary"></i>Unidad (Opcional)
                                </label>
                                <select name="unidadId" class="form-select">
                                    <option value="" selected>-- Sin unidad asociada --</option>
                                    <%
                                        List<Object[]> unidades = (List<Object[]>) request.getAttribute("unidades");
                                        if (unidades != null) {
                                            for(Object[] u : unidades){
                                    %>
                                    <option value="<%= u[0] %>">
                                        🏢 <%= u[1] %> - 📋 <%= u[2] %> - 📍 <%= u[3] %> - 🔤 <%= u[4] %>
                                    </option>
                                    <%
                                            }
                                        }
                                    %>
                                </select>
                                
                            </div>
                            
                            <div class="row">
                                <!-- Tipo de Movimiento -->
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-semibold">
                                        <i class="bi bi-arrow-left-right me-1 text-primary"></i>Tipo
                                    </label>
                                    <select name="tipo" class="form-select" required>
                                        <option value="INGRESO" class="text-success">
                                            <i class="bi bi-arrow-up-circle"></i> INGRESO
                                        </option>
                                        <option value="GASTO" class="text-danger">
                                            <i class="bi bi-arrow-down-circle"></i> GASTO
                                        </option>
                                    </select>
                                </div>
                                
                                <!-- Categoría -->
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-semibold">
                                        <i class="bi bi-tags me-1 text-primary"></i>Categoría
                                    </label>
                                    <select name="categoria" class="form-select" required>
                                        <option value="ARRIENDO">🏠 ARRIENDO</option>
                                        <option value="REPARACION">🔧 REPARACION</option>
                                        <option value="LIMPIEZA">🧹 LIMPIEZA</option>
                                        <option value="AGUA">💧 AGUA</option>
                                        <option value="LUZ">⚡ LUZ</option>
                                        <option value="PORTERIA">🚪 PORTERIA</option>
                                    </select>
                                </div>
                            </div>
                            
                            <!-- Concepto -->
                            <div class="mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-tag me-1 text-primary"></i>Concepto
                                </label>
                                <input type="text" name="concepto" class="form-control" 
                                       placeholder="Ej: Pago de alquiler, Reparación de fontanería"
                                       required>
                            </div>
                            
                            <div class="row">
                                <!-- Monto -->
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-semibold">
                                        <i class="bi bi-currency-dollar me-1 text-primary"></i>Monto
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">$</span>
                                        <input type="number" step="0.01" name="monto" class="form-control" 
                                               placeholder="0.00" required>
                                    </div>
                                </div>
                                
                                <!-- Fecha -->
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-semibold">
                                        <i class="bi bi-calendar3 me-1 text-primary"></i>Fecha
                                    </label>
                                    <input type="date" name="fecha" class="form-control" required>
                                </div>
                            </div>
                            
                            <!-- Descripción -->
                            <div class="mb-4">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-file-text me-1 text-primary"></i>Descripción (Opcional)
                                </label>
                                <textarea name="descripcion" class="form-control" rows="3" 
                                          placeholder="Detalles adicionales del movimiento..."></textarea>
                            </div>
                            
                            <!-- Botones -->
                            <div class="d-flex gap-3 mt-4">
                                <button type="submit" class="btn btn-success flex-grow-1">
                                    <i class="bi bi-save me-2"></i>Guardar Movimiento
                                </button>
                                <a href="${pageContext.request.contextPath}/movimiento?accion=listar" class="btn btn-outline-secondary">
                                    <i class="bi bi-arrow-left me-2"></i>Cancelar
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
                
                
                
               
               
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>