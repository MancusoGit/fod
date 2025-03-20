program archivos;

type	
	
	archivo_int = file of integer;
	
//modulos	
procedure cargarArchivo(var arch_log: archivo_int);
var
	num : integer;
begin
	rewrite(arch_log); //creamos el archivo
	write('ingrese un numero: '); 
	readln(num); //leemos un numero de teclado
	while (num <> 30000) do begin
		write(arch_log,num); //escribimos el numero en el archivo
		write('ingrese un numero: '); 
		readln(num); //repetimos
	end;
	close(arch_log); //cerramos el archivo
	writeln();
	writeln('se cerro el archivo');
	writeln();
end;

procedure leerArchivos(var arch_log: archivo_int);
var
	num,cantMenores,cantTotal : integer;
	promedio : real;
begin
	cantTotal := 0;
	promedio := 0;
	cantMenores := 0;
	writeln('impriendo los datos del archivo : ');
	reset(arch_log); //abrimos el archivo que ya existe
	while(not(EOF(arch_log))) do begin //mientras no se llegue al final del archivo
		read(arch_log,num); //leemos el caracter actual
		if (num < 1500) then //evaluamos
			cantMenores := cantMenores + 1; //aumentamos el contador
		cantTotal := cantTotal + 1;
		promedio := promedio + num;
		writeln('el numero ',num,' se encuentra en la posicion ',filePos(arch_log)); //imprimimos el dato actual
	end;
	close(arch_log); //cerramos el archivo
	promedio := promedio / cantTotal; //promediamos
	writeln();
	writeln('la cantidad de numeros menores a 1500 en el archivo es = ',cantMenores); //informamos
	writeln('el promedio de todos los numeros es = ',promedio:0:2);
end;

//programa principal
var
	arch_log : archivo_int;
	arch_name: String;
begin
	write('ingrese el nombre del archivo : ');
	readln(arch_name); //nombre del archivo
	assign(arch_log,arch_name); //vinculamos el nombre del archivo fisico con el del programa
	writeln();
	cargarArchivo(arch_log); //llamamos al proceso para cargar numeros
	leerArchivos(arch_log); //procesamos los datos del archivo
end.
