package model.entity;

public class UnidadInmueble {

    private int id;

    private int edificioId;

    private String tipo;

    private String planta;

    private String letra;

    private String descripcion;

    private String estado;

    public UnidadInmueble() {
    }

    public UnidadInmueble(int id, int edificioId, String tipo, String planta, String letra, String descripcion, String estado) {
        this.id = id;
        this.edificioId = edificioId;
        this.tipo = tipo;
        this.planta = planta;
        this.letra = letra;
        this.descripcion = descripcion;
        this.estado = estado;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getEdificioId() {
        return edificioId;
    }

    public void setEdificioId(
            int edificioId) {

        this.edificioId =
                edificioId;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(
            String tipo) {

        this.tipo = tipo;
    }

    public String getPlanta() {
        return planta;
    }

    public void setPlanta(
            String planta) {

        this.planta = planta;
    }

    public String getLetra() {
        return letra;
    }

    public void setLetra(
            String letra) {

        this.letra = letra;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(
            String descripcion) {

        this.descripcion =
                descripcion;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(
            String estado) {

        this.estado = estado;
    }
}