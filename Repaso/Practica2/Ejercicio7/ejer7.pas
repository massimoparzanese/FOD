program ejercicio7;
const
  valor_alto = 32420;
  M = 10;
type
  cadena = String[30];
  Municipio = record
     codloc:integer;
     nom:cadena;
     codcep:integer;
     nomcep:cadena;
     act:integer;
     nue:integer;
     rec:integer;
     fal:integer;
    end;
  
  muni = record
     cod:integer;
     cep:integer;
     act:integer;
     nue:integer;
     recu:integer;
     fal:integer;
    end;
   
   maestro = file of Municipio;
   detalle = file of muni;
   
   detalles = array[1..M] of detalle;
   registros_detalles = array[1..M] of muni;
procedure leer(var det:detalle;var m:muni);
begin
  if(not EOF(det))then
    read(det,m)
  else m.cod:=valor_alto;
end;
procedure minimo(var d:detalles;var regd:registros_detalles;var min:muni);
var
  i:integer;
  pos:integer;
begin
 pos:=1;
 min:=regd[pos];
 for i:= 2 to M do
   begin
     if((regd[i].cod < min.cod)or((regd[i].cod = min.cod)and(regd[i].cod <= min.cod)))then
       begin
         min:= regd[i];
         pos:=i;
       end;
   end;
 leer(d[pos],regd[pos]);
end;
procedure actualizar_maestro(var mae:maestro;det:detalles);
var
 regd:registros_detalles;
 min:muni;
 aux:muni;
 i:integer;
 regm:Municipio;
begin
 reset(mae);
 for i:= 1 to M do
   begin
     reset(det[i]);
     leer(det[i],regd[i]);
   end;
 minimo(det,regd,min);
 read(mae,regm);
 while(min.cod <> valor_alto)do
   begin
     aux.cod:= min.cod;
     while(min.cod = aux.cod)do
       begin
        aux.cod := min.cod;
        aux.act:=0;
		aux.nue:=0;
		aux.fal:=0;
		aux.recu:=0;
		while((min.cod = aux.cod)and(aux.cep = min.cep))do
		  begin
		    aux.act:= aux.act + min.act;
		    aux.nue := aux.nue + min.nue;
		    aux.fal := aux.fal + min.fal;
		    aux.recu:= aux.recu + min.recu;
		    minimo(det,regd,min);
		  end;
	    end;
	 while((regm.codloc <> aux.cod)or(regm.codcep <> aux.cep ))do
		     read(mae,regm);
      seek(mae,filepos(mae)-1);
      regm.fal := regm.fal + aux.fal;
      regm.rec := regm.rec + aux.recu;
      regm.act:= aux.act;
      regm.nue := aux.nue;
      write(mae,regm);
   end;
 close(mae);
 for i:= 1 to M do
   begin
     close(det[i]);
   end;
end;
var
  mae:maestro;
  det:detalles;
  cad:cadena;
  i:integer;
begin
writeln('Ingrese el nombre del arch maestro');
readln(cad);
assign(mae,cad);
reset(mae);
for i:= 1 to M do
  begin
    writeln('Ingrese el nombre del arch detalle',i);
	readln(cad);
	assign(det[i],cad);
  end;
actualizar_maestro(mae,det);
end.
