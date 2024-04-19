{Definir un programa que genere un archivo con registros de longitud fija conteniendo
información de asistentes a un congreso a partir de la información obtenida por
teclado. Se deberá almacenar la siguiente información: nro de asistente, apellido y
nombre, email, teléfono y D.N.I. Implementar un procedimiento que, a partir del
archivo de datos generado, elimine de forma lógica todos los asistentes con nro de
asistente inferior a 1000.
Para ello se podrá utilizar algún carácter especial situándolo delante de algún campo
String a su elección. Ejemplo: ‘@Saldaño’.}
program ejer2;
const
 valor_alto = 32420;
 car_esp = '$';
type
  cadena = string[40];
  asistente = record
    nro:integer;
    apeynom:cadena;
    email:cadena;
    tel:integer;
    dni:integer;
    end;
  archivo = file of asistente;
procedure leer(var a:archivo;var asis:asistente);
begin
  if(not EOF(a))then
     read(a,asis)
  else
    asis.nro:=valor_alto;    
end;
procedure cargar_binario(var t:text;var a:archivo);
var
  asist:asistente;
begin
  reset(t);
  rewrite(a);
  while(not EOF(t))do
    begin
      readln(t,asist.nro, asist.tel, asist.dni);
      readln(t,asist.apeynom);
      readln(t,asist.email);
      write(a,asist);    
    end;
 close(t);
 close(a);
end;
procedure imprimir_archivo(var a:archivo);
var
  asist:asistente;
begin
 reset(a);
 leer(a,asist);
 while(asist.nro <> valor_alto)do
   begin
    writeln('El empleado con numero ',asist.nro,' se llama ',asist.apeynom,' con dni ',asist.dni,' numero de telefono ',asist.tel,' e email ',asist.email);
    leer(a,asist);
   end;
 close(a);
end;
procedure eliminacion_logica(var a:archivo);
var
 asist:asistente;
 cod:integer;
begin
  writeln('Ingrese el numero de asistente a eliminar');
  readln(cod);
  reset(a);
  leer(a,asist);
  while(asist.nro <> valor_alto)and(asist.nro <> cod)do
    leer(a,asist);
  if(asist.nro = cod)then
    begin
     asist.apeynom:=Concat(car_esp,asist.apeynom);
     seek(a,filepos(a)-1);
     write(a,asist);
    end;
end;
var
  t:text;
  a:archivo;
  cad:cadena;
begin
 writeln('Ingrese el nombre del arch de texto');
 readln(cad);
 assign(t,cad);
 writeln('Ingrese el nombre del arch binario');
 readln(cad);
 assign(a,cad);
 cargar_binario(t,a);
 eliminacion_logica(a);
 imprimir_archivo(a);
end.
