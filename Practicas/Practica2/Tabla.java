//*****************************************************************************************
//TABLA.JAVA
//*****************************************************************************************
//*****************************************************************************************
//SANTOS MENDEZ ULISES JESUS
//Curso: Compiladores 3CM14
//ESCOM-IPN
//YACC EN JAVA GRAFIBASI
//*****************************************************************************************
public class Tabla {
	Simbolo listaSimbolo;
	Tabla(){
		listaSimbolo=null;
	}

Simbolo install(String s, short t, double d){
		Simbolo simb=new Simbolo(s,t,d);
		simb.ponSig(listaSimbolo);
		listaSimbolo=simb;
		return simb;
	}

Simbolo lookup(String s){
	for(Simbolo sp=listaSimbolo; sp!=null; sp=sp.obtenSig())
		if((sp.obtenNombre()).equals(s))
			return sp;
	return null;
	}
}
