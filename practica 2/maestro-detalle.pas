program ej;

const

    CORTE = -9999;

type    

    team = record
        cod: integer;
        nom: string;
        puntos: integer;
    end;

    stat = record
        codT: integer;
        puntosTemporada: integer;
    end;

    arch_eq = filo of team;

    arch_stats = file of stat;

//modulos

procedure actualizarArchivoMaestroDetalle(var arch : arch_eq; var det: arch_stats);
var 
    regD : stat;
    regM : team;
begin
    {
        precondiciones:
        - 1 maestro - 1 detalle (unico archivo detalle que actualiza al maestro)
        - 1 registro del detalle modifica 1 solo registro del maestro
        - No todos los registros del maestro son necesariamente modificados
        - Cada elemento del maestro se modifica es alterado por un solo elemento del archivo
        - Ambos archivos estan ordenados por igual criterio
    }

    assign(arch,'master.txt');
    assign(det,'stats.txt')
    reset(arch);
    reset(det);
    
    while (not EOF(det)) do begin
        read(arch,regM);
        read(det,regD)
        while (regM.cod <> regD.codT) do begin
            read(arch,regM);
        end;
        regM.puntos := regM.puntos + regD.puntosTemporada;
        //se reubica el puntero
        write(mae,regM);
    end;
end;

procedure leer(var arch: arch_stat; var aux: stat);
begin
    if (not EOF(arch)) then
        read(arch,aux)
    else
        aux.codT = CORTE;
end;

procedure actualizarArchivoMaestroDetalleConRepeticion(var mae: arch_eq; var det: arch_stats);
var
    regM: team;
    regD: stat;
begin

    {
        precondiciones: 
        - igual que el anterior solo que esta vez puede haber mas de un registro que modifica al maestro
    }
    
    assign(arch,'master.txt');
    assign(det,'stats.txt');
    reset(arch);
    reset(det);
    leer(det,regD); //importante este modulo
    while (regD.codT <> CORTE) do begin
        leer(mae,regM);
        while (regM.cod <> regD.codT) do begin //busco el equipo en el master
            leer(mae,regM);
        end;
        while (regM.cod = regD.codT) do begin //corte de control para el detalle
            regM.puntos := regM.puntos + regD.puntosTemporada;
            leer(det,regD);
        end;
        seek(mae,filepos(mae)-1); //reposiciono el puntero
        write(mae,regM); //actualizo el maestro
    end;
    close(arch);
    close(det);
end;
