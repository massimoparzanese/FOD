program ejercicio3;
const
  valor_alto= 32420;
type
 cadena = string[30];
 producto = record
    cod:integer;
    nom:cadena;
    precio:real;
    st:integer;
    stmin:integer;
   end;
 
 produc = record
   cod:integer;
   cant:integer;
   end;
 
 maestro = file of producto;
 detalle = file of produc;
procedure leer(var det:detalle;var p:produc);
begin
 if(not EOF(det))then
   read(det,p)
 else p.cod:=valor_alto;
end;
procedure crear_binario(var mae:maestro;var t:text);
var
  p:producto;
begin
 Reset(t);
 Rewrite(mae);
 while(not EOF(t))do
   begin
     readln(t,p.cod,p.precio,p.nom);
	 readln(t,p.st,p.stmin);
	 write(mae,p);
   end;
  close(mae);
  close(t);
end;
procedure crear_detalle(var det:detalle;var t:text);
var
  p:produc;
begin
 Reset(t);
 Rewrite(det);
 while(not EOF(t))do
   begin
     readln(t,p.cod,p.cant);
	 write(det,p);
   end;
  close(det);
  close(t);
end;
procedure actualizar_mae(var mae:maestro;var det:detalle);
var
  pro:produc;
  aux:produc;
  regm:producto;
begin
  reset(mae);
  reset(det);
  leer(det,pro);
  read(mae,regm);
  while(pro.cod <> valor_alto)do
    begin
      aux.cod:= pro.cod;
      aux.cant:=0;
      while(aux.cod = pro.cod)do
        begin
          aux.cant:= aux.cant + pro.cant;
          leer(det,pro);
        end;
      while(regm.cod <> aux.cod)do
        read(mae,regm);
      regm.st := regm.st - aux.cant;
      seek(mae,filepos(mae)-1);
      write(mae,regm);
    end;
  close(mae);
  close(det);
end;
procedure listar_texto(var mae:maestro;var t:text);
var
 regm:producto;
begin
  reset(mae);
  rewrite(t);
  while(not EOF(mae))do
    begin
      read(mae,regm);
      if(regm.stmin > regm.st )then {cod:integer;nom:cadena;precio:real;st:integer;stmin:integer;}
        begin
          writeln(t,regm.cod,' ',regm.precio:0:2,' ',regm.nom);
          writeln(t,regm.st,' ',regm.stmin);
        end;
    end;
  close(mae);
  close(t);
end;
procedure imprimir_maestro(var mae:maestro);
var
  regm:producto;
begin
  reset(mae);
  while(not EOF(mae))do
    begin
      read(mae,regm);
      writeln('-----------------------------------------------');
      writeln('El producto con nombre ',regm.nom,' y codigo ',regm.cod);
      writeln('Posee este precio: ',regm.precio:0:2);
      writeln('Su stock actual es: ',regm.st);
      writeln('Y su stock minimo :',regm.stmin)
    end;
  close(mae);
end;
var
  mae:maestro;
  t:text;
  det:detalle;
  cad:cadena;
begin
writeln('Ingrese el nombre del archivo de texto del maestro');
readln(cad);
assign(t,cad);
writeln('Ingrese el nombre del archivo maestro');
readln(cad);
assign(mae,cad);
crear_binario(mae,t);
writeln('Ingrese el nombre del archivo de texto del detalle');
readln(cad);
assign(t,cad);
writeln('Ingrese el nombre del archivo detalle');
readln(cad);
assign(det,cad);
crear_detalle(det,t);
actualizar_mae(mae,det);
writeln('Ingrese el nombre del archivo de texto');
readln(cad);
assign(t,cad);
listar_texto(mae,t);
imprimir_maestro(mae);
end.
