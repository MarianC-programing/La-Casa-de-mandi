package com.lacasademandi.modelo;

// Representa la tabla Cliente de la base de datos.
// Solo guarda los datos — sin lógica de BD.
public class Cliente {

    private int    idCliente;
    private String nombre;
    private String telefono;
    private String whatsapp;
    private String correo;
    private String password;

    public Cliente() {}

    public Cliente(String nombre, String telefono, String whatsapp, String correo, String password) {
        this.nombre    = nombre;
        this.telefono  = telefono;
        this.whatsapp  = whatsapp;
        this.correo    = correo;
        this.password  = password;
    }

    public int    getIdCliente()              { return idCliente; }
    public void   setIdCliente(int idCliente) { this.idCliente = idCliente; }

    public String getNombre()                 { return nombre; }
    public void   setNombre(String nombre)    { this.nombre = nombre; }

    public String getTelefono()               { return telefono; }
    public void   setTelefono(String t)       { this.telefono = t; }

    public String getWhatsapp()               { return whatsapp; }
    public void   setWhatsapp(String w)       { this.whatsapp = w; }

    public String getCorreo()                 { return correo; }
    public void   setCorreo(String correo)    { this.correo = correo; }

    public String getPassword()               { return password; }
    public void   setPassword(String p)       { this.password = p; }
}
