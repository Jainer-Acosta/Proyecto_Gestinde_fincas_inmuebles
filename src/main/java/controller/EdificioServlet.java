package controller;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.http.HttpServlet;

import jakarta.servlet.http.HttpServletRequest;

import jakarta.servlet.http.HttpServletResponse;

import model.dao.EdificioDAO;

import model.entity.Edificio;

import java.io.IOException;

import java.util.List;

@WebServlet("/edificio")
public class EdificioServlet
        extends HttpServlet {

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

                request.getRequestDispatcher(
                        "views/edificio/registrar.jsp"
                ).forward(request, response);

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
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        String id =
                request.getParameter("id");

        Edificio e =
                new Edificio();

        e.setNombre(
                request.getParameter(
                        "nombre"
                )
        );

        e.setDireccion(
                request.getParameter(
                        "direccion"
                )
        );

        e.setNumero(
                request.getParameter(
                        "numero"
                )
        );

        e.setCodigoPostal(
                request.getParameter(
                        "codigoPostal"
                )
        );

        e.setCiudad(
                request.getParameter(
                        "ciudad"
                )
        );

        e.setEstado(
                request.getParameter(
                        "estado"
                )
        );

        if(id == null || id.isEmpty()){

            edificioDAO.guardar(e);

        }else{

            e.setId(
                    Integer.parseInt(id)
            );

            edificioDAO.actualizar(e);
        }

        response.sendRedirect(
                "edificio?accion=listar"
        );
    }

    private void listar(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Edificio> lista =
                edificioDAO.listar();

        request.setAttribute(
                "listaEdificios",
                lista
        );

        request.getRequestDispatcher(
                "views/edificio/listar.jsp"
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

        Edificio edificio =
                edificioDAO.obtenerPorId(id);

        request.setAttribute(
                "edificio",
                edificio
        );

        request.getRequestDispatcher(
                "views/edificio/editar.jsp"
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

        edificioDAO.desactivar(id);

        response.sendRedirect(
                "edificio?accion=listar"
        );
    }
}