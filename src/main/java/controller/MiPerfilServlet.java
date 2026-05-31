package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.dao.InquilinoDAO;
import model.entity.Inquilino;
import model.entity.Usuario;

@WebServlet("/mi-perfil")
public class MiPerfilServlet extends HttpServlet {
    
    private final InquilinoDAO inquilinoDAO = new InquilinoDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        
        Inquilino inquilino = inquilinoDAO.buscarPorUsuarioId(usuario.getId());
        request.setAttribute("inquilino", inquilino);
        
        request.getRequestDispatcher("views/inquilino/mi-perfil.jsp")
               .forward(request, response);
    }
}