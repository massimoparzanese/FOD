{Se cuenta con un archivo que posee información de las ventas que realiza una empresa a
los diferentes clientes. Se necesita obtener un reporte con las ventas organizadas por
cliente. Para ello, se deberá informar por pantalla: los datos personales del cliente, el total
mensual (mes por mes cuánto compró) y finalmente el monto total comprado en el año por el
cliente. Además, al finalizar el reporte, se debe informar el monto total de ventas obtenido
por la empresa.
El formato del archivo maestro está dado por: cliente (cod cliente, nombre y apellido), año,
mes, día y monto de la venta. El orden del archivo está dado por: cod cliente, año y mes.
Nota: tenga en cuenta que puede haber meses en los que los clientes no realizaron
compras. No es necesario que informe tales meses en el reporte.}
program ejer8;
const
 valor_alto:'ZZZZ'
type
cad = string[4];
cadena = string[50];
fecha = record
  dia:1..31;
  mes:1..12;
  anio:integer;
 end;
  cliente = record
    cod:cad
    apeynom:cadena;
    end;
   venta = record
    cli:cliente;
    fec:fecha;
    monto:real;
    end;
   archivo_maestro = file of venta;
procedure leer(var mae:archivo_maestro;var v:venta);
begin
 if(not EOF(mae))then
   read(mae,v)
 else
   v.cli.cod:=valor_alto;
end;
procedure recorrer(var mae:archivo_maestro);
var
  totmes:real;
  totanio:real;
  tot_empresa:real;
  fechita:fecha;
  cod:cad;
  v:venta;
begin
 Reset(mae);
 leer(mae,v);
 tot_empresa:=0;
 while(v.cli.cod <> valor_alto)do
   begin
     cod:=v.cli.cod;
    while(v.cli.cod = cod)do
      begin
         totanio:=0;
         fechita.anio:=v.fec.anio;
        while(v.cli.cod = cod)(fechita.anio = v.fec.anio)do
          begin
           totmes:=0;
           fechita.mes:=v.fec.mes;
           writeln('El cliente ',v.cli.apeynom,'con código ',v.cli.cod);
           while(v.cli.cod = cod)(fechita.anio = v.fec.anio)and(fechita.mes = v.fec.mes)do
              begin
				totmes:=totmes + v.cli.monto;
				leer(mae,v);
			  end;
			writeln('En el mes: ',fec.mes);
			writeln('Gastó ',totmes);
            totanio:=totanio+totmes;
		  end;
       writeln('Y en todo el año gastó',totanio);
       tot_empresa:=tot_empresa + totanio;
      end;     
   end;
writeln('El total juntado por la empresa es ',tot_empresa);
close(mae);
end; 
var
  mae:archivo_maestro;
  cadenita:cadena;
begin
writeln('Ingrese el nombre del archivo maestro');
readln(cadenita);
assign(mae,cadenita);
recorrer(mae);
end.
