/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.entity.Recibo;

/**
 *
 * @author Jainer Acosta
 */
public class ReciboDAO {
    public boolean guardar(Recibo recibo) {
    String sql = """
        INSERT INTO recibo
        (
            alquiler_id,
            numero_recibo,
            fecha_emision,
            renta,
            agua,
            luz,
            iva,
            porteria,
            ipc,
            otros,
            total,
            estado
        )
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """;

    try (Connection conexion = Conexion.conectar();
         PreparedStatement ps = conexion.prepareStatement(sql)) {

        ps.setInt(1, recibo.getAlquilerId());
        ps.setString(2, recibo.getNumeroRecibo());
        ps.setDate(3, recibo.getFechaEmision());
        ps.setDouble(4, recibo.getRenta());
        ps.setDouble(5, recibo.getAgua());
        ps.setDouble(6, recibo.getLuz());
        ps.setDouble(7, recibo.getIva());
        ps.setDouble(8, recibo.getPorteria());
        ps.setDouble(9, recibo.getIpc());
        ps.setDouble(10, recibo.getOtros());
        ps.setDouble(11, recibo.getTotal());
        ps.setString(12, recibo.getEstado());

        return ps.executeUpdate() > 0;

    } catch (SQLException e) {
        System.out.println("Error guardando recibo: " + e.getMessage());
        return false;
    }
}
    
public List<Object[]> listar() {

    List<Object[]> lista = new ArrayList<>();

    String sql = """
        SELECT
            r.numero_recibo,
            i.nombre,
            i.apellido,
            e.nombre AS edificio,
            u.tipo,
            u.planta,
            u.letra,
            r.fecha_emision,
            r.total,
            r.estado
        FROM recibo r
        INNER JOIN alquiler a ON r.alquiler_id = a.id
        INNER JOIN inquilino i ON a.inquilino_id = i.id
        INNER JOIN unidad_inmueble u ON a.unidad_inmueble_id = u.id
        INNER JOIN edificio e ON u.edificio_id = e.id
        ORDER BY r.fecha_emision DESC
        """;

    try (Connection conexion = Conexion.conectar();
         PreparedStatement ps = conexion.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            Object[] fila = new Object[10];
            fila[0] = rs.getString("numero_recibo");  // Número único por piso/local
            fila[1] = rs.getString("nombre");
            fila[2] = rs.getString("apellido");
            fila[3] = rs.getString("edificio");
            fila[4] = rs.getString("tipo");
            fila[5] = rs.getString("planta");
            fila[6] = rs.getString("letra");
            fila[7] = rs.getDate("fecha_emision");
            fila[8] = rs.getDouble("total");
            fila[9] = rs.getString("estado");
            lista.add(fila);
        }

    } catch (SQLException e) {
        System.out.println("Error listando recibos: " + e.getMessage());
    }

    return lista;
}
    public boolean marcarPagado(
        int id) {

    String sql = """
            UPDATE recibo
            SET estado = 'PAGADO'
            WHERE id = ?
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
                "Error pagando recibo: "
                + e.getMessage()
        );
    }

    return false;
}
public Object[] obtenerDetalleRecibo(
        int id) {

    String sql = """
            SELECT
                r.numero_recibo,
                i.nombre,
                i.apellido,
                e.nombre AS edificio,
                u.tipo,
                u.planta,
                u.letra,
                r.fecha_emision,
                r.renta,
                r.agua,
                r.luz,
                r.iva,
                r.porteria,
                r.ipc,
                r.otros,
                r.total,
                r.estado
            FROM recibo r
            INNER JOIN alquiler a
                ON r.alquiler_id = a.id
            INNER JOIN inquilino i
                ON a.inquilino_id = i.id
            INNER JOIN unidad_inmueble u
                ON a.unidad_inmueble_id = u.id
            INNER JOIN edificio e
                ON u.edificio_id = e.id
            WHERE r.id = ?
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

            Object[] fila =
                    new Object[17];

            fila[0] =
                    rs.getString("numero_recibo");

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

            fila[7] =
                    rs.getDate("fecha_emision");

            fila[8] =
                    rs.getDouble("renta");

            fila[9] =
                    rs.getDouble("agua");

            fila[10] =
                    rs.getDouble("luz");

            fila[11] =
                    rs.getDouble("iva");

            fila[12] =
                    rs.getDouble("porteria");

            fila[13] =
                    rs.getDouble("ipc");

            fila[14] =
                    rs.getDouble("otros");

            fila[15] =
                    rs.getDouble("total");

            fila[16] =
                    rs.getString("estado");

            return fila;
        }

    } catch (SQLException e) {

        System.out.println(
                "Error obteniendo recibo: "
                + e.getMessage()
        );
    }

    return null;
}
    public boolean generarRecibosMensuales() {

    String sql = """
            INSERT INTO recibo
            (
                alquiler_id,
                fecha_emision,
                renta,
                agua,
                luz,
                iva,
                porteria,
                ipc,
                otros,
                total,
                estado
            )
            SELECT
                r.alquiler_id,
                CURDATE(),
                r.renta,
                r.agua,
                r.luz,
                r.iva,
                r.porteria,
                r.ipc,
                r.otros,
                r.total,
                'PENDIENTE'
            FROM recibo r
            WHERE MONTH(r.fecha_emision) =
                    MONTH(CURDATE() - INTERVAL 1 MONTH)
            AND YEAR(r.fecha_emision) =
                    YEAR(CURDATE() - INTERVAL 1 MONTH)

            AND NOT EXISTS (

                SELECT 1
                FROM recibo x
                WHERE x.alquiler_id =
                        r.alquiler_id
                AND MONTH(x.fecha_emision) =
                        MONTH(CURDATE())
                AND YEAR(x.fecha_emision) =
                        YEAR(CURDATE())
            )
            """;

    try (
            Connection conexion =
                    Conexion.conectar();

            PreparedStatement ps =
                    conexion.prepareStatement(sql)
    ) {

        return ps.executeUpdate() > 0;

    } catch (SQLException e) {

        System.out.println(
                "Error generar recibos: "
                + e.getMessage()
        );
    }

    return false;
}
    
    public List<Object[]> listarPorUsuario(int usuarioId) {

    List<Object[]> lista = new ArrayList<>();

    String sql = """
        SELECT
            r.numero_recibo,
            e.nombre AS edificio,
            u.tipo,
            u.planta,
            u.letra,
            r.fecha_emision,
            r.total,
            r.estado
        FROM recibo r
        INNER JOIN alquiler a ON r.alquiler_id = a.id
        INNER JOIN inquilino i ON a.inquilino_id = i.id
        INNER JOIN unidad_inmueble u ON a.unidad_inmueble_id = u.id
        INNER JOIN edificio e ON u.edificio_id = e.id
        WHERE i.usuario_id = ?
        ORDER BY r.fecha_emision DESC
        """;

    try (Connection conexion = Conexion.conectar();
         PreparedStatement ps = conexion.prepareStatement(sql)) {

        ps.setInt(1, usuarioId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Object[] fila = new Object[8];
            fila[0] = rs.getString("numero_recibo");  // Número único
            fila[1] = rs.getString("edificio");
            fila[2] = rs.getString("tipo");
            fila[3] = rs.getString("planta");
            fila[4] = rs.getString("letra");
            fila[5] = rs.getDate("fecha_emision");
            fila[6] = rs.getDouble("total");
            fila[7] = rs.getString("estado");
            lista.add(fila);
        }

    } catch (SQLException e) {
        System.out.println("Error mis recibos: " + e.getMessage());
    }

    return lista;
}
    public List<Object[]> listarPendientes() {

    List<Object[]> lista =
            new ArrayList<>();

    String sql = """
        SELECT
            r.id,
            i.nombre,
            i.apellido,
            e.nombre AS edificio,
            u.tipo,
            r.fecha_emision,
            r.total
        FROM recibo r

        INNER JOIN alquiler a
            ON r.alquiler_id = a.id

        INNER JOIN inquilino i
            ON a.inquilino_id = i.id

        INNER JOIN unidad_inmueble u
            ON a.unidad_inmueble_id = u.id

        INNER JOIN edificio e
            ON u.edificio_id = e.id

        WHERE r.estado = 'PENDIENTE'

        ORDER BY r.fecha_emision DESC
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
                    rs.getString("apellido");

            fila[3] =
                    rs.getString("edificio");

            fila[4] =
                    rs.getString("tipo");

            fila[5] =
                    rs.getDate("fecha_emision");

            fila[6] =
                    rs.getDouble("total");

            lista.add(fila);
        }

    } catch (SQLException e) {

        System.out.println(
                "Error pendientes: "
                + e.getMessage()
        );
    }

    return lista;
}
    
    public List<Object[]> listarPagados() {

    List<Object[]> lista =
            new ArrayList<>();

    String sql = """
        SELECT
            r.id,
            i.nombre,
            i.apellido,
            e.nombre AS edificio,
            u.tipo,
            r.fecha_emision,
            r.total,
            r.estado
        FROM recibo r

        INNER JOIN alquiler a
            ON r.alquiler_id = a.id

        INNER JOIN inquilino i
            ON a.inquilino_id = i.id

        INNER JOIN unidad_inmueble u
            ON a.unidad_inmueble_id = u.id

        INNER JOIN edificio e
            ON u.edificio_id = e.id

        WHERE r.estado = 'PAGADO'

        ORDER BY r.fecha_emision DESC
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
                    new Object[8];

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
                    rs.getDate("fecha_emision");

            fila[6] =
                    rs.getDouble("total");

            fila[7] =
                    rs.getString("estado");

            lista.add(fila);
        }

    } catch (SQLException e) {

        System.out.println(
                "Error recibos pagados: "
                + e.getMessage()
        );
    }

    return lista;
}
    
    public List<Object[]> listarPorEstadoYFecha(
        String estado,
        String desde,
        String hasta) {

    List<Object[]> lista =
            new ArrayList<>();

    String sql = """
            SELECT
                r.id,
                i.nombre,
                i.apellido,
                e.nombre AS edificio,
                u.tipo,
                r.fecha_emision,
                r.total,
                r.estado
            FROM recibo r
            INNER JOIN alquiler a
                ON r.alquiler_id = a.id
            INNER JOIN inquilino i
                ON a.inquilino_id = i.id
            INNER JOIN unidad_inmueble u
                ON a.unidad_inmueble_id = u.id
            INNER JOIN edificio e
                ON u.edificio_id = e.id
            WHERE r.estado = ?
            AND r.fecha_emision
                BETWEEN ? AND ?
            ORDER BY r.fecha_emision
            """;

    try (
            Connection conexion =
                    Conexion.conectar();

            PreparedStatement ps =
                    conexion.prepareStatement(sql)
    ) {

        ps.setString(1, estado);

        ps.setString(2, desde);

        ps.setString(3, hasta);

        ResultSet rs =
                ps.executeQuery();

        while(rs.next()){

            Object[] fila =
                    new Object[8];

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
                    rs.getDate("fecha_emision");

            fila[6] =
                    rs.getDouble("total");

            fila[7] =
                    rs.getString("estado");

            lista.add(fila);
        }

    } catch (SQLException e) {

        System.out.println(
                "Error reporte recibos: "
                + e.getMessage()
        );
    }

    return lista;
}
   public boolean actualizar(
        Recibo r) {

    String sql = """
            UPDATE recibo
            SET
                renta=?,
                agua=?,
                luz=?,
                iva=?,
                porteria=?,
                ipc=?,
                otros=?,
                total=?,
                estado=?
            WHERE id=?
            """;

    try (
            Connection conexion =
                    Conexion.conectar();

            PreparedStatement ps =
                    conexion.prepareStatement(sql)
    ) {

        ps.setDouble(1, r.getRenta());

        ps.setDouble(2, r.getAgua());

        ps.setDouble(3, r.getLuz());

        ps.setDouble(4, r.getIva());

        ps.setDouble(5, r.getPorteria());

        ps.setDouble(6, r.getIpc());

        ps.setDouble(7, r.getOtros());

        ps.setDouble(8, r.getTotal());

        ps.setString(9, r.getEstado());

        ps.setInt(10, r.getId());

        return ps.executeUpdate() > 0;

    } catch (SQLException e) {

        System.out.println(
                "Error actualizar recibo: "
                + e.getMessage()
        );
    }

    return false;
} 
   public Recibo obtenerPorId(
        int id) {

    String sql = """
            SELECT *
            FROM recibo
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

            Recibo r =
                    new Recibo();

            r.setId(
                    rs.getInt("id")
            );

            r.setAlquilerId(
                    rs.getInt(
                            "alquiler_id"
                    )
            );

            r.setFechaEmision(
                    rs.getDate(
                            "fecha_emision"
                    )
            );

            r.setRenta(
                    rs.getDouble("renta")
            );

            r.setAgua(
                    rs.getDouble("agua")
            );

            r.setLuz(
                    rs.getDouble("luz")
            );

            r.setIva(
                    rs.getDouble("iva")
            );

            r.setPorteria(
                    rs.getDouble(
                            "porteria"
                    )
            );

            r.setIpc(
                    rs.getDouble("ipc")
            );

            r.setOtros(
                    rs.getDouble("otros")
            );

            r.setTotal(
                    rs.getDouble("total")
            );

            r.setEstado(
                    rs.getString("estado")
            );
            
             String numeroRecibo = rs.getString("numero_recibo");
            if (numeroRecibo == null || numeroRecibo.isEmpty()) {
                numeroRecibo = generarNumeroRecibo(r.getAlquilerId());
                // Actualizar en la BD
                actualizarNumeroRecibo(id, numeroRecibo);
            }
            r.setNumeroRecibo(numeroRecibo);
            
            return r;
        }

    } catch (SQLException e) {

        System.out.println(
                "Error obtener recibo: "
                + e.getMessage()
        );
    }

    return null;
}
   
   public void actualizarNumeroRecibo(int id, String numeroRecibo) {
    String sql = "UPDATE recibo SET numero_recibo = ? WHERE id = ?";
    try (Connection conexion = Conexion.conectar();
         PreparedStatement ps = conexion.prepareStatement(sql)) {
        ps.setString(1, numeroRecibo);
        ps.setInt(2, id);
        ps.executeUpdate();
    } catch (SQLException e) {
        System.out.println("Error actualizando número recibo: " + e.getMessage());
    }
}
   
    public List<Object[]> filtrarRecibos(String estado, Date inicio, Date fin) {

    List<Object[]> lista = new ArrayList<>();

    String sql = """
        SELECT
            r.numero_recibo,
            i.nombre,
            i.apellido,
            e.nombre AS edificio,
            u.tipo,
            u.planta,
            u.letra,
            r.fecha_emision,
            r.total,
            r.estado
        FROM recibo r
        INNER JOIN alquiler a ON r.alquiler_id = a.id
        INNER JOIN inquilino i ON a.inquilino_id = i.id
        INNER JOIN unidad_inmueble u ON a.unidad_inmueble_id = u.id
        INNER JOIN edificio e ON u.edificio_id = e.id
        WHERE r.estado = ?
        AND r.fecha_emision BETWEEN ? AND ?
        ORDER BY r.fecha_emision
        """;

    try (Connection conexion = Conexion.conectar();
         PreparedStatement ps = conexion.prepareStatement(sql)) {

        ps.setString(1, estado);
        ps.setDate(2, inicio);
        ps.setDate(3, fin);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Object[] fila = new Object[10];
            fila[0] = rs.getString("numero_recibo");
            fila[1] = rs.getString("nombre");
            fila[2] = rs.getString("apellido");
            fila[3] = rs.getString("edificio");
            fila[4] = rs.getString("tipo");
            fila[5] = rs.getString("planta");
            fila[6] = rs.getString("letra");
            fila[7] = rs.getDate("fecha_emision");
            fila[8] = rs.getDouble("total");
            fila[9] = rs.getString("estado");
            lista.add(fila);
        }

    } catch (SQLException e) {
        System.out.println("Error filtrando recibos: " + e.getMessage());
    }

    return lista;
}
    public boolean generarRecibosClonandoMesAnterior() {
    
    String sql = """
        INSERT INTO recibo (alquiler_id, numero_recibo, fecha_emision, renta, agua, luz, iva, porteria, ipc, otros, total, estado)
        SELECT 
            r.alquiler_id,
            (SELECT CONCAT(
                UPPER(REPLACE(e.nombre, ' ', '')),
                '-',
                UPPER(u.tipo),
                '-',
                u.planta, u.letra,
                '-',
                LPAD(COALESCE(
                    (SELECT COUNT(*) + 1 FROM recibo r2 
                     INNER JOIN alquiler a2 ON r2.alquiler_id = a2.id
                     INNER JOIN unidad_inmueble u2 ON a2.unidad_inmueble_id = u2.id
                     WHERE u2.id = u.id), 1), 3, '0')
            ) AS numero_recibo),
            CURDATE() AS fecha_emision,
            r.renta,
            r.agua,
            r.luz,
            r.iva,
            r.porteria,
            r.ipc,
            r.otros,
            r.total,
            'PENDIENTE' AS estado
        FROM recibo r
        INNER JOIN alquiler a ON r.alquiler_id = a.id
        INNER JOIN unidad_inmueble u ON a.unidad_inmueble_id = u.id
        INNER JOIN edificio e ON u.edificio_id = e.id
        WHERE r.fecha_emision >= DATE_FORMAT(CURDATE() - INTERVAL 1 MONTH, '%Y-%m-01')
          AND r.fecha_emision < DATE_FORMAT(CURDATE(), '%Y-%m-01')
          AND NOT EXISTS (
              SELECT 1 FROM recibo x 
              WHERE x.alquiler_id = r.alquiler_id 
                AND x.fecha_emision >= DATE_FORMAT(CURDATE(), '%Y-%m-01')
                AND x.fecha_emision < DATE_FORMAT(CURDATE() + INTERVAL 1 MONTH, '%Y-%m-01')
          )
        """;
    
    try (Connection conexion = Conexion.conectar();
         PreparedStatement ps = conexion.prepareStatement(sql)) {
        
        int filasAfectadas = ps.executeUpdate();
        System.out.println("=== CLONACIÓN MES ANTERIOR ===");
        System.out.println("Recibos clonados: " + filasAfectadas);
        System.out.println("==============================");
        
        return filasAfectadas > 0;
        
    } catch (SQLException e) {
        System.out.println("Error clonando recibos: " + e.getMessage());
        e.printStackTrace();
        return false;
    }
}

public boolean generarRecibosClonandoMes(int mesOrigen, int anioOrigen, int mesDestino, int anioDestino) {
    
    String sql = """
        INSERT INTO recibo (alquiler_id, numero_recibo, fecha_emision, renta, agua, luz, iva, porteria, ipc, otros, total, estado)
        SELECT 
            r.alquiler_id,
            (SELECT CONCAT(
                UPPER(REPLACE(e.nombre, ' ', '')),
                '-',
                UPPER(u.tipo),
                '-',
                u.planta, u.letra,
                '-',
                LPAD(COALESCE(
                    (SELECT COUNT(*) + 1 FROM recibo r2 
                     INNER JOIN alquiler a2 ON r2.alquiler_id = a2.id
                     INNER JOIN unidad_inmueble u2 ON a2.unidad_inmueble_id = u2.id
                     WHERE u2.id = u.id), 1), 3, '0')
            ) AS numero_recibo),
            DATE(CONCAT(?, '-', ?, '-01')) AS fecha_emision,
            r.renta,
            r.agua,
            r.luz,
            r.iva,
            r.porteria,
            r.ipc,
            r.otros,
            r.total,
            'PENDIENTE' AS estado
        FROM recibo r
        INNER JOIN alquiler a ON r.alquiler_id = a.id
        INNER JOIN unidad_inmueble u ON a.unidad_inmueble_id = u.id
        INNER JOIN edificio e ON u.edificio_id = e.id
        WHERE MONTH(r.fecha_emision) = ? 
          AND YEAR(r.fecha_emision) = ?
          AND NOT EXISTS (
              SELECT 1 FROM recibo x 
              WHERE x.alquiler_id = r.alquiler_id 
                AND MONTH(x.fecha_emision) = ?
                AND YEAR(x.fecha_emision) = ?
          )
        """;
    
    try (Connection conexion = Conexion.conectar();
         PreparedStatement ps = conexion.prepareStatement(sql)) {
        
        ps.setInt(1, anioDestino);
        ps.setInt(2, mesDestino);
        ps.setInt(3, mesOrigen);
        ps.setInt(4, anioOrigen);
        ps.setInt(5, mesDestino);
        ps.setInt(6, anioDestino);
        
        int filasAfectadas = ps.executeUpdate();
        System.out.println("=== CLONACIÓN ===");
        System.out.println("Clonando desde: " + mesOrigen + "/" + anioOrigen);
        System.out.println("Hacia mes destino: " + mesDestino + "/" + anioDestino);
        System.out.println("Recibos clonados: " + filasAfectadas);
        System.out.println("================");
        
        return filasAfectadas > 0;
        
    } catch (SQLException e) {
        System.out.println("Error clonando recibos: " + e.getMessage());
        e.printStackTrace();
        return false;
    }
}
    public int contarRecibosPorMes(int mes, int anio) {
    String sql = "SELECT COUNT(*) FROM recibo WHERE MONTH(fecha_emision) = ? AND YEAR(fecha_emision) = ?";
    
    try (Connection conexion = Conexion.conectar();
         PreparedStatement ps = conexion.prepareStatement(sql)) {
        
        ps.setInt(1, mes);
        ps.setInt(2, anio);
        
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
        
    } catch (SQLException e) {
        System.out.println("Error contando recibos: " + e.getMessage());
    }
    
    return 0;
}
    
    // Generar número de recibo único por piso/local
public String generarNumeroRecibo(int alquilerId) {
    String sql = """
        SELECT CONCAT(
            UPPER(REPLACE(e.nombre, ' ', '')),
            '-',
            UPPER(u.tipo),
            '-',
            u.planta, u.letra,
            '-',
            LPAD(COALESCE(
                (SELECT COUNT(*) + 1 FROM recibo r2 
                 INNER JOIN alquiler a2 ON r2.alquiler_id = a2.id
                 INNER JOIN unidad_inmueble u2 ON a2.unidad_inmueble_id = u2.id
                 INNER JOIN edificio e2 ON u2.edificio_id = e2.id
                 WHERE e2.id = e.id AND u2.id = u.id), 1), 3, '0')
        ) AS numero_recibo
        FROM alquiler a
        INNER JOIN unidad_inmueble u ON a.unidad_inmueble_id = u.id
        INNER JOIN edificio e ON u.edificio_id = e.id
        WHERE a.id = ?
        """;
    
    try (Connection conexion = Conexion.conectar();
         PreparedStatement ps = conexion.prepareStatement(sql)) {
        
        ps.setInt(1, alquilerId);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            return rs.getString("numero_recibo");
        }
        
    } catch (SQLException e) {
        System.out.println("Error generando número recibo: " + e.getMessage());
    }
    
    return "REC-" + System.currentTimeMillis();
}

public boolean actualizarTotalRecibo(int reciboId, double total) {
    String sql = "UPDATE recibo SET total = ? WHERE id = ?";
    
    try (Connection conexion = Conexion.conectar();
         PreparedStatement ps = conexion.prepareStatement(sql)) {
        
        ps.setDouble(1, total);
        ps.setInt(2, reciboId);
        return ps.executeUpdate() > 0;
        
    } catch (SQLException e) {
        System.out.println("Error actualizando total: " + e.getMessage());
        return false;
    }
}



// Agregar concepto personalizado a un recibo
public boolean agregarConceptoPersonalizado(int reciboId, String nombre, double monto) {
    String sql = "INSERT INTO concepto_recibo (recibo_id, nombre, monto) VALUES (?, ?, ?)";
    
    try (Connection conexion = Conexion.conectar();
         PreparedStatement ps = conexion.prepareStatement(sql)) {
        
        ps.setInt(1, reciboId);
        ps.setString(2, nombre);
        ps.setDouble(3, monto);
        
        return ps.executeUpdate() > 0;
        
    } catch (SQLException e) {
        System.out.println("Error agregando concepto: " + e.getMessage());
        return false;
    }
}

// Obtener conceptos personalizados de un recibo
public List<Object[]> obtenerConceptosPersonalizados(int reciboId) {
    List<Object[]> lista = new ArrayList<>();
    String sql = "SELECT id, nombre, monto FROM concepto_recibo WHERE recibo_id = ?";
    
    try (Connection conexion = Conexion.conectar();
         PreparedStatement ps = conexion.prepareStatement(sql)) {
        
        ps.setInt(1, reciboId);
        ResultSet rs = ps.executeQuery();
        
        while (rs.next()) {
            Object[] concepto = new Object[3];
            concepto[0] = rs.getInt("id");
            concepto[1] = rs.getString("nombre");
            concepto[2] = rs.getDouble("monto");
            lista.add(concepto);
        }
        
    } catch (SQLException e) {
        System.out.println("Error obteniendo conceptos: " + e.getMessage());
    }
    
    return lista;
}

// Eliminar concepto personalizado
public boolean eliminarConceptoPersonalizado(int conceptoId) {
    String sql = "DELETE FROM concepto_recibo WHERE id = ?";
    
    try (Connection conexion = Conexion.conectar();
         PreparedStatement ps = conexion.prepareStatement(sql)) {
        
        ps.setInt(1, conceptoId);
        return ps.executeUpdate() > 0;
        
    } catch (SQLException e) {
        System.out.println("Error eliminando concepto: " + e.getMessage());
        return false;
    }
}

// Validar conceptos obligatorios
public boolean validarConceptosObligatorios(double renta) {
    // La renta es el único concepto obligatorio según el enunciado
    return renta > 0;
}

// Obtener IVA actual (valor fijo)
public double obtenerIVA() {
    String sql = "SELECT valor FROM configuracion_general WHERE clave = 'IVA'";
    
    try (Connection conexion = Conexion.conectar();
         PreparedStatement ps = conexion.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        
        if (rs.next()) {
            return rs.getDouble("valor");
        }
        
    } catch (SQLException e) {
        System.out.println("Error obteniendo IVA: " + e.getMessage());
    }
    
    return 19.0; // Valor por defecto
}

// Actualizar IVA (solo administradores)
public boolean actualizarIVA(double valor) {
    String sql = """
        UPDATE configuracion_general 
        SET valor = ?, fecha_actualizacion = CURDATE() 
        WHERE clave = 'IVA'
        """;
    
    try (Connection conexion = Conexion.conectar();
         PreparedStatement ps = conexion.prepareStatement(sql)) {
        
        ps.setDouble(1, valor);
        return ps.executeUpdate() > 0;
        
    } catch (SQLException e) {
        System.out.println("Error actualizando IVA: " + e.getMessage());
        return false;
    }
}

// Obtener IPC para un año específico
public double obtenerIPC(int anio) {
    String sql = "SELECT valor FROM configuracion_general WHERE clave = ?";
    
    try (Connection conexion = Conexion.conectar();
         PreparedStatement ps = conexion.prepareStatement(sql)) {
        
        ps.setString(1, "IPC_" + anio);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            return rs.getDouble("valor");
        }
        
    } catch (SQLException e) {
        System.out.println("Error obteniendo IPC: " + e.getMessage());
    }
    
    return 0.0;
}

// Actualizar IPC para un año
public boolean actualizarIPC(int anio, double valor) {
    String sql = """
        INSERT INTO configuracion_general (clave, valor, descripcion, fecha_actualizacion) 
        VALUES (?, ?, ?, CURDATE())
        ON DUPLICATE KEY UPDATE valor = ?, fecha_actualizacion = CURDATE()
        """;
    
    try (Connection conexion = Conexion.conectar();
         PreparedStatement ps = conexion.prepareStatement(sql)) {
        
        String clave = "IPC_" + anio;
        String descripcion = "IPC aplicable para el año " + anio;
        
        ps.setString(1, clave);
        ps.setDouble(2, valor);
        ps.setString(3, descripcion);
        ps.setDouble(4, valor);
        
        return ps.executeUpdate() > 0;
        
    } catch (SQLException e) {
        System.out.println("Error actualizando IPC: " + e.getMessage());
        return false;
    }
}

// Obtener todas las configuraciones
public List<Object[]> obtenerConfiguraciones() {
    List<Object[]> lista = new ArrayList<>();
    String sql = "SELECT clave, valor, descripcion, fecha_actualizacion FROM configuracion_general ORDER BY clave";
    
    try (Connection conexion = Conexion.conectar();
         PreparedStatement ps = conexion.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        
        while (rs.next()) {
            Object[] config = new Object[4];
            config[0] = rs.getString("clave");
            config[1] = rs.getDouble("valor");
            config[2] = rs.getString("descripcion");
            config[3] = rs.getDate("fecha_actualizacion");
            lista.add(config);
        }
        
    } catch (SQLException e) {
        System.out.println("Error obteniendo configuraciones: " + e.getMessage());
    }
    
    return lista;
}

// Calcular total del recibo correctamente
public double calcularTotal(double renta, double agua, double luz, double porteria, 
                            double otros, int anio) {
    double iva = obtenerIVA();  // 19%
    double ipc = obtenerIPC(anio);  // IPC del año (ej: 2.5)
    
    // 1. Calcular incremento por IPC sobre la renta
    double incrementoIPC = renta * (ipc / 100);
    
    
    // 2. Calcular IVA (solo sobre la renta base, no sobre servicios ni IPC)
    double valorIVA = renta * (iva / 100);
    
    // 3. Total = Renta + IPC + IVA + Agua + Luz + Portería + Otros
    double total = renta + incrementoIPC + valorIVA + agua + luz + porteria + otros;
    
    return total;
}

public int obtenerIdPorNumeroRecibo(String numeroRecibo) {
    String sql = "SELECT id FROM recibo WHERE numero_recibo = ?";
    
    try (Connection conexion = Conexion.conectar();
         PreparedStatement ps = conexion.prepareStatement(sql)) {
        
        ps.setString(1, numeroRecibo);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            return rs.getInt("id");
        }
        
    } catch (SQLException e) {
        System.out.println("Error obteniendo ID por número recibo: " + e.getMessage());
    }
    
    return -1;
}

// Reporte de ganancias por edificio y unidad
public List<Object[]> obtenerGananciasPorEdificio() {
    List<Object[]> lista = new ArrayList<>();
    
    String sql = """
        SELECT 
            e.id AS edificio_id,
            e.nombre AS edificio,
            u.id AS unidad_id,
            u.tipo,
            u.planta,
            u.letra,
            COALESCE(SUM(r.total), 0) AS total_ganado,
            COUNT(r.id) AS recibos_pagados,
            MAX(r.fecha_emision) AS ultimo_pago
        FROM edificio e
        INNER JOIN unidad_inmueble u ON u.edificio_id = e.id
        LEFT JOIN alquiler a ON a.unidad_inmueble_id = u.id
        LEFT JOIN recibo r ON r.alquiler_id = a.id AND r.estado = 'PAGADO'
        GROUP BY e.id, e.nombre, u.id, u.tipo, u.planta, u.letra
        ORDER BY e.nombre, u.tipo, u.planta, u.letra
        """;
    
    try (Connection conexion = Conexion.conectar();
         PreparedStatement ps = conexion.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        
        while (rs.next()) {
            Object[] fila = new Object[9];
            fila[0] = rs.getInt("edificio_id");
            fila[1] = rs.getString("edificio");
            fila[2] = rs.getInt("unidad_id");
            fila[3] = rs.getString("tipo");
            fila[4] = rs.getString("planta");
            fila[5] = rs.getString("letra");
            fila[6] = rs.getDouble("total_ganado");
            fila[7] = rs.getInt("recibos_pagados");
            fila[8] = rs.getDate("ultimo_pago");
            lista.add(fila);
        }
        
    } catch (SQLException e) {
        System.out.println("Error obteniendo ganancias por edificio: " + e.getMessage());
    }
    
    return lista;
}

// Resumen de ganancias por edificio (totales)
public List<Object[]> obtenerResumenGananciasPorEdificio() {
    List<Object[]> lista = new ArrayList<>();
    
    String sql = """
        SELECT 
            e.id AS edificio_id,
            e.nombre AS edificio,
            COALESCE(SUM(r.total), 0) AS total_ganado,
            COUNT(DISTINCT u.id) AS unidades_totales,
            COUNT(DISTINCT CASE WHEN r.id IS NOT NULL THEN u.id END) AS unidades_con_ingresos
        FROM edificio e
        INNER JOIN unidad_inmueble u ON u.edificio_id = e.id
        LEFT JOIN alquiler a ON a.unidad_inmueble_id = u.id
        LEFT JOIN recibo r ON r.alquiler_id = a.id AND r.estado = 'PAGADO'
        GROUP BY e.id, e.nombre
        ORDER BY total_ganado DESC
        """;
    
    try (Connection conexion = Conexion.conectar();
         PreparedStatement ps = conexion.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        
        while (rs.next()) {
            Object[] fila = new Object[5];
            fila[0] = rs.getInt("edificio_id");
            fila[1] = rs.getString("edificio");
            fila[2] = rs.getDouble("total_ganado");
            fila[3] = rs.getInt("unidades_totales");
            fila[4] = rs.getInt("unidades_con_ingresos");
            lista.add(fila);
        }
        
    } catch (SQLException e) {
        System.out.println("Error obteniendo resumen de ganancias: " + e.getMessage());
    }
    
    return lista;
}

}
