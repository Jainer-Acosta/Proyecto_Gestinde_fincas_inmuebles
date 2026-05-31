package model.dao;

import model.entity.CuentaBancaria;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

public class CuentaBancariaDAO {

    public boolean guardar(
            CuentaBancaria cuenta) {

        String sql = """
                INSERT INTO cuenta_bancaria
                (
                    banco_id,
                    numero_cuenta,
                    saldo
                )
                VALUES (?, ?, ?)
                """;

        try (
                Connection conexion =
                        Conexion.conectar();

                PreparedStatement ps =
                        conexion.prepareStatement(sql)
        ) {

            ps.setInt(
                    1,
                    cuenta.getBancoId()
            );

            ps.setString(
                    2,
                    cuenta.getNumeroCuenta()
            );

            ps.setDouble(
                    3,
                    cuenta.getSaldo()
            );

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {

            System.out.println(
                    "Error guardando cuenta: "
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
                    c.id,
                    b.nombre,
                    c.numero_cuenta,
                    c.saldo
                FROM cuenta_bancaria c
                INNER JOIN banco b
                    ON c.banco_id = b.id
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
                        new Object[4];

                fila[0] =
                        rs.getInt("id");

                fila[1] =
                        rs.getString("nombre");

                fila[2] =
                        rs.getString(
                                "numero_cuenta"
                        );

                fila[3] =
                        rs.getDouble("saldo");

                lista.add(fila);
            }

        } catch (SQLException e) {

            System.out.println(
                    "Error cuentas: "
                    + e.getMessage()
            );
        }

        return lista;
    }
    
    public List<CuentaBancaria> listarCuentas() {

    List<CuentaBancaria> lista =
            new ArrayList<>();

    String sql =
            "SELECT * FROM cuenta_bancaria";

    try (
            Connection conexion =
                    Conexion.conectar();

            PreparedStatement ps =
                    conexion.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery()
    ) {

        while (rs.next()) {

            CuentaBancaria c =
                    new CuentaBancaria();

            c.setId(
                    rs.getInt("id")
            );

            c.setBancoId(
                    rs.getInt("banco_id")
            );

            c.setNumeroCuenta(
                    rs.getString(
                            "numero_cuenta"
                    )
            );

            c.setSaldo(
                    rs.getDouble("saldo")
            );

            lista.add(c);
        }

    } catch (SQLException e) {

        System.out.println(
                "Error cuentas: "
                + e.getMessage()
        );
    }

    return lista;
}
}