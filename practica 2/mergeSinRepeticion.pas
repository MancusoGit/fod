program mrg;

const
    valorAlto = '9999';

procedure leer(var archivo: archivo; var reg: registro);
begin
    if not eof(archivo) then
        read(archivo, reg)
    else
        reg.provincia := valorAlto;
end;

procedure minimo(var reg1,reg2,reg3: registro; var min: integer); //hacemos el embudo
begin 
    if (reg1.nom < reg2.nom) and (reg1.nom < reg3.nom) then begin
        min := reg1;
        leer(archivo1, reg1);
    end else if (reg2.nom < reg3.nom) then begin
        min := reg2;
        leer(archivo2, reg2);
    end else begin
        min := reg3;
        leer(archivo3, reg3);
    end;
end;


begin
    //precondiciones: involucra archivos con contenido similiar, el cual debe resumirse en un unico archivo
    // osea a partir de los detalles se crea el maestro.
    // - los detalles tienen igual estructura
    // - los archivos estan ordenados por algun criterio, ej ciudades dentro de un mismo partido, y partidos dentro de provincias
    // suposiciones: los alumnos aparecen una sola vez en los archivos

    //assign de los 3 archivos detalle
    //reset de los 3 archivos detalle
    //llamo a leer para cada archivo detalle


    //assign del archivo maestro
    //rewrite del archivo maestro

    minimo(reg1,reg2,reg3,min);

    while (min.nom <> valorAlto) do begin
        write(maestro, min);
        minimo(reg1,reg2,reg3,min);
    end;
    close(maestro);
    //close de los 3 archivos detalle
end.
