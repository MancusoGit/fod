program ej2;

const

    CORTE = 9999;

type

    producto =  record
        cod: integer;
        nom: string;
        precio: real;
        stockAct: integer;
        stockMin: integer;
    end;

    venta = record
        codProd: integer;
        unidades: integer;
    end;

    arch_prod = file of producto;
    arch_venta = file of venta;

//modulos

procedure leerProd(var p: producto);
begin
    write('ingrese el codigo de producto: ');
    readln(p.cod);
    if (p.cod <> -1) then begin
        write('ingrese el nombre del producto: ');
        readln(p.nom);
        write('ingrese el precio del producto: ');
        readln(p.precio);
        write('ingrese el stock actual del producto: ');
        readln(p.stockAct);
        write('ingrese el stock minimo del producto: ');
        readln(p.stockMin);
        writeln();
    end;
    writeln();
end;

procedure leerVenta(var v: venta);
begin
    write('ingrese el codigo de producto: ');
    readln(v.codProd);
    if (v.codProd <> -1) then begin
        write('ingrese la cantidad de unidades vendidas: ');
        readln(v.unidades);
        writeln();
    end;
    writeln();
end;

procedure lecturaVenta(var arch_det: arch_venta; var v: venta);
begin
    if (not EOF(arch_det)) then
        read(arch_det,v)
    else
        v.codProd := CORTE;
end;

procedure lecturaProducto(var mae: arch_prod; var p: producto);
begin
    if (not EOF(mae)) then
        read(mae,p)
    else
        p.cod := CORTE;
end;

procedure actualizacion(var arch_det: arch_venta; var arch_mae: arch_prod);
var
    v_det: venta;
    p_mae: producto;
    codAct: integer;
begin
    reset(arch_det);
    reset(arch_mae);
    read(arch_mae,p_mae);
    lecturaVenta(arch_det,v_det);
    while (v_det.codProd <> CORTE) do begin
        codAct := v_det.codProd;
        while (p_mae.cod <> v_det.codProd) do 
            read(arch_mae,p_mae);
        while (v_det.codProd = codAct) do begin 
            p_mae.stockAct := p_mae.stockAct - v_det.unidades; 
            lecturaVenta(arch_det,v_det);
        end;
        seek(arch_mae, filepos(arch_mae)-1);
        write(arch_mae, p_mae);
        if (not(EOF(arch_mae))) then
            read(arch_mae, p_mae);
    end;
    close(arch_det);
    close(arch_mae);
end;

procedure cargarProductos(var mae: arch_prod);
var
    p: producto;
begin
    rewrite(mae);
    leerProd(p);
    while (p.cod <> -1) do begin
        write(mae,p);
        leerProd(p);
    end;
    close(mae);
end;

procedure cargarVentas(var det: arch_venta);
var
    v: venta;
begin
    rewrite(det);
    leerVenta(v);
    while (v.codProd <> -1) do begin
        write(det,v);
        leerVenta(v);
    end;
end;

procedure listarStockMin(var mae: arch_prod; var arch_stock: arch_prod);
var
    p: producto;
begin
    reset(mae);
    rewrite(arch_stock);
    lecturaProducto(mae,p);
    while (p.cod <> CORTE) do begin
        if (p.stockAct < p.stockMin) then
            write(arch_stock,p);
        lecturaProducto(mae,p);
    end;
    close(arch_stock);
    close(mae);
end;

procedure mostrarProductos(var a: arch_prod);
var
    p: producto;
begin
    reset(a);
    while (not(EOF(a))) do begin
        read(a,p);
        writeln('producto con codigo ',p.cod,', nombre ',p.nom,', precio = $ ',p.precio:0:2,', stock actual: ',p.stockAct,', stock minimo: ',p.stockMin);
        writeln();
    end;
    close(a);
end;

//programa principal

var
    archivo_detalle: arch_venta;
    archivo_maestro: arch_prod;
    archivo_stock: arch_prod;
begin
    writeln();
    writeln('Programa de control para productos comerciales - MancuSoftware 2025 (C)');
    writeln();
    assign(archivo_detalle,'ventas.txt');
    assign(archivo_maestro,'productosMaestro.txt');
    assign(archivo_stock,'stock_minimo.txt');
    cargarProductos(archivo_maestro);
    writeln('productos del archivo maestro');
    writeln();
    mostrarProductos(archivo_maestro);
    cargarVentas(archivo_detalle);
    actualizacion(archivo_detalle,archivo_maestro);
    listarStockMin(archivo_maestro,archivo_stock);
    writeln('productos del archivo maestro luego de la actualizacion');
    writeln();
    mostrarProductos(archivo_maestro);
    writeln('productos del archivo stock minimo');
    writeln();
    mostrarProductos(archivo_stock);
end.
