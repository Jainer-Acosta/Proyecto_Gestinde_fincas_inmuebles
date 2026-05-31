package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.dao.ReciboDAO;

@WebServlet("/pdf-recibo")
public class PdfReciboServlet extends HttpServlet {
    
    private final ReciboDAO reciboDAO = new ReciboDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        Object[] recibo = reciboDAO.obtenerDetalleRecibo(id);
        
        if (recibo == null) {
            response.sendRedirect("recibo?accion=listar");
            return;
        }
        
        response.setContentType("text/html");
        response.getWriter().write(generarHTMLRecibo(recibo));
    }
    
    private String generarHTMLRecibo(Object[] r) {
        StringBuilder html = new StringBuilder();
        html.append("<!DOCTYPE html><html><head>");
        html.append("<meta charset='UTF-8'><title>Recibo #").append(r[0]).append("</title>");
        html.append("<style>");
        html.append("body { font-family: Arial, sans-serif; margin: 20px; }");
        html.append(".recibo { max-width: 800px; margin: 0 auto; border: 1px solid #ddd; padding: 20px; }");
        html.append(".header { text-align: center; border-bottom: 2px solid #333; padding-bottom: 10px; }");
        html.append(".total { font-size: 24px; font-weight: bold; color: green; text-align: right; }");
        html.append(".concepto { display: flex; justify-content: space-between; padding: 5px 0; }");
        html.append(".estado { text-align: center; padding: 10px; margin-top: 20px; }");
        html.append("@media print { .no-print { display: none; } body { margin: 0; } }");
        html.append("</style></head><body>");
        
        html.append("<div class='recibo'>");
        html.append("<div class='header'>");
        html.append("<h1>RECIBO DE PAGO</h1>");
        html.append("<p><strong>N° Recibo:</strong> #").append(r[0]).append("</p>");
        html.append("<p><strong>Fecha Emisión:</strong> ").append(r[7]).append("</p>");
        html.append("</div>");
        
        html.append("<h3>Datos del Inquilino</h3>");
        html.append("<p><strong>Nombre:</strong> ").append(r[1]).append(" ").append(r[2]).append("</p>");
        html.append("<p><strong>Dirección:</strong> ").append(r[3]).append("</p>");
        
        html.append("<h3>Detalle de Conceptos</h3>");
        
        double[] montos = {Double.parseDouble(r[8].toString()), 
                          Double.parseDouble(r[9].toString()),
                          Double.parseDouble(r[10].toString()),
                          Double.parseDouble(r[11].toString()),
                          Double.parseDouble(r[12].toString()),
                          Double.parseDouble(r[13].toString()),
                          Double.parseDouble(r[14].toString())};
        String[] conceptos = {"Renta", "Agua", "Luz", "IVA", "Portería", "IPC", "Otros"};
        
        for (int i = 0; i < conceptos.length; i++) {
            if (montos[i] > 0) {
                html.append("<div class='concepto'>");
                html.append("<span>").append(conceptos[i]).append("</span>");
                html.append("<span>$ ").append(String.format("%,.2f", montos[i])).append("</span>");
                html.append("</div>");
            }
        }
        
        html.append("<hr>");
        html.append("<div class='total'>TOTAL: $ ").append(String.format("%,.2f", Double.parseDouble(r[15].toString()))).append("</div>");
        
        String estado = r[16].toString();
        String estadoClass = estado.equals("PAGADO") ? "color: green;" : "color: orange;";
        html.append("<div class='estado' style='").append(estadoClass).append("'>");
        html.append("<strong>").append(estado.equals("PAGADO") ? "PAGADO ✓" : "PENDIENTE ⏳").append("</strong>");
        html.append("</div>");
        
        html.append("</div>");
        html.append("<div class='no-print' style='text-align:center; margin-top:20px;'>");
        html.append("<button onclick='window.print()' style='padding:10px 20px;'>🖨️ Imprimir</button>");
        html.append(" <button onclick='window.close()' style='padding:10px 20px;'>✖️ Cerrar</button>");
        html.append("</div>");
        html.append("</body></html>");
        
        return html.toString();
    }
}