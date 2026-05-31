package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.dao.BancoDAO;
import model.dao.CuentaBancariaDAO;

import model.entity.Banco;
import model.entity.CuentaBancaria;

import java.io.IOException;

import java.util.List;

@WebServlet("/cuenta")
public class CuentaBancariaServlet
        extends HttpServlet {

    private final BancoDAO bancoDAO =
            new BancoDAO();

    private final CuentaBancariaDAO cuentaDAO =
            new CuentaBancariaDAO();

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
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        CuentaBancaria cuenta =
                new CuentaBancaria();

        cuenta.setBancoId(
                Integer.parseInt(
                        request.getParameter(
                                "bancoId"
                        )
                )
        );

        cuenta.setNumeroCuenta(
                request.getParameter(
                        "numeroCuenta"
                )
        );

        cuenta.setSaldo(
                Double.parseDouble(
                        request.getParameter(
                                "saldo"
                        )
                )
        );

        cuentaDAO.guardar(cuenta);

        response.sendRedirect(
                "cuenta?accion=listar"
        );
    }

    private void nuevo(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Banco> bancos =
                bancoDAO.listar();

        request.setAttribute(
                "bancos",
                bancos
        );

        request.getRequestDispatcher(
                "views/cuenta/registrar.jsp"
        ).forward(request, response);
    }

    private void listar(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Object[]> lista =
                cuentaDAO.listar();

        request.setAttribute(
                "listaCuentas",
                lista
        );

        request.getRequestDispatcher(
                "views/cuenta/listar.jsp"
        ).forward(request, response);
    }
}