{a. PosicionarYLeerNodo(): Indique qué hace y la forma en que deben ser
enviados los parámetros (valor o referencia). Implemente este módulo en Pascal.
}
program ejer4;
type
cadena = String[60];
 fecha = record
   dia:1..31;
   mes:1..12;
   anio:integer;
   end;
 
 alumno = record
   apeynom:cadena;
   dni:integer;
   legajo:integer;
   nac:fecha;
   end;
   Nodo = record
     cant_claves:integer;
     claves = array[1..M-1] of integer;
     enlaces = array[1..M-1] of integer;
     Hijos = array [1..M] of integer;
     HD:integer;
     end;
    Archivo = file of alumno;
    ArbolB = file of Nodo;
procedure PosicionarYLeerNodo(var a:ArbolB;var N:Nodo;NRR:integer;);
begin
 if(NRR <> -1)then
    begin
	 seek(a,NRR);
	 read(a,N);
	end
	else N:=nil;
end;
begin
end.
