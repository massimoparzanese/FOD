{Definir un programa que genere un archivo con registros de longitud fija conteniendo
información de asistentes a un congreso a partir de la información obtenida por
teclado. Se deberá almacenar la siguiente información: nro de asistente, apellido y
nombre, email, teléfono y D.N.I. Implementar un procedimiento que, a partir del
archivo de datos generado, elimine de forma lógica todos los asistentes con nro de
asistente inferior a 1000.
Para ello se podrá utilizar algún carácter especial situándolo delante de algún campo
String a su elección. Ejemplo: ‘@Saldaño’.
}
program ejercicio2;
const
 valor_alto = 32420;
 valor = 1000;
type
  cadena = String[30];
  asistente = record
    nro:integer;
    apeynom:cadena;
    email:cadena;
    tel:string[15];
    dni:integer;
    end;
   
   maestro = file of asistente;
procedure leer(var mae:maestro;var a:asistente);
begin
  if(not EOF(mae))then
    read(mae,a)
  else a.nro:=valor_alto;
end;
procedure cargar_maestro(var mae:maestro;var t:text);
var
  a:asistente;
begin
  reset(t);
  rewrite(mae);
  while(not EOF(t))do
    begin
     readln(t,a.nro,a.dni,a.tel);
     readln(t,a.apeynom);
     readln(t,a.email);
     write(mae,a);
    end;
  close(t);
  close(mae);
end;
procedure eliminar(var mae:maestro);
var
  a:asistente;
begin
  reset(mae);
  leer(mae,a);
  while(a.nro <> valor_alto)do
    begin
      if(a.nro < valor)then
        begin
          a.apeynom := concat(a.apeynom,'@');
          seek(mae,filepos(mae)-1);
          write(mae,a);
        end;
       leer(mae,a);
    end;
  close(mae);
end;
procedure informar(var mae:maestro);
var
  a:asistente;
begin
  reset(mae);
  leer(mae,a);
  while(a.nro <> valor_alto)do
    begin
      writeln('--------------------------------------------------------------');
      writeln('El asistente ',a.apeynom,' su numero de asistente ',a.nro,' su email es ',a.email);
      writeln('Su telefono es ', a.tel);
      writeln('Su DNI es: ', a.dni);
      leer(mae,a);
    end;
  close(mae);
end;
var 
 t:text;
 mae:maestro;
 cad:string[15];
begin
 writeln('Ingrese el nombre del archivo de texto');
 readln(cad);
 assign(t,cad);
 writeln('Ingrese el nombre del archivo maestro');
 readln(cad);
 assign(mae,cad);
 cargar_maestro(mae,t);
 informar(mae);
 eliminar(mae);
 writeln('archivo maestro con registros eliminados');
 informar(mae);
end.
