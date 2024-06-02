Program ejercicio4;
const
  valor_alto= 'ZZZZ';
type
  cadena = string[20];
  empleado = record
    num:string[5];
    nom:cadena;
    ape:cadena;
    edad:integer;
    Dni:integer;
    end;
  archivo = file of empleado;
procedure leer(var a:archivo; var e:empleado);
begin
  if(not EOF(a))then
     read(a,e)
  else e.num:=valor_alto;
end;
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
 aux:empleado;
 ok:boolean;
begin
 reset(a);
 writeln('Se ingresaran empleados, ingrese el apellido fin para terminar');
 leer_e(e);
 while(e.ape <> 'fin')do
   begin
     ok:= true;
     leer(a,aux);
     while(aux.num <> valor_alto)and(ok)do
       begin
         if(aux.num = e.num)then
             ok:=false;
         leer(a,aux);
        end;
     if(not ok)then
       begin
         seek(a,filesize(a));
         write(a,e);
       end;
     leer_e(e);
     seek(a,0);
   end;
 close(a);
end;
procedure modulo_d(var a:archivo);
var 
 e:empleado;
 num:string[5];
 edad:integer;
begin
  reset(a);
  writeln('Ingrese el numero de empleado a buscar');
  readln(num);
  writeln('Ingrese la nueva edad');
  readln(edad);
  leer(a,e);
  while(e.num <> valor_alto) and(e.num <> num) do
    begin
      leer(a,e);
    end;
  if(e.num <> valor_alto)then
    begin
      e.edad:=edad;
      seek(a,filepos(a)-1);
      write(a,e);
      writeln('La edad del empleado se ha modificado con exito');
    end
    else writeln('El empleado a buscar no existe');
  close(a);
end;
procedure modulo_e(var a:archivo;var t:text);
var
  e:empleado;
begin
  reset(a);
  rewrite(t);
  leer(a,e);
  while(e.num <> valor_alto)do
	begin
	  writeln(t,e.edad,'  ',e.Dni,'  ',e.nom);
	  writeln(t,e.ape);
	  writeln(t,e.num);
	  leer(a,e);
	end;
  close(a);
  close(t);
end;
procedure modulo_f(var a:archivo;var t:text);
var
  e:empleado;
begin
  reset(a);
  rewrite(t);
  leer(a,e);
  while(e.num <> valor_alto)do
	begin
	  if(e.num = '00')then
	    begin
	      writeln(t,e.edad,'  ',e.Dni,'  ',e.nom);
	      writeln(t,e.ape);
	      writeln(t,e.num);
	    end;
	   leer(a,e);
	end;
  close(a);
  close(t);
end;
var
 arch_emp:archivo;
 num:integer;
 opcion:integer;
 t:text;
 t2:text;
begin
repeat
write('elija la opcion a ejecutar: 1, 2, 3, 4, 5 o 6 para ejecutar y 0 para terminar');
read(opcion);
case (opcion) of
    0:writeln('El programa termino');
    1:crear_archivo(arch_emp);
    2: begin
           writeln('elija la opcion a ejecutar: 1, 2 o 3');
           readln(num);
		   case (num) of
               1:modulo_b_a(arch_emp);
               2:modulo_b_b(arch_emp);
               3:modulo_b_c(arch_emp);
           end;
        end;
    3:modulo_c(arch_emp);
    4:modulo_d(arch_emp);
    5:modulo_e(arch_emp,t);
    6:modulo_f(arch_emp,t2);
end;

until(opcion = 0);   
end.
