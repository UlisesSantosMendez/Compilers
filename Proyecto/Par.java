//**********************************************************************************
//PAR.JAVA
//**********************************************************************************
//**********************************************************************************
//CASTAÑEDA YESCAS LUIS CARLOS
//LOREDO CORTES LUIS JOSUE
//SANTOS MENDEZ ULISES JESUS
//VEGA ALVAREZ BRYAN ALBERTO
//Curso: Compiladores 3CM14
//JUNIO 2023
//ESCOM-IPN
// Clase que logra ligar un objeto de cualquier tipo con un nombre.
//**********************************************************************************

public class Par {

    private String nombre;
    private Object objeto;

    public Par(String nombre, Object objeto){
        this.nombre = nombre;
        this.objeto = objeto;
    }
    
    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Object getObjeto() {
        return objeto;
    }

    public void setObjeto(Object objeto) {
        this.objeto = objeto;
    }
        
}
