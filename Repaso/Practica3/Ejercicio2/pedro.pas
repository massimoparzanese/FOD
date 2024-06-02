program untitled;
const
    valorAlto=32420;
    valor=1000;
type
    asistente = record
        numero:integer;
        apeynombre:string;
        email:string;
        tel:integer;
        DNI:integer;
    end;
    archivo=file of asistente;

procedure leerAsistente(var a:archivo;var asis:asistente);
begin
      if(not EOF(a))then
         read(a,asis)
     else
       asis.numero:=valorAlto;
end;
procedure cargar(var a:archivo;var t:text);
var
  asist:asistente;
begin
   reset(t);
   rewrite(a);
   while(not EOF(t))do
    begin
      readln(t,asist.numero,asist.tel,asist.dni);
      readln(t,asist.apeynombre);
      readln(t,asist.email);
      write(a,asist);
    end;
close(t);
close(a);
end;
    procedure eliminar (var a:archivo);
    var
        asis:asistente;
    begin
        reset(a);
        leerAsistente(a,asis);
        while(asis.numero<>valorAlto)do 
        begin
            if(asis.numero<valor)then begin
                asis.apeynombre:='@'+asis.apeynombre;
                seek(a,filepos(a)-1);
                write(a,asis);
            end;
            leerAsistente(a,asis);
        end;
            close(a);
    end;

var
    a:archivo;
    t:text;
    s:string[30];
    titulo:string[15];
Begin
    writeln('Ingresa el nombre del txt');
    readln(titulo);
    assign(t, titulo);
    writeln('Ingresa el nombre del archivo');
    readln(s);
    assign(a,s);
    cargar(a,t);
    eliminar(a);
END.
