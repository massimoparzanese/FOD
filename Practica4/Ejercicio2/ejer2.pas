{Una mejora respecto a la solución propuesta en el ejercicio 1 sería mantener por un
lado el archivo que contiene la información de los alumnos de la Facultad de
Informática (archivo de datos no ordenado) y por otro lado mantener un índice al
archivo de datos que se estructura como un árbol B que ofrece acceso indizado por
DNI de los alumnos.
. Defina en Pascal las estructuras de datos correspondientes para el archivo de
alumnos y su índice}
program ejer2;
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
     end;
    Archivo = file of alumno;
    ArbolB = file of Nodo;
begin
end.
