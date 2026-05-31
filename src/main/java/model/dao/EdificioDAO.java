package model.dao;

import model.entity.Edificio;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EdificioDAO {

    public boolean guardar(
            Edificio edificio) {

        String sql = """
                INSERT INTO edificio
                (
                    nombre,
                    direccion,
                    numero,
                    codigo_postal,
                    ciudad,
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

            ps.setString(
                    1,
                    edificio.getNombre()
            );

            ps.setString(
                    2,
                    edificio.getDireccion()
            );

            ps.setString(
                    3,
                    edificio.getNumero()
            );

            ps.setString(
                    4,
                    edificio.getCodigoPostal()
            );

            ps.setString(
                    5,
                    edificio.getCiudad()
            );

            ps.setString(
                    6,
                    edificio.getEstado()
            );

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {

            System.out.println(
                    "Error edificio: "
                    + e.getMessage()
            );
        }

        return false;
    }
    
    public List<Edificio> listar() {

    List<Edificio> lista =
            new ArrayList<>();

    String sql =
            "SELECT * FROM edificio";

    try (
            Connection conexion =
                    Conexion.conectar();

            PreparedStatement ps =
                    conexion.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery()
    ) {

        while(rs.next()){

            Edificio e =
                    new Edificio();

            e.setId(
                    rs.getInt("id")
            );

            e.setNombre(
                    rs.getString(
                            "nombre"
                    )
            );

            e.setDireccion(
                    rs.getString(
                            "direccion"
                    )
            );

            e.setNumero(
                    rs.getString(
                            "numero"
                    )
            );

            e.setCodigoPostal(
                    rs.getString(
                            "codigo_postal"
                    )
            );

            e.setCiudad(
                    rs.getString(
                            "ciudad"
                    )
            );

            e.setEstado(
                    rs.getString(
                            "estado"
                    )
            );

            lista.add(e);
        }

    } catch (SQLException e) {

        System.out.println(
                "Error listar edificios: "
                + e.getMessage()
        );
    }

    return lista;
}
    public Edificio obtenerPorId(
        int id) {

    String sql =
            "SELECT * FROM edificio WHERE id=?";

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

            Edificio e =
                    new Edificio();

            e.setId(
                    rs.getInt("id")
            );

            e.setNombre(
                    rs.getString(
                            "nombre"
                    )
            );

            e.setDireccion(
                    rs.getString(
                            "direccion"
                    )
            );

            e.setNumero(
                    rs.getString(
                            "numero"
                    )
            );

            e.setCodigoPostal(
                    rs.getString(
                            "codigo_postal"
                    )
            );

            e.setCiudad(
                    rs.getString(
                            "ciudad"
                    )
            );

            e.setEstado(
                    rs.getString(
                            "estado"
                    )
            );

            return e;
        }

    } catch (SQLException e) {

        System.out.println(
                "Error obtener edificio: "
                + e.getMessage()
        );
    }

    return null;
}
    public boolean actualizar(
        Edificio edificio) {

    String sql = """
            UPDATE edificio
            SET
                nombre=?,
                direccion=?,
                numero=?,
                codigo_postal=?,
                ciudad=?,
                estado=?
            WHERE id=?
            """;

    try (
            Connection conexion =
                    Conexion.conectar();

            PreparedStatement ps =
                    conexion.prepareStatement(sql)
    ) {

        ps.setString(
                1,
                edificio.getNombre()
        );

        ps.setString(
                2,
                edificio.getDireccion()
        );

        ps.setString(
                3,
                edificio.getNumero()
        );

        ps.setString(
                4,
                edificio.getCodigoPostal()
        );

        ps.setString(
                5,
                edificio.getCiudad()
        );

        ps.setString(
                6,
                edificio.getEstado()
        );

        ps.setInt(
                7,
                edificio.getId()
        );

        return ps.executeUpdate() > 0;

    } catch (SQLException e) {

        System.out.println(
                "Error actualizar edificio: "
                + e.getMessage()
        );
    }

    return false;
}
    public boolean desactivar(
        int id) {

    String sql = """
            UPDATE edificio
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
                "Error desactivar edificio: "
                + e.getMessage()
        );
    }

    return false;
}
}