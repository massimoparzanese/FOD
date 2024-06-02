program ejercicio4;
const
  valor_alto = 'ZZZZ';
type
  cadena = string[20];
  provincia = record
    nom:cadena;
    alf:integer;
    cant:integer;
    end;
  detalle = file of provincia;
  maestro = file of provincia;
procedure leer(var det:detalle; var p:provincia);
begin
 if(not EOF(det))then
   read(det,p)
 else p.nom:= valor_alto;
end;
procedure minimo(var det1,det2:detalle;var reg1,reg2:provincia;var min:provincia);
begin
  if(reg1.nom <= reg2.nom)then
    begin
      min:=reg1;
      leer(det1,reg1);
    end
    else begin
           min:=reg2;
           leer(det2,reg2);
         end;
end;
procedure cargar_detalle(var det:detalle;var t:text);
var
  p:provincia;
begin
 reset(t);
 rewrite(det);
 while(not EOF(t))do
   begin
     readln(t,p.alf,p.cant,p.nom);
     write(det,p);
   end;
 close(t);
 close(det);
end;
procedure cargar_maestro(var mae:maestro;var t:text);
var
 p:provincia;
begin
 reset(t);
 rewrite(mae);
 while(not EOF(t))do
  begin
    readln(t,p.cant,p.alf,p.nom);
    write(mae,p);
  end;
 close(mae);
 close(t);
end;
procedure actualizar_maestro(var det1,det2:detalle;var mae:maestro);
var
  min:provincia;
  regdet1,regdet2:provincia;
  regm:provincia;
begin
  reset(det1);
  reset(det2);
  reset(mae);
  leer(det1,regdet1);
  leer(det2,regdet2);
  read(mae,regm);
  minimo(det1,det2,regdet1,regdet2,min);
  while(min.nom <> valor_alto)do
    begin
      while(regm.nom <> min.nom)do
       read(mae,regm);
     while(regm.nom = min.nom)do
       begin
         regm.alf:= regm.alf + min.alf;
         regm.cant:= regm.cant + min.cant;
         minimo(det1,det2,regdet1,regdet2,min);
       end;
      seek(mae,filepos(mae)-1);
      write(mae,regm);
    end;
  close(det1);
  close(det2);
  close(mae);
end;
procedure imprimir_maestro(var mae:maestro);
var
  p:provincia;
begin
  reset(mae);
  while(not EOF(mae))do
    begin
      read(mae,p);
      writeln('-----------------------------------------------');
      writeln('La provincia de ',p.nom);
      writeln('Tiene esta cantidad de alfabetizados ',p.alf);
      writeln('Los encuestados fueron: ',p.cant);
    end;
end;
var
  mae:maestro;
  det1,det2:detalle;
  t:text;
  cad:cadena;
begin
writeln('------------------------------------------------');
writeln('Ingrese el nombre del archivo de texto para el maestro');
readln(cad);
assign(t,cad);
writeln('Ingrese el nombre del archivo maestro');
readln(cad);
assign(mae,cad);
cargar_maestro(mae,t);
writeln('------------------------------------------------');
writeln('Ingrese el nombre del archivo de texto para el detalle 1');
readln(cad);
assign(t,cad);
writeln('Ingrese el nombre del archivo detalle 1');
readln(cad);
assign(det1,cad);
cargar_detalle(det1,t);
writeln('------------------------------------------------');
writeln('Ingrese el nombre del archivo de texto para el detalle 2');
readln(cad);
assign(t,cad);
writeln('Ingrese el nombre del archivo detalle 2');
readln(cad);
assign(det2,cad);
cargar_detalle(det2,t);
imprimir_maestro(mae);
actualizar_maestro(det1,det2,mae);
imprimir_maestro(mae);
end.
