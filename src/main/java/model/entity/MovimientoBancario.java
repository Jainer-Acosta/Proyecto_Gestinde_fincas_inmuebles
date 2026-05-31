package model.entity;

import java.sql.Date;

public class MovimientoBancario {

    private int id;

    private int cuentaId;

    private int unidadInmuebleId;

    private String tipo;

    private String concepto;

    private double monto;

    private Date fecha;

    private String descripcion;
    
    private String categoria;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCuentaId() {
        return cuentaId;
    }

    public void setCuentaId(int cuentaId) {
        this.cuentaId = cuentaId;
    }

    public int getUnidadInmuebleId() {
        return unidadInmuebleId;
    }

    public void setUnidadInmuebleId(
            int unidadInmuebleId) {

        this.unidadInmuebleId =
                unidadInmuebleId;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getConcepto() {
        return concepto;
    }

    public void setConcepto(
            String concepto) {

        this.concepto = concepto;
    }

    public double getMonto() {
        return monto;
    }

    public void setMonto(double monto) {
        this.monto = monto;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(
            String descripcion) {

        this.descripcion =
                descripcion;
    }
    
    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }
}