/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.dao;

import java.sql.*;

/**
 *
 * @author Jainer Acosta
 */
public class Conexion {

    private static final String URL =
            "jdbc:mysql://localhost:3306/gestion_inmuebles";

    private static final String USER = "root";

    private static final String PASSWORD = "";

    public static Connection conectar() {

        Connection conexion = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            conexion = DriverManager.getConnection(
                    URL,
                    USER,
                    PASSWORD
            );

            System.out.println("Conexión exitosa");

        } catch (ClassNotFoundException e) {

            System.out.println(
                    "Error cargando driver: "
                    + e.getMessage()
            );

        } catch (SQLException e) {

            System.out.println(
                    "Error de conexión: "
                    + e.getMessage()
            );
        }

        return conexion;
    }
}
