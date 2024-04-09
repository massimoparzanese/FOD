{Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados.
De cada producto se almacena: código del producto, nombre, descripción, stock disponible,
stock mínimo y precio del producto.
Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de la cadena. Se
debe realizar el procedimiento que recibe los 30 detalles y actualiza el stock del archivo
maestro. La información que se recibe en los detalles es: código de producto y cantidad
vendida. Además, se deberá informar en un archivo de texto: nombre de producto,
descripción, stock disponible y precio de aquellos productos que tengan stock disponible por
debajo del stock mínimo. Pensar alternativas sobre realizar el informe en el mismo
procedimiento de actualización, o realizarlo en un procedimiento separado (analizar
ventajas/desventajas en cada caso).
Nota: todos los archivos se encuentran ordenados por código de productos. En cada detalle
puede venir 0 o N registros de un determinado producto.}
program ejercicio5;
const
  valor_alto = 'ZZZZ';
  dimf = 30;
type
 cad = string[5];
 cadena = string[20];
 producto = record
   cod:cad;
   nom:cadena;
   desc:cadena;
   st:integer;
   stmin:integer;
   precio:real;
   end;
 prod = record
   cod:cad;
   cant:integer;
   end;
archivo_maestro = file of producto;
archivo_detalle = file of prod;

vector = array[1..dimf]of archivo_detalle;
vect = array[1..dimf] of prod;
procedure leer(var d:archivo_detalle;var p:prod);
begin
  if(not EOF(d))then
    read(d,p)
  else
    p.cod:= valor_alto;
end;
procedure minimo(var min:prod;var v:vector;var v2:vect);
var
  i:integer;
  pos:integer;
begin
  min := v2[1];
  for i:= 2 to dimf do
    begin
      if(v2[i].cod < min.cod)then
        begin
          min:=v2[i];
          pos:=i;
        end;
    end;
  leer(v[pos],v2[pos]);
end;  
procedure actualizar_mae(var mae:archivo_maestro;var det:vector);
var
 regd:vect;
 min:prod;
 aux:prod;
 i:integer;
 m:producto;
begin
  reset(mae);
  read(mae,m);
  for i:= 1 to dimf do
    begin
      reset(det[i]);
      leer(det[i],regd[i]);
    end; 
  minimo(min,det,regd);
  writeln('Los productos con stock minimo menor al actual son:');
  while(min.cod <> valor_alto)do
    begin
     aux.cod := min.cod;
     aux.cant:=0;
     while(min.cod = aux.cod)do
       begin
        aux.cant:=aux.cant + min.cant;
        minimo(min,det,regd);
       end;
     while(m.cod<> aux.cod)do
       read(mae,m);
     m.st:= m.st - aux.cant;
     seek(mae,filepos(mae)-1);
     write(mae,m);
     
     if(m.st < m.stmin)then
      writeln(m.nom,' ',m.cod,' ',m.desc,' ',m.st,' ',m.stmin,' ',m.precio:0:2);
    end;
close(mae);
for i:= 1 to dimf do
   close(det[i]);
end;
var
 mae:archivo_maestro;
 det:vector;
 cade:cadena;
 i:integer;
begin
writeln('Ingrese el nombre del archivo maestro');
readln(cade);
Assign(mae,cade);
for i:=1 to dimf do
 begin
  writeln('Ingrese el nombre del detalle numero: ',i);
  readln(cade);
  Assign(det[i],cade);
 end; 
actualizar_mae(mae,det);
end.
