{Suponga que trabaja en una oficina donde está montada una LAN (red local). La misma fue
construida sobre una topología de red que conecta 5 máquinas entre sí y todas las
máquinas se conectan con un servidor central. Semanalmente cada máquina genera un
archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por
cuánto tiempo estuvo abierta. Cada archivo detalle contiene los siguientes campos:
cod_usuario, fecha, tiempo_sesion. Debe realizar un procedimiento que reciba los archivos
detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha,
tiempo_total_de_sesiones_abiertas.
Notas:
● Cada archivo detalle está ordenado por cod_usuario y fecha.
● Un usuario puede iniciar más de una sesión el mismo día en la misma máquina, o
inclusive, en diferentes máquinas.
● El archivo maestro debe crearse en la siguiente ubicación física: /var/log.}
program ejer6;
const
 valor_alto = 'ZZZZ';
 dimf = 5;
type
 cade = string[5];
 cadena = string[20];
  fecha = record
    dia:1..31;
    mes:1..12;
    anio:integer;
    end;
  sesion = record
    cod:cade;
    fec:fecha;
    tiempo:integer;
    end;
  usuario = record 
    cod:cade;
    fec:fecha;
    tot:integer;
    end;
  archivo_maestro = file of usuario;
  archivo_detalle = file of sesion;
  arch_det = array[1..dimf]of archivo_detalle;
  sesiones = array[1..dimf]of sesion;
procedure leer(var d:archivo_detalle;var det:sesion);
begin
  if(not EOF(d))then
    read(d,det)
  else
    det.cod:=valor_alto;
end;
procedure minimo(var detalle:arch_det;var ses:sesiones;var min:sesion);
var
  i:integer;
begin
  for i:=1 to dimf do
    begin
      leer(detalle[i],ses[i]);
      if(min.cod = '')then
        min:=ses[i]
      else if(ses[i].cod < min.cod)then
        min:=ses[i];
    end;
end;
procedure actualizar(var mae:archivo_maestro;var detalle:arch_det);
var
  s:sesiones;
  u:usuario;
  min:sesion;
  i:integer;
begin
 rewrite(mae);
 for i:=1 to dimf do
   reset(detalle[i]);
 min.cod:='';
 minimo(detalle,s,min);
 while(min.cod <> valor_alto)do
  begin
   u.cod:=min.cod;
   u.tot:=0;
   u.fec:=min.fec;
   while(min.cod = u.cod)do
    begin
     u.tot:=u.tot + min.tiempo;
     minimo(detalle,s,min);
    end;
   write(mae,u);
 end;    
close(mae);
for i:=1 to dimf do
  close(detalle[i]);
end;
var
 mae:archivo_maestro;
 detalle:arch_det;
 nombre:cadena;
 i:integer;
begin
writeln('Ingrese el nombre del archivo maestro a crear');
readln(nombre);
assign(mae,nombre);
for i:= 1 to dimf do
 begin
  writeln('Ingrese el nombre del detalle ',i);
  readln(nombre);
  assign(detalle[i],nombre);
 end;
actualizar(mae,detalle);
end.
