CREATE TABLE roles_usuario (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(255) NOT NULL,
    email_usuario VARCHAR(255) UNIQUE NOT NULL,
    password_usuario VARCHAR(255) NOT NULL,
    id_rol INT,
    CONSTRAINT FK_rol_usuario FOREIGN KEY (id_rol) REFERENCES roles_usuario(id_rol)
);

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_cliente VARCHAR(255) NOT NULL,
    email_cliente VARCHAR(255) NULL,
    telefono_cliente VARCHAR(20) NULL
);

CREATE TABLE estado_producto (
    id_status INT AUTO_INCREMENT PRIMARY KEY,
    nombre_status VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE modelo_pr (
    id_modelo INT AUTO_INCREMENT PRIMARY KEY,
    nombre_modelo VARCHAR(120) NOT NULL UNIQUE 
);

CREATE TABLE plantas (
    id_planta INT AUTO_INCREMENT PRIMARY KEY,
    nombre_planta VARCHAR(100) NOT NULL UNIQUE,
    ancho_estacionamiento DECIMAL(10, 2) NULL,
    largo_estacionamiento DECIMAL(10, 2) NULL
);

CREATE TABLE secciones (
    id_seccion INT AUTO_INCREMENT PRIMARY KEY,
    nombre_seccion VARCHAR(50) NOT NULL,
    ancho_seccion DECIMAL(10, 2) NULL,
    largo_seccion DECIMAL(10, 2) NULL,
    cantidad_cajones INT NULL
);

CREATE TABLE estados (
    id_estado INT AUTO_INCREMENT PRIMARY KEY,
    nombre_estado VARCHAR(50) NOT NULL
);

CREATE TABLE cajones (
    id_cajon INT AUTO_INCREMENT PRIMARY KEY,
    numero_cajon VARCHAR(50) NOT NULL,
    id_estado INT,
    id_seccion INT,
    CONSTRAINT FK_estado_cajon FOREIGN KEY (id_estado) REFERENCES estados(id_estado),
    CONSTRAINT FK_seccion_cajon FOREIGN KEY (id_seccion) REFERENCES secciones(id_seccion)
);

CREATE TABLE empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    telefono VARCHAR(20) NULL,
    id_planta INT,
    CONSTRAINT FK_planta_empleado FOREIGN KEY (id_planta) REFERENCES plantas(id_planta)
);

CREATE TABLE producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    id_modelo INT,
    numero_serie INT NOT NULL,
    numero_orden INT NOT NULL,
    placa VARCHAR(20) NULL,
    id_seccion INT,  -- Referencia a la tabla secciones
    id_cajon INT,    -- Referencia a la tabla cajones
    id_estado INT,    -- Referencia a la tabla estados
    id_operador INT,  -- Referencia a la tabla empleados
    id_planta INT,    -- Referencia a la tabla plantas
    CONSTRAINT FK_modelo_producto FOREIGN KEY (id_modelo) REFERENCES modelo_pr(id_modelo),
    CONSTRAINT FK_seccion_producto FOREIGN KEY (id_seccion) REFERENCES secciones(id_seccion),
    CONSTRAINT FK_cajon_producto FOREIGN KEY (id_cajon) REFERENCES cajones(id_cajon),
    CONSTRAINT FK_estado_producto FOREIGN KEY (id_estado) REFERENCES estados(id_estado),
    CONSTRAINT FK_operador_producto FOREIGN KEY (id_operador) REFERENCES empleados(id_empleado),
    CONSTRAINT FK_planta_producto FOREIGN KEY (id_planta) REFERENCES plantas(id_planta),
    hora_entrada DATETIME NULL,
    hora_salida DATETIME NULL,
    codigo_barra VARCHAR(50) UNIQUE
);
