{Una compañía aérea dispone de un archivo maestro donde guarda información sobre sus
próximos vuelos. En dicho archivo se tiene almacenado el destino, fecha, hora de salida y la
cantidad de asientos disponibles. La empresa recibe todos los días dos archivos detalles
para actualizar el archivo maestro. En dichos archivos se tiene destino, fecha, hora de salida
y cantidad de asientos comprados. Se sabe que los archivos están ordenados por destino
más fecha y hora de salida, y que en los detalles pueden venir 0, 1 ó más registros por cada
uno del maestro. Se pide realizar los módulos necesarios para:
a. Actualizar el archivo maestro sabiendo que no se registró ninguna venta de pasaje
sin asiento disponible.
b. Generar una lista con aquellos vuelos (destino y fecha y hora de salida) que
tengan menos de una cantidad específica de asientos disponibles. La misma debe
ser ingresada por teclado.
NOTA: El archivo maestro y los archivos detalles sólo pueden recorrerse una vez.}
program ejer13;
const
 valor_alto = 'ZZZZZZZZ';
type
 cadena = string[15];
  fecha = record
    dia:1..31;
    mes:1..12;
    anio:integer;
    end;
  vuelo = record
    destino:cadena;
    fec:fecha;
    hora:cadena;
    asient:integer;
    end;
  archivo_maestro = file of vuelo;
  archivo_detalle = file of vuelo;
  lista = ^nodo;
  nodo = record
    dato:vuelo;
    sig:lista;
    end;
procedure leer(var deta:archivo_detalle;var vue:vuelo);
begin
 if(not EOF(deta))then
   read(deta,vue)
 else
   vue.destino:=valor_alto;
end;
procedure minimo(var deta1:archivo_detalle;var deta2:archivo_detalle;var r1,r2:vuelo;var min:vuelo);
begin
 if(r1.destino < r2.destino )then
   begin
    min:=r1;
    leer(deta1,r1);
   end
 else begin
       min:=r2;
       leer(deta2,r2);
      end;
end;
procedure agregarad(var l:lista;v:vuelo);
var
 nuevo:lista;
begin
 new(nuevo);
 nuevo^.dato:=v;
 nuevo^.sig:=l;
 l:=nuevo;
end;
procedure recorrer(var mae:archivo_maestro;var deta1:archivo_detalle;var deta2:archivo_detalle;var l:lista);
var
  r1:vuelo;
  r2:vuelo;
  regm:vuelo;
  min:vuelo;
  fec:fecha;
  dest:cadena;
  hora:cadena;
  cant:integer;
  cant_asien:integer;
begin
 reset(mae);
 reset(deta1);
 reset(deta2);
 leer(deta1,r1);
 leer(deta2,r2);
 minimo(deta1,deta2,r1,r2,min);
 read(mae,regm);
 writeln('Ingrese la cantidad de asientos para listar los vuelos con menos cantidad');
 readln(cant_asien);
 while(min.destino <> valor_alto)do
   begin
     dest:=min.destino;
     while(min.destino = dest)do
      begin
        fec:=min.fec;
         while(min.destino = dest)and(min.fec.dia = fec.dia)and(min.fec.mes = fec.mes)and(min.fec.anio = fec.anio)do
          begin
            hora:=min.hora;
            cant:=0;
            while(min.destino = dest)and(min.fec.dia = fec.dia)and(min.fec.mes = fec.mes)and(min.fec.anio = fec.anio)and(min.hora = hora)do
				begin
				 cant:=cant+ min.asient;
	             minimo(deta1,deta2,r1,r2,min);
	            end;
	        while(regm.destino <> dest)or(regm.fec.dia <> fec.dia)or(regm.fec.mes <> fec.mes)or(regm.fec.anio <> fec.anio)or(regm.hora <> hora)do
	          begin
	            read(mae,regm);
	          end;
	        regm.asient := regm.asient - cant;
	        if(regm.asient < cant_asien)then
	          agregarad(l,regm);
	        seek(mae,filepos(mae)-1);
	        write(mae,regm);
          end;
      end;   
   end;
 close(mae);
 close(deta1);
 close(deta2);
end;
var
 mae:archivo_maestro;
 det1:archivo_detalle;
 det2:archivo_detalle;
 cad:cadena;
 l:lista;
begin
l:=nil;
writeln('Ingrese el nombre del archivo maestro');
readln(cad);
assign(mae,cad);
writeln('Ingrese el nombre del archivo detalle 1');
readln(cad);
assign(det1,cad);
writeln('Ingrese el nombre del archivo detalle 2');
readln(cad);
assign(det2,cad);
recorrer(mae,det1,det2,l);
end.
