package model.dao;

import model.entity.MovimientoBancario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

public class MovimientoBancarioDAO {

    public boolean guardar(
            MovimientoBancario m) {

        String sql = """
                INSERT INTO movimiento_bancario
                (
                    cuenta_id,
                    unidad_inmueble_id,
                    tipo,
                    concepto,
                    categoria,
                    monto,
                    fecha,
                    descripcion
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)
                """;

        try (
                Connection conexion =
                        Conexion.conectar();

                PreparedStatement ps =
                        conexion.prepareStatement(sql)
        ) {

            ps.setInt(
                    1,
                    m.getCuentaId()
            );

            ps.setInt(
                    2,
                    m.getUnidadInmuebleId()
            );

            ps.setString(
                    3,
                    m.getTipo()
            );

            ps.setString(
                    4,
                    m.getConcepto()
            );
            
            ps.setString(5, 
                    m.getCategoria()
            );

            ps.setDouble(
                    6,
                    m.getMonto()
            );

            ps.setDate(
                    7,
                    m.getFecha()
            );

            ps.setString(
                    8,
                    m.getDescripcion()
            );

            int filas =
                    ps.executeUpdate();

            if(filas > 0){

                actualizarSaldo(
                        m.getCuentaId(),
                        m.getMonto(),
                        m.getTipo()
                );

                return true;
            }

        } catch (SQLException e) {

            System.out.println(
                    "Error movimiento: "
                    + e.getMessage()
            );
        }

        return false;
    }

    private void actualizarSaldo(
            int cuentaId,
            double monto,
            String tipo) {

        String sql;

        if(tipo.equals("INGRESO")){

            sql = """
                    UPDATE cuenta_bancaria
                    SET saldo = saldo + ?
                    WHERE id = ?
                    """;

        }else{

            sql = """
                    UPDATE cuenta_bancaria
                    SET saldo = saldo - ?
                    WHERE id = ?
                    """;
        }

        try (
                Connection conexion =
                        Conexion.conectar();

                PreparedStatement ps =
                        conexion.prepareStatement(sql)
        ) {

            ps.setDouble(1, monto);

            ps.setInt(2, cuentaId);

            ps.executeUpdate();

        } catch (SQLException e) {

            System.out.println(
                    "Error saldo: "
                    + e.getMessage()
            );
        }
    }

    public List<Object[]> listar() {

        List<Object[]> lista =
                new ArrayList<>();

        String sql = """
                SELECT
                    m.id,
                    c.numero_cuenta,
                    e.nombre,
                    u.tipo AS tipo_unidad,
                    m.tipo AS tipo_movimiento,
                    m.concepto,
                    m.monto,
                    m.fecha
                    FROM movimiento_bancario m
                    INNER JOIN cuenta_bancaria c
                    ON m.cuenta_id = c.id
                    INNER JOIN unidad_inmueble u
                    ON m.unidad_inmueble_id = u.id
                    INNER JOIN edificio e
                    ON u.edificio_id = e.id
                    ORDER BY m.fecha DESC
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
                        new Object[8];

                fila[0] =
                        rs.getInt("id");

                fila[1] =
                        rs.getString(
                                "numero_cuenta"
                        );

                fila[2] =
                        rs.getString("nombre");

                fila[3] =
                        rs.getString("tipo_unidad");

                fila[4] =
                        rs.getString("tipo_movimiento");

                fila[5] =
                        rs.getString(
                                "concepto"
                        );

                fila[6] =
                        rs.getDouble("monto");

                fila[7] =
                        rs.getDate("fecha");

                lista.add(fila);
            }

        } catch (SQLException e) {

            System.out.println(
                    "Error listar movimientos: "
                    + e.getMessage()
            );
        }

        return lista;
    }
    
    public Object[] resumenFinanciero() {

    Object[] datos =
            new Object[2];

    String ingresosSql = """
            SELECT IFNULL(SUM(monto),0)
            FROM movimiento_bancario
            WHERE tipo='INGRESO'
            """;

    String gastosSql = """
            SELECT IFNULL(SUM(monto),0)
            FROM movimiento_bancario
            WHERE tipo='GASTO'
            """;

    try (
            Connection conexion =
                    Conexion.conectar()
    ) {

        PreparedStatement ps1 =
                conexion.prepareStatement(
                        ingresosSql
                );

        ResultSet rs1 =
                ps1.executeQuery();

        if(rs1.next()){

            datos[0] =
                    rs1.getDouble(1);
        }

        PreparedStatement ps2 =
                conexion.prepareStatement(
                        gastosSql
                );

        ResultSet rs2 =
                ps2.executeQuery();

        if(rs2.next()){

            datos[1] =
                    rs2.getDouble(1);
        }

    } catch (SQLException e) {

        System.out.println(
                e.getMessage()
        );
    }

    return datos;
}
    
    public double totalIngresos() {

    String sql = """
            SELECT
            COALESCE(
                SUM(monto),
                0
            )
            total
            FROM movimiento_bancario
            WHERE tipo='INGRESO'
            """;

    try(
            Connection conexion =
                    Conexion.conectar();

            PreparedStatement ps =
                    conexion.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery()
    ){

        if(rs.next()){

            return rs.getDouble(
                    "total"
            );
        }

    } catch(SQLException e){

        System.out.println(
                e.getMessage()
        );
    }

    return 0;
}
    
    
    public double totalGastos() {

    String sql = """
            SELECT
            COALESCE(
                SUM(monto),
                0
            )
            total
            FROM movimiento_bancario
            WHERE tipo='GASTO'
            """;

    try(
            Connection conexion =
                    Conexion.conectar();

            PreparedStatement ps =
                    conexion.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery()
    ){

        if(rs.next()){

            return rs.getDouble(
                    "total"
            );
        }

    } catch(SQLException e){

        System.out.println(
                e.getMessage()
        );
    }

    return 0;
}
    
    public double saldoGeneral() {

    return totalIngresos()
            - totalGastos();
}
}