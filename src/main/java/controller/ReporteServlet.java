package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.dao.ReporteDAO;

import java.io.IOException;

@WebServlet("/reporte")
public class ReporteServlet
        extends HttpServlet {

    private final ReporteDAO reporteDAO =
            new ReporteDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        double ingresos =
                reporteDAO.totalIngresos();

        double gastos =
                reporteDAO.totalGastos();

        double saldo =
                reporteDAO.saldoGeneral();

        int recibosPendientes =
                reporteDAO.recibosPendientes();

        int inmueblesAlquilados =
                reporteDAO.inmueblesAlquilados();
        
        double ingresosMes =
        reporteDAO.ingresosMes();

        double gastosMes =
                reporteDAO.gastosMes();
        
        request.setAttribute(
                "ingresosMes",
                ingresosMes
        );

        request.setAttribute(
                "gastosMes",
                gastosMes
        );

        request.setAttribute(
                "ingresos",
                ingresos
        );

        request.setAttribute(
                "gastos",
                gastos
        );

        request.setAttribute(
                "saldo",
                saldo
        );

        request.setAttribute(
                "recibosPendientes",
                recibosPendientes
        );

        request.setAttribute(
                "inmueblesAlquilados",
                inmueblesAlquilados
        );

        request.getRequestDispatcher(
                "views/reporte/dashboard.jsp"
        ).forward(request, response);
    }
    
}