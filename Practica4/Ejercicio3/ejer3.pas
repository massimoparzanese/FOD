{
c. Defina en Pascal las estructuras de datos correspondientes para el archivo de
alumnos y su índice (árbol B+). Por simplicidad, suponga que todos los nodos del
árbol B+ (nodos internos y nodos hojas) tienen el mismo tamaño}
program ejer3;
const
 M = 5;
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
begin
end.
