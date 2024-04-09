{Se tiene información en un archivo de las horas extras realizadas por los empleados de una
empresa en un mes. Para cada empleado se tiene la siguiente información: departamento,
división, número de empleado, categoría y cantidad de horas extras realizadas por el
empleado. Se sabe que el archivo se encuentra ordenado por departamento, luego por
división y, por último, por número de empleado. Presentar en pantalla un listado con el
siguiente formato:
Departamento
División
Número de Empleado Total de Hs. Importe a cobrar
...... .......... .........
...... .......... .........
Total de horas división: ____
Monto total por división: ____
División
.................
Total horas departamento: ____
Monto total departamento: ____
Para obtener el valor de la hora se debe cargar un arreglo desde un archivo de texto al
iniciar el programa con el valor de la hora extra para cada categoría. La categoría varía
de 1 a 15. En el archivo de texto debe haber una línea para cada categoría con el número
de categoría y el valor de la hora, pero el arreglo debe ser de valores de horas, con la
posición del valor coincidente con el número de categoría.}
program ejercicio10;
const
  valor_alto = 'ZZZZZZ';
  dimf = 15;
type
 cadenita = string[6];
 empleado = record
   depa:cadenita;
   divi:cadenita;
   num:integer;
   cat:integer;
   ext:integer;
  end;
 cobro = record
   divi:cadenita;
   pago:real;
   end;
 vector = array[1..dimf] of real;
 archivo = file of empleado;
procedure leer(var a:archivo;var e:empleado);
begin
 if(not EOF(a))then
   read(a,e)
 else
   e.depa:=valor_alto;
end;
function obtener_valor(v:vector;num:integer;pos:integer):real;
begin
  obtener_valor:=(v[pos]*num);
end;
procedure cargarvec(var v:vector;var t:text);
var 
  i:integer;
  c:cobro;
begin
 reset(t);
 for i:=1 to dimf do
  begin
    readln(t, c.divi,c.pago);
    v[i]:=c.pago;
  end;
close(t);
end;
procedure recorrer(var a:archivo;var t:text);
var
 v:vector;
 depa:cadenita;
 divi:cadenita;
 hordiv:integer;
 totdiv:real;
 hordep:integer;
 totdep:real;
 e:empleado;
 cobro:real;
begin
 reset(a);
 cargarvec(v,t);
 leer(a,e);
 while(e.depa <> valor_alto)do
   begin
     depa:=e.depa;
     totdep:=0;
     hordep:=0;
     while(depa = e.depa)do
       begin
        writeln(depa);
        totdiv:=0;
        hordiv:=0;
        divi:=e.divi;
        while(e.depa = depa)and(divi = e.divi)do
          begin
            writeln(divi);
            cobro:=obtener_valor(v,e.ext,e.cat);
            writeln(e.num,e.ext,' Total a cobrar: ',cobro);
            writeln('-----------------------------------------');
            totdiv:= totdiv+cobro;
            hordiv:=hordiv + e.ext;
            leer(a,e);
          end;
          totdep:= totdep+totdiv;
          hordep:=hordep + hordiv;
          writeln('Total de horas por division ',hordiv);
          writeln('Total de cobro por division ',totdiv);
          writeln('...... .......... .........');
       end;
     writeln('Total de horas por departamento: ',hordep);
     writeln('Total de cobro por departamento: ',totdep);
   end;
close(a);
end;
var
 t:text;
 a:archivo;
 cad:string[15];
begin
writeln('Ingrese el nombre del archivo a procesar');
readln(cad);
assign(a,cad);
writeln('Ingrese el nombre del archivo de texto');
readln(cad);
assign(t,cad);
recorrer(a,t);
end.
