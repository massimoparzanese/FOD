{Se desea modelar la información necesaria para un sistema de recuentos de casos de covid
para el ministerio de salud de la provincia de buenos aires.
Diariamente se reciben archivos provenientes de los distintos municipios, la información
contenida en los mismos es la siguiente: código de localidad, código cepa, cantidad de
casos activos, cantidad de casos nuevos, cantidad de casos recuperados, cantidad de casos
fallecidos.
El ministerio cuenta con un archivo maestro con la siguiente información: código localidad,
nombre localidad, código cepa, nombre cepa, cantidad de casos activos, cantidad de casos
nuevos, cantidad de recuperados y cantidad de fallecidos.
Se debe realizar el procedimiento que permita actualizar el maestro con los detalles
recibidos, se reciben 10 detalles. Todos los archivos están ordenados por código de
localidad y código de cepa.
Para la actualización se debe proceder de la siguiente manera:
1. Al número de fallecidos se le suman el valor de fallecidos recibido del detalle.
2. Idem anterior para los recuperados.
3. Los casos activos se actualizan con el valor recibido en el detalle.
4. Idem anterior para los casos nuevos hallados.
Realice las declaraciones necesarias, el programa principal y los procedimientos que
requiera para la actualización solicitada e informe cantidad de localidades con más de 50
casos activos (las localidades pueden o no haber sido actualizadas).}
program ejercicio7;
const
 valor_alto= 'ZZZZ';
 dimf = 10;
type
cad = string[7];
cadena = string[25];
  municipio = record
    codloc:cad;
    codcep:cad;
    act:integer;
    nue:integer;
    rec:integer;
    fal:integer;
    end;
   localidad = record
     cod:cad;
     nom:cadena;
     codcep:cad;
     nombcep:cadena;
     act:integer;
     nue:integer;
     rec:integer;
     fal:integer;
     end;
   archivo_maestro = file of localidad;
   archivo_detalle = file of municipio;
 detalle = array[1..dimf] of archivo_detalle;
 municipios = array[1..dimf]of municipio;
procedure leer(var det:archivo_detalle;var mun:municipio);
begin
 if(not EOF(det))then
   read(det,mun)
 else
   mun.codloc:=valor_alto;
end;
procedure minimo(var deta:detalle;var min:municipio;var vector:municipios);
var
  i:integer;
begin
 for i:= 1 to dimf do
  begin
   leer(deta[i],vector[i]);
   if(min.codloc = '')then
     min:=vector[i]
   else if(min.codloc < vector[i].codloc)then
          min:=vector[i];
  end;
end;
procedure actualizar_mae(var mae:archivo_maestro;var deta:detalle);
var
  min:municipio;
  v:municipios;
  regd:municipio;
  regm:localidad;
  i:integer;
begin
 Reset(mae);
 for i:= 1 to dimf do
   reset(deta[i]);
 minimo(deta,min,v);
 read(mae,regm);
 while(min.codloc <> valor_alto)do 
  begin
    regd.codloc:= min.codloc;
   while(min.codloc = regd.codloc)do
    begin
     regd.codcep:=min.codcep;
     regd.nue:=0;
     regd.act:=0;
     regd.fal:=0;
     regd.rec:=0;
      while (min.codloc = regd.codloc)and(min.codcep = regd.codcep)do 
         begin
          regd.nue:= regd.nue + min.nue;
          regd.act:= regd.act + min.act;
          regd.fal:= regd.fal + min.fal;
          regd.rec:= regd.rec + min.rec;
          minimo(deta,min,v);
         end;
       while(regm.cod <> regd.codloc)and(regm.codcep <> regd.codcep)do
         read(mae,regm);
       regm.fal:= regm.fal + regd.fal;
       regm.rec:=regm.rec + regd.rec;
       regm.act:= regd.act;
       regm.nue:= regd.nue;
     end;
    
  end;
 close(mae);
 for i:=1 to dimf do
   close(deta[i]);
end;
var
 mae:archivo_maestro;
 deta:detalle;
 cadenita:cadena;
 i:integer;
begin
writeln('Ingrese el nombre del archivo maestro ');
readln(cadenita);
assign(mae,cadenita);
for i:= 1 to dimf do
 begin
  writeln('Ingrese el nombre del archivo detalle numero: ',i);
  readln(cadenita);
  assign(deta[i],cadenita);
 end;
actualizar_mae(mae,deta);
end.
