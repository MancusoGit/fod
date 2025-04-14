program mergeOrden;

begin
    //mismo inicio que mergeSinRepeticion.pas, con la variable auxiliar regMaster

    while (min.cod <> valorAlto) do begin
        regMaster.cod := min.cod;
        regMaster.total := 0;
        while (regMaster.cod = min.cod) do begin
            regMaster.total := regMaster.total + min.total;
            minimo(reg1,reg2,reg3,min);
        end;
        write(maestro, regMaster);
    end;

end.
