{A partir de información sobre la alfabetización en la Argentina, se necesita actualizar un
archivo que contiene los siguientes datos: nombre de provincia, cantidad de personas
alfabetizadas y total de encuestados. Se reciben dos archivos detalle provenientes de dos
agencias de censo diferentes, dichos archivos contienen: nombre de la provincia, código de
localidad, cantidad de alfabetizados y cantidad de encuestados. Se pide realizar los módulos
necesarios para actualizar el archivo maestro a partir de los dos archivos detalle.
NOTA: Los archivos están ordenados por nombre de provincia y en los archivos detalle
pueden venir 0, 1 ó más registros por cada provincia.}
program ejercicio4;
const
 valor_alto='ZZZZ';
type
 cadena = string[30];
 provincia = record
   nom:cadena;
   cant:integer;
   tot:integer;
   end;
  censo = record
    nom:cadena;
    cod:integer;
    cant:integer;
    tot:integer;
    end;
  archivo_maestro = file of provincia;
  archivo_detalle = file of censo;
procedure leer(var det:archivo_detalle;var c:censo);
begin
  if(not EOF(det))then
    read(det,c)
  else
    c.nom:=valor_alto;
end;
procedure minimo(var r1:censo;var r2:censo;var min:censo;var det1:archivo_detalle;var det2:archivo_detalle);
begin
  if(r1.nom <= r2.nom)then
   begin
    min:=r1;
    leer(det1,r1);
   end
   else begin
         min:=r2;
         leer(det2,r2);
        end;
end;
procedure actualizar(var mae:archivo_maestro;var det1:archivo_detalle;var det2:archivo_detalle);
var
  min:censo;
  regm:provincia;
  r1:censo;
  r2:censo;
begin
  reset(mae);
  reset(det1);
  reset(det2);
  leer(det1,r1);
  leer(det2,r2);
  minimo(r1,r2,min,det1,det2);
  while(min.nom <> valor_alto)do
   begin
     read(mae,regm);
     while(regm.nom <> min.nom)do
       read(mae,regm);
     while(regm.nom = min.nom)do
       begin
         regm.cant:= regm.cant + min.cant;
         regm.tot:= regm.tot + min.tot;
         minimo(r1,r2,min,det1,det2);
       end;
      seek(mae,filepos(mae)-1);
      write(mae,regm);
   end;
 close(mae);
 close(det1);
 close(det2);
end;
var
 det1:archivo_detalle;
 det2:archivo_detalle;
 mae:archivo_maestro;
 cad:cadena;
begin
writeln('Ingrese el nombre del archivo maestro');
readln(cad);
Assign(mae,cad);
writeln('Ingrese el nombre del archivo detalle');
readln(cad);
Assign(det1,cad);
writeln('Ingrese el nombre del segundo archivo detalle');
readln(cad);
Assign(det2,cad);
actualizar(mae,det1,det2);
end.
