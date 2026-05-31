/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.dao;

import java.sql.*;
import model.entity.Usuario;

/**
 *
 * @author Jainer Acosta
 */
public class UsuarioDAO {
    
    public Usuario login(
            String username,
            String password) {

        String sql = """
                SELECT * FROM usuario
                WHERE username = ?
                AND password = ?
                """;

        Usuario usuario = null;

        try (
                Connection conexion =
                        Conexion.conectar();

                PreparedStatement ps =
                        conexion.prepareStatement(sql)
        ) {

            ps.setString(1, username);

            ps.setString(2, password);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                usuario = new Usuario();

                usuario.setId(
                        rs.getInt("id")
                );

                usuario.setNombre(
                        rs.getString("nombre")
                );

                usuario.setUsername(
                        rs.getString("username")
                );

                usuario.setRol(
                        rs.getString("rol")
                );
            }

        } catch (SQLException e) {

            System.out.println(
                    "Error login: "
                    + e.getMessage()
            );
        }

        return usuario;
    }
    
    public int guardarRetornandoId(
        Usuario usuario) {

    String sql = """
            INSERT INTO usuario
            (
                nombre,
                username,
                password,
                rol,
                estado
            )
            VALUES (?, ?, ?, ?, ?)
            """;

    try (
            Connection conexion =
                    Conexion.conectar();

            PreparedStatement ps =
                    conexion.prepareStatement(
                            sql,
                            Statement.RETURN_GENERATED_KEYS
                    )
    ) {

        ps.setString(
                1,
                usuario.getNombre()
        );

        ps.setString(
                2,
                usuario.getUsername()
        );

        ps.setString(
                3,
                usuario.getPassword()
        );

        ps.setString(
                4,
                usuario.getRol()
        );

        ps.setString(
                5,
                usuario.getEstado()
        );

        ps.executeUpdate();

        ResultSet rs =
                ps.getGeneratedKeys();

        if (rs.next()) {

            return rs.getInt(1);
        }

    } catch (SQLException e) {

        System.out.println(
                "Error usuario: "
                + e.getMessage()
        );
    }

    return 0;
}
}

