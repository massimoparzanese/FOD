program ejercicio8;
const
  valor_alto = 32420;
type
  cadena = String[50];
  fecha = record
    dia:1..31;
    mes:1..12;
    anio:integer;
  end;
  cliente = record
	cod:integer;
	apeynom:cadena;
	fec:fecha;
	monto:real;
	end;
	maestro = file of cliente;
procedure leer(var mae:maestro;var c:cliente);
begin
  if(not EOF(mae))then
    read(mae,c)
  else c.cod:=valor_alto;
end;
procedure cargar_maestro(var mae:maestro;var t:text);
var
  c:cliente;
begin
  reset(t);
  rewrite(mae);
  while(not EOF(t))do
    begin
      readln(t,c.cod,c.apeynom);
      readln(t,c.fec.dia,c.fec.mes,c.fec.anio,c.monto);
      write(mae,c);
      writeln('No hay error');
    end;
    writeln('termine bien aca');
  close(t);
  close(mae);
end;
procedure informar(var mae:maestro);
var
  c:cliente;
  aux:cliente;
  total:real;
  monto_anio:real;
begin
 reset(mae);
 leer(mae,c);
 total:= 0;
 while(c.cod <> valor_alto)do
   begin
     aux.cod:= c.cod;
     writeln('-----------------------------------------------');
     writeln('El cliente ',c.apeynom,' con codigo ',c.cod);
     while(c.cod = aux.cod)do
       begin
         aux.fec.anio:= c.fec.anio;
         monto_anio:= 0;
         while((c.cod = aux.cod)and(c.fec.anio = aux.fec.anio))do 
             begin
              aux.fec.mes := c.fec.mes;
              aux.monto:=0;
              while((c.cod = aux.cod)and(c.fec.anio = aux.fec.anio)and(aux.fec.mes = c.fec.mes))do 
                  begin
                     aux.monto:= aux.monto + c.monto;
                     leer(mae,c);
                  end;
              writeln(' En el mes ',aux.fec.mes,' gasto un total de ',aux.monto:0:2);
              monto_anio:= monto_anio + aux.monto;
             end;
         writeln(' En el anio ',aux.fec.anio,' gasto un total de ',monto_anio:0:2);
         total:= total + monto_anio;
       end;
   end;
 writeln('El monto total obtenido por la empresa es: ',total:0:2);
 close(mae);
end;
var
  mae:maestro;
  cad:string[20];
  t:text;
begin
writeln('Ingrese el nombre del arch maestro');
readln(cad);
assign(mae,cad);
writeln('Ingrese el nombre del archivo de texto');
readln(cad);
assign(t,cad);
cargar_maestro(mae,t);
informar(mae);
end.
