package com.lacasademandi.modelo;

import java.time.LocalDateTime;

/**
 * JavaBean que representa la tabla Cliente.
 * Solo almacena datos — la lógica de acceso a la BD vive en ClienteDAO.
 */
public class Cliente {

    private int idCliente;
    private String nombre;
    private String telefono;
    private String whatsapp;
    private String correo;
    private String password;
    private LocalDateTime fechaRegistro;

    public Cliente() {
    }

    public Cliente(String nombre, String telefono, String whatsapp, String correo, String password) {
        this.nombre = nombre;
        this.telefono = telefono;
        this.whatsapp = whatsapp;
        this.correo = correo;
        this.password = password;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getWhatsapp() {
        return whatsapp;
    }

    public void setWhatsapp(String whatsapp) {
        this.whatsapp = whatsapp;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public LocalDateTime getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(LocalDateTime fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }
}
