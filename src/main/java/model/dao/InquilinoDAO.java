/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.entity.Inquilino;

/**
 *
 * @author Jainer Acosta
 */
public class InquilinoDAO {
    
/*
     * GUARDAR
     */
    public boolean guardar(Inquilino inquilino) {

        String sql = """
                INSERT INTO inquilino
                (
                    nombre,
                    apellido,
                    dni,
                    edad,
                    sexo,
                    telefono,
                    email,
                    fotografia,
                    estado,
                    usuario_id,
                    fecha_registro
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """;

        try (
                Connection conexion =
                        Conexion.conectar();

                PreparedStatement ps =
                        conexion.prepareStatement(sql)
        ) {

            ps.setString(1, inquilino.getNombre());

            ps.setString(2, inquilino.getApellido());

            ps.setString(3, inquilino.getDni());

            ps.setInt(4, inquilino.getEdad());

            ps.setString(5, inquilino.getSexo());

            ps.setString(6, inquilino.getTelefono());

            ps.setString(7, inquilino.getEmail());
            
            ps.setString(8, inquilino.getFotografia());

            ps.setString(9, inquilino.getEstado());
            
            ps.setInt(10, inquilino.getUsuarioId());
            
            ps.setDate(11, inquilino.getFechaRegistro());

            int filas =
                    ps.executeUpdate();

            return filas > 0;

        } catch (SQLException e) {

            System.out.println(
                    "Error guardando inquilino: "
                    + e.getMessage()
            );
        }

        return false;
    }

    /*
     * LISTAR
     */
    public List<Inquilino> listar() {

        List<Inquilino> lista =
                new ArrayList<>();

        String sql =
                "SELECT * FROM inquilino";

        try (
                Connection conexion =
                        Conexion.conectar();

                PreparedStatement ps =
                        conexion.prepareStatement(sql);

                ResultSet rs =
                        ps.executeQuery()
        ) {

            while (rs.next()) {

                Inquilino i =
                        new Inquilino();

                i.setId(
                        rs.getInt("id")
                );

                i.setNombre(
                        rs.getString("nombre")
                );

                i.setApellido(
                        rs.getString("apellido")
                );

                i.setDni(
                        rs.getString("dni")
                );

                i.setEdad(
                        rs.getInt("edad")
                );

                i.setSexo(
                        rs.getString("sexo")
                );

                i.setTelefono(
                        rs.getString("telefono")
                );

                i.setEmail(
                        rs.getString("email")
                );
                i.setFotografia(rs.getString("fotografia"));

                i.setEstado(
                        rs.getString("estado")
                );
                
                i.setFechaRegistro(
                        rs.getDate("fecha_registro"));

                lista.add(i);
            }

        } catch (SQLException e) {

            System.out.println(
                    "Error listando: "
                    + e.getMessage()
            );
        }

        return lista;
    }
    
    public Inquilino buscarPorId(int id) {

    String sql =
            "SELECT * FROM inquilino WHERE id = ?";

    try (
            Connection conexion =
                    Conexion.conectar();

            PreparedStatement ps =
                    conexion.prepareStatement(sql)
    ) {

        ps.setInt(1, id);

        ResultSet rs =
                ps.executeQuery();

        if (rs.next()) {

            Inquilino i =
                    new Inquilino();

            i.setId(
                    rs.getInt("id")
            );

            i.setNombre(
                    rs.getString("nombre")
            );

            i.setApellido(
                    rs.getString("apellido")
            );

            i.setDni(
                    rs.getString("dni")
            );

            i.setEdad(
                    rs.getInt("edad")
            );

            i.setSexo(
                    rs.getString("sexo")
            );

            i.setTelefono(
                    rs.getString("telefono")
            );

            i.setEmail(
                    rs.getString("email")
            );

            i.setFotografia(
                    rs.getString("fotografia")
            );

            i.setEstado(
                    rs.getString("estado")
            );
            
            i.setFechaRegistro(rs.getDate("fecha_registro"));
            
            i.setUsuarioId(rs.getInt("usuario_id"));

            return i;
        }

    } catch (SQLException e) {

        System.out.println(
                "Error buscando inquilino: "
                + e.getMessage()
        );
    }

    return null;
}
    
    public boolean actualizar(Inquilino i) {

    String sql = """
        UPDATE inquilino
        SET
            nombre = ?,
            apellido = ?,
            dni = ?,
            edad = ?,
            sexo = ?,
            telefono = ?,
            email = ?
        WHERE id = ?
        """;

    try (
            Connection conexion =
                    Conexion.conectar();

            PreparedStatement ps =
                    conexion.prepareStatement(sql)
    ) {

        ps.setString(1, i.getNombre());

        ps.setString(2, i.getApellido());

        ps.setString(3, i.getDni());

        ps.setInt(4, i.getEdad());

        ps.setString(5, i.getSexo());

        ps.setString(6, i.getTelefono());

        ps.setString(7, i.getEmail());

        ps.setInt(8, i.getId());

        return ps.executeUpdate() > 0;

    } catch (SQLException e) {

        System.out.println(
                "Error actualizando: "
                + e.getMessage()
        );
    }

    return false;
}
    
    public List<Inquilino> listarPorFecha(
        String desde,
        String hasta) {

    List<Inquilino> lista =
            new ArrayList<>();

    String sql = """
            SELECT *
            FROM inquilino
            WHERE fecha_registro
            BETWEEN ? AND ?
            ORDER BY fecha_registro DESC
            """;

    try (
            Connection conexion =
                    Conexion.conectar();

            PreparedStatement ps =
                    conexion.prepareStatement(sql)
    ) {

        ps.setString(1, desde);
        ps.setString(2, hasta);

        ResultSet rs =
                ps.executeQuery();

        while(rs.next()){

            Inquilino i =
                    new Inquilino();

            i.setId(rs.getInt("id"));
            i.setNombre(rs.getString("nombre"));
            i.setApellido(rs.getString("apellido"));
            i.setDni(rs.getString("dni"));
            i.setFechaRegistro(
                    rs.getDate(
                            "fecha_registro"
                    )
            );

            lista.add(i);
        }

    } catch (SQLException e) {

        System.out.println(
                e.getMessage()
        );
    }

    return lista;
}
    
    // Buscar inquilino por usuario ID
public Inquilino buscarPorUsuarioId(int usuarioId) {
    String sql = "SELECT * FROM inquilino WHERE usuario_id = ?";
    
    try (Connection conexion = Conexion.conectar();
         PreparedStatement ps = conexion.prepareStatement(sql)) {
        
        ps.setInt(1, usuarioId);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            Inquilino i = new Inquilino();
            i.setId(rs.getInt("id"));
            i.setNombre(rs.getString("nombre"));
            i.setApellido(rs.getString("apellido"));
            i.setDni(rs.getString("dni"));
            i.setEdad(rs.getInt("edad"));
            i.setSexo(rs.getString("sexo"));
            i.setTelefono(rs.getString("telefono"));
            i.setEmail(rs.getString("email"));
            i.setFotografia(rs.getString("fotografia"));
            i.setEstado(rs.getString("estado"));
            i.setFechaRegistro(rs.getDate("fecha_registro"));
            i.setUsuarioId(rs.getInt("usuario_id"));
            return i;
        }
        
    } catch (SQLException e) {
        System.out.println("Error buscando inquilino por usuario: " + e.getMessage());
    }
    
    return null;
}
public boolean desactivar(int id) {

    // Primero obtener el usuario_id del inquilino
    String sqlGetUsuario = "SELECT usuario_id FROM inquilino WHERE id = ?";
    int usuarioId = -1;
    
    try (Connection conexion = Conexion.conectar();
         PreparedStatement ps = conexion.prepareStatement(sqlGetUsuario)) {
        
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            usuarioId = rs.getInt("usuario_id");
        }
        
    } catch (SQLException e) {
        System.out.println("Error obteniendo usuario_id: " + e.getMessage());
        return false;
    }
    
    // Actualizar estado del inquilino
    String sqlUpdateInquilino = """
        UPDATE inquilino
        SET estado = 'INACTIVO'
        WHERE id = ?
        """;
    
    try (Connection conexion = Conexion.conectar();
         PreparedStatement ps = conexion.prepareStatement(sqlUpdateInquilino)) {
        
        ps.setInt(1, id);
        int resultado = ps.executeUpdate();
        
        // Si se actualizó el inquilino, actualizar también el usuario
        if (resultado > 0 && usuarioId != -1) {
            UsuarioDAO usuarioDAO = new UsuarioDAO();
            usuarioDAO.desactivar(usuarioId);
        }
        
        return resultado > 0;
        
    } catch (SQLException e) {
        System.out.println("Error desactivando inquilino: " + e.getMessage());
    }
    
    return false;
}

public boolean activar(int id) {

    // Primero obtener el usuario_id del inquilino
    String sqlGetUsuario = "SELECT usuario_id FROM inquilino WHERE id = ?";
    int usuarioId = -1;
    
    try (Connection conexion = Conexion.conectar();
         PreparedStatement ps = conexion.prepareStatement(sqlGetUsuario)) {
        
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            usuarioId = rs.getInt("usuario_id");
        }
        
    } catch (SQLException e) {
        System.out.println("Error obteniendo usuario_id: " + e.getMessage());
        return false;
    }
    
    // Actualizar estado del inquilino
    String sqlUpdateInquilino = """
        UPDATE inquilino
        SET estado = 'ACTIVO'
        WHERE id = ?
        """;
    
    try (Connection conexion = Conexion.conectar();
         PreparedStatement ps = conexion.prepareStatement(sqlUpdateInquilino)) {
        
        ps.setInt(1, id);
        int resultado = ps.executeUpdate();
        
        // Si se actualizó el inquilino, actualizar también el usuario
        if (resultado > 0 && usuarioId != -1) {
            UsuarioDAO usuarioDAO = new UsuarioDAO();
            usuarioDAO.activar(usuarioId);
        }
        
        return resultado > 0;
        
    } catch (SQLException e) {
        System.out.println("Error activando inquilino: " + e.getMessage());
    }
    
    return false;
}
    
}
