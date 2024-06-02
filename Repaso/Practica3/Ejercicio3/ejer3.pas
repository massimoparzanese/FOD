{ Realizar un programa que genere un archivo de novelas filmadas durante el presente
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
proporcionado por el usuario}

program ejercicio3;
const
  valor_alto = 32420;
type
  cadenita = string[10];
  
  cadena = string[30];
  
  novela = record
    cod:integer;
    gen:cadenita;
    nom:cadena;
    dur:integer;
    dir:cadena;
    precio:real;
   end;
  maestro = file of novela;
procedure leer(var mae:maestro;var N:novela);
begin
  if(not EOF(mae))then
    read(mae,N)
  else N.cod:=valor_alto;
end;
procedure leer_n(var N:novela);
begin
  writeln('Ingrese el codigo de novela');
  readln(N.cod);
  if(N.cod <> -1)then
    begin
     writeln('Ingrese el genero');
	 readln(N.gen);
	 writeln('Ingrese el nombre');
	 readln(N.nom);
	 writeln('Ingrese la duracion');
	 readln(N.dur);
	 writeln('Ingrese el director');
	 readln(N.dir);
	 writeln('Ingrese el precio');
	 readln(N.precio);
    end;
end;
procedure cargar(var mae:maestro;var t:text);
var
  n:novela;
begin
  reset(t);
  rewrite(mae);
  while(not EOF(t))do
    begin
      readln(t,n.cod,n.dur,n.gen);
      readln(t,n.precio,n.dir);
      readln(t,n.nom);
      write(mae,n);
    end;
  close(t);
  close(mae);
end;
procedure agregar(var mae:maestro);
var
  n:novela;
  ag:novela;
  aux:novela;
  pos:integer;
begin
  reset(mae);
  leer(mae,n);
  leer_n(ag);
  if(n.cod <> 0)then
    begin
      seek(mae,n.cod*-1);
      pos:=filepos(mae);
      read(mae,aux);
      seek(mae,0);
      write(mae,aux);
      seek(mae,pos);
      write(mae,ag);
    end
  else begin
    seek(mae,filesize(mae));
    write(mae,ag);
  end;
  close(mae);
end;
procedure modificar(var mae:maestro);
var
  n:novela;
  aux:novela;
  ok:boolean;
begin
 reset(mae);
 leer_n(aux);
 leer(mae,n);
 ok:=false;
 while((n.cod <> valor_alto) and(not ok))do
   begin
     if(aux.cod = n.cod)then
       begin
         seek(mae,filepos(mae)-1);
         write(mae,aux);
         ok:=true;
       end;
   end;
  if(ok)then
    begin
      writeln('Se ha modificado con exito');
    end
    else writeln('La novela que se busca no existe');
 close(mae);
end;
procedure eliminar(var mae:maestro);
var
 aux:novela;
 n:novela;
 pos:integer;
begin
  reset(mae);
  leer_n(aux);
  leer(mae,n);
  while((n.cod <> valor_alto)and(n.cod <> aux.cod))do
     leer(mae,n);
  if(n.cod = aux.cod)then
    begin
      pos:=filepos(mae)-1;
      seek(mae,0);
      read(mae,n);
      seek(mae,0);
      aux.cod:=pos*-1;
      write(mae,aux);
      seek(mae,pos);
      write(mae,n);    
    end;
  close(mae);
end;
procedure listar(var mae:maestro;var t:text);
var
  n:novela;
begin
  reset(mae);
  rewrite(t);
  leer(mae,n);
  while(n.cod <> valor_alto)do
    begin
      writeln(t,n.cod,' ',n.dur,' ',n.gen,'  ',n.precio,' ',n.dir,' ',n.nom);
      leer(mae,n);
    end;
  close(mae);
  close(t);
end;
begin
end.
