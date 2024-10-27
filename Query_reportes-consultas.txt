--CREACIÓN DE REPORTES

CREATE TABLE auditoria (
    id_auditoria INT IDENTITY(1,1) PRIMARY KEY,
    tabla NVARCHAR(255),
    id_registro INT,
    tipo_cambio NVARCHAR(50),  -- Ej: 'INSERT', 'UPDATE', 'DELETE'
    fecha_cambio DATETIME2 DEFAULT GETDATE(),
    usuario NVARCHAR(255),
    detalles NVARCHAR(MAX)
);
GO

-- Trigger para INSERT en la tabla producto
CREATE TRIGGER trg_auditoria_producto_insert
ON producto
AFTER INSERT
AS
BEGIN
    INSERT INTO auditoria (tabla, id_registro, tipo_cambio, usuario, detalles)
    SELECT 
        'producto',
        id_producto,
        'INSERT',
        SYSTEM_USER,
        CONCAT('Modelo: ', i.id_modelo, ', Número Serie: ', i.numero_serie, ', Número Orden: ', i.numero_orden)
    FROM inserted i;
END;
GO

-- Trigger para UPDATE en la tabla producto
CREATE TRIGGER trg_auditoria_producto_update
ON producto
AFTER UPDATE
AS
BEGIN
    INSERT INTO auditoria (tabla, id_registro, tipo_cambio, usuario, detalles)
    SELECT 
        'producto',
        i.id_producto,  -- Aquí especificamos que el id_producto proviene de "inserted" como "i"
        'UPDATE',
        SYSTEM_USER,
        CONCAT('Modelo: ', d.id_modelo, ' actualizado a ', i.id_modelo, 
               ', Número Serie: ', d.numero_serie, ' actualizado a ', i.numero_serie)
    FROM deleted d
    INNER JOIN inserted i ON d.id_producto = i.id_producto;
END;
GO


-- Trigger para DELETE en la tabla producto
CREATE TRIGGER trg_auditoria_producto_delete
ON producto
AFTER DELETE
AS
BEGIN
    INSERT INTO auditoria (tabla, id_registro, tipo_cambio, usuario, detalles)
    SELECT 
        'producto',
        id_producto,
        'DELETE',
        SYSTEM_USER,
        CONCAT('Modelo: ', d.id_modelo, ', Número Serie: ', d.numero_serie, ', Número Orden: ', d.numero_orden)
    FROM deleted d;
END;
GO

---------------------------------------------------------------------------

SELECT 
    id_auditoria AS "ID Auditoría",
    tabla AS "Tabla Afectada",
    id_registro AS "ID del Registro",
    tipo_cambio AS "Tipo de Cambio",
    fecha_cambio AS "Fecha/Hora del Cambio",
    usuario AS "Usuario",
    detalles AS "Detalles del Cambio"
FROM 
    auditoria
WHERE 
    fecha_cambio >= DATEADD(DAY, -1, GETDATE())
ORDER BY 
    fecha_cambio DESC;
