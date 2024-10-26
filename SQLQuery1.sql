CREATE DATABASE nju_problema3;
GO 

USE nju_problema3;
GO

CREATE TABLE roles_usuario (
	id_rol INT IDENTITY(1,1) PRIMARY KEY,
    nombre_rol NVARCHAR(60) NOT NULL UNIQUE
);
GO

CREATE TABLE usuarios (
    id_usuario INT IDENTITY(1,1) PRIMARY KEY,
    nombre_usuario NVARCHAR(255) NOT NULL,
    email_usuario NVARCHAR(255) UNIQUE NOT NULL,
    password_usuario NVARCHAR(255) NOT NULL,
    id_rol INT,
    CONSTRAINT FK_rol_usuario FOREIGN KEY (id_rol) REFERENCES roles_usuario(id_rol)
);
GO

CREATE TABLE clientes (
	id_cliente INT IDENTITY(1,1) PRIMARY KEY,
    nombre_cliente NVARCHAR(255) NOT NULL,
    email_cliente NVARCHAR(255) NULL,
    telefono_cliente NVARCHAR(20) NULL
);
GO

CREATE TABLE estado_producto (
	id_status INT IDENTITY(1,1) PRIMARY KEY,
    nombre_status NVARCHAR(60) NOT NULL UNIQUE
);
GO 

CREATE TABLE modelo_pr (
	id_modelo INT IDENTITY(1,1) PRIMARY KEY,
    nombre_modelo NVARCHAR(120) NOT NULL UNIQUE 
);
GO

CREATE TABLE secciones (
    id_seccion INT PRIMARY KEY IDENTITY(1,1),
    nombre_seccion NVARCHAR(50) NOT NULL
);
GO

CREATE TABLE estados (
    id_estado INT PRIMARY KEY IDENTITY(1,1),
    nombre_estado NVARCHAR(50) NOT NULL
);
GO

CREATE TABLE cajones (
    id_cajon INT PRIMARY KEY IDENTITY(1,1),
    numero_cajon NVARCHAR(50) NOT NULL,
    id_estado INT,
    id_seccion INT,
    CONSTRAINT FK_estado_cajon FOREIGN KEY (id_estado) REFERENCES estados(id_estado),
    CONSTRAINT FK_seccion_cajon FOREIGN KEY (id_seccion) REFERENCES secciones(id_seccion)
);
GO

CREATE TABLE empleados (
    id_empleado INT PRIMARY KEY IDENTITY(1,1),
    nombre NVARCHAR(100) NOT NULL,
    apellido NVARCHAR(100) NOT NULL,
    cargo NVARCHAR(50) NOT NULL,
    email NVARCHAR(255) NOT NULL UNIQUE,
    telefono NVARCHAR(20) NULL
);
GO

CREATE TABLE producto (
	id_producto INT IDENTITY(1,1) PRIMARY KEY,
	id_modelo INT,
	numero_serie INT NOT NULL,
	numero_orden INT NOT NULL,
	placa NVARCHAR(20) NULL,
	id_seccion INT,  -- Referencia a la tabla secciones
	id_cajon INT,    -- Referencia a la tabla cajones
	id_estado INT,   -- Referencia a la tabla estados
	id_operador INT, -- Referencia a la tabla empleados
    CONSTRAINT FK_modelo_producto FOREIGN KEY (id_modelo) REFERENCES modelo_pr(id_modelo),
	CONSTRAINT FK_seccion_producto FOREIGN KEY (id_seccion) REFERENCES secciones(id_seccion),
	CONSTRAINT FK_cajon_producto FOREIGN KEY (id_cajon) REFERENCES cajones(id_cajon),
	CONSTRAINT FK_estado_producto FOREIGN KEY (id_estado) REFERENCES estados(id_estado),
	CONSTRAINT FK_operador_producto FOREIGN KEY (id_operador) REFERENCES empleados(id_empleado)
);
GO

ALTER TABLE producto
ADD hora_entrada DATETIME2 NULL,
    hora_salida DATETIME2 NULL;
GO

-- Agregar el campo codigo_barra a la tabla empleados
ALTER TABLE empleados
ADD codigo_barra NVARCHAR(50) UNIQUE;
GO

-- Agregar el campo codigo_barra a la tabla producto
ALTER TABLE producto
ADD codigo_barra NVARCHAR(50) UNIQUE;
GO

----------------------------------------------------------------------------
----------------------------------------------------------------------------
CREATE TABLE plantas (
    id_planta INT PRIMARY KEY IDENTITY(1,1),
    nombre_planta NVARCHAR(100) NOT NULL UNIQUE
);
GO

-- Agregar el campo id_planta a la tabla producto
ALTER TABLE producto
ADD id_planta INT,
    CONSTRAINT FK_planta_producto FOREIGN KEY (id_planta) REFERENCES plantas(id_planta);
GO

-- Agregar el campo id_planta a la tabla empleados
ALTER TABLE empleados
ADD id_planta INT,
    CONSTRAINT FK_planta_empleado FOREIGN KEY (id_planta) REFERENCES plantas(id_planta);
GO

ALTER TABLE plantas
ADD ancho_estacionamiento DECIMAL(10, 2) NULL,
    largo_estacionamiento DECIMAL(10, 2) NULL;
GO

ALTER TABLE secciones
ADD ancho_seccion DECIMAL(10, 2) NULL,
    largo_seccion DECIMAL(10, 2) NULL;
GO

ALTER TABLE secciones
ADD cantidad_cajones INT NULL;
GO

