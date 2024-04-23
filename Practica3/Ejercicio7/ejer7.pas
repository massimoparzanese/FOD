{Se cuenta con un archivo que almacena información sobre especies de aves en vía
de extinción, para ello se almacena: código, nombre de la especie, familia de ave,
descripción y zona geográfica. El archivo no está ordenado por ningún criterio. Realice
un programa que elimine especies de aves, para ello se recibe por teclado las
especies a eliminar. Deberá realizar todas las declaraciones necesarias, implementar
todos los procedimientos que requiera y una alternativa para borrar los registros. Para
ello deberá implementar dos procedimientos, uno que marque los registros a borrar y
posteriormente otro procedimiento que compacte el archivo, quitando los registros
marcados. Para quitar los registros se deberá copiar el último registro del archivo en la
posición del registro a borrar y luego eliminar del archivo el último registro de forma tal
de evitar registros duplicados.
Nota: Las bajas deben finalizar al recibir el código 500000}
program ejercicio7;
const
  valor_alto= 32420;
  fin = 500000;
type
 cadenita = string[15];
 cadena = string[50];
  ave = record
    cod:integer;
    nom:cadena;
    fam:cadena;
    desc:cadena;
    zon:cadena;
    end;
   archivo = file of ave;
procedure leer(var a:archivo;var av:ave);
begin
if(not EOF(a))then
   read(a,av)
 else
   av.cod:=valor_alto;
end;
procedure leer_ave(var a:ave);
begin
 writeln('Ingrese el codigo de ave');
 readln(a.cod);
 if(a.cod  <> 5000)then
   begin
	writeln('Ingrese el nombre ');
	readln(a.nom);
   end;
end;
procedure cargar_binario(var t:text;var a:archivo);
var
  av:ave;
begin
  reset(t);
  rewrite(a);
  while(not EOF(t))do
    begin
      readln(t,av.cod,av.nom);
      readln(t,av.fam);
      readln(t,av.desc);
      readln(t,av.zon);
      write(a,av);    
    end;
 close(t);
 close(a);
end;
procedure eliminar_logico(var a:archivo);
var
  av:ave;
  aux:ave;
begin
  reset(a);
  leer(a,av);
  leer_ave(aux);
  while(aux.cod <> 5000)do
    begin
    while((av.cod <> valor_alto)and(av.nom  <> aux.nom))do
      leer(a,av);
     if((av.cod <> valor_alto)and(av.nom = aux.nom))then
        begin
          av.cod := av.cod * -1;
          seek(a,filepos(a)-1);
          write(a,av);
         end;
      leer_ave(aux);
      seek(a,0);
    end;
 close(a);
end;
procedure eliminar_completo(var a:archivo);
var
  av:ave;
  cant:integer;
  pos:integer;
begin
cant:=0;
reset(a);
leer(a,av);
  while(av.cod <> valor_alto )do
    begin
     while((av.cod <> valor_alto )and(av.cod > 0 ))do
       leer(a,av);
      if(av.cod <> valor_alto)then
       begin
        cant:=cant+1;
        pos:=filepos(a)-1;
        seek(a,filesize(a)-cant);
        leer(a,av);
        seek(a,pos);
        write(a,av);
       end;
    end;
   cant:=cant-1;
   seek(a,filesize(a)-cant);
   truncate(a);
close(a);
end;
procedure imprimir(var a:archivo);
var
  av:ave;
begin
 reset(a);
 leer(a,av);
 while(av.cod <> valor_alto)do
   begin
    writeln('-------------------------------------------------------------');
    writeln('El codigo del ave es ',av.cod,' su nombre es ',av.nom,' y su descripcion es ',av.desc);
    writeln('Es de familia ',av.fam,' de la zona ',av.zon);
    writeln('-------------------------------------------------------------');
    leer(a,av);
   end;
 close(a);
end;
var
  t:text;
  a:archivo;
  cad:cadenita;
begin
writeln('Ingrese el nombre del arch de texto');
readln(cad);
assign(t,cad);
writeln('Ingrese el nombre del arch binario');
readln(cad);
assign(a,cad);
cargar_binario(t,a);
imprimir(a);
eliminar_logico(a);
//imprimir(a);
eliminar_completo(a);
imprimir(a);
end.
