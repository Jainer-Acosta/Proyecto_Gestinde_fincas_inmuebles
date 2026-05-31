package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.sql.SQLException;

public class ReporteDAO {

    public double totalIngresos() {

        String sql = """
                SELECT
                IFNULL(SUM(monto),0)
                AS total
                FROM movimiento_bancario
                WHERE tipo = 'INGRESO'
                """;

        try (
                Connection conexion =
                        Conexion.conectar();

                PreparedStatement ps =
                        conexion.prepareStatement(sql);

                ResultSet rs =
                        ps.executeQuery()
        ) {

            if(rs.next()){

                return rs.getDouble(
                        "total"
                );
            }

        } catch (SQLException e) {

            System.out.println(
                    "Error ingresos: "
                    + e.getMessage()
            );
        }

        return 0;
    }

    public double totalGastos() {

        String sql = """
                SELECT
                IFNULL(SUM(monto),0)
                AS total
                FROM movimiento_bancario
                WHERE tipo = 'GASTO'
                """;

        try (
                Connection conexion =
                        Conexion.conectar();

                PreparedStatement ps =
                        conexion.prepareStatement(sql);

                ResultSet rs =
                        ps.executeQuery()
        ) {

            if(rs.next()){

                return rs.getDouble(
                        "total"
                );
            }

        } catch (SQLException e) {

            System.out.println(
                    "Error gastos: "
                    + e.getMessage()
            );
        }

        return 0;
    }

    public int recibosPendientes() {

        String sql = """
                SELECT COUNT(*)
                AS total
                FROM recibo
                WHERE estado = 'PENDIENTE'
                """;

        try (
                Connection conexion =
                        Conexion.conectar();

                PreparedStatement ps =
                        conexion.prepareStatement(sql);

                ResultSet rs =
                        ps.executeQuery()
        ) {

            if(rs.next()){

                return rs.getInt(
                        "total"
                );
            }

        } catch (SQLException e) {

            System.out.println(
                    "Error recibos: "
                    + e.getMessage()
            );
        }

        return 0;
    }

    public int inmueblesAlquilados() {

        String sql = """
                SELECT COUNT(*)
                AS total
                FROM alquiler
                WHERE estado = 'ACTIVO'
                """;

        try (
                Connection conexion =
                        Conexion.conectar();

                PreparedStatement ps =
                        conexion.prepareStatement(sql);

                ResultSet rs =
                        ps.executeQuery()
        ) {

            if(rs.next()){

                return rs.getInt(
                        "total"
                );
            }

        } catch (SQLException e) {

            System.out.println(
                    "Error alquileres: "
                    + e.getMessage()
            );
        }

        return 0;
    }

    public double saldoGeneral() {

        String sql = """
                SELECT
                IFNULL(SUM(saldo),0)
                AS total
                FROM cuenta_bancaria
                """;

        try (
                Connection conexion =
                        Conexion.conectar();

                PreparedStatement ps =
                        conexion.prepareStatement(sql);

                ResultSet rs =
                        ps.executeQuery()
        ) {

            if(rs.next()){

                return rs.getDouble(
                        "total"
                );
            }

        } catch (SQLException e) {

            System.out.println(
                    "Error saldo: "
                    + e.getMessage()
            );
        }

        return 0;
    }
    
    public double ingresosMes() {

    String sql = """
            SELECT
            IFNULL(SUM(monto),0)
            AS total
            FROM movimiento_bancario
            WHERE tipo = 'INGRESO'
            AND MONTH(fecha) = MONTH(CURDATE())
            AND YEAR(fecha) = YEAR(CURDATE())
            """;

    try (
            Connection conexion =
                    Conexion.conectar();

            PreparedStatement ps =
                    conexion.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery()
    ) {

        if(rs.next()){

            return rs.getDouble(
                    "total"
            );
        }

    } catch (SQLException e) {

        System.out.println(
                "Error ingresos mes: "
                + e.getMessage()
        );
    }

    return 0;
}

public double gastosMes() {

    String sql = """
            SELECT
            IFNULL(SUM(monto),0)
            AS total
            FROM movimiento_bancario
            WHERE tipo = 'GASTO'
            AND MONTH(fecha) = MONTH(CURDATE())
            AND YEAR(fecha) = YEAR(CURDATE())
            """;

    try (
            Connection conexion =
                    Conexion.conectar();

            PreparedStatement ps =
                    conexion.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery()
    ) {

        if(rs.next()){

            return rs.getDouble(
                    "total"
            );
        }

    } catch (SQLException e) {

        System.out.println(
                "Error gastos mes: "
                + e.getMessage()
        );
    }

    return 0;
}
}