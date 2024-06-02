program ejer2;
const
  valor_alto = 32420;
type
 cadena = string[30];
  alumno = record
    cod:integer;
    ape:cadena;
    nom:cadena;
    apro:integer;
    curs:integer;
    end;
  registro_detalle = record
     cod:integer;
     aprobo:integer;
     end;
   archivo_detalle = file of registro_detalle;
   archivo = file of alumno;
procedure leer(var a:archivo_detalle;var deta:registro_detalle);
begin
  if(not EOF(a))then
    read(a,deta)
  else deta.cod:=valor_alto;
end;
procedure crear_binario(var a:archivo;var t:text);
var
  alu:alumno;
begin
 Reset(t);
 Rewrite(a);
 while(not EOF(t))do
   begin
     readln(t,alu.cod,alu.apro,alu.curs);
	 readln(t,alu.nom);
	 readln(t,alu.ape);
	 write(a,alu);
   end;
  close(a);
  close(t);
end;
procedure crear_binario2(var a:archivo_detalle;var t:text);
var
  al:registro_detalle;
begin
 reset(t);
 rewrite(a);
 while(not EOF(t))do
  begin
    readln(t,al.cod,al.aprobo);
    write(a,al);
  end;
 close(a);
 close(t);
end;
procedure actualizar_mae(var a:archivo;var deta:archivo_detalle);
var
  alu:alumno;
  a2: registro_detalle;
  apro:integer;
  curs:integer;
  cod:integer;
begin
 reset(a);
 reset(deta);
 leer(deta,a2);
 read(a,alu);
 while(a2.cod  <> valor_alto)do
   begin
     cod:=a2.cod;
     apro:=0;
     curs:=0;
     while(a2.cod = cod)do
      begin
        if(a2.aprobo = 1)then
          apro:=apro +1
        else curs:= curs + 1;
        leer(deta,a2);
      end;
     while(alu.cod <> cod)do
       read(a,alu);
     writeln('Aprobo: ',apro);
     writeln('Curso: ',curs);
     alu.apro:= alu.apro + apro;
     alu.curs:= alu.curs - apro;
     alu.curs:= alu.curs + curs;
     seek(a,filepos(a)-1);
     write(a,alu);
   end;
 close(a);
 close(deta);
end;
procedure listar(var t:text;var a:archivo);
var
  alu:alumno;
begin
 reset(a);
 rewrite(t);
 while(not EOF(a))do
  begin
    read(a,alu);
    writeln(t,alu.nom,' ',alu.ape,' ',alu.cod,' ',alu.apro,' ',alu.curs);
  end;
 close(a);
 close(t);
end;
var
 t:text;
 t2:text;
 a:archivo;
 deta:archivo_detalle;
 cad:string[15];
begin
  writeln('Ingrese el nombre del detalle');
  readln(cad);
  assign(deta,cad);
  writeln('Ingrese el nombre del binario');
  readln(cad);
  assign(a,cad);
  writeln('Ingrese el nombre del archivo de texto para el binario');
  readln(cad);
  assign(t,cad);
  crear_binario(a,t);
  writeln('Ingrese el nombre del archivo de texto para el detalle');
  readln(cad);
  assign(t,cad);
  crear_binario2(deta,t);
  actualizar_mae(a,deta);
  writeln('Ingrese el nombre del archivo de texto para el listado');
  readln(cad);
  assign(t2,cad);
  listar(t2,a);
end.
