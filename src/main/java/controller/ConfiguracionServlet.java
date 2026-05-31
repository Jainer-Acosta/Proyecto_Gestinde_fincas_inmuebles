package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.dao.ReciboDAO;
import java.io.IOException;

@WebServlet("/configuracion")
public class ConfiguracionServlet extends HttpServlet {
    
    private final ReciboDAO reciboDAO = new ReciboDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Obtener IVA actual
        double ivaActual = reciboDAO.obtenerIVA();
        request.setAttribute("ivaActual", ivaActual);
        
        request.getRequestDispatcher("views/recibo/configurar_parametros.jsp")
               .forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        if ("actualizarIVA".equals(accion)) {
            try {
                double iva = Double.parseDouble(request.getParameter("iva"));
                if (reciboDAO.actualizarIVA(iva)) {
                    request.setAttribute("mensaje", "IVA actualizado correctamente a " + iva + "%");
                } else {
                    request.setAttribute("error", "Error al actualizar el IVA");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Formato de número inválido");
            }
            
        } else if ("actualizarIPC".equals(accion)) {
            try {
                int anio = Integer.parseInt(request.getParameter("anio"));
                double ipc = Double.parseDouble(request.getParameter("ipc"));
                if (reciboDAO.actualizarIPC(anio, ipc)) {
                    request.setAttribute("mensaje", "IPC actualizado para " + anio + " a " + ipc + "%");
                } else {
                    request.setAttribute("error", "Error al actualizar el IPC");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Formato de número inválido");
            }
        }
        
        // Recargar la página con los mensajes
        double ivaActual = reciboDAO.obtenerIVA();
        request.setAttribute("ivaActual", ivaActual);
        request.getRequestDispatcher("views/recibo/configurar_parametros.jsp")
               .forward(request, response);
    }
}