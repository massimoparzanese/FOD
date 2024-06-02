program pruebaa;
var
 cadena: string[15];
 i:integer;
begin
readln(cadena);
for i := 1 to Length(cadena) do
begin
  // Imprimir cada caracter de la cadena
  WriteLn('Caracter ', i, ': ', cadena[i]);
end;
end.
