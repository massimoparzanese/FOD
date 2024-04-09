program ejer6;
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
procedure leer(var c:celulares);
begin
  writeln('Ingrese el codigo de celular');
  readln(c.cod);
  if(c.cod <> -1)then
   begin
	writeln('Ingresa el nombre');
	readln(c.nom);
	writeln('Ingrese la descripcion');
	readln(c.desc);
	writeln('Ingrese la marca');
	readln(c.marca);
	writeln('Ingrese el stock actual del celular');
	readln(c.st);
	writeln('Ingrese el precio del celular');
	readln(c.precio);
	writeln('Ingrese el stock minimo');
	readln(c.stmin);
   end;
end;
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
procedure modulo_e(var a:archivo);
var
  c:celulares;
  aux:celulares;
  cad:cadena;
begin
  writeln('Ingresar el nombre del archivo de binario');
  readln(cad);
  assign(a,cad);
  reset(a);
  leer(c);
  while(c.cod <> -1 )do
  begin
	while(not EOF(a))do
		begin
		 read(a,aux);
		end;
    write(a,c);
    leer(c);
  end;
 close(a);
end;
procedure modulo_f(var a:archivo);
var 
 stock:integer;
 cad:cadena;
 aux:celulares;
 ok:boolean;
 begin
   writeln('Ingresar el nombre del archivo de binario');
   readln(cad);
   assign(a,cad);
   reset(a);
   writeln('Ingrese el nombre del celular a cambiar de stock');
   readln(cad);
   writeln('Ingrese el stock a cambiar');
   readln(stock);
   while(not EOF(a))do
    begin
     read(a,aux);
     if(aux.nom = cad)then
       begin
        ok:=true;
        aux.st:=stock;
        seek(a,filepos(a)-1);
        write(a,aux);
       end;
   end;
   if(ok = true)then
     writeln('La operacion se realizo correctamente');
  close(a);
 
end;
procedure modulo_g(var a:archivo;var t:text);
var
  aux:celulares;
  cad:cadena;
begin
  writeln('Ingresar el nombre del archivo de binario');
  readln(cad);
  assign(a,cad);
  reset(a);
  writeln('Ingrese el nombre del archivo de texto:');
  readln(cad);
  assign(t,cad);
  Rewrite(t);
  while(not EOF(a)) do
    begin
     read(a,aux);
     if(aux.st = 0)then
       begin
		writeln(t, aux.cod, aux.precio, aux.marca);
		writeln(t, aux.st, aux.stmin, aux.desc);
		writeln(t, aux.nom);
       end;
    end;
 close(a);
 close(t);
end;
var
  num:integer;
  t:text;
  a:archivo;
  t2:text;
begin
 repeat
  writeln(' Ingrese el numero de opcion a ejecutar: 0,1,2,3,4,5,6,7');
  writeln('0.Terminar programa');
  writeln('1.Crear arcvivo binario en base a uno de texto');
  writeln('2.Listar celulares con un stock minimo mayor al actual');
  writeln('3.Listar en pantalla los celulares con descripcion proporcionada por el usuario');
  writeln('4.Exportar de archivo binario a archivo de texto');
  writeln('5.Agregar celulares a archivo binario');
  writeln('6.Modificar stock de un celular dado');
  writeln('7.Exportar celulares con stock 0 a archivo de texto');   
  readln(num);
   case num of
     1:crear_archivo(a,t);
     2:modulo_b(t);
     3:modulo_c(t);
     4:modulo_d(a,t);
     5:modulo_e(a);
     6:modulo_f(a);
     7:modulo_g(a,t2);
   end;
 until( num = 0);
end.

