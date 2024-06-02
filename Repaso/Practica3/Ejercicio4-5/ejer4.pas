{
* 4. Dada la siguiente estructura:
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
considere necesario para obtener el listado.
5. Dada la estructura planteada en el ejercicio anterior, implemente el siguiente módulo:
Abre el archivo y elimina la flor recibida como parámetro manteniendo
la política descripta anteriormente}
program ejercicio4;
const
  valor_alto = 32420;
type
	reg_flor = record
	nombre: String[45];
	codigo:integer;
	end;
	tArchFlores = file of reg_flor;
procedure leer(var a:tArchFlores; var r:reg_flor);
begin
  if(not EOF(a))then
    read(a,r)
  else
    r.codigo:=valor_alto
end;
procedure cargar_arch(var a: tArchFlores;var t:text);
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
  close(a);
  close(t);
end;
procedure agregarFlor (var a: tArchFlores ; nombre: string;
codigo:integer);
var
  flor:reg_flor;
  pos:integer;
  aux:reg_flor;
begin
 reset(a);
 leer(a,flor);
 aux.nombre:=nombre;
 aux.codigo:=codigo;
 if(flor.codigo < 0)then
   begin
     seek(a,flor.codigo*-1);
     pos:=filepos(a);
     read(a,flor);
     seek(a,pos);
     write(a,aux);
     seek(a,0);
     write(a,flor);
   end
   else begin
     seek(a,filesize(a));
     write(a,aux);
   end;
 close(a);
end;
procedure listado(var a: tArchFlores);
var
  flor:reg_flor;
begin
  reset(a);
  leer(a,flor);
  while(not EOF(a))do
   begin
     if(flor.codigo > 0)then
       begin
       writeln('--------------------------------------------------');
       writeln('La flor es ',flor.nombre,' y su codigo es :',flor.codigo);
       end;
     leer(a,flor);
   end;
  close(a);
end;
procedure imprimir_todo(var a: tArchFlores);
var
  flor:reg_flor;
begin
  reset(a);
  leer(a,flor);
  while(not EOF(a))do
   begin
    writeln('--------------------------------------------------');
    writeln('La flor es ',flor.nombre,' y su codigo es :',flor.codigo);
    leer(a,flor);
   end;
  close(a);
end;
procedure eliminarFlor (var a: tArchFlores; flor:reg_flor);
var
  f:reg_flor;
  pos:integer;
begin
  reset(a);
  leer(a,f);
  while((f.codigo <> valor_alto)and(f.codigo <> flor.codigo))do
    begin
      leer(a,f);
    end;
  if(f.codigo = flor.codigo)then
    begin
      pos:=filepos(a)-1;
      seek(a,0);
      read(a,f);
      seek(a,0);
      flor.codigo:=pos*-1;
      write(a,flor);
      seek(a,pos);
      write(a,f);
    end
    else writeln('La flor a buscar no existe');
  close(a);
end;
var
  a:tArchFlores;
  f:reg_flor;
  t:text;
  cad:String[17];
begin
 writeln('Ingrese el nombre del archivo binario');
 readln(cad);
 assign(a,cad);
 writeln('Ingrese el nombre del archivo de texto');
 readln(cad);
 assign(t,cad);
 cargar_arch(a,t);
 imprimir_todo(a);
 writeln('Ingrese el nombre de la flor a agregar');
 readln(f.nombre);
 writeln('Ingrese el codigo de la flor a agregar');
 readln(f.codigo);
 agregarFlor(a,f.nombre,f.codigo);
 imprimir_todo(a);
 writeln('Ingrese el codigo de la flor a Eliminar');
 readln(f.codigo);
 writeln('Ingrese el nombre de la flor a Eliminar');
 readln(f.nombre);
 eliminarFlor(a,f);
 imprimir_todo(a);
 listado(a);
end.
