{Se necesita contabilizar los votos de las diferentes mesas electorales registradas por
provincia y localidad. Para ello, se posee un archivo con la siguiente información: código de
provincia, código de localidad, número de mesa y cantidad de votos en dicha mesa.
Presentar en pantalla un listado como se muestra a continuación:
Código de Provincia
Código de Localidad Total de Votos
................................ ......................
................................ ......................
Total de Votos Provincia: ____
Código de Provincia
Código de Localidad Total de Votos
................................ ......................
Total de Votos Provincia: ___
…………………………………………………………..
Total General de Votos: ___
NOTA: La información está ordenada por código de provincia y código de localidad.}
program ejer9;
const
 valor_alto ='ZZZZ';
type
 cadenita = string[4];
  provincia = record
    cod:cadenita;
    codloc:cadenita;
    num:integer;
    vot:integer;
    end;
  archivo = file of provincia;
procedure leer(var arch:archivo;var prov:provincia);
begin
 if(not EOF(arch))then
   read(arch,prov)
 else
   prov.cod:=valor_alto;
end;
procedure recorrer_archivo(var a:archivo);
var
  cantloc:integer;
  cantprov:integer;
  tot:integer;
  cod:cadenita;
  prov:provincia;
  codloc:cadenita;
begin
 reset(a);
 leer(a,prov);
 tot:=0;
 while(prov.cod <> valor_alto)do
  begin
   cod:=prov.cod;
   cantprov:=0;
   writeln('La provincia con codigo:',cod);
   while(prov.cod = cod)do
     begin
      cantloc:=0;
      codloc:=prov.codloc;
      writeln('Localidad con codigo: ',codloc);
      while(prov.cod = cod)and(prov.codloc = codloc)do
        begin
         cantloc:=cantloc + prov.vot;
         leer(a,prov);
        end;
      writeln('Cantidad de votos: ',cantloc);
      writeln('................................ ......................');
      cantprov:=cantprov + cantloc;
     end;
    tot:=tot+ cantprov;
    writeln('................................ ......................');
    writeln('Total de votos de la provincia: ',cantprov);
  end;
writeln('Total de votos en general: ',tot);
close(a);
end;
var
  archi:archivo;
  nombre:string[20];
begin
writeln('Ingrese el nombre del archivo');
readln(nombre);
assign(archi,nombre);
recorrer_archivo(archi);
end.
