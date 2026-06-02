<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.entity.Recibo"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Recibo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<%
    Recibo r = (Recibo) request.getAttribute("recibo");
    List<Object[]> conceptosPersonalizados = (List<Object[]>) request.getAttribute("conceptosPersonalizados");
    
    java.sql.Date fechaEmision = r.getFechaEmision();
    java.util.Date hoy = new java.util.Date();
    boolean esMesAnterior = false;
    
    if (fechaEmision != null) {
        java.util.Calendar calRecibo = java.util.Calendar.getInstance();
        calRecibo.setTime(fechaEmision);
        java.util.Calendar calHoy = java.util.Calendar.getInstance();
        calHoy.setTime(hoy);
        
        if (calRecibo.get(java.util.Calendar.MONTH) < calHoy.get(java.util.Calendar.MONTH) ||
            calRecibo.get(java.util.Calendar.YEAR) < calHoy.get(java.util.Calendar.YEAR)) {
            esMesAnterior = true;
        }
    }
%>

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-md-10 col-lg-9">
            <% if (esMesAnterior) { %>
                <div class="alert alert-warning alert-dismissible fade show">
                    <i class="bi bi-exclamation-triangle me-2"></i>
                    Este recibo es de un mes anterior. Puede modificarlo según lo requerido.
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>
            
            <div class="card shadow-lg border-0">
                <div class="card-header bg-warning text-dark py-3">
                   <h2 class="h4 mb-0">
                        <i class="bi bi-pencil-square me-2"></i>Editar Recibo #<%= r.getNumeroRecibo() != null ? r.getNumeroRecibo() : "Sin número" %>
                    </h2>
                </div>
                
                <div class="card-body p-4">
                    <!-- Formulario principal -->
                    <form action="${pageContext.request.contextPath}/recibo" method="post">
                        <input type="hidden" name="accion" value="actualizar">
                        <input type="hidden" name="id" value="<%= r.getId() %>">
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-cash me-1 text-danger"></i>Renta * (Obligatorio)
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text">$</span>
                                    <input type="number" step="0.01" name="renta" class="form-control" value="<%= r.getRenta() %>" required>
                                </div>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-droplet me-1 text-primary"></i>Agua
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text">$</span>
                                    <input type="number" step="0.01" name="agua" class="form-control" value="<%= r.getAgua() %>">
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-lightbulb me-1 text-primary"></i>Luz
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text">$</span>
                                    <input type="number" step="0.01" name="luz" class="form-control" value="<%= r.getLuz() %>">
                                </div>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-person-walking me-1 text-primary"></i>Portería
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text">$</span>
                                    <input type="number" step="0.01" name="porteria" class="form-control" value="<%= r.getPorteria() %>">
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-three-dots me-1 text-primary"></i>Otros
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text">$</span>
                                    <input type="number" step="0.01" name="otros" class="form-control" value="<%= r.getOtros() %>">
                                </div>
                            </div>
                            
                            <div class="col-md-6 mb-4">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-toggle-on me-1 text-primary"></i>Estado
                                </label>
                                <select name="estado" class="form-select">
                                    <option value="PENDIENTE" <%= r.getEstado().equals("PENDIENTE") ? "selected" : "" %>>⏳ PENDIENTE</option>
                                    <option value="PAGADO" <%= r.getEstado().equals("PAGADO") ? "selected" : "" %>>✅ PAGADO</option>
                                </select>
                            </div>
                        </div>
                        
                        <!-- Conceptos Personalizados -->
                        <div class="mt-4">
                            <hr>
                            <h5 class="text-primary">
                                <i class="bi bi-tags me-2"></i>Conceptos Personalizados
                            </h5>
                            
                            <div class="table-responsive mb-3">
                                <table class="table table-sm table-hover">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Concepto</th>
                                            <th>Monto</th>
                                            <th style="width: 50px"></th>
                                        </tr>
                                    </thead>
                                    <tbody id="conceptosTable">
                                        <%
                                            if (conceptosPersonalizados != null && !conceptosPersonalizados.isEmpty()) {
                                                for (Object[] c : conceptosPersonalizados) {
                                        %>
                                        <tr id="concepto-<%= c[0] %>">
                                            <td><%= c[1] %></td>
                                            <td>$ <%= String.format("%,.2f", (double) c[2]) %></td>
                                            <td>
                                                <button type="button" class="btn btn-danger btn-sm" 
                                                        onclick="eliminarConcepto(<%= c[0] %>, <%= r.getId() %>)">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                        <%
                                                }
                                            } else {
                                        %>
                                        <tr id="sinConceptos">
                                            <td colspan="3" class="text-center text-muted">
                                                No hay conceptos personalizados agregados
                                            </td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                            
                            <!-- Formulario para agregar nuevo concepto -->
                            <div class="row g-2 align-items-end">
                                <div class="col-md-6">
                                    <label class="form-label small fw-semibold">Nuevo Concepto</label>
                                    <input type="text" id="nuevoConceptoNombre" class="form-control" placeholder="Ej: Parqueadero, Administración...">
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label small fw-semibold">Monto</label>
                                    <div class="input-group">
                                        <span class="input-group-text">$</span>
                                        <input type="number" step="0.01" id="nuevoConceptoMonto" class="form-control" placeholder="0.00">
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <button type="button" class="btn btn-success w-100" onclick="agregarConcepto(<%= r.getId() %>)">
                                        <i class="bi bi-plus-circle"></i> Agregar
                                    </button>
                                </div>
                            </div>
                        </div>
                        
                        <div class="d-flex gap-3 mt-4">
                            <button type="submit" class="btn btn-primary flex-grow-1">
                                <i class="bi bi-save me-2"></i>Actualizar Recibo
                            </button>
                            <a href="${pageContext.request.contextPath}/recibo?accion=listar" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left me-2"></i>Cancelar
                            </a>
                        </div>
                    </form>
                </div>
            </div>
            

<script>
    function actualizarPreview() {
        var renta = parseFloat(document.getElementById('renta').value) || 0;
        var agua = parseFloat(document.getElementById('agua').value) || 0;
        var luz = parseFloat(document.getElementById('luz').value) || 0;
        var porteria = parseFloat(document.getElementById('porteria').value) || 0;
        var otros = parseFloat(document.getElementById('otros').value) || 0;
        var ipcPercent = 2.5 ;
        var ivaPercent = 19 ;
        
        // Sumar conceptos personalizados existentes
        var conceptosPersonalizadosTotal = 0;
        var conceptosRows = document.querySelectorAll('#conceptosTable tr:not(#sinConceptos)');
        conceptosRows.forEach(function(row) {
            var montoCell = row.cells[1];
            if (montoCell) {
                var montoTexto = montoCell.innerText.replace('$', '').replace(/,/g, '').trim();
                var monto = parseFloat(montoTexto) || 0;
                conceptosPersonalizadosTotal += monto;
            }
        });
        
        var incrementoIPC = renta * (ipcPercent / 100);
        var valorIVA = renta * (ivaPercent / 100);
        var servicios = agua + luz + porteria;
        var total = renta + incrementoIPC + valorIVA + servicios + otros + conceptosPersonalizadosTotal;
        
        document.getElementById('previewRenta').innerText = renta.toFixed(2);
        document.getElementById('previewIPCPercent').innerText = ipcPercent;
        document.getElementById('previewIPC').innerText = incrementoIPC.toFixed(2);
        document.getElementById('previewIVA').innerText = valorIVA.toFixed(2);
        document.getElementById('previewServicios').innerText = servicios.toFixed(2);
        document.getElementById('previewOtros').innerText = otros.toFixed(2);
        document.getElementById('previewConceptosPersonalizados').innerText = conceptosPersonalizadosTotal.toFixed(2);
        document.getElementById('previewTotal').innerText = total.toFixed(2);
    }
    
    // Asignar IDs a los campos
    document.addEventListener('DOMContentLoaded', function() {
        var campos = ['renta', 'agua', 'luz', 'porteria', 'otros'];
        campos.forEach(function(campo) {
            var el = document.querySelector('[name="' + campo + '"]');
            if (el) el.id = campo;
        });
        
        // Agregar eventos
        campos.forEach(function(campo) {
            var el = document.getElementById(campo);
            if (el) el.addEventListener('input', actualizarPreview);
        });
        
        actualizarPreview();
    });
</script>                                
                                
            <div class="card mt-4">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <strong>Número de Recibo (Único por unidad):</strong>
                            <span class="font-monospace text-primary fw-bold"><%= r.getNumeroRecibo() != null ? r.getNumeroRecibo() : "Pendiente de generar" %></span>
                            <br><small class="text-muted">Formato: EDIFICIO-TIPO-PLANTA-LETRA-CORRELATIVO</small>
                        </div>
                        <div class="col-md-6">
                            <strong>Total Actual:</strong>
                            <span class="text-success fw-bold">$ <%= String.format("%,.2f", r.getTotal()) %></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function agregarConcepto(reciboId) {
        var nombre = document.getElementById('nuevoConceptoNombre').value;
        var monto = document.getElementById('nuevoConceptoMonto').value;
        
        if (!nombre || !monto) {
            alert('Por favor complete el nombre y el monto del concepto');
            return;
        }
        
        if (parseFloat(monto) <= 0) {
            alert('El monto debe ser mayor a 0');
            return;
        }
        
        window.location.href = '${pageContext.request.contextPath}/recibo?accion=agregarConcepto&reciboId=' + reciboId + 
                               '&nombre=' + encodeURIComponent(nombre) + '&monto=' + monto;
    }
    
    function eliminarConcepto(conceptoId, reciboId) {
        if (confirm('¿Está seguro de eliminar este concepto?')) {
            window.location.href = '${pageContext.request.contextPath}/recibo?accion=eliminarConcepto&conceptoId=' + 
                                   conceptoId + '&reciboId=' + reciboId;
        }
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>