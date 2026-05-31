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
public class Recibo {
    private int id;

    private int alquilerId;
    
    private String numeroRecibo;

    private Date fechaEmision;

    private double renta;

    private double agua;

    private double luz;

    private double iva;

    private double porteria;

    private double ipc;

    private double otros;

    private double total;
    
    private String estado;

    public Recibo() {
    }

    public Recibo(int id, int alquilerId, Date fechaEmision, double renta, double agua, double luz, double iva, double porteria, double ipc, double otros, double total, String estado) {
        this.id = id;
        this.alquilerId = alquilerId;
        this.fechaEmision = fechaEmision;
        this.renta = renta;
        this.agua = agua;
        this.luz = luz;
        this.iva = iva;
        this.porteria = porteria;
        this.ipc = ipc;
        this.otros = otros;
        this.total = total;
        this.estado = estado;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getAlquilerId() {
        return alquilerId;
    }

    public void setAlquilerId(int alquilerId) {
        this.alquilerId = alquilerId;
    }

    public Date getFechaEmision() {
        return fechaEmision;
    }

    public void setFechaEmision(Date fechaEmision) {
        this.fechaEmision = fechaEmision;
    }

    public double getRenta() {
        return renta;
    }

    public void setRenta(double renta) {
        this.renta = renta;
    }

    public double getAgua() {
        return agua;
    }

    public void setAgua(double agua) {
        this.agua = agua;
    }

    public double getLuz() {
        return luz;
    }

    public void setLuz(double luz) {
        this.luz = luz;
    }

    public double getIva() {
        return iva;
    }

    public void setIva(double iva) {
        this.iva = iva;
    }

    public double getPorteria() {
        return porteria;
    }

    public void setPorteria(double porteria) {
        this.porteria = porteria;
    }

    public double getIpc() {
        return ipc;
    }

    public void setIpc(double ipc) {
        this.ipc = ipc;
    }

    public double getOtros() {
        return otros;
    }

    public void setOtros(double otros) {
        this.otros = otros;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
    
    public String getNumeroRecibo() { return numeroRecibo; }
    
    public void setNumeroRecibo(String numeroRecibo) 
        { this.numeroRecibo = numeroRecibo; }

    
    
}
