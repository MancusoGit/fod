program merge;

{
merge = fusion
generar un archivo nuevo a partir de 2 o más archivos ya existentes
}

const
    CORTO = -0;

type

    data = record
        cod: integer;
        nom: string;
        monto: real;
    end;

    arch = file of data;

//algoritmo

{
criterios del archivo:
respeta un orden
puede haber solo una aparicion de un mismo cod de data
}

procedure leer var(var a: arch; var d: data);
begin
    if not eof(a) then
        read(a, d)
    else
        d.cod := CORTO;
end;

//n archivos, n reg, suponemos 3 archivos

procedure minimo(var det1, det2, det3: arch; var r1,r2,r3,min : data);
begin

    if (r1.cod <= r2.cod) and (r1.cod <= r3.cod) then begin
        min := r1;
        leer(det1,r1);
    end
    else if (r2.cod <= r3.cod) then begin
        min := r2;
        leer(det2,r2);
    end
    else begin
        min := r3;
        leer(det3,r3);
    end;
end;

procedure merge(var mae,a1,a2,a3: arch);
var
    min,reg1,reg2,reg3: data; //min va a ser el registro a procesar
begin
    rewrite(mae);
    reset(a1);
    reset(a2);
    reset(a3);
    leer(a1,reg1);
    leer(a2,reg2);
    leer(a3,reg3);
    minimo(a1,a2,a3,reg1,reg2,reg3,min);
    while(min.cod <> CORTO) do begin
        write(mae,min);
        minimo(a1,a2,a3,reg1,reg2,reg3,min);
    end;
    close(mae);
    close(a1)
    close
end;

procedure mergeConRepeticion(var mae,a1,a2,a3: arch);
var
    aux,min,reg1,reg2,reg3: data;
    tot: real;
begin
    rewrite(mae);
    reset(a1);
    reset(a2);
    reset(a3);
    leer(a1,reg1);
    leer(a2,reg2);
    leer(a3,reg3);
    minimo(a1,a2,a3,reg1,reg2,reg3,min);
    while(min.cod <> CORTO) do begin
        aux := min;
        tot := 0;
        while(aux.cod = min.cod) do begin
            tot := tot + min.monto;
            minimo(a1,a2,a3,reg1,reg2,reg3,min);
        end;
        aux.monto := tot;
        write(mae,aux);
    end;
end;
