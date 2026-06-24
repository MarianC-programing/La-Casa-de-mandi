package com.lacasademandi.modelo;

// Representa la tabla Administrador de la base de datos.
public class Administrador {

    private int    idAdmin;
    private String nombre;
    private String correo;
    private String password;

    public Administrador() {}

    public int    getIdAdmin()                { return idAdmin; }
    public void   setIdAdmin(int id)          { this.idAdmin = id; }

    public String getNombre()                 { return nombre; }
    public void   setNombre(String nombre)    { this.nombre = nombre; }

    public String getCorreo()                 { return correo; }
    public void   setCorreo(String correo)    { this.correo = correo; }

    public String getPassword()               { return password; }
    public void   setPassword(String p)       { this.password = p; }
}
