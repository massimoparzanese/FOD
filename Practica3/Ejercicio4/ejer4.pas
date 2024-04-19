{Dada la siguiente estructura:
type
reg_flor = record
nombre: String[45];
codigo:integer;
end;
tArchFlores = file of reg_flor;
Las bajas se realizan apilando registros borrados y las altas reutilizando registros
borrados. El registro 0 se usa como cabecera de la pila de registros borrados: el
número 0 en el campo código implica que no hay registros borrados y -N indica que el
próximo registro a reutilizar es el N, siendo éste un número relativo de registro válido.
a. Implemente el siguiente módulo:
Abre el archivo y agrega una flor, recibida como parámetro
manteniendo la política descrita anteriormente
procedure agregarFlor (var a: tArchFlores ; nombre: string;
codigo:integer);
b. Liste el contenido del archivo omitiendo las flores eliminadas. Modifique lo que
considere necesario para obtener el listado.}
program ejer4;
const
  valor_alto = 32420;
type
  reg_flor = record
    nombre: String[45];
   codigo:integer;
   end;
tArchFlores = file of reg_flor;
procedure leer(var a:tArchFlores;var f:reg_flor);
begin
 if(not EOF(a))then
   read(a,f)
 else
   f.codigo:=valor_alto;
end;
procedure cargar_binario(var t:text;var a:tArchFlores);
var
  f:reg_flor;
begin
  reset(t);
  rewrite(a);
  while(not EOF(t))do
    begin
      readln(t,f.codigo,f.nombre);
      write(a,f);    
    end;
 close(t);
 close(a);
end;
procedure imprimir_archivo(var a:tArchFlores);
var
  f:reg_flor;
begin
 reset(a);
 leer(a,f);
 while(f.codigo <> valor_alto)do
   begin
   if(f.codigo > 0 )then
      writeln('El codigo de la flor es ',f.codigo,' y su nombre es ',f.nombre);
   leer(a,f);
   end;
 close(a);
end;
procedure imprimir_prueba(var a:tArchFlores);
var
  f:reg_flor;
begin
 reset(a);
 leer(a,f);
 while(f.codigo <> valor_alto)do
   begin
    writeln('El codigo de la flor es ',f.codigo,' y su nombre es ',f.nombre);
    leer(a,f);
   end;
 close(a);
end;
procedure agregarFlor (var a: tArchFlores ; nombre: string;codigo:integer);
var
  f:reg_flor;
  aux:reg_flor;
begin
 f.codigo:=codigo;
 f.nombre:=nombre;
 Reset(a);
 leer(a,aux);
 if(aux.codigo <> 0)and(aux.codigo <> valor_alto)then
   begin
     aux.codigo:=aux.codigo*-1;
     seek(a,(aux.codigo));
     read(a,aux);
     seek(a,filepos(a)-1);
     write(a,f);
     seek(a,0);
     if(aux.codigo > 0)then
       aux.codigo:= aux.codigo *-1;
     write(a,aux);
   end
   else begin
          seek(a,filesize(a)-1);
          write(a,f);        
        end;
 close(a);
end;
procedure modulo_eliminar(var a:tArchFlores);
var
 cod:integer;
 pos:integer;
 f:reg_flor;
 aux:reg_flor;
begin
 writeln('Ingrese el cod de la flor a eliminar:');
 readln(cod);
 reset(a);
 leer(a,aux);
 leer(a,f);
 while(f.codigo <> valor_alto)and(cod <> f.codigo)do
   leer(a,f);
 if(cod = f.codigo)then
   begin
     pos:=filepos(a)-1;
     seek(a,pos);
     write(a,aux);
     seek(a,0);
     f.codigo:= pos* -1;
     write(a,f);
   end
  else writeln('El codigo de flor que ingresó no se encuentra en el archivo');
close(a);
end;
var
  a:tArchFlores;
  t:text;
  cad:string[15];
  cod:integer;
begin
writeln('Ingrese el nombre del archivo binario');
readln(cad);
assign(a,cad);
writeln('Ingrese el nombre de la flor a agregar');
readln(cad);
writeln('Ingrese el codigo de flor a eliminar');
readln(cod);
writeln('------------------------------');
writeln('Impresion sin dicha flor agregada');
imprimir_prueba(a);
writeln('------------------------------');
agregarFlor(a,cad,cod);
writeln('------------------------------');
writeln('Impresion con dicha flor agregada');
imprimir_archivo(a);
writeln('------------------------------');
end.
