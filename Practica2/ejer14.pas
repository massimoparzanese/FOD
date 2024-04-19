{Se desea modelar la información de una ONG dedicada a la asistencia de personas con
carencias habitacionales. La ONG cuenta con un archivo maestro conteniendo información
como se indica a continuación: Código pcia, nombre provincia, código de localidad, nombre
de localidad, #viviendas sin luz, #viviendas sin gas, #viviendas de chapa, #viviendas sin
agua, # viviendas sin sanitarios.
Mensualmente reciben detalles de las diferentes provincias indicando avances en las obras
de ayuda en la edificación y equipamientos de viviendas en cada provincia. La información
de los detalles es la siguiente: Código pcia, código localidad, #viviendas con luz, #viviendas
construidas, #viviendas con agua, #viviendas con gas, #entrega sanitarios.
Se debe realizar el procedimiento que permita actualizar el maestro con los detalles
recibidos, se reciben 10 detalles. Todos los archivos están ordenados por código de
provincia y código de localidad.
Para la actualización del archivo maestro, se debe proceder de la siguiente manera:
● Al valor de viviendas sin luz se le resta el valor recibido en el detalle.
● Idem para viviendas sin agua, sin gas y sin sanitarios.
● A las viviendas de chapa se le resta el valor recibido de viviendas construidas
La misma combinación de provincia y localidad aparecen a lo sumo una única vez.
Realice las declaraciones necesarias, el programa principal y los procedimientos que
requiera para la actualización solicitada e informe cantidad de localidades sin viviendas de
chapa (las localidades pueden o no haber sido actualizadas).}
program ejer14;
const
 valor_alto= 32420;
 dimf = 10;
type
 cadena = string[20];
  provincia = record
    cod:integer;
    nom:cadena;
    codloc:integer;
    nomloc:cadena;
    luz:integer;
    gas:integer;
    chapa:integer;
    agua:integer;
    san:integer;
    end;
  provi = record
    cod:integer;
    codloc:integer;
    luz:integer;
    cons:integer;
    agua:integer;
    gas:integer;
    ent_san:integer;
    end;
  archivo_maestro = file of provincia;
  archivo_detalle = file of provi;
  detalles = array [1..dimf]of archivo_detalle;
  reg_detalles = array [1..dimf]of provi;
procedure leer(var det:archivo_detalle;var regd:provi);
begin
  if(not EOF(det))then
    read(det,regd)
  else
    regd.cod:=valor_alto;
end;
procedure minimo(var vec_deta:detalles;var v_regd:reg_detalles;var min:provi);
var
  i:integer;
  pos:integer;
begin
 min:=v_regd[1];
 pos:=1;
 for i:= 2 to dimf do
   begin
    if(min.cod > v_regd[i].cod)or ((min.cod = v_regd[i].cod)and(min.codloc > v_regd[i].codloc))then
          begin
            pos:=i;
            min:=v_regd[i];
          end;
   end;
 leer(vec_deta[pos],v_regd[pos]);
end;
procedure act_maestro(var mae:archivo_maestro;var deta:detalles);
var
  v_regd:reg_detalles;
  i:integer;
  regm:provincia;
  min:provi;
  codp:integer;
  codl:integer;
  luz:integer;
  gas:integer;
  agua:integer;
  san:integer;
  cons:integer;
begin
reset(mae);
read(mae,regm);
for i:= 1 to dimf do
 begin
   reset(deta[i]);
   read(deta[i],v_regd[i]);
 end;
 minimo(deta,v_regd,min);
while(min.cod <> valor_alto)do
   begin
     codp:=min.cod;
     while(min.cod = codp)do
       begin
        codl:=min.codloc;
        luz:=0;
        gas:=0;
        agua:=0;
        san:=0;
        cons:=0;
        while(min.cod = codp)and(min.codloc = codl)do
          begin
            luz:= luz + min.luz;
            gas:= gas + min.gas;
            agua:= agua + min.agua;
            san:= san + min.ent_san;
            cons:= cons + min.cons;
            minimo(deta,v_regd,min);
          end;
         while(regm.cod <> codp)do
           read(mae,regm);
         while(regm.cod = codp)and(regm.codloc <> codl)do
           read(mae,regm);
        regm.luz:= regm.luz - luz;
        regm.gas:= regm.gas - gas;
        regm.agua:= regm.agua - agua;
        regm.san:= regm.san - san;
        regm.chapa:= regm.chapa - cons;
        seek(mae,filepos(mae)-1);
        write(mae,regm);
       end;
  end;
for i:= 1 to dimf do
   close(deta[i]);
close(mae);
end;    
begin
end.
