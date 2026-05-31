<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.entity.Recibo"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrar Recibo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-7">
            <div class="card shadow-lg border-0">
                <div class="card-header bg-primary text-white py-3">
                    <h2 class="h4 mb-0">
                        <i class="bi bi-receipt me-2"></i>Registrar Recibo
                    </h2>
                </div>
                
                <div class="card-body p-4">
                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger alert-dismissible fade show">
                            <i class="bi bi-exclamation-triangle me-2"></i> <%= request.getAttribute("error") %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    <% } %>
                    
                    <form action="${pageContext.request.contextPath}/recibo" method="post" id="reciboForm">
                        <input type="hidden" name="accion" value="guardar">
                        
                        <!-- Alquiler -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-file-text me-1 text-primary"></i>Alquiler
                            </label>
                            <select name="alquilerId" class="form-select" required>
                                <option value="" disabled selected>-- Seleccione un alquiler --</option>
                                <%
                                    List<Object[]> alquileres = (List<Object[]>) request.getAttribute("alquileres");
                                    if (alquileres != null) {
                                        for(Object[] a : alquileres){
                                %>
                                <option value="<%= a[0]%>">
                                    👤 <%= a[1]%> <%= a[2]%> - 🏢 <%= a[3]%> - 📋 <%= a[4]%>
                                </option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                        
                        <!-- Fecha Emisión -->
                        <div class="mb-4">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-calendar3 me-1 text-primary"></i>Fecha Emisión
                            </label>
                            <input type="date" name="fechaEmision" id="fechaEmision" class="form-control" required>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-cash me-1 text-danger"></i>Renta * (Obligatorio)
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text">$</span>
                                    <input type="number" step="0.01" name="renta" id="renta" class="form-control" value="0" required>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-droplet me-1 text-primary"></i>Agua
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text">$</span>
                                    <input type="number" step="0.01" name="agua" id="agua" class="form-control" value="0">
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
                                    <input type="number" step="0.01" name="luz" id="luz" class="form-control" value="0">
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-person-walking me-1 text-primary"></i>Portería
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text">$</span>
                                    <input type="number" step="0.01" name="porteria" id="porteria" class="form-control" value="0">
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
                                    <input type="number" step="0.01" name="otros" id="otros" class="form-control" value="0">
                                </div>
                            </div>
                        </div>
                        
                        <div class="alert alert-info">
                            <i class="bi bi-info-circle me-2"></i>
                            <strong>Nota:</strong> El IVA (19%) y el IPC (según el año) se aplicarán automáticamente.
                            <br>La renta es el único concepto obligatorio.
                        </div>
                        
                        <!-- Desglose del Cálculo en tiempo real -->
                        <div class="card mt-3 bg-light">
                            <div class="card-header bg-secondary text-white">
                                <h6 class="mb-0"><i class="bi bi-calculator me-2"></i>Desglose del Cálculo</h6>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <table class="table table-sm table-borderless">
                                            <tr>
                                                <td>Renta Base:</td>
                                                <td class="text-end">$ <span id="previewRenta">0.00</span></td>
                                            </tr>
                                            <tr>
                                                <td>IPC (<span id="previewIPCPercent">0</span>%):</td>
                                                <td class="text-end">$ <span id="previewIPC">0.00</span></td>
                                            </tr>
                                            <tr>
                                                <td>IVA (<span id="previewIVAPercent">0</span>% sobre renta):</td>
                                                <td class="text-end">$ <span id="previewIVA">0.00</span></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="col-md-6">
                                        <table class="table table-sm table-borderless">
                                            <tr>
                                                <td>Servicios (Agua+Luz+Portería):</td>
                                                <td class="text-end">$ <span id="previewServicios">0.00</span></td>
                                            </tr>
                                            <tr>
                                                <td>Otros conceptos:</td>
                                                <td class="text-end">$ <span id="previewOtros">0.00</span></td>
                                            </tr>
                                            <tr class="table-active">
                                                <td><strong>TOTAL A PAGAR:</strong></td>
                                                <td class="text-end"><strong>$ <span id="previewTotal">0.00</span></strong></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="d-flex gap-3 mt-4">
                            <button type="submit" class="btn btn-success flex-grow-1">
                                <i class="bi bi-save me-2"></i>Generar Recibo
                            </button>
                            <a href="${pageContext.request.contextPath}/recibo?accion=listar" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left me-2"></i>Cancelar
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Valores fijos (deberían obtenerse del servidor)
    var ivaPorcentaje = 19.0;
    var ipcPorcentaje = 2.5;
    
    function actualizarPreview() {
        var renta = parseFloat(document.getElementById('renta').value) || 0;
        var agua = parseFloat(document.getElementById('agua').value) || 0;
        var luz = parseFloat(document.getElementById('luz').value) || 0;
        var porteria = parseFloat(document.getElementById('porteria').value) || 0;
        var otros = parseFloat(document.getElementById('otros').value) || 0;
        
        var incrementoIPC = renta * (ipcPorcentaje / 100);
        var valorIVA = renta * (ivaPorcentaje / 100);
        var servicios = agua + luz + porteria;
        var total = renta + incrementoIPC + valorIVA + servicios + otros;
        
        document.getElementById('previewRenta').innerText = renta.toFixed(2);
        document.getElementById('previewIPCPercent').innerText = ipcPorcentaje;
        document.getElementById('previewIPC').innerText = incrementoIPC.toFixed(2);
        document.getElementById('previewIVAPercent').innerText = ivaPorcentaje;
        document.getElementById('previewIVA').innerText = valorIVA.toFixed(2);
        document.getElementById('previewServicios').innerText = servicios.toFixed(2);
        document.getElementById('previewOtros').innerText = otros.toFixed(2);
        document.getElementById('previewTotal').innerText = total.toFixed(2);
    }
    
    // Agregar eventos a los campos
    document.addEventListener('DOMContentLoaded', function() {
        var campos = ['renta', 'agua', 'luz', 'porteria', 'otros'];
        campos.forEach(function(campo) {
            var el = document.getElementById(campo);
            if (el) {
                el.addEventListener('input', actualizarPreview);
            }
        });
        actualizarPreview();
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>