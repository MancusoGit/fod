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
	writeln();
	write('ingrese el apellido del empleado (fin para terminar): ');
	readln(e.apellido);
	if (e.apellido <> ape) then begin
		write('ingrese el nombre del empleado: ');
		readln(e.nombre);
		write('ingrese la edad del empleado: ');
		readln(e.edad);
		write('ingrese el dni del empleado: ');
		readln(e.dni);
		write('ingrese el id del empleado: ');
		readln(e.id);
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
	emp : empleado;
begin
	reset(arch_log);
	while(not EOF(arch_log)) do begin
		read(arch_log,emp);
		writeln('nombre del empleado ',emp.nombre,', apellido del empleado ',emp.apellido,', id ',emp.id,', edad del empleado ',emp.edad,', dni del empleado ',emp.dni:0:0);
		writeln();
	end;
	close(arch_log);
end;

procedure imprimirEmpleadosPorEdad(var arch_log : arch_emp);
var
	emp : empleado;
begin
	reset(arch_log);
	while(not EOF(arch_log)) do begin
		read(arch_log,emp);
		if (emp.edad > 70) then begin
			writeln('el siguiente empleado esta proximo a jubilarse: ');
			writeln('nombre del empleado ',emp.nombre,', apellido del empleado ',emp.apellido,', id ',emp.id,', edad del empleado ',emp.edad,', dni del empleado ',emp.dni:0:0);
			writeln();
		end;
	end;
	close(arch_log);
end;

procedure imprimirEmpleadosPorTeclado(var arch_log : arch_emp);
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
		end;
	end;
	close(arch_log);
end;

procedure cargarEmpleados(var arch_log : arch_emp);
var
	empNue,empArch : empleado;
begin
	leerEmp(empNue);
	while(empNue.apellido <> 'fin') do begin
		reset(arch_log);
		read(arch_log,empArch);
		while (not EOF(arch_log) and (empNue.id <> empArch.id)) do begin
			read(arch_log,empArch);
		end;
		if (empNue.id = empArch.id) then begin
			writeln('el id de empleado ya existe en el archivo');
			writeln();
		end
		else begin
			write(arch_log,empNue);
			writeln('se ha cargado el empleado correctamente');
			writeln();
		end;
		close(arch_log);
		leerEmp(empNue);	
	end;
end;

procedure actualizarEdad(var arch_log : arch_emp);
var
	emp : empleado;
	ape,nom : String;
	edadNueva : integer;
begin
	reset(arch_log);
	write('ingrese el apellido del empleado a actualizar: ');
	readln(ape);
	write('ingrese el nombre del empleado a actualizar: ');
	readln(nom);
	write('ingrese la nueva edad del empleado: ');
	readln(edadNueva);
	while(not EOF(arch_log)) do begin
		read(arch_log,emp);
		if ((emp.apellido = ape) and (emp.nombre = nom)) then begin
			emp.edad := edadNueva;
			seek(arch_log,filepos(arch_log) - 1);
			write(arch_log,emp);
			writeln('se ha actualizado la edad del empleado');
			writeln();
		end;
	end;
	if ((emp.apellido <> ape) and (emp.nombre <> nom)) then begin
		writeln('no se ha encontrado el empleado');
		writeln();
	end;
	close(arch_log);
end;

procedure exportarArchivo(var arch_log : arch_emp);
var
	arch_maestro : arch_emp;
	emp : empleado;
begin
	assign(arch_maestro,'todos_empleados.txt');
	reset(arch_log);
	reset(arch_maestro);
	while(not EOF(arch_log)) do begin
		read(arch_log,emp);
		write(arch_maestro,emp);
	end;
	close(arch_maestro);
	close(arch_log);
	writeln('se han exportado los empleados al archivo maestro');
	writeln();
end;

procedure exportarEmpleadosSinDni(var arch_log : arch_emp);
var
	arch_sin_dni : arch_emp;
	emp : empleado;
begin
	assign(arch_sin_dni,'faltaDNIEmpleado.txt');
	reset(arch_log);
	reset(arch_sin_dni);
	while(not EOF(arch_log)) do begin
		read(arch_log,emp);
		if (emp.dni = 00) then begin
			write(arch_sin_dni,emp);
		end;
	end;
	close(arch_sin_dni);
	close(arch_log);
	writeln('se han exportado los empleados sin dni');
	writeln();
end;

procedure menuEmpleados(var arch_log : arch_emp);
var	
	res : integer;
begin
	writeln('Bienvenido al menu de empleados');
	writeln('- cargar uno o mas empleados -> presione (1)');
	writeln('- imprimir empleados -> presione (2)');
	writeln('- imprimir los datos de un empleado -> presione (3)');
	writeln('- imprimir los datos de los empleados proximos a jubilarse -> presione (4)');
	writeln('- actualizar la edad de un empleado -> presione (5)');
	writeln('- exportar el contenido al archivo maestro -> presione (6)');
	writeln('- exportar los empleados que no tienen dni -> presione (7)');
	writeln('- salir -> presione (0)');
	write('respuesta: ');
	readln(res);
	writeln();
	while (res <> 0) do begin
		case res of
			1: cargarEmpleados(arch_log);
			2: imprimirEmpleados(arch_log);
			3: imprimirEmpleadosPorTeclado(arch_log);
			4: imprimirEmpleadosPorEdad(arch_log);
			5: actualizarEdad(arch_log);
			6: exportarArchivo(arch_log);
			7: exportarEmpleadosSinDni(arch_log);
			0: writeln('saliendo del menu de empleados...');
			otherwise writeln('opcion incorrecta');
		end;
		writeln('Bienvenido al menu de empleados');
		writeln('- cargar uno o mas empleados -> presione (1)');
		writeln('- imprimir empleados -> presione (2)');
		writeln('- imprimir los datos de un empleado -> presione (3)');
		writeln('- imprimir los datos de los empleados proximos a jubilarse -> presione (4)');
		writeln('- actualizar la edad de un empleado -> presione (5)');
		writeln('- exportar el contenido al archivo maestro -> presione (6)');
		writeln('- exportar los empleados que no tienen dni -> presione (7)');
		writeln('- salir -> presione (0)');
		write('respuesta: ');
		readln(res);
		writeln();
	end;
	writeln('menu de empleados cerrado.');
end;

var
	arch_name : String;
	arch_log : arch_emp;
begin
	writeln();
	write('ingrese el nombre del archivo: ');
	readln(arch_name);
	assign(arch_log,arch_name);
	cargarArchivo(arch_log);
	menuEmpleados(arch_log);
end.
