/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.http.*;

import model.dao.AlquilerDAO;
import model.dao.InquilinoDAO;

import model.entity.Alquiler;
import model.entity.Inquilino;

import java.io.IOException;

import java.sql.Date;

import java.util.List;

import model.dao.UnidadInmuebleDAO;


/**
 *
 * @author Jainer Acosta
 */
@WebServlet("/alquiler")
public class AlquilerServlet extends HttpServlet {

    private final AlquilerDAO alquilerDAO =
            new AlquilerDAO();


    private final InquilinoDAO inquilinoDAO =
            new InquilinoDAO();
    
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

        if (accion == null) {

            accion = "nuevo";
        }

        switch (accion) {

            case "nuevo":

                mostrarFormulario(
                        request,
                        response
                );

                break;
                
                
            case "listar":

                listar(request, response);

                break;

            case "finalizar":

                finalizar(request, response);

                break;
        }
        
        
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String accion =
                request.getParameter(
                        "accion"
                );

        switch (accion) {

            case "guardar":

                guardar(request, response);

                break;
        }
    }

    private void mostrarFormulario(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Inquilino> inquilinos =
                inquilinoDAO.listar();

        List<Object[]> unidades =
                unidadDAO.listarDisponibles();

        request.setAttribute(
                "inquilinos",
                inquilinos
        );

        request.setAttribute(
                "unidades",
                 unidades
        );

        request.getRequestDispatcher(
                "views/alquiler/registrar.jsp"
        ).forward(request, response);
    }

    private void guardar(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        Alquiler alquiler =
                new Alquiler();

        alquiler.setInquilinoId(
                Integer.parseInt(
                        request.getParameter(
                                "inquilinoId"
                        )
                )
        );

        alquiler.setUnidadInmuebleId(
                Integer.parseInt(
                        request.getParameter(
                                "unidadId"
                        )
                )
        );

        alquiler.setFechaInicio(
                Date.valueOf(
                        request.getParameter(
                                "fechaInicio"
                        )
                )
        );

        String fechaFin =
                request.getParameter(
                        "fechaFin"
                );

        if (!fechaFin.isEmpty()) {

            alquiler.setFechaFin(
                    Date.valueOf(fechaFin)
            );
        }

        alquiler.setEstado(
                "ACTIVO"
        );

        alquilerDAO.guardar(alquiler);

        response.sendRedirect(
            "alquiler?accion=listar"
        );
    }
    
    private void listar(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    List<Object[]> lista =
            alquilerDAO.listar();

    request.setAttribute(
            "listaAlquileres",
            lista
    );

    request.getRequestDispatcher(
            "views/alquiler/listar.jsp"
    ).forward(request, response);
}

    private void finalizar(
        HttpServletRequest request,
        HttpServletResponse response)
        throws IOException {

    int id =
            Integer.parseInt(
                    request.getParameter("id")
            );

    int unidadId =
            Integer.parseInt(
                    request.getParameter(
                            "unidadId"
                    )
            );

    alquilerDAO.finalizar(
            id,
            unidadId
    );

    response.sendRedirect(
            "alquiler?accion=listar"
    );
}
}
