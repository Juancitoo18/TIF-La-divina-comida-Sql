USE master
GO

CREATE DATABASE TIF_LAB3_La_Divina_Comida
GO

USE TIF_LAB3_La_Divina_Comida
GO

CREATE TABLE Categorias(
	CodCategoria_Ct CHAR(8) NOT NULL,
	Nombre_Ct VARCHAR(30) NOT NULL,
	Estado_Ct BIT DEFAULT 1,
	CONSTRAINT PK_Categoria PRIMARY KEY (CodCategoria_Ct)
)
GO

CREATE TABLE Tipos(
	CodTipo_T CHAR(8) NOT NULL,
	Nombre_T VARCHAR(30) NOT NULL,
	Estado_T BIT DEFAULT 1,
	CONSTRAINT PK_Tipo PRIMARY KEY (CodTipo_T)
)
GO

CREATE TABLE Productos(
	CodProducto_P CHAR(8) NOT NULL,
	CodCategoria_P CHAR(8) NOT NULL,
	CodTipo_P CHAR(8) NOT NULL,
	Stock_P INT NOT NULL,
	NombreProducto_P VARCHAR (30) NOT NULL,
	Descripcion_P VARCHAR(100) NOT NULL,
	PrecioUnitario_P DECIMAL NOT NULL,
	Estado_Pr BIT DEFAULT 1,
	CONSTRAINT PK_Productos PRIMARY KEY (CodProducto_P),
	CONSTRAINT FK_Productos_Categoria FOREIGN KEY (CodCategoria_P) REFERENCES Categorias(CodCategoria_Ct),
	CONSTRAINT FK_Productos_Tipo FOREIGN KEY (CodTipo_P) REFERENCES Tipos(CodTipo_T)
)
GO

CREATE TABLE Sucursales(
	CodSucursal_S CHAR(8) NOT NULL,
	Localidad_S VARCHAR(30) NOT NULL,
	Estado_S BIT DEFAULT 1,
	CONSTRAINT PK_Sucursales PRIMARY KEY (CodSucursal_S)
)
GO

CREATE TABLE Suc_X_Prod(
	CodProducto_SxP CHAR(8) NOT NULL,
	CodSucursal_SxP CHAR(8) NOT NULL,
	CONSTRAINT PK_Sucursales_X_Productos PRIMARY KEY (CodProducto_SxP, CodSucursal_SxP),
	CONSTRAINT FK_Suc_X_Prod_Productos FOREIGN KEY (CodProducto_SxP) REFERENCES Productos (CodProducto_P),
	CONSTRAINT FK_Suc_X_Prod_Sucursales FOREIGN KEY (CodSucursal_SxP) REFERENCES Sucursales (CodSucursal_S),
)
GO

CREATE TABLE Clientes(
	CodCliente_C CHAR(8) NOT NULL,
	Nombre_C VARCHAR(30) NOT NULL,
	Apellido_C VARCHAR(30) NOT NULL,
	Dni_C CHAR(8) NOT NULL,
	Telefono_C CHAR(10) NOT NULL,
	Estado_C BIT DEFAULT 1,
	CONSTRAINT PK_Clientes PRIMARY KEY (CodCliente_C)
)
GO

CREATE TABLE Ventas(
	NroFactura_V INT IDENTITY(1,1) NOT NULL,
    CodCliente_V CHAR(8) NOT NULL,
	CodSucursal_V CHAR(8) NOT NULL,
    Fecha_V DATE NOT NULL,
	MetodoDePago_V VARCHAR(30) NOT NULL,
    Total_V DECIMAL NOT NULL,
	Estado_V BIT DEFAULT 1,
	CONSTRAINT PK_Ventas PRIMARY KEY (NroFactura_V),
	CONSTRAINT FK_Ventas_Clientes FOREIGN KEY (CodCliente_V) REFERENCES Clientes(CodCliente_C),
	CONSTRAINT FK_Ventas_Sucursales FOREIGN KEY (CodSucursal_V) REFERENCES Sucursales(CodSucursal_S),
)
GO

CREATE TABLE Detalle_Venta(
	NroFactura_DV INT NOT NULL,
    CodProducto_DV CHAR(8) NOT NULL,
	CodSucursal_DV CHAR(8) NOT NULL,
    Cantidad_DV INT NOT NULL,
    PrecioUnitario_DV DECIMAL NOT NULL,
	CONSTRAINT PK_Detalle_Venta PRIMARY KEY (NroFactura_DV,CodProducto_DV,CodSucursal_DV),
	CONSTRAINT FK_Detalle_Venta_Factura FOREIGN KEY (NroFactura_DV) REFERENCES Ventas(NroFactura_V),
	CONSTRAINT FK_Detalle_Venta_Productos FOREIGN KEY (CodProducto_DV) REFERENCES Productos(CodProducto_P),
	CONSTRAINT FK_Detalle_Venta_Sucursales FOREIGN KEY (CodSucursal_DV) REFERENCES Sucursales(CodSucursal_S)
)
GO

--CARGA DE DATOS

INSERT INTO Categorias (CodCategoria_Ct,Nombre_Ct)
SELECT '1','Comida' UNION
SELECT '2','Bebida' UNION
SELECT '3','Combo' UNION
SELECT '4','Postre' UNION
SELECT '5','Desayuno'UNION
SELECT '6','Almuerzo'
GO

INSERT INTO Tipos (CodTipo_T,Nombre_T)
SELECT '1','Sin gluten' UNION
SELECT '2','Alto en proteínas' UNION
SELECT '3','Sin lactosa' UNION
SELECT '4','Sin azúcar' UNION
SELECT '5','Vegano'UNION
SELECT '6','Vegetariano'
GO

INSERT INTO Productos (CodProducto_P, CodCategoria_P, CodTipo_P, Stock_P, NombreProducto_P, Descripcion_P,PrecioUnitario_P)
SELECT '1000',1,5,110, 'Hamburguesa Vegana', 'Deliciosa hamburguesa vegana con remolacha, salsa de aguacate y lechuga', 800.00 UNION
SELECT '1001',1,1,280, 'Ensalada de Espinacas', 'Ensalada fresca con espinacas, nueces y queso', 700.00 UNION
SELECT '1002',2,3,100, 'Agua Mineral con Gas', 'Botella de agua mineral con gas Bonaqua 500ml', 150.00 UNION
SELECT '1003',2,4,150, 'Zumo de Naranja Natural', 'Zumo recién exprimido de naranja', 250.00 UNION
SELECT '1004',3,2,300, 'Combo de Hamburguesa', 'Hamburguesa, patatas y refresco grande', 1200.00 UNION
SELECT '1005',2,3,90, 'Leche de Almendra', 'Leche vegetal de almendra sin lactosa', 400.00 UNION
SELECT '1006',5,6,50, 'Desayuno Continental', 'Croissant, café, jugo de naranja y frutas frescas', 500.00 UNION
SELECT '1007',6,2,300, 'Menú Ejecutivo', 'Plato del día con guarnición y bebida', 1500.00 
GO

INSERT INTO Sucursales(CodSucursal_S,Localidad_S)
SELECT '11111111','General Pacheco' UNION
SELECT '22222222','Martinez' UNION
SELECT '33333333','Olivos'
GO

INSERT INTO Suc_X_Prod(CodProducto_SxP,CodSucursal_SxP)
SELECT '1000','11111111' UNION
SELECT '1001','11111111' UNION
SELECT '1002','11111111' UNION
SELECT '1004','11111111' UNION
SELECT '1005','11111111' UNION
SELECT '1006','11111111' UNION
SELECT '1007','11111111' UNION
SELECT '1000','22222222' UNION
SELECT '1001','22222222' UNION
SELECT '1002','22222222' UNION
SELECT '1003','22222222' UNION
SELECT '1005','22222222' UNION
SELECT '1006','22222222' UNION
SELECT '1000','33333333' UNION
SELECT '1001','33333333' UNION
SELECT '1002','33333333' UNION
SELECT '1003','33333333' UNION
SELECT '1004','33333333' UNION
SELECT '1005','33333333' UNION
SELECT '1006','33333333' UNION
SELECT '1007','33333333' 
GO

INSERT INTO Clientes(CodCliente_C,Nombre_C, Apellido_C,Dni_C,Telefono_C)
SELECT '9999','Marcela','Perez','121212','123456' UNION
SELECT '9998','Gustavo','Gimenez','131313','123456' UNION
SELECT '9997','Claudia','Gonzalez','141414','123456' UNION
SELECT '9996','Juan','Fernandez','141414','123456' UNION
SELECT '9995','Luciana','Lopez','151515','123456' UNION
SELECT '9994','Andres','Varela','161616','123456' UNION
SELECT '9993','Micaela','Rodriguez','171717','123456' UNION
SELECT '9992','Marcos','Mitre','181818','123456' 
GO

INSERT INTO Ventas(CodCliente_V,CodSucursal_V, Fecha_V,MetodoDePago_V,Total_V)
SELECT '9999','11111111','2023-01-05','Efectivo','2000' UNION
SELECT '9998','33333333','2023-07-15','Tarjeta debito','1200' UNION
SELECT '9997','33333333','2023-06-07','Tarjeta credito','950' UNION
SELECT '9996','11111111','2023-08-13','Tarjeta debito','1600' UNION
SELECT '9996','33333333','2023-05-22','Tarjeta credito','3200' UNION
SELECT '9994','33333333','2023-01-13','Efectivo','5600' UNION
SELECT '9993','11111111','2023-07-15','Tarjeta debito','3600' UNION
SELECT '9992','22222222','2023-09-03','Efectivo','2000' 
GO

INSERT INTO Detalle_Venta(NroFactura_DV,CodProducto_DV, CodSucursal_DV,Cantidad_DV,PrecioUnitario_DV)
SELECT '1','1000','11111111','2','800' UNION
SELECT '1','1005','11111111','1','400' UNION
SELECT '2','1004','33333333','3','1200' UNION
SELECT '3','1004','33333333','3','1200' UNION
SELECT '3','1003','33333333','2','250' UNION
SELECT '3','1006','33333333','3','500' UNION
SELECT '4','1000','11111111','4','800' UNION
SELECT '5','1000','11111111','2','800' UNION
SELECT '6','1002','22222222','1','150' UNION
SELECT '6','1006','22222222','2','400' UNION
SELECT '7','1004','11111111','1','1200' UNION
SELECT '8','1005','11111111','5','400' 
GO

-- Consultas 

-- Lista los productos de una sucursal determinada
SELECT p.NombreProducto_P, p.PrecioUnitario_P, s.Localidad_S
FROM (Productos p INNER JOIN Suc_X_Prod sxp ON p.CodProducto_P = sxp.CodProducto_SxP)
INNER JOIN Sucursales s ON sxp.CodSucursal_SxP = s.CodSucursal_S
WHERE s.CodSucursal_S = '11111111'
GO


--  Muestra las ventas realizadas en una fecha específica junto con los detalles

SELECT v.NroFactura_V, v.Fecha_V, p.NombreProducto_P, dv.Cantidad_DV, dv.PrecioUnitario_DV, Total_V
FROM (Ventas v INNER JOIN Detalle_Venta dv ON v.NroFactura_V = dv.NroFactura_DV)
INNER JOIN Productos p ON dv.CodProducto_DV = p.CodProducto_P
WHERE v.Fecha_V = '2023-07-15'
GO

-- Lista los clientes que realizaron compras en una sucursal determinada

SELECT c.Nombre_C, c.Apellido_C, s.Localidad_S
FROM Clientes c INNER JOIN Ventas v ON c.CodCliente_C = v.CodCliente_V
INNER JOIN Sucursales s ON v.CodSucursal_V = s.CodSucursal_S
WHERE s.CodSucursal_S = '33333333'
GO

-- Procedimientos almacenados

-- procedimiento para insertar un nuevo producto

CREATE PROCEDURE InsertarProducto
    @Categoria CHAR(8),
    @Tipo CHAR(8),
    @Stock INT,
    @Nombre VARCHAR(30),
    @Descripcion VARCHAR(100),
    @Precio DECIMAL
AS
BEGIN
    INSERT INTO Productos ( CodCategoria_P, CodTipo_P, Stock_P, NombreProducto_P, Descripcion_P, PrecioUnitario_P)
    VALUES (@Categoria, @Tipo, @Stock, @Nombre, @Descripcion, @Precio)
END
GO

-- Procedimiento para actualizar el stock de un producto

CREATE PROCEDURE ActualizarStock
    @CodigoProducto CHAR(8),
    @NuevoStock INT
AS
BEGIN
    UPDATE Productos
    SET Stock_P = @NuevoStock
    WHERE CodProducto_P = @CodigoProducto
END
GO

--AGREGAR DETALLE VENTA
CREATE PROCEDURE spAgregarDetalleVentas(
@CodProducto_Pr_DV CHAR(8),
@CodSucursal_DV CHAR(8),
@cantidad INT,
@PrecioUnitario decimal(18, 0)
)
AS
INSERT INTO Detalle_Venta(NroFactura_DV,CodProducto_DV,CodSucursal_DV,Cantidad_DV,PrecioUnitario_DV)
VALUES((SELECT MAX(NroFactura_V)FROM Ventas),@CodProducto_Pr_DV,@CodSucursal_DV,@cantidad,@PrecioUnitario)
RETURN
GO

/*EDITAR PRODUCTO*/
CREATE PROCEDURE spEditarProducto
(
@CodProducto_Pr CHAR(8),
@CodCategoria_Ct_Pr CHAR(8),
@CodTipoProducto_T_Pr CHAR(8),
@stock_Pr Int,
@NombreProducto_Pr VARCHAR(30),
@Descripcion_Pr VARCHAR (100),
@PrecioUnitario_Pr DECIMAL,
@Estado_Pr BIT
)
AS
UPDATE Productos
SET
CodCategoria_P = @CodCategoria_Ct_Pr,
CodTipo_P = @CodTipoProducto_T_Pr,
stock_P = @stock_Pr,
NombreProducto_P = @NombreProducto_Pr,
Descripcion_P = @Descripcion_Pr,
PrecioUnitario_P = @PrecioUnitario_Pr,
Estado_Pr = @Estado_Pr
WHERE CodProducto_P = @CodProducto_Pr
RETURN
GO

/*ELIMINAR PRODUCTO*/
CREATE PROCEDURE spEliminarProducto
(
@CodProducto_Pr CHAR(8)
)
AS
UPDATE Productos
SET Estado_Pr = 0
WHERE CodProducto_P = @CodProducto_Pr
RETURN
GO

-- trigger para actualizar el total de una factura.

CREATE TRIGGER TrActualizarToT
ON Detalle_Venta
AFTER INSERT
AS 
BEGIN
SET NOCOUNT ON;
		UPDATE Ventas SET Total_V = Total_V + (SELECT Cantidad_DV * PrecioUnitario_DV
												FROM inserted)
		where NroFactura_V = (SELECT NroFactura_DV FROM inserted)
END
GO

-- trigger para actualizar el stock de un producto.

CREATE TRIGGER TrActualizarStock
ON Detalle_Venta
AFTER INSERT
AS
BEGIN
SET NOCOUNT ON;
UPDATE Productos set Stock_P = Stock_P - (SELECT TOP 1 Cantidad_DV 
											FROM INSERTED)
where CodProducto_P = (SELECT TOP 1 CodProducto_DV
						FROM INSERTED)
END
GO
