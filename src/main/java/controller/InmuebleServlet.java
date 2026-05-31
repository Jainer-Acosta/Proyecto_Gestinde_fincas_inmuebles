/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.dao.InmuebleDAO;
import model.entity.Inmueble;

/**
 *
 * @author Jainer Acosta
 */
@WebServlet("/inmueble")
public class InmuebleServlet extends HttpServlet {

    private final InmuebleDAO dao =
            new InmuebleDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String accion =
                request.getParameter("accion");

        if (accion == null) {

            accion = "listar";
        }

        switch (accion) {

            case "listar":

                listar(request, response);

                break;
            
            case "editar":
                
                mostrarEditar(request, response);
                
                break;
                
                
            case "eliminar":

                eliminar(request, response);

                break;

            default:

                listar(request, response);
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String accion =
                request.getParameter("accion");

        switch (accion) {

            case "guardar":

                guardar(request, response);

                break;

            default:

                listar(request, response);
                
            case "actualizar":
                
                actualizar(request, response);
        }
    }

    /*
     * GUARDAR
     */
    private void guardar(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        Inmueble inmueble =
                new Inmueble();

        inmueble.setTipo(
                request.getParameter("tipo")
        );

        inmueble.setDireccion(
                request.getParameter("direccion")
        );

        inmueble.setNumero(
                request.getParameter("numero")
        );

        inmueble.setCodigoPostal(
                request.getParameter("codigoPostal")
        );

        inmueble.setCiudad(
                request.getParameter("ciudad")
        );

        inmueble.setEstado(
                request.getParameter("estado")
        );

        dao.guardar(inmueble);

        response.sendRedirect(
                "inmueble?accion=listar"
        );
    }
    
    
    private void actualizar(
        HttpServletRequest request,
        HttpServletResponse response)
        throws IOException {

        Inmueble inmueble =
                new Inmueble();

        inmueble.setId(
                Integer.parseInt(
                        request.getParameter("id")
                )
        );

        inmueble.setTipo(
                request.getParameter("tipo")
        );

        inmueble.setDireccion(
                request.getParameter("direccion")
        );

        inmueble.setNumero(
                request.getParameter("numero")
        );

        inmueble.setCodigoPostal(
                request.getParameter("codigoPostal")
        );

        inmueble.setCiudad(
                request.getParameter("ciudad")
        );

        inmueble.setEstado(
                request.getParameter("estado")
        );

        dao.actualizar(inmueble);

        response.sendRedirect(
                "inmueble?accion=listar"
        );
    }
    

    /*
     * LISTAR
     */
    private void listar(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Inmueble> lista =
                dao.listar();

        request.setAttribute(
                "listaInmuebles",
                lista
        );

        request.getRequestDispatcher(
                "views/inmueble/listar.jsp"
        ).forward(request, response);
    }

    private void mostrarEditar(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

        int id = Integer.parseInt(
                request.getParameter("id")
        );

        Inmueble inmueble =
                dao.buscarPorId(id);

        request.setAttribute(
                "inmueble",
                inmueble
        );

        request.getRequestDispatcher(
                "views/inmueble/editar.jsp"
        ).forward(request, response);
    }
    
    
    /*
     * ELIMINAR
     */
    private void eliminar(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(
                request.getParameter("id")
        );

        dao.desactivar(id);

        response.sendRedirect(
                "inmueble?accion=listar"
        );
    }
}