{Se dispone de un archivo con información de los alumnos de la Facultad de Informática. Por
cada alumno se dispone de su código de alumno, apellido, nombre, cantidad de materias
(cursadas) aprobadas sin final y cantidad de materias con final aprobado. Además, se tiene
un archivo detalle con el código de alumno e información correspondiente a una materia
(esta información indica si aprobó la cursada o aprobó el final).
Todos los archivos están ordenados por código de alumno y en el archivo detalle puede
haber 0, 1 ó más registros por cada alumno del archivo maestro. Se pide realizar un
programa con opciones para:
a. Actualizar el archivo maestro de la siguiente manera:
i.Si aprobó el final se incrementa en uno la cantidad de materias con final aprobado,
y se decrementa en uno la cantidad de materias sin final aprobado.
ii.Si aprobó la cursada se incrementa en uno la cantidad de materias aprobadas sin
final.
b. Listar en un archivo de texto aquellos alumnos que tengan más materias con finales
aprobados que materias sin finales aprobados. Teniendo en cuenta que este listado
es un reporte de salida (no se usa con fines de carga), debe informar todos los
campos de cada alumno en una sola línea del archivo de texto.
NOTA: Para la actualización del inciso a) los archivos deben ser recorridos sólo una vez.}
program ejercicio2;
const
 valor_alto = 9999;
type
cadena = string[40];
  alumno = record
    cod:integer;
    apeynom:cadena;
    cursadas:integer;
    aprobadas:integer;
    end;
   alumno2 = record
      cod:integer;
      finales:boolean;
      end;
  archivo_maestro = file of alumno;
  archivo_detalle = file of alumno2;
procedure leer(var a:archivo_detalle;var alu:alumno2);
begin
  if(not EOF(a))then
    read(a,alu)
  else
    alu.cod:= valor_alto;
end;
procedure actualizar(var arch_mae:archivo_maestro;var arch_det:archivo_detalle);
var
 det:alumno2;
 finale:integer;
 aprob:integer;
 mae:alumno;
 codact:integer;
begin
  Reset(arch_mae);
  Reset(arch_det);
  read(arch_mae,mae);
  leer(arch_det,det);
     while(det.cod <> valor_alto)do
     begin
	  codact:=det.cod;
	  finale:=0;
	  aprob:=0;
	  while(mae.cod <> det.cod)do
          read(arch_mae,mae);
      while(det.cod = codact)do
       begin
         if(det.finales)then
            finale:=finale+1
          else
           aprob:=aprob + 1;
          leer(arch_det,det);
         end;
	  mae.aprobadas:= mae.aprobadas+finale;
      mae.cursadas:= mae.cursadas - finale + aprob;
      seek(arch_mae,filepos(arch_mae)-1);
      write(arch_mae,mae);
     end;
close(arch_mae);
close(arch_det);
end;
procedure inciso_b(var arch_mae:archivo_maestro);
var
  mae:alumno;
begin
  reset(arch_mae);
  while(not EOF(arch_mae))do
    begin
     read(arch_mae,mae);
     if(mae.aprobadas > mae.cursadas)then
        writeln(mae.apeynom, mae.cod, mae.cursadas, mae.aprobadas);  
    end;
 close(arch_mae);
end;
var
  arch_mae:archivo_maestro;
  arch_det:archivo_detalle;       
  cad:cadena;
begin
writeln('Ingrese el nombre del archivo maestro');
readln(cad);
assign(arch_mae,cad);
writeln('Ingrese el nombre del archivo detalle');
readln(cad);
assign(arch_det,cad);
actualizar(arch_mae,arch_det);
inciso_b(arch_mae);
end.
