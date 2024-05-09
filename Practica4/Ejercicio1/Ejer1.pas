{Defina en Pascal las estructuras de datos necesarias para organizar el archivo de
alumnos como un árbol B de orden M.}
program ejer1;
const 
  M = 5 ;
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
     claves = array[1..M-1] of alumno;
     Hijos = array [1..M] of integer;
     end;
    ArbolB = file of Nodo;
begin
end.
