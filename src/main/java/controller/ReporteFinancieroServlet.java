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
import model.dao.MovimientoBancarioDAO;

/**
 *
 * @author Jainer Acosta
 */
@WebServlet("/financiero")
public class ReporteFinancieroServlet
        extends HttpServlet {

private final MovimientoBancarioDAO dao =
        new MovimientoBancarioDAO();

@Override
protected void doGet(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException,
               IOException {

    request.setAttribute(
            "ingresos",
            dao.totalIngresos()
    );

    request.setAttribute(
            "gastos",
            dao.totalGastos()
    );

    request.setAttribute(
            "saldo",
            dao.saldoGeneral()
    );

    request.getRequestDispatcher(
            "views/financiero/reporte.jsp"
    ).forward(
            request,
            response
    );
}

}