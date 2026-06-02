/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.dao.InquilinoDAO;
import model.entity.Inquilino;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.io.File;
import model.dao.UsuarioDAO;
import model.entity.Usuario;

/**
 *
 * @author Jainer Acosta
 */
@MultipartConfig
@WebServlet("/inquilino")
public class InquilinoServlet extends HttpServlet {

    private final InquilinoDAO dao =
            new InquilinoDAO();
    
    private final UsuarioDAO usuarioDAO =
        new UsuarioDAO();
    


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

            accion = "listar";
        }

        switch (accion) {

            case "listar":

                listar(request, response);

                break;
                
            case "nuevo":  
                
                nuevo(request, response);
                
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
                
            case "activar":
                
                activar(request, response);
                
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
                
            case "actualizar":

                actualizar(request, response);

                break;
        }
    }

    private void guardar(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException, ServletException {

        Inquilino i =
                new Inquilino();

        i.setNombre(
                request.getParameter("nombre")
        );

        i.setApellido(
                request.getParameter("apellido")
        );

        i.setDni(
                request.getParameter("dni")
        );

        i.setEdad(
                Integer.parseInt(
                        request.getParameter(
                                "edad"
                        )
                )
        );

        i.setSexo(
                request.getParameter("sexo")
        );

        i.setTelefono(
                request.getParameter("telefono")
        );

        i.setEmail(
                request.getParameter("email")
        );

        i.setUsuario(
                request.getParameter("usuario")
        );

        i.setPassword(
                request.getParameter("password")
        );
        
        /*
        * CREAR USUARIO
        */
       Usuario usuario =
               new Usuario();

       usuario.setNombre(
               request.getParameter("nombre")
       );

       usuario.setUsername(
               request.getParameter("usuario")
       );

       usuario.setPassword(
               request.getParameter("password")
       );

       usuario.setRol("INQUILINO");

       usuario.setEstado("ACTIVO");

       int usuarioId =
               usuarioDAO
                       .guardarRetornandoId(
                               usuario
                       );

       i.setUsuarioId(usuarioId);
       
       

        Part archivo =
            request.getPart("fotografia");

        String nombreOriginal =
            archivo.getSubmittedFileName();

        String extension =
                nombreOriginal.substring(
                        nombreOriginal.lastIndexOf(".")
                );

        String nombreArchivo =
                System.currentTimeMillis()
                + extension;

        String ruta = "C:\\fotografias";

        File directorio =
                new File(ruta);

        if (!directorio.exists()) {

            directorio.mkdirs();
        }

        archivo.write(
                ruta + File.separator
                + nombreArchivo
        );

        i.setFotografia(nombreArchivo);

        i.setEstado("ACTIVO");

        i.setFechaRegistro(
            new java.sql.Date(
                System.currentTimeMillis()
            )
        );
        
        
        dao.guardar(i);

        response.sendRedirect(
                "inquilino?accion=listar"
        );
    }

        private void nuevo(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        
        request.getRequestDispatcher(
                "views/inquilino/registrar.jsp"
        ).forward(request, response);
    }

    
    
    private void listar(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Inquilino> lista =
                dao.listar();

        request.setAttribute(
                "listaInquilinos",
                lista
        );

        request.getRequestDispatcher(
                "views/inquilino/listar.jsp"
        ).forward(request, response);
    }
    
    private void editar(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    int id =
            Integer.parseInt(
                    request.getParameter("id")
            );

    Inquilino i =
            dao.buscarPorId(id);

    request.setAttribute(
            "inquilino",
            i
    );

    request.getRequestDispatcher(
            "views/inquilino/editar.jsp"
    ).forward(request, response);
}
    
    private void actualizar(
        HttpServletRequest request,
        HttpServletResponse response)
        throws IOException {

    Inquilino i =
            new Inquilino();

    i.setId(
            Integer.parseInt(
                    request.getParameter("id")
            )
    );

    i.setNombre(
            request.getParameter("nombre")
    );

    i.setApellido(
            request.getParameter("apellido")
    );

    i.setDni(
            request.getParameter("dni")
    );

    i.setEdad(
            Integer.parseInt(
                    request.getParameter("edad")
            )
    );

    i.setSexo(
            request.getParameter("sexo")
    );

    i.setTelefono(
            request.getParameter("telefono")
    );

    i.setEmail(
            request.getParameter("email")
    );

    dao.actualizar(i);

    response.sendRedirect(
            "inquilino?accion=listar"
    );
}
    private void desactivar(
        HttpServletRequest request,
        HttpServletResponse response)
        throws IOException {

    int id =
            Integer.parseInt(
                    request.getParameter("id")
            );

    dao.desactivar(id);

    response.sendRedirect(
            "inquilino?accion=listar"
    );
}
    
    private void reporte(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    String desde =
            request.getParameter("desde");

    String hasta =
            request.getParameter("hasta");

    if(desde != null && hasta != null){

        List<Inquilino> lista =
                dao.listarPorFecha(
                        desde,
                        hasta
                );

        request.setAttribute(
                "listaReporte",
                lista
        );
    }

    request.getRequestDispatcher(
            "views/inquilino/reporte.jsp"
    ).forward(request, response);
}
    private void activar(HttpServletRequest request, HttpServletResponse response)
        throws IOException {
    
    int id = Integer.parseInt(request.getParameter("id"));
    dao.activar(id);
    
    response.sendRedirect("inquilino?accion=listar");
}
}
