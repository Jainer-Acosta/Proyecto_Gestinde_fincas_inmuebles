package controller;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.http.HttpServlet;

import jakarta.servlet.http.HttpServletRequest;

import jakarta.servlet.http.HttpServletResponse;

import model.dao.MovimientoBancarioDAO;
import model.dao.CuentaBancariaDAO;
import model.dao.UnidadInmuebleDAO;

import model.entity.MovimientoBancario;

import java.io.IOException;

import java.sql.Date;

import java.util.List;

@WebServlet("/movimiento")
public class MovimientoBancarioServlet
        extends HttpServlet {

    private final MovimientoBancarioDAO dao =
            new MovimientoBancarioDAO();

    private final CuentaBancariaDAO cuentaDAO =
            new CuentaBancariaDAO();

    private final UnidadInmuebleDAO unidadDAO =
            new UnidadInmuebleDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String accion =
                request.getParameter(
                        "accion"
                );

        if(accion == null){

            accion = "listar";
        }

        switch(accion){

            case "nuevo":

                nuevo(request, response);

                break;

            case "listar":

                listar(request, response);

                break;
                
            case "reporte":

                reporte(request, response);

                break;
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        MovimientoBancario m =
                new MovimientoBancario();

        m.setCuentaId(
                Integer.parseInt(
                        request.getParameter(
                                "cuentaId"
                        )
                )
        );

        m.setUnidadInmuebleId(
                Integer.parseInt(
                        request.getParameter(
                                "unidadId"
                        )
                )
        );

        m.setTipo(
                request.getParameter(
                        "tipo"
                )
        );

        m.setConcepto(
                request.getParameter(
                        "concepto"
                )
        );
        
        m.setCategoria(
                request.getParameter(
                        "categoria"
                )
        );

        m.setMonto(
                Double.parseDouble(
                        request.getParameter(
                                "monto"
                        )
                )
        );

        m.setFecha(
                Date.valueOf(
                        request.getParameter(
                                "fecha"
                        )
                )
        );

        m.setDescripcion(
                request.getParameter(
                        "descripcion"
                )
        );

        dao.guardar(m);

        response.sendRedirect(
                "movimiento?accion=listar"
        );
    }

    private void nuevo(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Object[]> cuentas =
                cuentaDAO.listar();

        List<Object[]> unidades =
                unidadDAO.listar();

        request.setAttribute(
                "cuentas",
                cuentas
        );

        request.setAttribute(
                "unidades",
                unidades
        );

        request.getRequestDispatcher(
                "views/movimiento/registrar.jsp"
        ).forward(request, response);
    }

    private void listar(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Object[]> lista =
                dao.listar();

        request.setAttribute(
                "listaMovimientos",
                lista
        );

        request.getRequestDispatcher(
                "views/movimiento/listar.jsp"
        ).forward(request, response);
    }
    
    private void reporte(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    Object[] datos =
            dao.resumenFinanciero();

    request.setAttribute(
            "ingresos",
            datos[0]
    );

    request.setAttribute(
            "gastos",
            datos[1]
    );

    request.setAttribute(
            "balance",
            (double) datos[0]
            - (double) datos[1]
    );

    request.getRequestDispatcher(
            "views/movimiento/reporte.jsp"
    ).forward(request, response);
}
    
}