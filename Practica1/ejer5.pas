program ejercicio5;
type
 cadena = string[20];
  celulares = record
    cod:integer;
    nom:cadena;
    desc:cadena;
    marca:cadena;
    precio:real;
    st:integer;
    stmin:integer;
    end;
  archivo = file of celulares;
procedure crear_archivo(var a:archivo;var t:text);
var
  c:celulares;
  cad:cadena;
  cad2:cadena;
begin
 writeln('Ingresar el nombre del archivo de binario');
 readln(cad2);
 assign(a,cad2);
 Rewrite(a);
 writeln('Ingresar el nombre del archivo de texto');
 readln(cad);
 assign(t,cad);
 Reset(t);
 while(not EOF(t))do
   begin
    readln(t, c.cod, c.precio,c.marca);
    readln(t, c.st, c.stmin, c.desc);
    readln(t, c.nom);
    write(a,c);
   end;
 close(a);
 close(t);
end;
procedure imprimir_Cel(c:celulares);
begin
  writeln(' El celular marca ', c.marca,' con codigo ', c.cod,' modelo ', c.nom,' descripcion ', c.desc, ' precio ', c.precio:0:2);
  writeln(' stock actual de ', c.st,' y stock minimo de ', c.stmin);
end;
procedure modulo_b(var t:Text);
var
  c:celulares;
  cad:cadena;
begin
 writeln('Ingresar el nombre del archivo de texto');
 readln(cad);
 assign(t,cad);
 reset(t);
 while(not EOF(t))do
   begin
    readln(t, c.cod, c.precio,c.marca);
    readln(t, c.st, c.stmin, c.desc);
    readln(t, c.nom);
    if(c.st < c.stmin)then
      imprimir_Cel(c);
   end;
 close(t);
end;
procedure modulo_c(var t:Text);
var 
  cad:cadena;
  c:celulares;
begin
  writeln('Ingresar el nombre del archivo de texto');
  readln(cad);
  assign(t,cad);
  reset(t);
  writeln(' Ingrese el nombre de la descripcion a comparar ');
  readln(cad);
  while(not EOF(t))do
    begin
      readln(t, c.cod, c.precio,c.marca);
      readln(t, c.st, c.stmin, c.desc);
      readln(t, c.nom);
      if(c.desc = cad)then
        imprimir_Cel(c);
    end;
  close(t);
end;
procedure modulo_d(var a:archivo;var t:Text);
var 
  cad:cadena;
  c:celulares;
begin
 writeln('Ingresar el nombre del archivo de texto');
 readln(cad);
 assign(t,cad);
 rewrite(t);
 writeln('Ingresar el nombre del archivo de binario');
 readln(cad);
 assign(a,cad);
 reset(a);
 while(not EOF(a))do
   begin
     read(a,c);
	 writeln(t, c.cod, c.precio:0:2,c.marca);
     writeln(t, c.st, c.stmin, c.desc);
     writeln(t, c.nom);
   end;
 close(a);
 close(t);
end;
var
  num:integer;
  t:text;
  a:archivo;
begin
 repeat
  writeln(' Ingrese el numero de opcion a ejecutar: 1,2,3 o 4');
  writeln('Ingrese 0 para terminar');
  readln(num);
   case num of
     1:crear_archivo(a,t);
     2:modulo_b(t);
     3:modulo_c(t);
     4:modulo_d(a,t);
   end;
 until( num = 0);
end.
