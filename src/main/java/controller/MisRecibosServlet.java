package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

import model.dao.ReciboDAO;
import model.entity.Usuario;

@WebServlet("/mis-recibos")
public class MisRecibosServlet extends HttpServlet {

    private final ReciboDAO dao = new ReciboDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        List<Object[]> lista = dao.listarPorUsuario(usuario.getId());

        request.setAttribute("listaRecibos", lista);

        request.getRequestDispatcher("views/inquilino/mis-recibos.jsp")
               .forward(request, response);
    }
}