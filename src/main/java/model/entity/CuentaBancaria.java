package model.entity;

public class CuentaBancaria {

    private int id;

    private int bancoId;

    private String numeroCuenta;

    private double saldo;

    public CuentaBancaria() {
    }

    public CuentaBancaria(int id, int bancoId, String numeroCuenta, double saldo) {
        this.id = id;
        this.bancoId = bancoId;
        this.numeroCuenta = numeroCuenta;
        this.saldo = saldo;
    }

    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getBancoId() {
        return bancoId;
    }

    public void setBancoId(int bancoId) {
        this.bancoId = bancoId;
    }

    public String getNumeroCuenta() {
        return numeroCuenta;
    }

    public void setNumeroCuenta(
            String numeroCuenta) {

        this.numeroCuenta =
                numeroCuenta;
    }

    public double getSaldo() {
        return saldo;
    }

    public void setSaldo(double saldo) {
        this.saldo = saldo;
    }
}