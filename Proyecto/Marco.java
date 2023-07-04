//**********************************************************************************
//MARCO.JAVA
//**********************************************************************************
//**********************************************************************************
//CASTAÑEDA YESCAS LUIS CARLOS
//LOREDO CORTES LUIS JOSUE
//SANTOS MENDEZ ULISES JESUS
//VEGA ALVAREZ BRYAN ALBERTO
//Curso: Compiladores 3CM14
//JUNIO 2023
//ESCOM-IPN
// Clase que crea define el objeto Marco para definir los Marcos de Funciones de la
// máquina virtual de pila.
//**********************************************************************************

import java.util.ArrayList;

public class Marco {
    private ArrayList parametros;
    private int retorno;
    private String nombre;

    public Marco(){
        parametros = new ArrayList();
        retorno = 0;
        nombre = null;
    }
    
    public void agregarParametro(Object parametro){
        parametros.add(parametro);
    }
    
    public Object getParametro(int i){
        return parametros.get(i);
    }
    
    public void setParametros(ArrayList parametros) {
        this.parametros = parametros;
    }

    public int getRetorno() {
        return retorno;
    }

    public void setRetorno(int retorno) {
        this.retorno = retorno;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
 
}
