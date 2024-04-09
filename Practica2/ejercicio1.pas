{Una empresa posee un archivo con información de los ingresos percibidos por diferentes
empleados en concepto de comisión, de cada uno de ellos se conoce: código de empleado,
nombre y monto de la comisión. La información del archivo se encuentra ordenada por
código de empleado y cada empleado puede aparecer más de una vez en el archivo de
comisiones.
Realice un procedimiento que reciba el archivo anteriormente descrito y lo compacte. En
consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca una
única vez con el valor total de sus comisiones.
NOTA: No se conoce a priori la cantidad de empleados. Además, el archivo debe ser
recorrido una única vez.}
program ejercicio1;
const
  valor_alto =9999;
type
  cadena = string[20];
  empleado = record
    cod:integer;
    nom:cadena;
    monto:real;
    end;
  archivo = file of empleado;
procedure leer(var a:archivo;var e:empleado);
begin
  if(not EOF(a))then
    read(a,e)
  else
    e.cod:= valor_alto;
end;
procedure recorrer(var a:archivo;var a2:archivo);
var
 tot:real;
 e:empleado;
 aux:empleado;
begin
  Reset(a);
  Rewrite(a2);
  leer(a,e);
  while(e.cod <> valor_alto)do
    begin
     aux:=e;
     tot:=0;
     while((e.cod <> valor_alto)and(e.cod = aux.cod))do
       begin
         tot:= tot + e.monto;
         leer(a,e);
       end;
     aux.monto:=tot;
     write(a2,aux);
     leer(a,e);
   end;
  close(a);
  close(a2);
end;
var
  a:archivo;
  a2:archivo;
  cad:cadena;
begin
writeln('Ingrese el nombre del archivo');
readln(cad);
Assign(a,cad);
writeln('Ingrese el nombre del archivo a crear');
readln(cad);
Assign(a2,cad);
recorrer(a,a2);
end.
