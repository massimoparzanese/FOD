{El encargado de ventas de un negocio de productos de limpieza desea administrar el stock
de los productos que vende. Para ello, genera un archivo maestro donde figuran todos los
productos que comercializa. De cada producto se maneja la siguiente información: código de
producto, nombre comercial, precio de venta, stock actual y stock mínimo. Diariamente se
genera un archivo detalle donde se registran todas las ventas de productos realizadas. De
cada venta se registran: código de producto y cantidad de unidades vendidas. Se pide
realizar un programa con opciones para:
a. Actualizar el archivo maestro con el archivo detalle, sabiendo que:
● Ambos archivos están ordenados por código de producto.
● Cada registro del maestro puede ser actualizado por 0, 1 ó más registros del
archivo detalle.
● El archivo detalle sólo contiene registros que están en el archivo maestro.
b. Listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo
stock actual esté por debajo del stock mínimo permitido.}
program ejercicio3;
const
  valor_alto = 32400;
type
 cadena = string[20];
 producto = record
    cod:integer;
    nom:cadena;
    precio:real;
    st:integer;
    stmin:integer;
    end;
 venta = record
   cod:integer;
   cant:integer;
   end;
  archivo_maestro = file of producto;
  archivo_detalle = file of venta;
procedure leer(var arch_det:archivo_detalle;var v:venta);
begin
  if(not EOF(arch_det))then
    read(arch_det,v)
  else
    v.cod:= valor_alto;
end;
procedure inciso_a(var arch_mae:archivo_maestro;var arch_det:archivo_detalle);
var 
 regdet:venta;
 aux:venta;
 regm:producto;
begin
  Reset(arch_mae);
  Reset(arch_det);
  leer(arch_det,regdet);
  read(arch_mae,regm);
  while(regdet.cod <> valor_alto)do
    begin
      aux.cod:=regdet.cod;
      aux.cant:=0;
      while(regdet.cod = aux.cod)do
        begin
          aux.cant:= aux.cant + regdet.cant;
          read(arch_det,regdet);
        end;
      while(aux.cod <> regm.cod)do
        read(arch_mae,regm);
      seek(arch_mae,filepos(arch_mae)-1);
      regm.st:=regm.st - aux.cant;
      write(arch_mae,regm);
      if(not EOF(arch_mae))then
         read(arch_mae,regm);
   end;
close(arch_mae);
close(arch_det);
end;
procedure inciso_b(var arch_mae:archivo_maestro;var t:text);
var 
 regm:producto;
begin
  reset(arch_mae);
  rewrite(t);
  while(not EOF(arch_mae))do
   begin
    read(arch_mae,regm);
    if(regm.st < regm.stmin)then
     begin
      writeln(t,regm.cod,'   ',regm.precio,'   ',regm.nom);
      writeln(t,regm.st,'   ',regm.stmin);
     end;
    end;
 close(arch_mae);
 close(t);
end;
var
  arch_mae:archivo_maestro;
  arch_det:archivo_detalle;
  num:integer;
  t:text;
  cad:cadena;  
begin
 writeln('Ingrese el nombre del archivo maestro'); 
 readln(cad);
 Assign(arch_mae,cad);
 writeln('Ingrese el nombre del archivo detalle');
 readln(cad);
 Assign(arch_det,cad);
repeat
 writeln('Ingrese la opcion a ejecutar ');
 writeln('0.Terminar el programa');
 writeln('1.Actualizar el archivo maestro');
 writeln('2.Exportar productos con stock menor al minimo');
 readln(num);
 case num of
   0:writeln('El programa termino');
   1:begin
      writeln('ingrese el nombre del archivo maestro');
      readln(cad);
      assign(arch_mae,cad);
      writeln('ingrese el nombre del archivo maestro');
      readln(cad);
      assign(arch_det,cad);
      inciso_a(arch_mae,arch_det);
     end;  
   2:begin
     writeln('ingrese el nombre del archivo de texto');
     readln(cad);
     Assign(t,cad);
     inciso_b(arch_mae,t);
     end;
  end;
 until(num = 0);
end.
