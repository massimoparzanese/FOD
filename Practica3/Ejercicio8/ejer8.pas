{Se cuenta con un archivo con información de las diferentes distribuciones de linux
existentes. De cada distribución se conoce: nombre, año de lanzamiento, número de
versión del kernel, cantidad de desarrolladores y descripción. El nombre de las
distribuciones no puede repetirse. Este archivo debe ser mantenido realizando bajas
lógicas y utilizando la técnica de reutilización de espacio libre llamada lista invertida.
Escriba la definición de las estructuras de datos necesarias y los siguientes
procedimientos:
a. ExisteDistribucion: módulo que recibe por parámetro un nombre y devuelve
verdadero si la distribución existe en el archivo o falso en caso contrario.
b. AltaDistribución: módulo que lee por teclado los datos de una nueva
distribución y la agrega al archivo reutilizando espacio disponible en caso
de que exista. (El control de unicidad lo debe realizar utilizando el módulo
anterior). En caso de que la distribución que se quiere agregar ya exista se
debe informar “ya existe la distribución”.
c. BajaDistribución: módulo que da de baja lógicamente una distribución 
cuyo nombre se lee por teclado. Para marcar una distribución como
borrada se debe utilizar el campo cantidad de desarrolladores para
mantener actualizada la lista invertida. Para verificar que la distribución a
borrar exista debe utilizar el módulo ExisteDistribucion. En caso de no existir
se debe informar “Distribución no existente”.}
program ejer8;
const
 valor_alto = 'ZZZZ';
type
 cadena = string[50];
  lin_ver = record
    nom:cadena;
    anio:integer;
    v_ker:cadena;
    cant:integer;
    desc:cadena;
    end;
    archivo = file of lin_ver;
procedure leer(var a:archivo;var lin:lin_ver);
begin
 if(not EOF(a))then
   read(a,lin)
 else
   lin.nom:=valor_alto;
end;
procedure leer_version(var l:lin_ver);
begin
writeln('Ingrese el nombre de la distribucion');
readln(l.nom);
writeln('Ingrese el anio de la distribucion');
readln(l.anio);
writeln('Ingrese la version de kernel');
readln(l.v_ker);
writeln('Ingrese la cantidad de desarrolladores');
readln(l.cant);
writeln('Ingrese la descripcion');
readln(l.desc);
end;
procedure cargar_binario(var t:text;var a:archivo);
var
  l:lin_ver;
begin
  reset(t);
  rewrite(a);
  while(not EOF(t))do
    begin
      readln(t,l.anio,l.nom);
      readln(t,l.cant,l.v_ker);
      readln(t,l.desc);
      write(a,l);    
    end;
 close(t);
 close(a);
end;
procedure ExisteDistribucion(var a:archivo; nom:cadena;var ok:boolean);
var
  l:lin_ver;
begin
 reset(a);
 leer(a,l);
 while((l.nom <> valor_alto)and(l.nom  <> nom))do
      leer(a,l);
 if((l.nom <> valor_alto)and(l.nom  <> nom))then
   ok:=true;
 close(a);
end;
procedure AltaDistribucion(var a:archivo);
var
  l:lin_ver;
  ok:boolean;
  aux:lin_ver;
begin
leer_version(l);
ok:= false;
ExisteDistribucion(a,l.nom,ok);
if(ok)then
  begin
    reset(a);
    read(a,aux);
    seek(a,(aux.cant*-1));
    read(a,aux);
    seek(a,filepos(a)-1); 
    write(a,l);
    seek(a,0);
    write(a,aux);
    close(a);
  end
 else writeln('ya existe la distribución');
end;

procedure Baja_distribucion(var a:archivo);
var
  l:lin_ver;
  nom:cadena;
  pos:integer;
  aux:lin_ver;
begin
  reset(a);
  leer(a,l);
  writeln('Ingrese el nombre de la distribucion a eliminar');
  readln(nom);
  while((l.nom <> valor_alto)and(l.nom  <> nom))do
      leer(a,l);
  if((l.nom <> valor_alto)and(l.nom = nom))then
    begin
       pos:=filepos(a)-1;
       l.cant:= (pos)*(-1);
       seek(a,0);
       read(a,aux);
       seek(a,pos);
       write(a,aux);
       seek(a,0);
       write(a,l);
    end;
close(a);
end;
procedure imprimir(var a:archivo);
var
  l:lin_ver;
begin
 reset(a);
 leer(a,l);
 while(l.nom <> valor_alto)do
   begin
    writeln('---------------------------------------------------------------------------------');
    writeln('El nombre de la distribucion es ',l.nom,' y su descripcion es ',l.desc);
    writeln('El anio de su lanzamiento',l.anio,' con la cantidad de ',l.cant,' de desarrolladores  y su version de kernel es: ',l.v_ker);
    writeln('-------------------------------------------------------------------------------------------------------');
    leer(a,l);
   end;
 close(a);
end;
begin
end.
