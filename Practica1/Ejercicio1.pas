//Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita
//incorporar datos al archivo. Los números son ingresados desde teclado. La carga finaliza
//cuando se ingresa el número 30000, que no debe incorporarse al archivo. El nombre del
//archivo debe ser proporcionado por el usuario desde teclado.
program ejercicio1;
type
  archivo = file of integer;
var
  arch_int:archivo;
  nomb_arch: string[20];
  num:integer;
begin
 writeln('Ingrese el nombre del archivo');
 read(nomb_arch);
 Assign(arch_int,nomb_arch);
 Rewrite(arch_int);
 write('Ingrese un numero');
 read(num);
 while(num <> 30000) do
   begin
     write(arch_int,num);
     write('Ingrese un numero');
     read(num);
   end;
  write('La carga de numeros ha finalizado');
  close(arch_int);
end.
 
