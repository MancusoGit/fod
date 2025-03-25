program ej3;	
type 
	
	empleado = record
		id : integer;
		apellido : String;
		nombre: String;
		edad : integer;
		dni : real;
	end;
	
	arch_emp = file of empleado;
	
//modulos

procedure leerEmp(var e : empleado);
var
	ape : String;
begin
	ape := 'fin';
	write('ingrese el apellido del empleado: ');
	readln(e.apellido);
	if (e.apellido <> ape) then begin
		write('ingrese el nombre del empleado: ');
		readln(e.nombre);
		write('ingrese la edad del empleado: ');
		readln(e.edad);
		write('ingrese el dni del empleado: ');
		readln(e.dni);
		writeln('generando id de empleado...');
		e.id := random(100) + 1;
		writeln();
	end;
	writeln();
end;

procedure cargarArchivo(var archivo : arch_emp);
var
	emp : empleado;
	corte : String;
begin
	corte := 'fin';
	rewrite(archivo);
	leerEmp(emp);
	while(emp.apellido <> corte) do begin
		write(archivo,emp);
		leerEmp(emp);
	end;
	close(archivo);
end;

procedure imprimirEmpleados(var arch_log : arch_emp);
var
	ape,nom: String;
	emp : empleado;
begin
	write('ingrese el apellido a corroborar : ');
	readln(ape);
	write('ingrese el nombre a corroborar : ');
	readln(nom);
	writeln();
	reset(arch_log);
	while(not EOF(arch_log)) do begin
		read(arch_log,emp);
		if ((emp.apellido = ape) and (emp.nombre = nom)) then begin
			writeln('el siguiente el empleado coincide con el nombre y apellido a corroborar: ');
			writeln('nombre del empleado ',emp.nombre,', apellido del empleado ',emp.apellido,', id ',emp.id,', edad del empleado ',emp.edad,', dni del empleado ',emp.dni:0:0);
			writeln();
		end
		else begin
			writeln('nombre del empleado ',emp.nombre,', apellido del empleado ',emp.apellido,', id ',emp.id,', edad del empleado ',emp.edad,', dni del empleado ',emp.dni:0:0);
			writeln();
		end;
		if (emp.edad > 70) then begin
			writeln('el siguiente empleado esta proximo a jubilarse: ');
			writeln('nombre del empleado ',emp.nombre,', apellido del empleado ',emp.apellido,', id ',emp.id,', edad del empleado ',emp.edad,', dni del empleado ',emp.dni:0:0);
			writeln();
		end;	
	end;
	close(arch_log);
end;

var
	arch_name : String;
	arch_log : arch_emp;
begin
	write('ingrese el nombre del archivo: ');
	readln(arch_name);
	assign(arch_log,arch_name);
	cargarArchivo(arch_log);
	imprimirEmpleados(arch_log);
end.
