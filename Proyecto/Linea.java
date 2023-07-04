//**********************************************************************************
//LINEA.JAVA
//**********************************************************************************
//**********************************************************************************
//CASTAÑEDA YESCAS LUIS CARLOS
//LOREDO CORTES LUIS JOSUE
//SANTOS MENDEZ ULISES JESUS
//VEGA ALVAREZ BRYAN ALBERTO
//Curso: Compiladores 3CM14
//JUNIO 2023
//ESCOM-IPN
// OBJETO LÍNEA QUE SE UTILIZA PARA DIBUJAR EN EL PANEL DE DIBUJO
//**********************************************************************************

import java.awt.Color;
public class Linea {
    int x0;
    int y0;
    int x1;
    int y1;
    Color color;
    
    public Linea(int x0, int y0, int x1, int y1, Color color) {
        this.x0 = x0;
        this.y0 = y0;
        this.x1 = x1;
        this.y1 = y1;
        this.color = color;
    }

    public int getX0() { return x0; }
    public int getY0() { return y0; }
    public int getX1() { return x1; }
    public int getY1() { return y1; }
    public Color getColor() {
        return color;
    }
    public void setColor(Color color) {
        this.color = color;
    }

    @Override
    public String toString(){
        return "(" + x0 + "," + y0 + "," + x1 + "," + y1 + ")";
    }
    
}
