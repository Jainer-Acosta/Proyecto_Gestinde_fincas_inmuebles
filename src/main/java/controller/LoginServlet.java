/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.dao.UsuarioDAO;
import model.entity.Usuario;

/**
 *
 * @author Jainer Acosta
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UsuarioDAO dao =
            new UsuarioDAO();

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String username =
                request.getParameter(
                        "username"
                );

        String password =
                request.getParameter(
                        "password"
                );

        Usuario usuario =
                dao.login(username, password);

        if (usuario != null) {

            HttpSession session =
                    request.getSession();

            session.setAttribute(
                    "usuario",
                    usuario
            );

            response.sendRedirect(
                "views/dashboard/dashboard.jsp"
            );

        } else {

            response.sendRedirect(
                    "views/login/login.jsp?error=true"
            );
        }
    }
}