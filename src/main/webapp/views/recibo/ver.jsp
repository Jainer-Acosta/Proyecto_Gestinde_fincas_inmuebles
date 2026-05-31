<%@page import="java.util.List"%>
<%@page import="model.dao.ReciboDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Factura Recibo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <style>
        @media print {
            .no-print {
                display: none;
            }
            .factura-card {
                box-shadow: none;
                border: 1px solid #ddd;
            }
            body {
                background: white;
                padding: 0;
                margin: 0;
            }
        }
        
        /* Estilos para el PDF */
        .factura-card {
            background: white;
        }
    </style>
    <!-- Incluir html2pdf library -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js" integrity="sha512-GsLlZN/3F2ErC5ifS5QtgpiJtWd43JWSuIgh7mbzZ8zBps+dvLusV+eNQATqgA/HdeKFVgA5v3S/cIrLF7QnIg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>
<body class="bg-light">

<%
    Object[] r = (Object[]) request.getAttribute("recibo");
    List<Object[]> conceptosPersonalizados = (List<Object[]>) request.getAttribute("conceptosPersonalizados");
    
    // Obtener valores de configuración
    ReciboDAO reciboDAO = new ReciboDAO();
    double ivaPorcentaje = reciboDAO.obtenerIVA();
    
    // Obtener año del recibo para el IPC
    java.sql.Date fechaEmision = (java.sql.Date) r[7];
    java.util.Calendar cal = java.util.Calendar.getInstance();
    cal.setTime(fechaEmision);
    int anioRecibo = cal.get(java.util.Calendar.YEAR);
    double ipcPorcentaje = reciboDAO.obtenerIPC(anioRecibo);
    
    // Si no hay IPC configurado, usar 0
    if (ipcPorcentaje <= 0) {
        ipcPorcentaje = 0;
    }
    
    // Valores del recibo
    double renta = Double.parseDouble(r[8].toString());
    double agua = Double.parseDouble(r[9].toString());
    double luz = Double.parseDouble(r[10].toString());
    double porteria = Double.parseDouble(r[12].toString());
    double otros = Double.parseDouble(r[14].toString());
    
    // Cálculos
    double incrementoIPC = renta * (ipcPorcentaje / 100);
    double valorIVA = renta * (ivaPorcentaje / 100);
    double servicios = agua + luz + porteria;
    
    // Sumar conceptos personalizados
    double totalConceptosPersonalizados = 0;
    if (conceptosPersonalizados != null && !conceptosPersonalizados.isEmpty()) {
        for (Object[] c : conceptosPersonalizados) {
            totalConceptosPersonalizados += (double) c[2];
        }
    }
    
    // Total correcto
    double totalCorrecto = renta + incrementoIPC + valorIVA + servicios + otros + totalConceptosPersonalizados;
    
    // Extraer información del número de recibo para mostrar el desglose
    String numeroReciboCompleto = r[0].toString();
    String formatoExplicacion = "";
    if (numeroReciboCompleto != null && !numeroReciboCompleto.equals("No asignado")) {
        String[] partes = numeroReciboCompleto.split("-");
        if (partes.length >= 4) {
            formatoExplicacion = "Formato: " + partes[0] + " (Edificio) - " + partes[1] + " (Tipo) - " + partes[2] + " (Ubicación) - " + partes[3] + " (N° consecutivo)";
        }
    }
%>

<div class="container py-4" id="reciboContainer">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-7">
            <!-- Botones (no se imprimen) -->
            <div class="no-print mb-3 text-end">
                <button onclick="window.print()" class="btn btn-primary">
                    <i class="bi bi-printer me-2"></i>Imprimir Recibo
                </button>
                <button onclick="descargarPDF()" class="btn btn-danger ms-2">
                    <i class="bi bi-file-pdf me-2"></i>Descargar PDF
                </button>
                <a href="${pageContext.request.contextPath}/views/dashboard/dashboard.jsp" class="btn btn-outline-secondary ms-2">
                    <i class="bi bi-arrow-left me-2"></i>Volver
                </a>
            </div>
            
            <!-- Factura (lo que se va a convertir a PDF) -->
            <div id="facturaContent" class="card shadow-lg border-0 factura-card">
                <div class="card-header bg-primary text-white text-center py-4">
                    <i class="bi bi-receipt fs-1"></i>
                    <h1 class="h3 mb-0 mt-2">RECIBO DE PAGO</h1>
                    <p class="mb-0 mt-2 small">Documento de cobro para arrendamiento</p>
                </div>
                
                <div class="card-body p-4">
                    <!-- Información del recibo - NÚMERO ÚNICO POR PISO/LOCAL -->
                    <div class="row mb-4">
                        <div class="col-sm-12 text-center mb-3">
                            <div class="bg-light p-3 rounded">
                                <p class="mb-1"><strong class="text-primary">N° RECIBO (ÚNICO POR PISO/LOCAL):</strong></p>
                                <p class="fs-2 fw-bold font-monospace mb-1"><%= r[0]%></p>
                                <small class="text-muted">
                                    <i class="bi bi-info-circle"></i> 
                                    Este número identifica de forma permanente a esta unidad<br>
                                    <%= formatoExplicacion %>
                                </small>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <p class="mb-1"><strong class="text-primary">FECHA EMISIÓN:</strong></p>
                            <p class="fs-5"><%= r[7]%></p>
                        </div>
                        <div class="col-sm-6 text-sm-end">
                            <p class="mb-1"><strong class="text-primary">ESTADO:</strong></p>
                            <%
                                String estadoFactura = r[16].toString();
                                String estadoBadgeFactura = estadoFactura.equals("PAGADO") ? "bg-success" : "bg-warning";
                            %>
                            <span class="badge <%= estadoBadgeFactura %> fs-6 px-3 py-2">
                                <i class="bi bi-<%= estadoFactura.equals("PAGADO") ? "check-circle" : "clock" %> me-1"></i>
                                <%= estadoFactura %>
                            </span>
                        </div>
                    </div>
                    
                    <hr>
                    
                    <!-- Datos de la unidad (importante para mostrar qué piso/local) -->
                    <div class="mb-4">
                        <h5 class="text-primary">
                            <i class="bi bi-building me-2"></i>Datos de la Unidad
                        </h5>
                        <div class="row">
                            <div class="col-md-6">
                                <p class="mb-1"><strong>Edificio:</strong> <%= r[3]%></p>
                                <p class="mb-1"><strong>Tipo:</strong> <%= r[4]%></p>
                            </div>
                            <div class="col-md-6">
                                <p class="mb-1"><strong>Planta:</strong> <%= r[5]%></p>
                                <p class="mb-1"><strong>Letra/Número:</strong> <%= r[6]%></p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Datos del inquilino -->
                    <div class="mb-4">
                        <h5 class="text-primary">
                            <i class="bi bi-person me-2"></i>Datos del Inquilino
                        </h5>
                        <p class="mb-1"><strong>Nombre:</strong> <%= r[1]%> <%= r[2]%></p>
                        <p class="mb-1"><strong>Dirección de la unidad:</strong> <%= r[3]%> - <%= r[4]%> - Planta <%= r[5]%>, Letra <%= r[6]%></p>
                    </div>
                    
                    <hr>
                    
                    <!-- Detalle de conceptos -->
                    <h5 class="text-primary mb-3">
                        <i class="bi bi-list-ul me-2"></i>Detalle de Conceptos
                    </h5>

                    <!-- Renta Base -->
                    <div class="row mb-2">
                        <div class="col-8">Renta Base</div>
                        <div class="col-4 text-end">$ <%= String.format("%,.2f", renta) %></div>
                    </div>

                    <!-- IPC (actualización anual) -->
                    <% if (ipcPorcentaje > 0 && incrementoIPC > 0) { %>
                    <div class="row mb-2">
                        <div class="col-8">IPC (<%= String.format("%.2f", ipcPorcentaje) %>% anual)</div>
                        <div class="col-4 text-end">$ <%= String.format("%,.2f", incrementoIPC) %></div>
                    </div>
                    <% } %>

                    <!-- IVA -->
                    <% if (ivaPorcentaje > 0 && valorIVA > 0) { %>
                    <div class="row mb-2">
                        <div class="col-8">IVA (<%= String.format("%.2f", ivaPorcentaje) %>% sobre renta)</div>
                        <div class="col-4 text-end">$ <%= String.format("%,.2f", valorIVA) %></div>
                    </div>
                    <% } %>

                    <!-- Servicios -->
                    <% if (agua > 0) { %>
                    <div class="row mb-2">
                        <div class="col-8">Agua</div>
                        <div class="col-4 text-end">$ <%= String.format("%,.2f", agua) %></div>
                    </div>
                    <% } %>

                    <% if (luz > 0) { %>
                    <div class="row mb-2">
                        <div class="col-8">Luz</div>
                        <div class="col-4 text-end">$ <%= String.format("%,.2f", luz) %></div>
                    </div>
                    <% } %>

                    <% if (porteria > 0) { %>
                    <div class="row mb-2">
                        <div class="col-8">Portería</div>
                        <div class="col-4 text-end">$ <%= String.format("%,.2f", porteria) %></div>
                    </div>
                    <% } %>

                    <!-- Otros -->
                    <% if (otros > 0) { %>
                    <div class="row mb-2">
                        <div class="col-8">Otros</div>
                        <div class="col-4 text-end">$ <%= String.format("%,.2f", otros) %></div>
                    </div>
                    <% } %>

                    <!-- Conceptos Personalizados -->
                    <%
                        if (conceptosPersonalizados != null && !conceptosPersonalizados.isEmpty()) {
                            for (Object[] c : conceptosPersonalizados) {
                                double montoConcepto = (double) c[2];
                                if (montoConcepto > 0) {
                    %>
                    <div class="row mb-2">
                        <div class="col-8"><i class="bi bi-tag me-1"></i> <%= c[1] %></div>
                        <div class="col-4 text-end">$ <%= String.format("%,.2f", montoConcepto) %></div>
                    </div>
                    <%
                                }
                            }
                        }
                    %>

                    <hr class="border-2">

                    <!-- Total -->
                    <div class="row mb-3">
                        <div class="col-8">
                            <h4 class="fw-bold text-primary">TOTAL A PAGAR</h4>
                        </div>
                        <div class="col-4 text-end">
                            <h4 class="fw-bold text-success">$ <%= String.format("%,.2f", totalCorrecto) %></h4>
                        </div>
                    </div>
                    
                    <!-- Pie de factura -->
                    <div class="row mt-3 text-muted small">
                        <div class="col-12 text-center">
                            <hr>
                            <span><i class="bi bi-receipt"></i> Recibo generado por Sistema Gestión Inmobiliaria</span><br>
                            <span><i class="bi bi-info-circle"></i> Este número de recibo es permanente para esta unidad: <strong><%= r[0]%></strong></span>
                        </div>
                    </div>
                    
                    <!-- Estado detallado -->
                    <div class="text-center mt-4">
                        <% if (estadoFactura.equals("PAGADO")) { %>
                            <div class="text-center mt-3 text-success">
                                <i class="bi bi-stamp fs-1"></i>
                                <p class="mb-0"><strong>PAGADO</strong> - Recibo válido como comprobante de pago</p>
                                <small>Fecha de pago: <%= r[7]%></small>
                            </div>
                        <% } else { %>
                            <div class="text-center mt-3 text-muted">
                                <i class="bi bi-hourglass-split fs-1"></i>
                                <p class="mb-0">Este recibo está pendiente de pago</p>
                                <small>Por favor realizar el pago antes de la fecha de vencimiento</small>
                            </div>
                        <% } %>
                    </div>
                </div>
                
                <div class="card-footer text-center text-muted py-3">
                    <i class="bi bi-c-circle me-1"></i> Sistema Gestión Inmobiliaria
                    <br>
                    <small>Este documento es un comprobante válido. N° Recibo Único: <%= r[0]%></small>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function descargarPDF() {
        // Obtener el elemento que queremos convertir a PDF
        const element = document.getElementById('facturaContent');
        
        // Configuración del PDF
        const opt = {
            margin: [0.5, 0.5, 0.5, 0.5], // márgenes en pulgadas
            filename: 'recibo_<%= r[0] %>.pdf',
            image: { type: 'jpeg', quality: 0.98 },
            html2canvas: { scale: 2, useCORS: true, letterRendering: true },
            jsPDF: { unit: 'in', format: 'a4', orientation: 'portrait' }
        };
        
        // Generar y descargar PDF
        html2pdf().set(opt).from(element).save();
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>