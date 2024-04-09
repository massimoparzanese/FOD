{La empresa de software ‘X’ posee un servidor web donde se encuentra alojado el sitio web
de la organización. En dicho servidor, se almacenan en un archivo todos los accesos que se
realizan al sitio. La información que se almacena en el archivo es la siguiente: año, mes, día,
idUsuario y tiempo de acceso al sitio de la organización. El archivo se encuentra ordenado
por los siguientes criterios: año, mes, día e idUsuario.
Se debe realizar un procedimiento que genere un informe en pantalla, para ello se indicará
el año calendario sobre el cual debe realizar el informe. El mismo debe respetar el formato
mostrado a continuación:
Año : ---
Mes:-- 1
día:-- 1
idUsuario 1 Tiempo Total de acceso en el dia 1 mes 1
--------
idusuario N Tiempo total de acceso en el dia 1 mes 1
Tiempo total acceso dia 1 mes 1
-------------
día N
idUsuario 1 Tiempo Total de acceso en el dia N mes 1
--------
idusuario N Tiempo total de acceso en el dia N mes 1
Tiempo total acceso dia N mes 1
Total tiempo de acceso mes 1
------
Mes 12
día 1
idUsuario 1 Tiempo Total de acceso en el dia 1 mes 12
--------
idusuario N Tiempo total de acceso en el dia 1 mes 12
Tiempo total acceso dia 1 mes 12
-------------
día N
idUsuario 1 Tiempo Total de acceso en el dia N mes 12
--------
idusuario N Tiempo total de acceso en el dia N mes 12
Tiempo total acceso dia N mes 12
Total tiempo de acceso mes 12
Total tiempo de acceso año
Se deberá tener en cuenta las siguientes aclaraciones:
● El año sobre el cual realizará el informe de accesos debe leerse desde el teclado.
● El año puede no existir en el archivo, en tal caso, debe informarse en pantalla “año
no encontrado”.
● Debe definir las estructuras de datos necesarias.
● El recorrido del archivo debe realizarse una única vez procesando sólo la información
necesaria.}
program ejer11;
const 
  valor_alto = 'ZZZZ';
type
 cadenita = string[4];
 fecha = record
    dia:1..31;
    mes:1..12;
    anio:integer;
   end;
 usuario = record
    id:cadenita;
    fec:fecha;
    tiemp:integer;
   end;
  archivo = file of usuario;
procedure leer(var a:archivo;var u:usuario);
begin
 if(not EOF(a))then
   read(a,u)
 else
   u.id:=valor_alto;
end;
procedure Informar(var a:archivo);
var
 tiempo:integer;
 totalanio:integer;
 totalmes:integer;
 usu:usuario;
 mes:1..12;
 dia:1..31;
 anio:integer;
begin
 reset(a);
 leer(a,usu);
 writeln('Ingrese el anio a procesar');
 readln(anio);
 while(usu.id <> valor_alto)do
   begin
     while (usu.id <> valor_alto)and (anio <> usu.fec.anio)do
        leer(a,usu);
     if(anio = usu.fec.anio)then
       begin
         writeln('Anio :',anio);
         totalanio:=0;
         while(anio = usu.fec.anio)do
			begin
			   totalmes:=0;
			   mes:=usu.fec.mes;
			   writeln('Mes: ',mes);
			   while(anio = usu.fec.anio)and(mes = usu.fec.mes)do
				begin
					dia:= usu.fec.anio;
					writeln('Dia: ',dia);
					tiempo:=0;
					while(anio = usu.fec.anio)and(mes = usu.fec.mes)and(dia = usu.fec.dia)do
					  begin
						writeln(usu.id,' Tiempo Total de acceso en el dia ',usu.fec.dia,' y mes ',usu.fec.mes);
                        tiempo:=tiempo + usu.tiemp;
                        leer(a,usu);
					 end;
					writeln('Tiempo total de acceso del dia ',dia,' es ',tiempo);
					totalmes:= totalmes + tiempo;
				end;
			  writeln('El tiempo total de acceso del mes ',mes,' es ',totalmes);
			  totalanio:=totalanio + totalmes;
			end;
		  writeln('El total de tiempos de acceso en todo el anio ', anio, ' es ',totalanio);
	   end
	   else writeln('año no encontrado');
   end;
end;
	      
begin
end.
