program ejercicio1;
const
  valor_alto = 32420;
type
  cadena = string[30];
  empleado = record
     cod:integer;
     nom:cadena;
     monto:real;
     end;
     archivo = file of empleado;
procedure leer(var a:archivo;var e:empleado); // lo utilizo para no ir verificando el EOF
begin
  if(not EOF(a))then
    begin
      read(a,e);
    end
    else e.cod:=valor_alto;
end;
procedure crear_binario(var a:archivo;var t:text);
var
  e:empleado;
begin
 Reset(t);
 Rewrite(a);
 while(not EOF(t))do
   begin
     readln(t,e.cod);
     readln(t,e.monto);
	 readln(t,e.nom);
	 writeln(e.nom);
	 write(a,e);
   end;
  writeln('sali del while');
  close(a);
  close(t);
end;
procedure nuevo_binario(var a:archivo;var new_a:archivo);
var
  e:empleado;
  aux: empleado;
begin
 reset(a);
 rewrite(new_a);
 leer(a,e);
 while(e.cod  <> valor_alto)do
   begin
     aux.cod:=e.cod;
     aux.nom:=e.nom;
     aux.monto:=0;
     while(e.cod = aux.cod)do // mientras el empleado sea el mismo cuento
       begin
         aux.monto:=aux.monto + e.monto;
         leer(a,e);
       end;
     write(new_a,aux); // escribo aux porque tiene el empleado que necesito escribir
   end;
 close(a);
 close(new_a);
end;
procedure informar_archivo(var a:archivo);
var
  e:empleado;
begin
 reset(a);
 leer(a,e);
 while(e.cod <> valor_alto)do
  begin
    writeln('Su nombre es :', e.nom,' con codigo de empleado ',e.cod,' y su total por comisiones es: ',e.monto:0:2);
    leer(a,e);
  end;
  close(a);
end;
var
 t:text;
 a:archivo;
 new_a:archivo;
 cad:string[14];
begin
 writeln('Ingrese el nombre del arch de texto');
 readln(cad);
 assign(t,cad);
 writeln('Ingrese el nombre del arch binario');
 readln(cad);
 assign(a,cad);
 crear_binario(a,t);
 writeln('Ingrese el nombre del nuevo arch binario compactado ');
 readln(cad);
 assign(new_a,cad);
 nuevo_binario(a,new_a);
 informar_archivo(new_a);
end.
