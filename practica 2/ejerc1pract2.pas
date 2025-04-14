program e1p2;

const

    CORTE = 9999;

type

    empleado = record
        cod: integer;
        nombre: string[20];
        monto: real;
    end;

    arch_emp = file of empleado;

//modulos

procedure leerEmp(var e: empleado);
begin
    write('Ingrese el codigo del empleado: ');
    readln(e.cod);
    write('Ingrese el nombre del empleado: ');
    readln(e.nombre);
    write('Ingrese el monto del empleado: ');
    readln(e.monto);
    writeln();
end;

procedure lectura(var a: arch_emp; var e: empleado);
begin
    if not eof(a) then
        read(a, e)
    else
        e.cod := CORTE;
end;

procedure compactar(var arch_det: arch_emp; var arch_nue: arch_emp);
var
    e, eaux: empleado;
    codAct: integer;
    totalMonto: real;
begin
    reset(arch_det);
    rewrite(arch_nue);
    lectura(arch_det, e);
    while (e.cod <> CORTE) do begin
        codAct := e.cod;
        totalMonto := 0;
        eaux := e;
        while (e.cod = codAct) do begin
            totalMonto := totalMonto + e.monto;
            lectura(arch_det,e);
        end;
        eaux.monto := totalMonto;
        write(arch_nue,eaux);
    end;
    close(arch_det);
    close(arch_nue);
end;

procedure cargarArchivo(var archivo : arch_emp);
var
	emp : empleado;
	corte : string;
begin
	corte := 'fin';
	rewrite(archivo);
	leerEmp(emp);
	while(emp.nombre <> corte) do begin
		write(archivo,emp);
		leerEmp(emp);
	end;
	close(archivo);
end;

procedure imprimirEmpleados(var arch_log : arch_emp);
var
	emp : empleado;
begin
	reset(arch_log);
	while(not EOF(arch_log)) do begin
		read(arch_log,emp);
		writeln('nombre del empleado ',emp.nombre,', codigo de empleado ',emp.cod,', monto total emp = $ ',emp.monto:0:2);
		writeln();
	end;
	close(arch_log);
end;

//programa principal

var
    archivo_detalle: arch_emp;
    archivo_maestro: arch_emp;
begin
    writeln();
    writeln('programa de actualizacion de datos MancuSoftware (C).');
    writeln();
    assign(archivo_detalle,'detEmpleados.txt');
    assign(archivo_maestro,'masterEmpleados.txt');
    cargarArchivo(archivo_detalle);
    writeln();
    writeln('empleados del detalle: ');
    imprimirEmpleados(archivo_detalle);
    writeln();
    compactar(archivo_detalle,archivo_maestro);
    writeln('empleados del maestro: ');
    imprimirEmpleados(archivo_maestro);
end.
