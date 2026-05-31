package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

import model.dao.EdificioDAO;
import model.dao.UnidadInmuebleDAO;

import model.entity.Edificio;
import model.entity.UnidadInmueble;

@WebServlet("/unidad")
public class UnidadServlet
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

        if (accion == null) {

            accion = "listar";
        }

        switch (accion) {

            case "nuevo":

                mostrarFormulario(
                        request,
                        response
                );

                break;

            case "listar":

                listar(
                        request,
                        response
                );

                break;

            case "editar":

                editar(
                        request,
                        response
                );

                break;

            case "desactivar":

                desactivar(
                        request,
                        response
                );

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

                guardar(
                        request,
                        response
                );

                break;

            case "actualizar":

                actualizar(
                        request,
                        response
                );

                break;
        }
    }

    private void mostrarFormulario(
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

    private void guardar(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        UnidadInmueble unidad =
                new UnidadInmueble();

        unidad.setEdificioId(
                Integer.parseInt(
                        request.getParameter(
                                "edificioId"
                        )
                )
        );

        unidad.setTipo(
                request.getParameter(
                        "tipo"
                )
        );

        unidad.setPlanta(
                request.getParameter(
                        "planta"
                )
        );

        unidad.setLetra(
                request.getParameter(
                        "letra"
                )
        );

        unidad.setEstado(
                "DISPONIBLE"
        );

        unidadDAO.guardar(unidad);

        response.sendRedirect(
                "unidad?accion=listar"
        );
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
            unidadDAO.buscarPorId(id);

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
    private void actualizar(
        HttpServletRequest request,
        HttpServletResponse response)
        throws IOException {

    UnidadInmueble unidad =
            new UnidadInmueble();

    unidad.setId(
            Integer.parseInt(
                    request.getParameter(
                            "id"
                    )
            )
    );

    unidad.setEdificioId(
            Integer.parseInt(
                    request.getParameter(
                            "edificioId"
                    )
            )
    );

    unidad.setTipo(
            request.getParameter(
                    "tipo"
            )
    );

    unidad.setPlanta(
            request.getParameter(
                    "planta"
            )
    );

    unidad.setLetra(
            request.getParameter(
                    "letra"
            )
    );

    unidad.setEstado(
            request.getParameter(
                    "estado"
            )
    );

    unidadDAO.actualizar(unidad);

    response.sendRedirect(
            "unidad?accion=listar"
    );
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
            "unidad?accion=listar"
    );
}
}