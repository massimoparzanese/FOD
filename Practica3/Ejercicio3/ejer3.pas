{. Realizar un programa que genere un archivo de novelas filmadas durante el presente
año. De cada novela se registra: código, género, nombre, duración, director y precio.
El programa debe presentar un menú con las siguientes opciones:
a. Crear el archivo y cargarlo a partir de datos ingresados por teclado. Se
utiliza la técnica de lista invertida para recuperar espacio libre en el
archivo. Para ello, durante la creación del archivo, en el primer registro del
mismo se debe almacenar la cabecera de la lista. Es decir un registro
ficticio, inicializando con el valor cero (0) el campo correspondiente al
código de novela, el cual indica que no hay espacio libre dentro del
archivo.
b. Abrir el archivo existente y permitir su mantenimiento teniendo en cuenta el
inciso a., se utiliza lista invertida para recuperación de espacio. En
particular, para el campo de ´enlace´ de la lista, se debe especificar los
números de registro referenciados con signo negativo, (utilice el código de
novela como enlace).Una vez abierto el archivo, brindar operaciones para:
i. Dar de alta una novela leyendo la información desde teclado. Para
esta operación, en caso de ser posible, deberá recuperarse el
espacio libre. Es decir, si en el campo correspondiente al código de
novela del registro cabecera hay un valor negativo, por ejemplo -5,
se debe leer el registro en la posición 5, copiarlo en la posición 0
(actualizar la lista de espacio libre) y grabar el nuevo registro en la
posición 5. Con el valor 0 (cero) en el registro cabecera se indica
que no hay espacio libre.
ii. Modificar los datos de una novela leyendo la información desde
teclado. El código de novela no puede ser modificado.
iii. Eliminar una novela cuyo código es ingresado por teclado. Por
ejemplo, si se da de baja un registro en la posición 8, en el campo
código de novela del registro cabecera deberá figurar -8, y en el
registro en la posición 8 debe copiarse el antiguo registro cabecera.
c. Listar en un archivo de texto todas las novelas, incluyendo las borradas, que
representan la lista de espacio libre. El archivo debe llamarse “novelas.txt”.
NOTA: Tanto en la creación como en la apertura el nombre del archivo debe ser
proporcionado por el usuario.}
program ejercicio3;
const
 valor_alto = 32420;
type
 cadena = string[50];
  novela = record
    cod:integer;
    genero:cadena;
    nombre:cadena;
    duracion:integer;
    direc:cadena;
    precio:real;
   end;
   archivo = file of novela;
procedure leer_nov(var n:novela);
begin
 writeln('Ingrese el codigo de la novela');
 readln(n.cod);
 writeln('Ingrese el nombre de la novela');
 readln(n.nombre);
 writeln('Ingrese la duracion de la novela');
 readln(n.duracion);
 writeln('Ingrese el precio de la novela');
 readln(n.precio);
 writeln('Ingrese el genero de la novela');
 readln(n.genero);
 writeln('Ingrese el nombre del director de la novela');
 readln(n.direc);
end;
procedure leer(var a:archivo;var n:novela);
begin
 if(not EOF(a))then
   read(a,n)
 else
   n.cod:=valor_alto;
end;
procedure cargar_binario(var t:text;var a:archivo);
var
  n:novela;
begin
  reset(t);
  rewrite(a);
  while(not EOF(t))do
    begin
      readln(t,n.cod,n.duracion,n.direc);
      readln(t,n.precio);
      readln(t,n.nombre);
      readln(t,n.genero);
      write(a,n);    
    end;
 close(t);
 close(a);
end;
procedure imprimir_archivo(var a:archivo);
var
  n:novela;
begin
 reset(a);
 leer(a,n);
 while(n.cod <> valor_alto)do
   begin
    writeln('El codigo de novela ',n.cod,' se llama ',n.nombre,' su genero es ',n.genero,' con duracion ',n.duracion,' Dirigida por ',n.direc,' y precio ',n.precio:0:2);
    leer(a,n);
   end;
 close(a);
end;
procedure modulob_a(var a:archivo);
var
 n:novela;
 aux:novela;
begin
 leer_nov(n);
 Reset(a);
 leer(a,aux);
 if(aux.cod <> 0)and(aux.cod <> valor_alto)then
   begin
     aux.cod:=aux.cod*-1;
     seek(a,(aux.cod));
     read(a,aux);
     seek(a,filepos(a)-1);
     write(a,n);
     seek(a,0);
     if(aux.cod > 0)then
       aux.cod:= aux.cod *-1;
     write(a,aux);
   end
   else begin
          seek(a,filesize(a)-1);
          write(a,n);        
        end;
 close(a);
end;
procedure modulob_b(var a:archivo);
var
 n:novela;
 aux:novela;
begin
 writeln('Estas son las novelas con las que cuenta el archivo');
 imprimir_archivo(a);
 writeln('--------------------------------------------------------');
 writeln('Aclaracion: Las novelas que tienen cod negativo o 0, no se contemplan a la hora de modificarla');
 writeln('--------------------------------------------------------');
 reset(a);
 writeln('Se le hará ingresar los datos de la novela para modificarla. El unico campo que no puede modificar es el de su codigo. Si quiere mantener el valor que ese campo tiene, solo ingrese el valor correspondiente');
 leer_nov(n);
 leer(a,aux);
 while(aux.cod <> valor_alto)and(aux.cod <> n.cod)do
   begin
     leer(a,aux);
   end;
 if(aux.cod = n.cod)then
   begin
    seek(a,filepos(a)-1);
    write(a,n);
   end
   else writeln('La novela que busca no se encuentra en el archivo');
   close(a);
  writeln('Este es el archivo modificado: ');
  imprimir_archivo(a);
  writeln('--------------------------------------------------------');
 
end;
procedure modulob_c(var a:archivo);
var
 cod:integer;
 pos:integer;
 n:novela;
 aux:novela;
begin
 writeln('Ingrese el cod de la novela a eliminar:');
 readln(cod);
 reset(a);
 leer(a,aux);
 leer(a,n);
 while(n.cod <> valor_alto)and(cod <> n.cod)do
   leer(a,n);
 if(cod = n.cod)then
   begin
     pos:=filepos(a)-1;
     seek(a,pos);
     write(a,aux);
     seek(a,0);
     n.cod:= pos* -1;
     write(a,n);
   end
  else writeln('El codigo de novela que ingresó no se encuentra en el archivo');
close(a);
end;
procedure modulo_b(var a:archivo;opcion:integer);
begin 
  case(opcion)of
   1: modulob_a(a);
   2: modulob_b(a);
   3: modulob_c(a);
  end;
end;
procedure modulo_c(var a:archivo;var t:text);
var
  n:novela;
begin
  reset(a);
  rewrite(t);
  leer(a,n);
  while(n.cod <> valor_alto)do
    begin
      writeln(t,n.cod,'  ',n.duracion,'  ',n.direc);
      writeln(t,n.precio);
      writeln(t,n.nombre);
      writeln(t,n.genero);
      leer(a,n); 
    end;
  close(a);
  close(t);
end;
var
 t:text;
 cad:cadena;
 a:archivo;
 option:integer;
 t2:text;
begin
repeat
 writeln('Ingrese la opcion a ejecutar: ');
 writeln('0.Terminar/1.Crear un archivo Binario/2.Mantenimiento del archivo/3.Listar las novelas en un archivo de texto');
 readln(option);
 case(option)of
  0:writeln('El programa terminara...');
  1:begin
      writeln('Ingrese el nombre del arch de texto');
      readln(cad);
      assign(t,cad);
      writeln('Ingrese el nombre del arch binario');
      readln(cad);
      assign(a,cad);
      cargar_binario(t,a);
     end;
  2:begin
      writeln('Ingrese el nombre del arch binario');
      readln(cad);
      assign(a,cad);
      writeln('Ingrese la opcion a ejecutar: ');
      writeln('1.Dar una novela de alta/2.Modificar los datos de una novela existente/3.Eliminar una novela existente');
      readln(option);
      modulo_b(a,option);
    end;
  3:begin 
      writeln('Ingrese el nombre del arch de texto');
      readln(cad);
      assign(t2,cad);
      writeln('Ingrese el nombre del arch binario');
      readln(cad);
      assign(a,cad);
      modulo_c(a,t2);
    end;
 
 end;
until(option = 0);
end.
