<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.entity.Banco"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrar Cuenta</title>
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
                            <i class="bi bi-bank me-2"></i>Registrar Cuenta Bancaria
                        </h2>
                    </div>
                    
                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/cuenta" method="post">
                            
                            <!-- Selección de Banco -->
                            <div class="mb-4">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-building me-1 text-primary"></i>Banco
                                </label>
                                <select name="bancoId" class="form-select form-select-lg" required>
                                    <option value="" disabled selected>-- Seleccione un banco --</option>
                                    <%
                                        List<Banco> bancos = (List<Banco>) request.getAttribute("bancos");
                                        if (bancos != null) {
                                            for(Banco b : bancos){
                                    %>
                                    <option value="<%= b.getId()%>">
                                        <i class="bi bi-bank"></i> <%= b.getNombre()%>
                                    </option>
                                    <%
                                            }
                                        } else {
                                    %>
                                    <option disabled>No hay bancos disponibles</option>
                                    <% } %>
                                </select>
                                <div class="form-text text-muted">
                                    <i class="bi bi-info-circle"></i> Seleccione la entidad bancaria
                                </div>
                            </div>
                            
                            <!-- Número de Cuenta -->
                            <div class="mb-4">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-credit-card me-1 text-primary"></i>Número Cuenta
                                </label>
                                <input type="text" 
                                       name="numeroCuenta" 
                                       class="form-control form-control-lg" 
                                       placeholder="Ej: 1234-5678-9012-3456"
                                       required>
                                <div class="form-text text-muted">
                                    <i class="bi bi-shield-check"></i> Ingrese el número de cuenta bancaria
                                </div>
                            </div>
                            
                            <!-- Saldo Inicial -->
                            <div class="mb-4">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-cash-stack me-1 text-primary"></i>Saldo Inicial
                                </label>
                                <div class="input-group input-group-lg">
                                    <span class="input-group-text">$</span>
                                    <input type="number" 
                                           step="0.01" 
                                           name="saldo" 
                                           class="form-control" 
                                           value="0" 
                                           placeholder="0.00">
                                </div>
                                <div class="form-text text-muted">
                                    <i class="bi bi-calculator"></i> Saldo inicial de la cuenta (puede modificarse después)
                                </div>
                            </div>
                            
                            <!-- Botones -->
                            <div class="d-flex gap-3 mt-4">
                                <button type="submit" class="btn btn-success btn-lg flex-grow-1">
                                    <i class="bi bi-save me-2"></i>Guardar Cuenta
                                </button>
                                <a href="${pageContext.request.contextPath}/cuenta?accion=listar" class="btn btn-outline-secondary btn-lg">
                                    <i class="bi bi-arrow-left me-2"></i>Cancelar
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
                
                <!-- Consejos útiles -->
                <div class="alert alert-info mt-4" role="alert">
                    <i class="bi bi-lightbulb me-2 fs-5"></i>
                    <strong>Consejo:</strong> Registre todas las cuentas bancarias de la empresa para llevar un control financiero completo. Los movimientos bancarios se registrarán por separado.
                </div>
                
                <!-- Tarjeta de ayuda -->
                <div class="card bg-light mt-3 border-0">
                    <div class="card-body">
                        <h6 class="card-title">
                            <i class="bi bi-question-circle me-2 text-primary"></i>¿Qué hacer después?
                        </h6>
                        <p class="card-text small text-muted mb-0">
                            Una vez registrada la cuenta, podrá:
                            <br>✓ Registrar movimientos bancarios (ingresos/egresos)
                            <br>✓ Consultar reportes financieros
                            <br>✓ Asociar recibos a esta cuenta
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>