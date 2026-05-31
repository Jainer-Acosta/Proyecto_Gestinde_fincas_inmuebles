/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.entity.Alquiler;

/**
 *
 * @author Jainer Acosta
 */
public class AlquilerDAO {
    public boolean guardar(
            Alquiler alquiler) {

        String sql = """
                INSERT INTO alquiler
                (
                    inquilino_id,
                    unidad_inmueble_id,
                    fecha_inicio,
                    fecha_fin,
                    estado
                )
                VALUES (?, ?, ?, ?, ?)
                """;

        try (
                Connection conexion =
                        Conexion.conectar()
        ) {

            conexion.setAutoCommit(false);

            /*
             * INSERT ALQUILER
             */
            PreparedStatement ps =
                    conexion.prepareStatement(sql);

            ps.setInt(
                    1,
                    alquiler.getInquilinoId()
            );

            ps.setInt(
                    2,
                    alquiler.getUnidadInmuebleId()
            );

            ps.setDate(
                    3,
                    alquiler.getFechaInicio()
            );

            ps.setDate(
                    4,
                    alquiler.getFechaFin()
            );

            ps.setString(
                    5,
                    alquiler.getEstado()
            );

            ps.executeUpdate();

            /*
             * CAMBIAR ESTADO INMUEBLE
             */
            String sqlUpdate = """
                    UPDATE unidad_inmueble
                    SET estado = 'ALQUILADO'
                    WHERE id = ?
                    """;

            PreparedStatement ps2 =
                    conexion.prepareStatement(
                            sqlUpdate
                    );

            ps2.setInt(
                    1,
                    alquiler.getUnidadInmuebleId()
            );

            ps2.executeUpdate();

            conexion.commit();

            return true;

        } catch (SQLException e) {

            System.out.println(
                    "Error alquiler: "
                    + e.getMessage()
            );
        }

        return false;
    }
    
    public List<Object[]> listar() {

    List<Object[]> lista =
            new ArrayList<>();

    String sql = """
        SELECT
            a.id,
            i.nombre,
            i.apellido,
            e.nombre AS edificio,
            u.tipo,
            u.planta,
            u.letra,
            a.fecha_inicio,
            a.fecha_fin,
            a.estado
        FROM alquiler a

        INNER JOIN inquilino i
            ON a.inquilino_id = i.id

        INNER JOIN unidad_inmueble u
            ON a.unidad_inmueble_id = u.id

        INNER JOIN edificio e
            ON u.edificio_id = e.id

        ORDER BY a.id DESC
        """;

    try (
            Connection conexion =
                    Conexion.conectar();

            PreparedStatement ps =
                    conexion.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery()
    ) {

        while (rs.next()) {

            Object[] fila =
                    new Object[10];

            fila[0] = rs.getInt("id");

            fila[1] = rs.getString("nombre");

            fila[2] = rs.getString("apellido");

            fila[3] = rs.getString("edificio");

            fila[4] = rs.getString("tipo");

            fila[5] = rs.getString("planta");

            fila[6] = rs.getString("letra");

            fila[7] = rs.getDate("fecha_inicio");

            fila[8] = rs.getDate("fecha_fin");

            fila[9] = rs.getString("estado");
            lista.add(fila);
        }

    } catch (SQLException e) {

        System.out.println(
                "Error listando alquileres: "
                + e.getMessage()
        );
    }

    return lista;
}
    
    public boolean finalizar(
        int id,
        int unidadId) {

    String sql = """
            UPDATE alquiler
            SET estado='FINALIZADO'
            WHERE id=?
            """;

    try (
            Connection conexion =
                    Conexion.conectar();

            PreparedStatement ps =
                    conexion.prepareStatement(sql)
    ) {

        ps.setInt(1, id);

        int filas =
                ps.executeUpdate();

        if(filas > 0){

            liberarUnidad(
                    unidadId
            );

            return true;
        }

    } catch (SQLException e) {

        System.out.println(
                "Error finalizar alquiler: "
                + e.getMessage()
        );
    }

    return false;
}
    
private void liberarUnidad(
        int unidadId) {

    String sql = """
            UPDATE unidad_inmueble
            SET estado='DISPONIBLE'
            WHERE id=?
            """;

    try (
            Connection conexion =
                    Conexion.conectar();

            PreparedStatement ps =
                    conexion.prepareStatement(sql)
    ) {

        ps.setInt(1, unidadId);

        ps.executeUpdate();

    } catch (SQLException e) {

        System.out.println(
                e.getMessage()
        );
    }
}
    
    
    public List<Object[]> listarActivos() {

    List<Object[]> lista =
            new ArrayList<>();

String sql = """
        SELECT
            a.id,
            i.nombre,
            i.apellido,
            e.nombre AS edificio,
            u.tipo,
            u.planta,
            u.letra
        FROM alquiler a

        INNER JOIN inquilino i
            ON a.inquilino_id = i.id

        INNER JOIN unidad_inmueble u
            ON a.unidad_inmueble_id = u.id

        INNER JOIN edificio e
            ON u.edificio_id = e.id

        WHERE a.estado = 'ACTIVO'
        """;

    try (
            Connection conexion =
                    Conexion.conectar();

            PreparedStatement ps =
                    conexion.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery()
    ) {

        while (rs.next()) {

            Object[] fila =
                    new Object[7];

            fila[0] =
        rs.getInt("id");

        fila[1] =
                rs.getString("nombre");

        fila[2] =
                rs.getString("apellido");

        fila[3] =
                rs.getString("edificio");

        fila[4] =
                rs.getString("tipo");

        fila[5] =
                rs.getString("planta");

        fila[6] =
                rs.getString("letra");

            lista.add(fila);
        }

    } catch (SQLException e) {

        System.out.println(
                "Error alquileres activos: "
                + e.getMessage()
        );
    }

    return lista;
}

    // Obtener alquiler activo por usuario ID
public Object[] obtenerAlquilerActivoPorUsuario(int usuarioId) {
    String sql = """
        SELECT 
            e.nombre AS edificio,
            u.tipo,
            u.planta,
            u.letra,
            a.fecha_inicio,
            a.fecha_fin,
            a.estado
        FROM alquiler a
        INNER JOIN unidad_inmueble u ON a.unidad_inmueble_id = u.id
        INNER JOIN edificio e ON u.edificio_id = e.id
        INNER JOIN inquilino i ON a.inquilino_id = i.id
        WHERE i.usuario_id = ? AND a.estado = 'ACTIVO'
        """;
    
    try (Connection conexion = Conexion.conectar();
         PreparedStatement ps = conexion.prepareStatement(sql)) {
        
        ps.setInt(1, usuarioId);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            Object[] fila = new Object[7];
            fila[0] = rs.getString("edificio");
            fila[1] = rs.getString("tipo");
            fila[2] = rs.getString("planta");
            fila[3] = rs.getString("letra");
            fila[4] = rs.getDate("fecha_inicio");
            fila[5] = rs.getDate("fecha_fin");
            fila[6] = rs.getString("estado");
            return fila;
        }
        
    } catch (SQLException e) {
        System.out.println("Error obteniendo alquiler activo: " + e.getMessage());
    }
    
    return null;
}

    
}

