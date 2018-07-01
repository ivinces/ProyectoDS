/*CREATE database ProyectoDS;*/
USE ProyectoDS;
CREATE TABLE Locales(
IDLocales int NOT NULL,
Nombre varchar(50),
Direccion varchar(100),
Telefono varchar(10),
Internet INT,
PRIMARY KEY(IDLocales),
CONSTRAINT CHKInternet CHECK (Internet=1 OR Internet=0)
);
CREATE TABLE Articulos(
IDArticulos int NOT NULL,
Marca varchar(50),
Modelo varchar(50),
Precio float,
Color varchar(50),
IDLocales int NOT NULL,
PRIMARY KEY(IDArticulos),
FOREIGN KEY(IDLocales) REFERENCES Locales(IDLocales)
);
CREATE TABLE Cocinas(
IDCocina int NOT NULL,
Induccion int,
IDArticulos int NOT NULL,
PRIMARY KEY(IDCocina),
CONSTRAINT CHKInduccion CHECK (Induccion=1 OR Induccion=0),
FOREIGN KEY(IDArticulos) REFERENCES Articulos(IDArticulos)
);
CREATE TABLE Refrigeradoras(
IDRefrigeradora int NOT NULL,
IDArticulos int NOT NULL,
PRIMARY KEY(IDRefrigeradora),
FOREIGN KEY(IDArticulos) REFERENCES Articulos(IDArticulos)
);
CREATE TABLE Lavadoras(
IDLavadoras int NOT NULL,
IDArticulos int NOT NULL,
PRIMARY KEY(IDLavadoras),
FOREIGN KEY(IDArticulos) REFERENCES Articulos(IDArticulos)
);
CREATE TABLE Personas(
IDPersonas int NOT NULL,
Nombre varchar(50),
Apellido varchar(50),
Cedula varchar(10),
Telefono varchar(10),
Direccion varchar(100),
PRIMARY KEY(IDPersonas)
);
CREATE TABLE Usuarios(
Usuario varchar(50) NOT NULL,
Clave varchar(50) NOT NULL,
IDPersonas int NOT NULL,
IDLocales int NOT NULL,
PRIMARY KEY(Usuario),
FOREIGN KEY(IDLocales) REFERENCES Locales(IDLocales),
FOREIGN KEY(IDPersonas) REFERENCES Personas(IDPersonas)
);
CREATE TABLE Administrador(
IDAdmin int NOT NULL,
Usuario varchar(50) NOT NULL,
PRIMARY KEY(IDAdmin),
FOREIGN KEY(Usuario) REFERENCES Usuarios(Usuario)
);
CREATE TABLE Gerente(
IDGerente int NOT NULL,
Usuario varchar(50) NOT NULL,
PRIMARY KEY(IDGerente),
FOREIGN KEY(Usuario) REFERENCES Usuarios(Usuario)
);
CREATE TABLE Vendedor(
IDVendedor int NOT NULL,
Usuario varchar(50) NOT NULL,
PRIMARY KEY(IDVendedor),
FOREIGN KEY(Usuario) REFERENCES Usuarios(Usuario)
);
CREATE TABLE Cliente(
IDCliente int NOT NULL,
Correo varchar(50) NOT NULL,
IDPersonas int NOT NULL,
IDLocales int NOT NULL,
IDVendedor int NOT NULL,
PRIMARY KEY(IDCliente),
FOREIGN KEY(IDLocales) REFERENCES Locales(IDLocales),
FOREIGN KEY(IDPersonas) REFERENCES Personas(IDPersonas),
FOREIGN KEY(IDVendedor) REFERENCES Vendedor(IDVendedor)
);
CREATE TABLE Documentos(
IDDoc int NOT NULL,
Ruc varchar(13),
IDCliente int NOT NULL,
Fecha Date,
Codigo varchar(15),
IDLocales int NOT NULL,
PRIMARY KEY(IDDoc),
FOREIGN KEY(IDLocales) REFERENCES Locales(IDLocales),
FOREIGN KEY(IDCliente) REFERENCES Cliente(IDCliente),
);
CREATE TABLE Facturas(
IDFacturas int NOT NULL,
IDDoc int NOT NULL,
Valor float,
IVA float,
ValorFinal float,
PRIMARY KEY(IDFacturas),
FOREIGN KEY(IDDoc) REFERENCES Documentos(IDDoc)
);
CREATE TABLE NotasCredito(
IDNCredito int NOT NULL,
IDDoc int NOT NULL,
Valor float,
Devolucion varchar(100),
Descripcion varchar(100),
PRIMARY KEY(IDNCredito),
FOREIGN KEY(IDDoc) REFERENCES Documentos(IDDoc)
);
CREATE TABLE ComprobanteRetencion(
IDCRentencion int NOT NULL,
IDDoc int NOT NULL,
Impuesto float,
PRIMARY KEY(IDCRentencion),
FOREIGN KEY(IDDoc) REFERENCES Documentos(IDDoc)
);
CREATE TABLE Transaccion(
IDTRANS int NOT NULL,
Fecha date,
Hora Datetime,
IDCliente int NOT NULL,
PRIMARY KEY(IDTRANS),
FOREIGN KEY(IDCliente) REFERENCES Cliente(IDCliente)
);
CREATE TABLE Pago(
IDPago int NOT NULL,
Tipo varchar(50),
ValorPagado float,
Saldo float,
IDTRANS int NOT NULL,
IDVendedor int NOT NULL,
PRIMARY KEY(IDPago),
FOREIGN KEY(IDTRANS) REFERENCES Transaccion(IDTRANS),
FOREIGN KEY(IDVendedor) REFERENCES Vendedor(IDVendedor),
CONSTRAINT CHKTipo CHECK (Tipo='Efectivo' OR Tipo='Visa'),
);
CREATE TABLE Ventas(
IDVentas int NOT NULL,
PrecioFinal float,
IDPago int NOT NULL,
IDArticulos int NOT NULL,
IDTRANS int NOT NULL,
IDVendedor int NOT NULL,
PRIMARY KEY(IDVentas),
FOREIGN KEY(IDTRANS) REFERENCES Transaccion(IDTRANS),
FOREIGN KEY(IDVendedor) REFERENCES Vendedor(IDVendedor),
FOREIGN KEY(IDArticulos) REFERENCES Articulos(IDArticulos),
FOREIGN KEY(IDPago) REFERENCES Pago(IDPago)
);
CREATE TABLE Cotizaciones(
IDCotizacion int NOT NULL,
PrecioFinal float,
IDArticulos int NOT NULL,
IDTRANS int NOT NULL,
IDVendedor int NOT NULL,
PRIMARY KEY(IDCotizacion),
FOREIGN KEY(IDTRANS) REFERENCES Transaccion(IDTRANS),
FOREIGN KEY(IDVendedor) REFERENCES Vendedor(IDVendedor),
FOREIGN KEY(IDArticulos) REFERENCES Articulos(IDArticulos)
);