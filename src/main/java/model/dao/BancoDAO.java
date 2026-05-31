package model.dao;

import model.entity.Banco;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

public class BancoDAO {

    public List<Banco> listar() {

        List<Banco> lista =
                new ArrayList<>();

        String sql =
                "SELECT * FROM banco";

        try (
                Connection conexion =
                        Conexion.conectar();

                PreparedStatement ps =
                        conexion.prepareStatement(sql);

                ResultSet rs =
                        ps.executeQuery()
        ) {

            while (rs.next()) {

                Banco banco =
                        new Banco();

                banco.setId(
                        rs.getInt("id")
                );

                banco.setNombre(
                        rs.getString(
                                "nombre"
                        )
                );

                lista.add(banco);
            }

        } catch (SQLException e) {

            System.out.println(
                    "Error bancos: "
                    + e.getMessage()
            );
        }

        return lista;
    }
}