package model.dao;

import model.entity.UnidadInmueble;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

public class UnidadInmuebleDAO {

    public boolean guardar(
            UnidadInmueble unidad) {

        String sql = """
                INSERT INTO unidad_inmueble
                (
                    edificio_id,
                    tipo,
                    planta,
                    letra,
                    descripcion,
                    estado
                )
                VALUES (?, ?, ?, ?, ?, ?)
                """;

        try (
                Connection conexion =
                        Conexion.conectar();

                PreparedStatement ps =
                        conexion.prepareStatement(sql)
        ) {

            ps.setInt(
                    1,
                    unidad.getEdificioId()
            );

            ps.setString(
                    2,
                    unidad.getTipo()
            );

            ps.setString(
                    3,
                    unidad.getPlanta()
            );

            ps.setString(
                    4,
                    unidad.getLetra()
            );

            ps.setString(
                    5,
                    unidad.getDescripcion()
            );

            ps.setString(
                    6,
                    unidad.getEstado()
            );

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {

            System.out.println(
                    "Error guardar unidad: "
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
                u.id,
                e.nombre,
                u.tipo,
                u.planta,
                u.letra,
                u.descripcion,
                u.estado
                FROM unidad_inmueble u
                INNER JOIN edificio e
                ON u.edificio_id = e.id
                """;

        try (
                Connection conexion =
                        Conexion.conectar();

                PreparedStatement ps =
                        conexion.prepareStatement(sql);

                ResultSet rs =
                        ps.executeQuery()
        ) {

            while(rs.next()){

                Object[] fila =
                        new Object[7];

                fila[0] =
                        rs.getInt("id");

                fila[1] =
                        rs.getString("nombre");

                fila[2] =
                        rs.getString("tipo");

                fila[3] =
                        rs.getString("planta");

                fila[4] =
                        rs.getString("letra");

                fila[5] =
                        rs.getString(
                                "descripcion"
                        );

                fila[6] =
                        rs.getString("estado");

                lista.add(fila);
            }

        } catch (SQLException e) {

            System.out.println(
                    "Error listar unidades: "
                    + e.getMessage()
            );
        }

        return lista;
    }

    public UnidadInmueble obtenerPorId(
            int id) {

        String sql = """
                SELECT *
                FROM unidad_inmueble
                WHERE id=?
                """;

        try (
                Connection conexion =
                        Conexion.conectar();

                PreparedStatement ps =
                        conexion.prepareStatement(sql)
        ) {

            ps.setInt(1, id);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()){

                UnidadInmueble u =
                        new UnidadInmueble();

                u.setId(
                        rs.getInt("id")
                );

                u.setEdificioId(
                        rs.getInt(
                                "edificio_id"
                        )
                );

                u.setTipo(
                        rs.getString("tipo")
                );

                u.setPlanta(
                        rs.getString(
                                "planta"
                        )
                );

                u.setLetra(
                        rs.getString("letra")
                );

                u.setDescripcion(
                        rs.getString(
                                "descripcion"
                        )
                );

                u.setEstado(
                        rs.getString(
                                "estado"
                        )
                );

                return u;
            }

        } catch (SQLException e) {

            System.out.println(
                    "Error obtener unidad: "
                    + e.getMessage()
            );
        }

        return null;
    }

    public boolean actualizar(
            UnidadInmueble unidad) {

        String sql = """
                UPDATE unidad_inmueble
                SET
                    edificio_id=?,
                    tipo=?,
                    planta=?,
                    letra=?,
                    descripcion=?,
                    estado=?
                WHERE id=?
                """;

        try (
                Connection conexion =
                        Conexion.conectar();

                PreparedStatement ps =
                        conexion.prepareStatement(sql)
        ) {

            ps.setInt(
                    1,
                    unidad.getEdificioId()
            );

            ps.setString(
                    2,
                    unidad.getTipo()
            );

            ps.setString(
                    3,
                    unidad.getPlanta()
            );

            ps.setString(
                    4,
                    unidad.getLetra()
            );

            ps.setString(
                    5,
                    unidad.getDescripcion()
            );

            ps.setString(
                    6,
                    unidad.getEstado()
            );

            ps.setInt(
                    7,
                    unidad.getId()
            );

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {

            System.out.println(
                    "Error actualizar unidad: "
                    + e.getMessage()
            );
        }

        return false;
    }

    public boolean desactivar(
            int id) {

        String sql = """
                UPDATE unidad_inmueble
                SET estado='NO DISPONIBLE'
                WHERE id=?
                """;

        try (
                Connection conexion =
                        Conexion.conectar();

                PreparedStatement ps =
                        conexion.prepareStatement(sql)
        ) {

            ps.setInt(1, id);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {

            System.out.println(
                    "Error desactivar unidad: "
                    + e.getMessage()
            );
        }

        return false;
    }
    
    public List<Object[]> listarDisponibles() {

    List<Object[]> lista =
            new ArrayList<>();

    String sql = """
            SELECT
            u.id,
            e.nombre,
            u.tipo,
            u.planta,
            u.letra
            FROM unidad_inmueble u
            INNER JOIN edificio e
            ON u.edificio_id = e.id
            WHERE u.estado='DISPONIBLE'
            """;

    try (
            Connection conexion =
                    Conexion.conectar();

            PreparedStatement ps =
                    conexion.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery()
    ) {

        while(rs.next()){

            Object[] fila =
                    new Object[5];

            fila[0] =
                    rs.getInt("id");

            fila[1] =
                    rs.getString("nombre");

            fila[2] =
                    rs.getString("tipo");

            fila[3] =
                    rs.getString("planta");

            fila[4] =
                    rs.getString("letra");

            lista.add(fila);
        }

    } catch (SQLException e) {

        System.out.println(
                "Error unidades disponibles: "
                + e.getMessage()
        );
    }

    return lista;
}
    
        public UnidadInmueble buscarPorId(
        int id) {

    UnidadInmueble unidad =
            null;

    String sql = """
            SELECT *
            FROM unidad_inmueble
            WHERE id = ?
            """;

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

            unidad =
                    new UnidadInmueble();

            unidad.setId(
                    rs.getInt("id")
            );

            unidad.setEdificioId(
                    rs.getInt("edificio_id")
            );

            unidad.setTipo(
                    rs.getString("tipo")
            );

            unidad.setPlanta(
                    rs.getString("planta")
            );

            unidad.setLetra(
                    rs.getString("letra")
            );

            unidad.setEstado(
                    rs.getString("estado")
            );
        }

    } catch (SQLException e) {

        System.out.println(
                e.getMessage()
        );
    }

    return unidad;
}
        public List<Object[]> listarPorEdificio() {

    List<Object[]> lista =
            new ArrayList<>();

    String sql = """
            SELECT
                e.nombre AS edificio,
                u.tipo,
                u.planta,
                u.letra,
                u.descripcion,
                u.estado
            FROM unidad_inmueble u
            INNER JOIN edificio e
                ON u.edificio_id = e.id
            ORDER BY e.nombre
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
                    new Object[6];

            fila[0] =
                    rs.getString("edificio");

            fila[1] =
                    rs.getString("tipo");

            fila[2] =
                    rs.getString("planta");

            fila[3] =
                    rs.getString("letra");

            fila[4] =
                    rs.getString("descripcion");

            fila[5] =
                    rs.getString("estado");

            lista.add(fila);
        }

    } catch (SQLException e) {

        System.out.println(
                "Error reporte unidades: "
                + e.getMessage()
        );
    }

    return lista;
}

}