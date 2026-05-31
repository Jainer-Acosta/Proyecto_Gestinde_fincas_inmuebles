package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.dao.AlquilerDAO;
import model.entity.Usuario;

@WebServlet("/mi-alquiler")
public class MiAlquilerServlet extends HttpServlet {
    
    private final AlquilerDAO alquilerDAO = new AlquilerDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        
        Object[] alquiler = alquilerDAO.obtenerAlquilerActivoPorUsuario(usuario.getId());
        request.setAttribute("alquiler", alquiler);
        
        request.getRequestDispatcher("views/inquilino/mi-alquiler.jsp")
               .forward(request, response);
    }
}