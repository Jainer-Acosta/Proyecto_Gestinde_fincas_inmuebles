package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

@WebServlet("/imagen")
public class ImagenServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String nombre =
                request.getParameter("nombre");

        String ruta =
                "C:\\fotografias\\"
                + nombre;

        File archivo =
                new File(ruta);

        if (!archivo.exists()) {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND
            );

            return;
        }

        response.setContentType(
                getServletContext()
                        .getMimeType(
                                archivo.getName()
                        )
        );

        try (
                FileInputStream fis =
                        new FileInputStream(archivo);

                OutputStream os =
                        response.getOutputStream()
        ) {

            byte[] buffer =
                    new byte[1024];

            int bytesLeidos;

            while ((bytesLeidos =
                    fis.read(buffer)) != -1) {

                os.write(
                        buffer,
                        0,
                        bytesLeidos
                );
            }
        }
    }
}