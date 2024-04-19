{Modificar el ejercicio 4 de la práctica 1 (programa de gestión de empleados),
agregándole una opción para realizar bajas copiando el último registro del archivo en
la posición del registro a borrar y luego truncando el archivo en la posición del último
registro de forma tal de evitar duplicados.}
program ejer1;
const
  valor_alto = 32420;
type
 cadena = string[20];
  empleado = record
    num:integer;
    nom:cadena;
    ape:cadena;
    edad:integer;
    Dni:integer;
   end;
  archivo = file of empleado;
procedure leer_e(Var e:empleado);
begin
  writeln('Ingrese el apellido del empleado');
  readln(e.ape);
  if(e.ape <> 'fin')then
   begin
	writeln('Ingrese el nombre del empleado');
	readln(e.nom);
	writeln('Ingrese el numero de empleado');
	readln(e.num);
	writeln('Ingrese el dni del empleado');
	readln(e.Dni);
	writeln('Ingrese la edad del empleado');
	readln(e.edad);
   end;
end;
function cumple(num:integer):boolean;
begin
  cumple:=(num > 70);
end;
function cumple2(nom:cadena;nom2:cadena):boolean;
begin
 cumple2:=(nom = nom2);
end;
procedure imprimir_emp(e:empleado);
begin
  writeln(' Su nombre es ', e.nom,' ', e.ape,' su edad es ', e.edad,' con numero de empleado ', e.num,' y dni ', e.Dni);
end;
procedure crear_archivo(Var a:archivo);
var
 cad:cadena;
 e:empleado;
begin
 writeln('Ingrese el nombre del archivo');
 readln(cad);
 readln(cad);
 assign(a,cad);
 rewrite(a);
 leer_e(e);
 while(e.ape <> 'fin') do
    begin
      write(a,e);
      leer_e(e);
    end;
 close(a);
end;
procedure modulo_b_a(Var a:archivo);
var
  cad:cadena;
  e:empleado;
begin
 writeln('Ingrese el nombre del archivo a abrir');
 readln(cad);
 Assign(a,cad);
 reset(a);
 writeln('ingrese el apellido/nombre a buscar ');
 readln(cad);
 while(not EOF(a))do
    begin
      read(a,e);
      if(cumple2(e.nom,cad) or (cumple2(e.ape,cad)))then
        imprimir_emp(e);
    end;
 close(a);
end;
procedure modulo_b_b(var a:archivo);
var
 e:empleado;
 cad:cadena;
begin
 writeln('Ingrese el nombre del archivo a abrir');
 readln(cad);
 Assign(a,cad);
 reset(a);
  while(not EOF(a))do
    begin
      read(a,e);
      imprimir_emp(e);
   end;
  close(a);
end;
procedure modulo_b_c(var a:archivo);
var
  e:empleado;
  cad:cadena;
  
begin
 writeln('Ingrese el nombre del archivo a abrir');
 readln(cad);
 Assign(a,cad);
 reset(a);
 writeln('Los empleados proximos a jubilarse son :');
 while(not EOF(a))do
   begin
    read(a,e);
    if(cumple(e.edad))then
      imprimir_emp(e);
   end;
  close(a); 
end;
procedure modulo_c(var a:archivo);
var
 e:empleado;
 ok:boolean;
 e2:empleado;
 cad:cadena;
begin
  leer_e(e);
  ok:= false;
  writeln('Ingrese el nombre del archivo');
  readln(cad);
  assign(a,cad);
  reset(a);
  while(not EOF(a)) and (ok = false)do
    begin
      read(a,e2);
      if(e.num = e2.num)then
        ok:=true;
    end;
  if(ok = false)then
    write(a,e);
  close(a);
end;
procedure modulo_d(var a:archivo);
var
 num:integer;
 edad:integer;
 e:empleado;
 cad:cadena;
begin
  read(num);
  read(edad);
  writeln('Ingrese el nombre del archivo');
  readln(cad);
  assign(a,cad);
  reset(a);
  read(a,e);
  while(e.num <> num)do
    begin
     read(a,e);
    end;
  seek(a,Filepos(a)-1);
  e.edad:=edad;
  close(a);
end;
procedure modulo_e(var a:archivo;var t:text);
var
  e:empleado;
  cad:cadena;
begin
  writeln('Ingrese el nombre del archivo');
  readln(cad);
  assign(a,cad);
  reset(a);
  writeln('Ingrese el nombre del archivo');
  readln(cad);
  assign(t,cad);
  rewrite(t);
  while(not EOF(a))do
    begin
      read(a,e);
      writeln(t,e.num,'   ',e.edad,'   ',e.Dni,'   ',e.nom);
      writeln(t,e.ape);
    end;
  close(a);
end;
procedure modulo_f(var a:archivo;var t:text);
var
  e:empleado;
  cad:cadena;
begin
  writeln('Ingrese el nombre del archivo');
  readln(cad);
  assign(t,cad);
  rewrite(t);
  writeln('Ingrese el nombre del archivo');
  readln(cad);
  reset(a);
  while(not EOF(a))do
   begin
     read(a,e);
     if(e.dni = 00)then
      begin
       writeln(t,e.num,'   ',e.edad,'   ',e.Dni,'   ',e.nom);
       writeln(t,e.ape);
      end;
   end;
end;
procedure leer_emple(var a:archivo;var emp:empleado);
begin
  if(not EOF(a))then
     read(a,emp)
  else
    emp.num:=valor_alto;
end;
procedure bajas(var a:archivo);
var
 num:integer;
 emp:empleado;
 pos:integer;
 
begin
  writeln('Ingrese el numero del empleado a borrar');
  readln(num);
  reset(a);
  leer_emple(a,emp);
  while(emp.num <> valor_alto)and(emp.num <> num)do
    begin
      leer_emple(a,emp);
    end;
  if(emp.num = num)then
    begin
      pos:=filepos(a)-1;
      seek(a,filesize(a)-1);
      read(a,emp);
      seek(a,pos);
      write(a,emp);
      seek(a,filesize(a)-1);
      Truncate(a);
    end;
 close(a);
end;
var
 arch_emp:archivo;
 num:integer;
 opcion:integer;
 t:Text;
begin
repeat
write('elija la opcion a ejecutar: 1 o 2 para ejecutar y 0 para terminar');
read(opcion);
case (opcion) of
    0:writeln('El programa termino');
    1:crear_archivo(arch_emp);
     2: begin
           writeln('elija la opcion a ejecutar: 1,2,3,4,5,6,7 o 8');
           readln(num);
		   case (num) of
               1:modulo_b_a(arch_emp);
               2:modulo_b_b(arch_emp);
               3:modulo_b_c(arch_emp);
               4:modulo_c(arch_emp);
               5:modulo_d(arch_emp);
               6:modulo_e(arch_emp,t);
               7:modulo_f(arch_emp,t);
               8:bajas(arch_emp);
           end;
        end;
end;

until(opcion = 0); 
end.

