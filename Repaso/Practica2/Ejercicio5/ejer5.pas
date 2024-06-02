program ejercicio5;
const
 valor_alto = 32420;
 M = 30;
type
  cadena = string[30];
  producto = record
    cod:integer;
    nom:cadena;
    desc:cadena;
    st:integer;
    stmin:integer;
    precio:integer;
    end;
  produc = record
    cod:integer;
    cant:integer;
    end;
    maestro = file of producto;
    detalle = file of produc;
    detalles = array[1..M] of detalle;
    vector = array[1..M] of produc;
procedure leer(var det:detalle;var p:produc);
begin
  if(not EOF(det))then
    read(det,p)
  else p.cod:=valor_alto;
end;
procedure minimo(var det:detalles;var v:vector;var min:produc);
var
  pos:integer;
  i:integer;
begin
 min:=v[1];
 pos:=1;
 for i:= 2 to M do                                               
   begin
     if(v[i].cod <= min.cod)then
       begin
         pos:=i;
         min:=v[i];
       end;
   end;
 leer(det[pos],v[pos]);
end;
procedure cargar_detalle(var det:detalle;var t:text);
var
 p:produc;
begin
 reset(t);
 rewrite(det);
 while(not EOF(t))do
  begin
    readln(t,p.cod,p.cant);
    write(det,p);
  end;
 close(t);
 close(det);
end;
procedure cargar_maestro(var mae:maestro;var t:text);
var
  p:producto;
begin
 rewrite(mae);
 reset(t);
 while(not EOF(t))do
   begin
     readln(t,p.cod,p.precio,p.desc);
     readln(t,p.st,p.stmin,p.nom);
     write(mae,p);                    {cod:integer;nom:cadena;desc:cadena;st:integer;stmin:integer;precio:integer;}
   end;
 close(mae);
 close(t);
end;
procedure actualizar_maestro(var mae:maestro;det:detalles;var v:vector);
var
  regm:producto;
  min:produc;
  i:integer;
  aux:produc;
begin
 reset(mae);
 read(mae,regm);
 for i:=1 to M do
   begin
	reset(det[i]);
	leer(det[i],v[i]);
   end;
 minimo(det,v,min);
 while(min.cod <> valor_alto)do
   begin
     aux.cod:=min.cod;
     aux.cant:=0;
     while(min.cod = aux.cod)do
       begin
         aux.cant:=aux.cant + min.cant;
         minimo(det,v,min);
       end;
     while(regm.cod <> aux.cod)do
       read(mae,regm);
     regm.st:= regm.st - aux.cant;
     seek(mae,filepos(mae)-1);
     write(mae,regm);
   end;
  close(mae);
  for i:=1 to M do
   begin
	close(det[i]);
   end;
end;
procedure imprimir_maestro(var mae:maestro);
var
  p:producto;
begin
 reset(mae);
 while(not EOF(mae))do
   begin
     read(mae,p);
     writeln('------------------------------------');
     writeln('El producto ',p.nom,' con codigo ',p.cod,' y descripcion ',p.desc);
     writeln('Posee un stock: ',p.st);
     writeln('Su stock minimo es: ',p.stmin);
     writeln('Su precio es: ',p.precio);
   end;
end;
var
  cad:cadena;
  i:integer;
  mae:maestro;
  det:detalles;
  v:vector;
  t:text;
begin
writeln('Ingrese el nombre del arch maestro');
readln(cad);
assign(mae,cad);
writeln('Ingrese el nombre del arch de texto para el maestro');
readln(cad);
assign(t,cad);
cargar_maestro(mae,t);
for i:= 1 to M do
  begin
     writeln('Ingrese el nombre del arch de texto para el detalle ',i);
	 readln(cad);
	 assign(t,cad);
	 writeln('Ingrese el nombre del arch detalle ',i);
	 readln(cad);
	 assign(det[i],cad);
     cargar_detalle(det[i],t);
  end;
imprimir_maestro(mae);
actualizar_maestro(mae,det,v);
imprimir_maestro(mae);
end.
