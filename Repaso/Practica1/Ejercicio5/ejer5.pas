program ejercicio5;
const
  valor_alto = 32420;
type
  cadena = string[30];
  cadenita = string[12];
  
  celular = record
    cod:integer;
    nom:cadena;
    desc:cadena;
    marca:cadenita;
    precio:real;
    st:integer;
    st_min:integer;
    end;
    archivo = file of celular;
procedure leer(var a:archivo;var c:celular);
begin
  if(not EOF(a))then
    read(a,c)
  else c.cod:=valor_alto;
end;
procedure cargar_binario(var a:archivo;var t:text);
var
  c:celular;
begin
  rewrite(a);
  reset(t);
  while(not EOF(t))do 
    begin
     readln(t,c.cod,c.precio,c.marca);
     readln(t,c.st,c.st_min,c.desc);
     readln(t,c.nom);
     write(a,c);
    end;
  close(a);
  close(t);
end;
procedure informar_celular(var c:celular);
begin
  writeln('El celular ', c.nom,' con codigo ', c.cod,' de la marca ', c.marca);
  writeln('Cuesta un total de', c.precio,' y su stock minimo es ', c.st_min, ' y el actual es ', c.st,' con descripcion ', c.desc);
end;
procedure modulo_b(var a:archivo);
var
 c:celular;
begin
  reset(a);
  leer(a,c);
   writeln('Los celulares con stock actual menor al minimo son:');
  while(c.cod <> valor_alto)do
    begin
      if(c.st < c.st_min)then
        informar_celular(c);
      leer(a,c);
    end;
  close(a);
end;
procedure modulo_c(var a:archivo);
var 
  texto:cadena;
  c:celular;
begin
  reset(a);
  writeln('Ingrese la cadena a buscar');
  read(texto);
  leer(a,c);
  writeln('Los celulares con la descripcion ', texto,' son: ');
  while(c.cod <> valor_alto) do
    begin
      if(c.desc = texto)then
        informar_celular(c);
      leer(a,c);
    end;
  close(a);
end;
procedure modulo_d(var t:text;var a:archivo);
var
  c:celular;
begin
  reset(a);
  rewrite(t);
  leer(a,c);
  while(c.cod <> valor_alto) do 
    begin
     writeln(t,c.cod,'   ',c.precio,'   ',c.marca);
     writeln(t,c.st,'  ',c.st_min,'  ',c.desc);
     writeln(t,c.nom);
     leer(a,c); 
    end;
 close(a);
 close(t);
end;
var
  num:integer;
  cad:cadenita;
  t:text;
  a:archivo;
begin
 writeln('Ingrese el nombre del archivo de texto');
 readln(cad);
 assign(t,cad);
 writeln('Ingrese el nombre del archivo binario');
 readln(cad);
 assign(a,cad);
 repeat
   writeln('Ingrese un numero para ejecutar: 1,2,3 o 4, y 0 para terminar');
   readln(num);
   case num of
     1:cargar_binario(a,t);
     2:modulo_b(a);
     3:modulo_c(a);
     4:begin
        writeln('Ingrese el nombre del archivo de texto');
        readln(cad);
        assign(t,cad);
        modulo_d(t,a);
       end;
   end;
 until(num = 0);
end.
