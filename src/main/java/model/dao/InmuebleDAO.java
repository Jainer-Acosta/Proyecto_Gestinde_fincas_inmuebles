/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.dao;

import java.sql.*;
import java.util.*;
import model.entity.Inmueble;

/**
 *
 * @author Jainer Acosta
 */
public class InmuebleDAO {

    /*
     * INSERTAR INMUEBLE
     */
    public boolean guardar(Inmueble inmueble) {

        String sql = """
                INSERT INTO inmueble
                (
                    tipo,
                    direccion,
                    numero,
                    codigo_postal,
                    ciudad,
                    estado
                )
                VALUES (?, ?, ?, ?, ?, ?)
                """;

        try (
                Connection conexion = Conexion.conectar();

                PreparedStatement ps =
                        conexion.prepareStatement(sql)
        ) {

            ps.setString(1, inmueble.getTipo());

            ps.setString(2, inmueble.getDireccion());

            ps.setString(3, inmueble.getNumero());

            ps.setString(4, inmueble.getCodigoPostal());

            ps.setString(5, inmueble.getCiudad());

            ps.setString(6, inmueble.getEstado());

            int filas = ps.executeUpdate();

            return filas > 0;

        } catch (SQLException e) {

            System.out.println(
                    "Error guardando inmueble: "
                    + e.getMessage()
            );
        }

        return false;
    }

    /*
     * LISTAR TODOS
     */
    public List<Inmueble> listar() {

        List<Inmueble> lista =
                new ArrayList<>();

        String sql = """
                SELECT * FROM inmueble
                """;

        try (
                Connection conexion = Conexion.conectar();

                PreparedStatement ps =
                        conexion.prepareStatement(sql);

                ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                Inmueble inmueble =
                        new Inmueble();

                inmueble.setId(
                        rs.getInt("id")
                );

                inmueble.setTipo(
                        rs.getString("tipo")
                );

                inmueble.setDireccion(
                        rs.getString("direccion")
                );

                inmueble.setNumero(
                        rs.getString("numero")
                );

                inmueble.setCodigoPostal(
                        rs.getString("codigo_postal")
                );

                inmueble.setCiudad(
                        rs.getString("ciudad")
                );

                inmueble.setEstado(
                        rs.getString("estado")
                );

                lista.add(inmueble);
            }

        } catch (SQLException e) {

            System.out.println(
                    "Error listando inmuebles: "
                    + e.getMessage()
            );
        }

        return lista;
    }

    /*
     * BUSCAR POR ID
     */
    public Inmueble buscarPorId(int id) {

        String sql = """
                SELECT * FROM inmueble
                WHERE id = ?
                """;

        Inmueble inmueble = null;

        try (
                Connection conexion = Conexion.conectar();

                PreparedStatement ps =
                        conexion.prepareStatement(sql)
        ) {

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                inmueble = new Inmueble();

                inmueble.setId(
                        rs.getInt("id")
                );

                inmueble.setTipo(
                        rs.getString("tipo")
                );

                inmueble.setDireccion(
                        rs.getString("direccion")
                );

                inmueble.setNumero(
                        rs.getString("numero")
                );

                inmueble.setCodigoPostal(
                        rs.getString("codigo_postal")
                );

                inmueble.setCiudad(
                        rs.getString("ciudad")
                );

                inmueble.setEstado(
                        rs.getString("estado")
                );
            }

        } catch (SQLException e) {

            System.out.println(
                    "Error buscando inmueble: "
                    + e.getMessage()
            );
        }

        return inmueble;
    }

    /*
     * ACTUALIZAR
     */
    public boolean actualizar(Inmueble inmueble) {

        String sql = """
                UPDATE inmueble
                SET
                    tipo = ?,
                    direccion = ?,
                    numero = ?,
                    codigo_postal = ?,
                    ciudad = ?,
                    estado = ?
                WHERE id = ?
                """;

        try (
                Connection conexion = Conexion.conectar();

                PreparedStatement ps =
                        conexion.prepareStatement(sql)
        ) {

            ps.setString(1, inmueble.getTipo());

            ps.setString(2, inmueble.getDireccion());

            ps.setString(3, inmueble.getNumero());

            ps.setString(4, inmueble.getCodigoPostal());

            ps.setString(5, inmueble.getCiudad());

            ps.setString(6, inmueble.getEstado());

            ps.setInt(7, inmueble.getId());

            int filas = ps.executeUpdate();

            return filas > 0;

        } catch (SQLException e) {

            System.out.println(
                    "Error actualizando inmueble: "
                    + e.getMessage()
            );
        }

        return false;
    }

    /*
     * ELIMINAR
     */
    public boolean desactivar(int id) {

        String sql = """
                UPDATE inmueble
                SET estado = 'NO DISPONIBLE'
                WHERE id = ?
                """;

        try (
                Connection conexion = Conexion.conectar();

                PreparedStatement ps =
                        conexion.prepareStatement(sql)
        ) {

            ps.setInt(1, id);

            int filas = ps.executeUpdate();

            return filas > 0;

        } catch (SQLException e) {

            System.out.println(
                    "Error desactivando inmueble: "
                    + e.getMessage()
            );
        }

        return false;
    }
    
    public List<Inmueble> listarDisponibles() {

    List<Inmueble> lista =
            new ArrayList<>();

    String sql = """
            SELECT *
            FROM inmueble
            WHERE estado = 'DISPONIBLE'
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

            Inmueble inmueble =
                    new Inmueble();

            inmueble.setId(
                    rs.getInt("id")
            );

            inmueble.setTipo(
                    rs.getString("tipo")
            );

            inmueble.setDireccion(
                    rs.getString("direccion")
            );

            inmueble.setNumero(
                    rs.getString("numero")
            );

            inmueble.setCodigoPostal(
                    rs.getString("codigo_postal")
            );

            inmueble.setCiudad(
                    rs.getString("ciudad")
            );

            inmueble.setEstado(
                    rs.getString("estado")
            );

            lista.add(inmueble);
        }

    } catch (SQLException e) {

        System.out.println(
                "Error listando disponibles: "
                + e.getMessage()
        );
    }

    return lista;
}
    
}
