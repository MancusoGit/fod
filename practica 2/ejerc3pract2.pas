program ej3;

const

    CORTE = 'zzz';

type

    regMaestro = record
        provincia: string;
        totalAlfabetizados: integer;
        totalEncuestados: integer;
    end;

    regDetalle = record
        nombreProvincia: string;
        codigoLocal: integer;
        cantAlfa: integer;
        cantEncuesta: integer;
    end;

    archMaestro = file of regMaestro;

    archDetalle = file of regDetalle;

//modulos

procedure leer(var arch: archDetalle; var reg: regDetalle);
begin
    if (not(EOF(arch))) then
        read(arch,reg)
    else
        reg.nombreProvincia := CORTE;
end;

procedure minimo(var det1, det2: archDetalle; var reg1,reg2,min: regDetalle);
begin
    if (reg1.nombreProvincia <= reg2.nombreProvincia) then begin
        min := reg1;
        leer(det1,reg1);
    end
    else begin
        min := reg2;
        leer(det2,reg2);
    end;
end;

procedure procesarDetalles(var archMae: archMaestro; var archDet1, archDet2: archDetalle);
var
    regMae: regMaestro;
    regDet1, regDet2, min: regDetalle;
    provAct: string;
begin
    reset(archMae);
    reset(archDet1);
    reset(archDet2);
    leer(archDet1,regDet1);
    leer(archDet2,regDet2);
    read(archMae,regMae);
    minimo(archDet1,archDet2,regDet1,regDet2,min);
    while (min.nombreProvincia <> CORTE) do begin
        while (regMae.provincia <> min.nombreProvincia) do begin
            read(archMae,regMae);
        end;
        provAct := min.nombreProvincia;
        while (min.nombreProvincia = provAct) do begin
            regMae.totalAlfabetizados := regMae.totalAlfabetizados + min.cantAlfa;
            regMae.totalEncuestados := regMae.totalEncuestados + min.cantEncuesta;
            minimo(archDet1,archDet2,regDet1,regDet2,min);
        end;
        seek(archMae, filepos(archMae)-1);
        write(archMae, regMae);
        if (not(EOF(archMae))) then
            read(archMae, regMae);
    end;
    close(archDet1);
    close(archDet2);
    close(archMae);
end;

procedure leerRegMaestro(var r: regMaestro);
begin
    write('ingrese el nombre de la provincia: ');
    readln(r.provincia);
    if (r.provincia <> CORTE) then begin
        r.totalAlfabetizados := 0;
        r.totalEncuestados := 0;
    end;
    writeln();
end;

procedure cargarMaestro(var mae: archMaestro);
var
    reg: regMaestro;
begin
    rewrite(mae);
    leerRegMaestro(reg);
    while(reg.provincia <> CORTE) do begin
        write(mae,reg);
        leerRegMaestro(reg);
    end;
    close(mae);
end;

procedure leerRegDetalle(var r: regDetalle);
begin
    write('ingrese el nombre de la provincia: ');
    readln(r.nombreProvincia);
    if (r.nombreProvincia <> CORTE) then begin
        write('ingrese el codigo de la localidad: ');
        readln(r.codigoLocal);
        write('ingrese la cantidad de personas alfabetizadas: ');
        readln(r.cantAlfa);
        write('ingrese la cantidad de personas encuestadas: ');
        readln(r.cantEncuesta);
    end;
    writeln();
end;

procedure cargarDetalle(var det: archDetalle);
var
    r: regDetalle;
begin
    rewrite(det);
    leerRegDetalle(r);
    while (r.nombreProvincia <> CORTE) do begin
        write(det,r);
        leerRegDetalle(r);
    end;
    close(det);
end;

procedure imprimirMaestro(var m: archMaestro);
var
    r: regMaestro;
begin
    reset(m);
    while (not(EOF(m))) do begin
        read(m,r);
        writeln('-----------------------------------------');
        writeln('nombre de la provincia: ',r.provincia);
        writeln('cantidad de personas alfabetizadas: ',r.totalAlfabetizados);
        writeln('cantidad de personas encuestadas: ',r.totalEncuestados);
        writeln('-----------------------------------------');
        writeln();
    end;
    close(m);
end;

//programa principal

var
    
archivo_master: archMaestro;
detalle1, detalle2: archDetalle;

begin
    writeln();
    writeln('Bienvenido al programa de actualizacion de censos, by MancuSoftware 2025 (C).');
    writeln();
    assign(archivo_master,'master_provincias.txt');
    assign(detalle1,'detalle_provincias1.txt');
    assign(detalle2,'detalle_provincias2.txt');
    writeln('Cargando datos del archivo maestro.');
    writeln();
    cargarMaestro(archivo_master);
    writeln('Cargando datos del primer detalle.');
    writeln();
    cargarDetalle(detalle1);
    writeln('Cargando datos del segundo detalle.');
    writeln();
    cargarDetalle(detalle2);
    procesarDetalles(archivo_master,detalle1,detalle2);
    writeln('Mostrando datos del maestro despues de la actualización de datos...');
    writeln();
    imprimirMaestro(archivo_master);
end.
