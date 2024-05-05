{El encargado de ventas de un negocio de productos de limpieza desea administrar el
stock de los productos que vende. Para ello, genera un archivo maestro donde figuran
todos los productos que comercializa. De cada producto se maneja la siguiente
información: código de producto, nombre comercial, precio de venta, stock actual y
stock mínimo. Diariamente se genera un archivo detalle donde se registran todas las
ventas de productos realizadas. De cada venta se registran: código de producto y
cantidad de unidades vendidas. Resuelve los siguientes puntos:
a. Se pide realizar un procedimiento que actualice el archivo maestro con el
archivo detalle, teniendo en cuenta que:
i. Los archivos no están ordenados por ningún criterio.
ii. Cada registro del maestro puede ser actualizado por 0, 1 ó más registros
del archivo detalle.
b. ¿Qué cambios realizaría en el procedimiento del punto anterior si se sabe que
cada registro del archivo maestro puede ser actualizado por 0 o 1 registro del
archivo detalle?}
program ejer_merge1;
const
  valor_alto = 'ZZZZ';
type
cadenita = string[4];
 cadena = string[20];
 producto = record
   cod:cadenita;
   nom_com:cadena;
   precio:real;
   st:integer;
   stmin:integer;
   end;
   venta = record
     cod:cadenita;
     cant:integer;
     procesado:boolean;
     end;
   
   archivo_maestro = file of producto;
   archivo_detalle = file of venta;
procedure leer(var det:archivo_detalle;var v:venta);
begin
  if(not EOF(det))then
    read(det,v)
   else v.cod:=valor_alto;
end;
procedure marcar(var det:archivo_detalle;cod:cadenita);
var
  v:venta;
begin
seek(det,0);
leer(det,v);
while(v.cod <> valor_alto)do
  begin
   if(v.cod = cod) and(v.procesado = false)then
     v.procesado := true;
     seek(det,filepos(det)-1);
     write(det,v);
  end;
end;
procedure actualizar_multiple(var mae:archivo_maestro;var det:archivo_detalle);
var 
 regdet:venta;
 aux:venta;
 regm:producto;
begin
  Reset(mae);
  Reset(det);
  leer(det,regdet);
  read(mae,regm);
  while(regdet.cod <> valor_alto)do
    begin
     if(regdet.procesado = false)then 
     begin
       aux.cod:=regdet.cod;
       aux.cant:=0;
        if(regdet.cod = aux.cod)then
          begin
            aux.cant:= aux.cant + regdet.cant;
            leer(det,regdet);
          end;
        while(aux.cod <> regm.cod)do
          read(mae,regm);
        seek(mae,filepos(mae)-1);
        regm.st:=regm.st - aux.cant;
        write(mae,regm);
        if(not EOF(mae))then
          read(mae,regm);
       seek(mae,0);
       marcar(det,aux.cod);
      end
     else leer(det,regdet);
   end;
close(mae);
close(det);
end;
procedure actualizar_unica(var mae:archivo_maestro;var det:archivo_detalle);
var
 regdet:venta;
 regm:producto;
begin
  Reset(mae);
  Reset(det);
  leer(det,regdet);
  read(mae,regm);
  while(regdet.cod <> valor_alto)do
    begin
      while(regdet.cod <> regm.cod)do
          read(mae,regm);
      seek(mae,filepos(mae)-1);
      regm.st:=regm.st - regdet.cant;
      write(mae,regm);
      seek(mae,0);
      leer(det,regdet);
    end;
  close(mae);
  close(det);
end;
var
 cad:cadena;
 mae:archivo_maestro;
 det:archivo_detalle;
 num:integer;
begin
 readln(cad);
 assign(mae,cad);
 readln(cad);
 assign(det,cad);
repeat 
 readln(num);
 case (num)of
    1:actualizar_unica(mae,det);
    2:actualizar_multiple(mae,det);
   end;
  until(num = 0);
end.
