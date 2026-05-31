package model.entity;

public class Edificio {

    private int id;

    private String nombre;

    private String direccion;

    private String numero;

    private String codigoPostal;

    private String ciudad;

    private String estado;

    public Edificio() {
    }

    public Edificio(int id, String nombre, String direccion, String numero, String codigoPostal, String ciudad, String estado) {
        this.id = id;
        this.nombre = nombre;
        this.direccion = direccion;
        this.numero = numero;
        this.codigoPostal = codigoPostal;
        this.ciudad = ciudad;
        this.estado = estado;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(
            String nombre) {

        this.nombre = nombre;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(
            String direccion) {

        this.direccion = direccion;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(
            String numero) {

        this.numero = numero;
    }

    public String getCodigoPostal() {
        return codigoPostal;
    }

    public void setCodigoPostal(
            String codigoPostal) {

        this.codigoPostal =
                codigoPostal;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(
            String ciudad) {

        this.ciudad = ciudad;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(
            String estado) {

        this.estado = estado;
    }
}