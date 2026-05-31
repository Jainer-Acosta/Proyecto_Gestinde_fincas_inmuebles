/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.entity;

import java.sql.Date;

/**
 *
 * @author Jainer Acosta
 */
public class Alquiler {
    
    private int id;

    private int inquilinoId;

    private int unidadInmuebleId;

    private Date fechaInicio;

    private Date fechaFin;

    private String estado;

    public Alquiler() {
    }

    public Alquiler(int id, int inquilinoId, int unidadInmuebleId, Date fechaInicio, Date fechaFin, String estado) {
        this.id = id;
        this.inquilinoId = inquilinoId;
        this.unidadInmuebleId = unidadInmuebleId;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
        this.estado = estado;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getInquilinoId() {
        return inquilinoId;
    }

    public void setInquilinoId(int inquilinoId) {
        this.inquilinoId = inquilinoId;
    }

    public int getUnidadInmuebleId() {
        return unidadInmuebleId;
    }

    public void setUnidadInmuebleId(int unidadInmuebleId) {
        this.unidadInmuebleId = unidadInmuebleId;
    }

    public Date getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(Date fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public Date getFechaFin() {
        return fechaFin;
    }

    public void setFechaFin(Date fechaFin) {
        this.fechaFin = fechaFin;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    
    
    
}
