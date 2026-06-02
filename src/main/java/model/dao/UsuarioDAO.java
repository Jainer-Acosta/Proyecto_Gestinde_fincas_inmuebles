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
    
    public Usuario login(String username, String password) {

        String sql = """
                SELECT * FROM usuario
                WHERE username = ?
                AND password = ?
                AND estado = 'ACTIVO'
                """;

        Usuario usuario = null;

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setUsername(rs.getString("username"));
                usuario.setRol(rs.getString("rol"));
                usuario.setEstado(rs.getString("estado"));
            }

        } catch (SQLException e) {
            System.out.println("Error login: " + e.getMessage());
        }

        return usuario;
    }
    
    public int guardarRetornandoId(Usuario usuario) {

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

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getUsername());
            ps.setString(3, usuario.getPassword());
            ps.setString(4, usuario.getRol());
            ps.setString(5, usuario.getEstado());

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            System.out.println("Error usuario: " + e.getMessage());
        }

        return 0;
    }
    
    public boolean desactivar(int id) {

        String sql = """
                UPDATE usuario
                SET estado = 'INACTIVO'
                WHERE id = ?
                """;

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Error desactivando usuario: " + e.getMessage());
        }

        return false;
    }
    
    public boolean activar(int id) {

        String sql = """
                UPDATE usuario
                SET estado = 'ACTIVO'
                WHERE id = ?
                """;

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Error activando usuario: " + e.getMessage());
        }

        return false;
    }
    
    // Cambiar estado del usuario (ACTIVO/INACTIVO)
    public boolean cambiarEstado(int id, String estado) {

        String sql = "UPDATE usuario SET estado = ? WHERE id = ?";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setString(1, estado);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Error cambiando estado usuario: " + e.getMessage());
        }

        return false;
    }
    
    // Obtener usuario por ID
    public Usuario obtenerPorId(int id) {

        String sql = "SELECT * FROM usuario WHERE id = ?";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setUsername(rs.getString("username"));
                usuario.setRol(rs.getString("rol"));
                usuario.setEstado(rs.getString("estado"));
                return usuario;
            }

        } catch (SQLException e) {
            System.out.println("Error obteniendo usuario: " + e.getMessage());
        }

        return null;
    }
}