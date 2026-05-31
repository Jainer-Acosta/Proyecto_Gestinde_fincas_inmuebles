/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;



import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;

import model.entity.Usuario;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(
            ServletRequest request,
            ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req =
                (HttpServletRequest) request;

        HttpServletResponse res =
                (HttpServletResponse) response;

        String ruta =
                req.getRequestURI();

        /*
         * RUTAS LIBRES
         */
        if (
                ruta.contains("login.jsp")
                || ruta.contains("/login")
                || ruta.contains("/css/")
                || ruta.contains("/imagen")
        ) {

            chain.doFilter(request, response);
            return;
        }

        HttpSession session =
                req.getSession(false);

        /*
         * NO LOGIN
         */
        if (
                session == null
                || session.getAttribute("usuario") == null
        ) {

            res.sendRedirect(
                    req.getContextPath()
                    + "/views/login/login.jsp"
            );

            return;
        }

        Usuario usuario =
                (Usuario)
                session.getAttribute(
                        "usuario"
                );

        /*
         * RESTRICCIONES INQUILINO
         */
        if (
                usuario.getRol()
                        .equals("INQUILINO")
        ) {

            if (
                    ruta.contains("/inquilino")
                    || ruta.contains("/edificio")
                    || ruta.contains("/unidad_inmueble")
                    || ruta.contains("/movimiento")
                    || ruta.contains("/cuenta")
            ) {

                res.sendRedirect(
                        req.getContextPath()
                        + "/views/dashboard/dashboard.jsp"
                );

                return;
            }
        }

        chain.doFilter(request, response);
    }
}