{ Una cadena de tiendas de indumentaria posee un archivo maestro no ordenado con
la información correspondiente a las prendas que se encuentran a la venta. De cada
prenda se registra: cod_prenda, descripción, colores, tipo_prenda, stock y
precio_unitario. Ante un eventual cambio de temporada, se deben actualizar las
prendas a la venta. Para ello reciben un archivo conteniendo: cod_prenda de las
prendas que quedarán obsoletas. Deberá implementar un procedimiento que reciba
ambos archivos y realice la baja lógica de las prendas, para ello deberá modificar el
stock de la prenda correspondiente a valor negativo.
Adicionalmente, deberá implementar otro procedimiento que se encargue de
efectivizar las bajas lógicas que se realizaron sobre el archivo maestro con la
información de las prendas a la venta. Para ello se deberá utilizar una estructura
auxiliar (esto es, un archivo nuevo), en el cual se copien únicamente aquellas prendas
que no están marcadas como borradas. Al finalizar este proceso de compactación
del archivo, se deberá renombrar el archivo nuevo con el nombre del archivo maestro
original.
}
program ejer6;
const
 valor_alto = 32420;
type
cadena = string[60];
cadenita = string[10];
  prenda = record
    cod:integer;
    desc:cadena;
    colores:cadena;
    tipo:cadenita;
    stock:integer;
    precio:real;
    end;
   
   archivo_maestro = file of prenda;
   archivo_detalle = file of integer;
procedure leer(var det:archivo_detalle;var cod:integer);
begin
if(not EOF(det))then
   read(det,cod)
 else
   cod:=valor_alto;
end;
procedure leer_maestro(var mae:archivo_maestro;var p:prenda);
begin
if(not EOF(mae))then
   read(mae,p)
 else
   p.cod:=valor_alto;
end;
procedure cargar_det_binario(var t:text;var a:archivo_detalle);
var
  cod:integer;
begin
  reset(t);
  rewrite(a);
  while(not EOF(t))do
    begin
      readln(t,cod);
      write(a,cod);    
    end;
 close(t);
 close(a);
end;
procedure cargar_binario(var t:text;var a:archivo_maestro);
var
  p:prenda;
begin
  reset(t);
  rewrite(a);
  while(not EOF(t))do
    begin
      readln(t,p.cod,p.stock, p.desc);
      readln(t,p.precio,p.colores);
      readln(t,p.tipo);
      write(a,p);    
    end;
 close(t);
 close(a);
end;
procedure eliminar_logico(var det:archivo_detalle;var mae:archivo_maestro);
var
  cod:integer;
  regm:prenda;
begin
  reset(det);
  leer(det,cod);
  reset(mae);
  while(cod <> valor_alto)do
    begin
       read(mae,regm);
       while(cod <> regm.cod)do
          read(mae,regm);
       regm.stock:=regm.stock * -1;
       seek(mae,filepos(mae)-1);
       write(mae,regm);
       seek(mae,0);
       leer(det,cod);   
    end;
 close(det);
 close(mae);
end;
procedure bajas_efectivas(var mae:archivo_maestro;var mae2:archivo_maestro);
var
  p:prenda;
begin
 reset(mae);
 rewrite(mae2);
 leer_maestro(mae,p);
 while(p.cod <> valor_alto )do
   begin
     if(p.stock > 0 )then
       write(mae2,p);
     leer_maestro(mae,p);
   end;
 close(mae);
 close(mae2);
end;
procedure imprimir_maestro(var a:archivo_maestro);
var
  p:prenda;
begin
 reset(a);
 leer_maestro(a,p);
 while(p.cod <> valor_alto)do
   begin
    writeln('-------------------------------------------------------------');
    writeln('El codigo de la prenda es ',p.cod,' y su descripcion es ',p.desc);
    writeln('Es de color',p.colores,' de tipo ',p.tipo,' con stock de ',p.stock,' unidades. Y su precio es de ',p.precio:0:2);
    writeln('-------------------------------------------------------------');
    leer_maestro(a,p);
   end;
 close(a);
end;
procedure imprimir_detalle(var a:archivo_detalle);
var
  cod:integer;
begin
 reset(a);
 leer(a,cod);
 while(cod <> valor_alto)do
   begin
    writeln('El codigo de la prenda es ',cod);
    leer(a,cod);
   end;
 close(a);
end;
var
 t:text;
 t2:text;
 det:archivo_detalle;
 mae:archivo_maestro;
 new_mae:archivo_maestro;
 cad:string[15];
begin
writeln('Ingrese el nombre del archivo binario');
readln(cad);
Assign(mae,cad);
writeln('Ingrese el nombre del archivo detalle');
readln(cad);
assign(det,cad);
writeln('-------------------------------------------------------------');
writeln('archivo maestro');
imprimir_maestro(mae);
writeln('-------------------------------------------------------------');
eliminar_logico(det,mae);
writeln('-------------------------------------------------------------');
writeln('archivo maestro con eliminaciones');
imprimir_maestro(mae);
writeln('-------------------------------------------------------------');
writeln('Ingrese el nombre del nuevo archivo binario');
readln(cad);
Assign(new_mae,cad);
bajas_efectivas(mae,new_mae);
writeln('archivo maestro nuevo');
imprimir_maestro(new_mae);
writeln('-------------------------------------------------------------');
end.
