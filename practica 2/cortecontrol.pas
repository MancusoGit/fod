program ap;

const
    valorAlto = '9999';

procedure leer(var archivo: archivo; var reg: registro);
begin
    if not eof(archivo) then
        read(archivo, reg)
    else
        reg.provincia := valorAlto;
end;

begin
    //precondiciones: archivo ordenado por algun criterio, ej ciudades dentro de un mismo partido, y partidos dentro de provincias
    assign(archivo, 'archivo.txt'); //asignamos el archivo ya existente
    reset(archivo); //abrimos el archivo en modo lectura    
    leer(archivo, reg); //leemos el primer registro del archivo 
    //informar el contenido del registro
    //iniciar el valor de las variables contadoras o x
    while (reg.provincia <> valorAlto) do begin
        provinciaAnterior := reg.provincia;
        partidoAnterior := reg.partido;
        while (partidoAnterior = reg.partido) and (provinciaAnterio = reg.provincia) do begin
            //informar el contenido del registro del partido
            //hacer algo con los datos
            leer(archivo, reg);
        end;
        partidoAnterior := reg.partido;
        if (provinciaAnterior <> reg.provincia) then begin
            //hacer algo con los datos
            //reinicio los valores de las variables
        end;
    end;
end.
