package controller;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.http.HttpServlet;

import jakarta.servlet.http.HttpServletRequest;

import jakarta.servlet.http.HttpServletResponse;

import model.dao.EdificioDAO;
import model.dao.UnidadInmuebleDAO;

import model.entity.Edificio;
import model.entity.UnidadInmueble;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import java.util.List;
import model.dao.Conexion;

@WebServlet("/unidad_inmueble")
public class UnidadInmuebleServlet
        extends HttpServlet {

    private final UnidadInmuebleDAO unidadDAO =
            new UnidadInmuebleDAO();

    private final EdificioDAO edificioDAO =
            new EdificioDAO();

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

            case "editar":

                editar(request, response);

                break;

            case "desactivar":

                desactivar(request, response);

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

        String id =
                request.getParameter("id");

        UnidadInmueble u =
                new UnidadInmueble();

        u.setEdificioId(
                Integer.parseInt(
                        request.getParameter(
                                "edificioId"
                        )
                )
        );

        u.setTipo(
                request.getParameter(
                        "tipo"
                )
        );

        u.setPlanta(
                request.getParameter(
                        "planta"
                )
        );

        u.setLetra(
                request.getParameter(
                        "letra"
                )
        );

        u.setDescripcion(
                request.getParameter(
                        "descripcion"
                )
        );

        u.setEstado(
                request.getParameter(
                        "estado"
                )
        );

        if(id == null || id.isEmpty()){

            unidadDAO.guardar(u);

        }else{

            u.setId(
                    Integer.parseInt(id)
            );

            unidadDAO.actualizar(u);
        }

        response.sendRedirect(
                "unidad_inmueble?accion=listar"
        );
    }

    private void nuevo(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Edificio> edificios =
                edificioDAO.listar();

        request.setAttribute(
                "edificios",
                edificios
        );

        request.getRequestDispatcher(
                "views/unidad/registrar.jsp"
        ).forward(request, response);
    }

    private void listar(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Object[]> lista =
                unidadDAO.listar();

        request.setAttribute(
                "listaUnidades",
                lista
        );

        request.getRequestDispatcher(
                "views/unidad/listar.jsp"
        ).forward(request, response);
    }

    private void editar(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int id =
                Integer.parseInt(
                        request.getParameter(
                                "id"
                        )
                );

        UnidadInmueble unidad =
                unidadDAO.obtenerPorId(id);

        List<Edificio> edificios =
                edificioDAO.listar();

        request.setAttribute(
                "unidad",
                unidad
        );

        request.setAttribute(
                "edificios",
                edificios
        );

        request.getRequestDispatcher(
                "views/unidad/editar.jsp"
        ).forward(request, response);
    }

    private void desactivar(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        int id =
                Integer.parseInt(
                        request.getParameter(
                                "id"
                        )
                );

        unidadDAO.desactivar(id);

        response.sendRedirect(
                "unidad_inmueble?accion=listar"
        );
    }
    
    
    private void reporte(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    List<Object[]> lista =
            unidadDAO.listarPorEdificio();

    request.setAttribute(
            "listaReporte",
            lista
    );

    request.getRequestDispatcher(
            "views/unidad/reporte.jsp"
    ).forward(request, response);
}
    
    
}
