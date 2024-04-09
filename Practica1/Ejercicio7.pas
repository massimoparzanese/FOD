//A)Crear un archivo binario a partir de la información almacenada en un archivo de
//texto. El nombre del archivo de texto es: “novelas.txt”. La información en el
//archivo de texto consiste en: código de novela, nombre, género y precio de
//diferentes novelas argentinas. Los datos de cada novela se almacenan en dos
//líneas en el archivo de texto. La primera línea contendrá la siguiente información:
//código novela, precio y género, y la segunda línea almacenará el nombre de la
//novela.
//b) Abrir el archivo binario y permitir la actualización del mismo. Se debe poder
//agregar una novela y modificar una existente. Las búsquedas se realizan por
//código de novela.
//NOTA: El nombre del archivo binario es proporcionado por el usuario desde el teclado.
program ejer7;
type
cadena = string[20];
  novela = record
    cod:integer;
    nom:cadena;
    gen:cadena;
    precio:real;
    end;
  archivo = file of novela;
procedure leer(var N:novela);
begin
  writeln('Ingresa el codigo de novela');
  readln(N.cod);
  if(N.cod <> -1)then
   begin
	 writeln('Ingrese el nombre de la novela');
	 readln(N.nom);
	 writeln('Ingrese el genero de la novela');
	 readln(N.gen);
	 writeln('Ingrese el precio de la misma');
	 readln(N.precio);
   end;
end;
procedure crear_archivo(var a:archivo;var t:text);
var
 n:novela;
 cad:cadena;
begin
  writeln('Ingrese el nombre del archivo de texto');
  readln(cad);
  assign(t,cad);
  Reset(t);
  writeln('Ingrese el nombre del archivo binario');
  readln(cad);
  assign(a,cad);
  Rewrite(a);
  while(not EOF(t))do
   begin
     readln(t, n.cod, n.precio, n.gen);
     readln(t, n.nom);
     write(a,n);
   end;
  close(a);
  close(t);
  writeln('Se creó el archivo binario de forma correcta');
end;
procedure modulo_b(var a:archivo);
var
  cad:cadena;
  n:novela;
  num:integer;
  aux:novela;
begin
  writeln('Ingrese el nombre del archivo binario');
  readln(cad);
  assign(a,cad);
  Reset(a);
  repeat
    writeln('Ingrese la operacion que quiera hacer');
    writeln('1.Agregar una o mas novelas');
    writeln('2.Modificar una novela');
    readln(num);
    case num of
      1:begin
         seek(a,0);
         while(not EOF(a))do
           read(a,aux);
         leer(n);
         while(n.cod <> -1)do
           begin
			write(a,n);
			leer(n);
           end;
        end;
      2:begin
         leer(n);
         seek(a,0);
         repeat
           read(a,aux)
         until(aux.cod = n.cod);
         seek(a,filepos(a)-1);
         write(a,n);
        end;
    end;
 until(num = 0);
end;
begin
end.
