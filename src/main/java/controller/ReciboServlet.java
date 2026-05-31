/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import model.dao.AlquilerDAO;
import model.dao.ReciboDAO;
import model.entity.Recibo;

@WebServlet("/recibo")
public class ReciboServlet extends HttpServlet {

    private final ReciboDAO reciboDAO = new ReciboDAO();
    private final AlquilerDAO alquilerDAO = new AlquilerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        switch (accion) {
            case "nuevo":
                nuevo(request, response);
                break;
            case "listar":
                listar(request, response);
                break;
            case "generar":
                generarMensuales(request, response);
                break;
            case "pendientes":
                pendientes(request, response);
                break;
            case "pagados":
                pagados(request, response);
                break;
            case "reporte":
                reporte(request, response);
                break;
            case "filtrar":
                filtrar(request, response);
                break;
            case "clonar":
                clonarRecibos(request, response);
                break;
            case "clonarMesAnterior":
                clonarMesAnterior(request, response);
                break;
            case "configurarIPC":
                configurarIPC(request, response);
                break;
            case "agregarConcepto":
                agregarConcepto(request, response);
                break;
            case "eliminarConcepto":
                eliminarConcepto(request, response);
                break;
            case "ver":
                verPorNumeroRecibo(request, response);
                break;
            case "editar":
                editarPorNumeroRecibo(request, response);
                break;
            case "pagar":
                pagarPorNumeroRecibo(request, response);
                break;
                
            case "gananciasEdificio":
                gananciasEdificio(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        switch (accion) {
            case "guardar":
                guardar(request, response);
                break;
            case "actualizar":
                actualizar(request, response);
                break;
        }
    }

    private void nuevo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Object[]> alquileres = alquilerDAO.listarActivos();
        request.setAttribute("alquileres", alquileres);
        request.getRequestDispatcher("views/recibo/registrar.jsp").forward(request, response);
    }

    private void guardar(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        double renta = Double.parseDouble(request.getParameter("renta"));
        if (renta <= 0) {
            request.setAttribute("error", "La renta es un concepto obligatorio y debe ser mayor a 0");
            nuevo(request, response);
            return;
        }
        
        Recibo r = new Recibo();
        r.setAlquilerId(Integer.parseInt(request.getParameter("alquilerId")));
        Date fechaEmision = Date.valueOf(request.getParameter("fechaEmision"));
        r.setFechaEmision(fechaEmision);
        
        java.util.Calendar cal = java.util.Calendar.getInstance();
        cal.setTime(fechaEmision);
        int anio = cal.get(java.util.Calendar.YEAR);
        
        double agua = Double.parseDouble(request.getParameter("agua"));
        double luz = Double.parseDouble(request.getParameter("luz"));
        double porteria = Double.parseDouble(request.getParameter("porteria"));
        double otros = Double.parseDouble(request.getParameter("otros"));
        
        double ipcPorcentaje = reciboDAO.obtenerIPC(anio);
        double ivaPorcentaje = reciboDAO.obtenerIVA();
        
        double incrementoIPC = renta * (ipcPorcentaje / 100);
        double valorIVA = renta * (ivaPorcentaje / 100);
        double servicios = agua + luz + porteria;
        double total = renta + incrementoIPC + valorIVA + servicios + otros;
        
        r.setRenta(renta);
        r.setAgua(agua);
        r.setLuz(luz);
        r.setIva(ivaPorcentaje);
        r.setPorteria(porteria);
        r.setIpc(ipcPorcentaje);
        r.setOtros(otros);
        r.setTotal(total);
        r.setEstado("PENDIENTE");
        
        String numeroRecibo = reciboDAO.generarNumeroRecibo(r.getAlquilerId());
        r.setNumeroRecibo(numeroRecibo);
        reciboDAO.guardar(r);
        response.sendRedirect("recibo?accion=listar");
    }

    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Object[]> lista = reciboDAO.listar();
        request.setAttribute("listaRecibos", lista);
        request.getRequestDispatcher("views/recibo/listar.jsp").forward(request, response);
    }

    private void generarMensuales(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        reciboDAO.generarRecibosMensuales();
        response.sendRedirect("recibo?accion=listar");
    }

    private void pendientes(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Object[]> lista = reciboDAO.listarPendientes();
        request.setAttribute("listaPendientes", lista);
        request.getRequestDispatcher("views/recibo/pendientes.jsp").forward(request, response);
    }

    private void pagados(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Object[]> lista = reciboDAO.listarPagados();
        request.setAttribute("listaPagados", lista);
        request.getRequestDispatcher("views/recibo/pagados.jsp").forward(request, response);
    }

    private void reporte(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String estado = request.getParameter("estado");
        String desde = request.getParameter("desde");
        String hasta = request.getParameter("hasta");
        if (estado != null && desde != null && hasta != null) {
            List<Object[]> lista = reciboDAO.listarPorEstadoYFecha(estado, desde, hasta);
            request.setAttribute("listaReporte", lista);
        }
        request.getRequestDispatcher("views/recibo/reporte.jsp").forward(request, response);
    }

    private void filtrar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String estado = request.getParameter("estado");
        Date inicio = Date.valueOf(request.getParameter("inicio"));
        Date fin = Date.valueOf(request.getParameter("fin"));
        List<Object[]> lista = reciboDAO.filtrarRecibos(estado, inicio, fin);
        request.setAttribute("listaRecibos", lista);
        request.getRequestDispatcher("views/recibo/listar.jsp").forward(request, response);
    }

    private void clonarRecibos(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException {
        String mesOrigenParam = request.getParameter("mes");
        String anioOrigenParam = request.getParameter("anio");
        String mesDestinoParam = request.getParameter("mesDestino");
        String anioDestinoParam = request.getParameter("anioDestino");
        
        if (mesOrigenParam != null && anioOrigenParam != null && mesDestinoParam != null && anioDestinoParam != null) {
            try {
                int mesOrigen = Integer.parseInt(mesOrigenParam);
                int anioOrigen = Integer.parseInt(anioOrigenParam);
                int mesDestino = Integer.parseInt(mesDestinoParam);
                int anioDestino = Integer.parseInt(anioDestinoParam);
                int count = reciboDAO.contarRecibosPorMes(mesOrigen, anioOrigen);
                if (count == 0) {
                    request.setAttribute("error", "No hay recibos en " + obtenerNombreMes(mesOrigen) + " de " + anioOrigen + " para clonar");
                } else {
                    boolean exito = reciboDAO.generarRecibosClonandoMes(mesOrigen, anioOrigen, mesDestino, anioDestino);
                    if (exito) {
                        request.setAttribute("mensaje", "Se clonaron " + count + " recibos desde " + 
                                            obtenerNombreMes(mesOrigen) + " de " + anioOrigen + " hacia " + 
                                            obtenerNombreMes(mesDestino) + " de " + anioDestino);
                    } else {
                        request.setAttribute("error", "No se pudieron generar los recibos. Ya existen recibos para " + 
                                            obtenerNombreMes(mesDestino) + " de " + anioDestino);
                    }
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Error en los parámetros de fecha");
            }
        } else {
            request.setAttribute("error", "Debe seleccionar mes y año origen y destino");
        }
        listar(request, response);
    }

    private void clonarMesAnterior(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException {
        java.util.Calendar cal = java.util.Calendar.getInstance();
        int mesActual = cal.get(java.util.Calendar.MONTH) + 1;
        int anioActual = cal.get(java.util.Calendar.YEAR);
        int mesOrigen = mesActual == 1 ? 12 : mesActual - 1;
        int anioOrigen = mesActual == 1 ? anioActual - 1 : anioActual;
        int count = reciboDAO.contarRecibosPorMes(mesOrigen, anioOrigen);
        if (count == 0) {
            request.setAttribute("error", "No hay recibos en " + obtenerNombreMes(mesOrigen) + " de " + anioOrigen + " para clonar");
        } else {
            boolean exito = reciboDAO.generarRecibosClonandoMes(mesOrigen, anioOrigen, mesActual, anioActual);
            if (exito) {
                request.setAttribute("mensaje", "Recibos generados exitosamente para " + 
                                    obtenerNombreMes(mesActual) + " de " + anioActual +
                                    " copiando desde " + obtenerNombreMes(mesOrigen) + " de " + anioOrigen);
            } else {
                request.setAttribute("error", "No se pudieron generar los recibos. Ya existen recibos para " + 
                                    obtenerNombreMes(mesActual) + " de " + anioActual);
            }
        }
        listar(request, response);
    }

    private String obtenerNombreMes(int mes) {
        String[] meses = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", 
                          "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};
        return meses[mes - 1];
    }

    private void configurarIPC(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String anioParam = request.getParameter("anio");
        String valorParam = request.getParameter("valor");
        if (anioParam != null && valorParam != null) {
            try {
                int anio = Integer.parseInt(anioParam);
                double valor = Double.parseDouble(valorParam);
                if (reciboDAO.actualizarIPC(anio, valor)) {
                    request.setAttribute("mensaje", "IPC para el año " + anio + " actualizado a " + valor + "%");
                } else {
                    request.setAttribute("error", "Error al actualizar el IPC");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Formato de número inválido");
            }
        }
        request.getRequestDispatcher("views/recibo/configurar_ipc.jsp").forward(request, response);
    }

    private void agregarConcepto(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        int reciboId = Integer.parseInt(request.getParameter("reciboId"));
        String nombre = request.getParameter("nombre");
        double monto = Double.parseDouble(request.getParameter("monto"));
        reciboDAO.agregarConceptoPersonalizado(reciboId, nombre, monto);
        
        Recibo recibo = reciboDAO.obtenerPorId(reciboId);
        List<Object[]> conceptos = reciboDAO.obtenerConceptosPersonalizados(reciboId);
        double totalConceptos = 0;
        for (Object[] c : conceptos) totalConceptos += (double) c[2];
        
        java.util.Calendar cal = java.util.Calendar.getInstance();
        cal.setTime(recibo.getFechaEmision());
        int anio = cal.get(java.util.Calendar.YEAR);
        double ipcPorcentaje = reciboDAO.obtenerIPC(anio);
        double ivaPorcentaje = reciboDAO.obtenerIVA();
        double incrementoIPC = recibo.getRenta() * (ipcPorcentaje / 100);
        double valorIVA = recibo.getRenta() * (ivaPorcentaje / 100);
        double servicios = recibo.getAgua() + recibo.getLuz() + recibo.getPorteria();
        double nuevoTotal = recibo.getRenta() + incrementoIPC + valorIVA + servicios + recibo.getOtros() + totalConceptos;
        reciboDAO.actualizarTotalRecibo(reciboId, nuevoTotal);
        response.sendRedirect("recibo?accion=editar&id=" + reciboId);
    }

    private void eliminarConcepto(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        int conceptoId = Integer.parseInt(request.getParameter("conceptoId"));
        int reciboId = Integer.parseInt(request.getParameter("reciboId"));
        reciboDAO.eliminarConceptoPersonalizado(conceptoId);
        
        Recibo recibo = reciboDAO.obtenerPorId(reciboId);
        List<Object[]> conceptos = reciboDAO.obtenerConceptosPersonalizados(reciboId);
        double totalConceptos = 0;
        for (Object[] c : conceptos) totalConceptos += (double) c[2];
        
        java.util.Calendar cal = java.util.Calendar.getInstance();
        cal.setTime(recibo.getFechaEmision());
        int anio = cal.get(java.util.Calendar.YEAR);
        double ipcPorcentaje = reciboDAO.obtenerIPC(anio);
        double ivaPorcentaje = reciboDAO.obtenerIVA();
        double incrementoIPC = recibo.getRenta() * (ipcPorcentaje / 100);
        double valorIVA = recibo.getRenta() * (ivaPorcentaje / 100);
        double servicios = recibo.getAgua() + recibo.getLuz() + recibo.getPorteria();
        double nuevoTotal = recibo.getRenta() + incrementoIPC + valorIVA + servicios + recibo.getOtros() + totalConceptos;
        reciboDAO.actualizarTotalRecibo(reciboId, nuevoTotal);
        response.sendRedirect("recibo?accion=editar&id=" + reciboId);
    }

    // Métodos para trabajar con número de recibo
    private void verPorNumeroRecibo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String numeroRecibo = request.getParameter("numeroRecibo");
        int id = reciboDAO.obtenerIdPorNumeroRecibo(numeroRecibo);
        if (id == -1) {
            response.sendRedirect("recibo?accion=listar");
            return;
        }
        Object[] recibo = reciboDAO.obtenerDetalleRecibo(id);
        List<Object[]> conceptosPersonalizados = reciboDAO.obtenerConceptosPersonalizados(id);
        request.setAttribute("recibo", recibo);
        request.setAttribute("conceptosPersonalizados", conceptosPersonalizados);
        request.getRequestDispatcher("views/recibo/ver.jsp").forward(request, response);
    }

    private void editarPorNumeroRecibo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String numeroRecibo = request.getParameter("numeroRecibo");
        int id = reciboDAO.obtenerIdPorNumeroRecibo(numeroRecibo);
        if (id == -1) {
            response.sendRedirect("recibo?accion=listar");
            return;
        }
        Recibo recibo = reciboDAO.obtenerPorId(id);
        List<Object[]> conceptosPersonalizados = reciboDAO.obtenerConceptosPersonalizados(id);
        request.setAttribute("recibo", recibo);
        request.setAttribute("conceptosPersonalizados", conceptosPersonalizados);
        request.getRequestDispatcher("views/recibo/editar.jsp").forward(request, response);
    }

    private void pagarPorNumeroRecibo(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String numeroRecibo = request.getParameter("numeroRecibo");
        int id = reciboDAO.obtenerIdPorNumeroRecibo(numeroRecibo);
        if (id != -1) {
            reciboDAO.marcarPagado(id);
        }
        response.sendRedirect("recibo?accion=listar");
    }

    private void actualizar(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        double renta = Double.parseDouble(request.getParameter("renta"));
        double agua = Double.parseDouble(request.getParameter("agua"));
        double luz = Double.parseDouble(request.getParameter("luz"));
        double porteria = Double.parseDouble(request.getParameter("porteria"));
        double otros = Double.parseDouble(request.getParameter("otros"));
        String estado = request.getParameter("estado");
        
        Recibo reciboExistente = reciboDAO.obtenerPorId(id);
        List<Object[]> conceptos = reciboDAO.obtenerConceptosPersonalizados(id);
        double totalConceptos = 0;
        for (Object[] c : conceptos) totalConceptos += (double) c[2];
        
        java.util.Calendar cal = java.util.Calendar.getInstance();
        cal.setTime(reciboExistente.getFechaEmision());
        int anio = cal.get(java.util.Calendar.YEAR);
        double ipcPorcentaje = reciboDAO.obtenerIPC(anio);
        double ivaPorcentaje = reciboDAO.obtenerIVA();
        double incrementoIPC = renta * (ipcPorcentaje / 100);
        double valorIVA = renta * (ivaPorcentaje / 100);
        double servicios = agua + luz + porteria;
        double nuevoTotal = renta + incrementoIPC + valorIVA + servicios + otros + totalConceptos;
        
        Recibo r = new Recibo();
        r.setId(id);
        r.setRenta(renta);
        r.setAgua(agua);
        r.setLuz(luz);
        r.setPorteria(porteria);
        r.setOtros(otros);
        r.setTotal(nuevoTotal);
        r.setEstado(estado);
        reciboDAO.actualizar(r);
        response.sendRedirect("recibo?accion=listar");
    }
    
    
// Método para mostrar ganancias por edificio
private void gananciasEdificio(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    List<Object[]> gananciasDetalle = reciboDAO.obtenerGananciasPorEdificio();
    List<Object[]> resumenEdificios = reciboDAO.obtenerResumenGananciasPorEdificio();
    
    request.setAttribute("gananciasDetalle", gananciasDetalle);
    request.setAttribute("resumenEdificios", resumenEdificios);
    
    request.getRequestDispatcher("views/recibo/ganancias_edificio.jsp")
           .forward(request, response);
}
}