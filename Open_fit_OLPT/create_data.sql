-- Insertar 1000 filas aleatorias en cliente_suscripcion
INSERT INTO cliente_suscripcion (cliente_id, suscripcion_id, dias_restantes, fecha_inicio, fecha_fin)
SELECT
    -- cliente_id aleatorio entre 1 y 10, con pesos para dar más filas a algunos clientes
    CASE
        WHEN RAND(CHECKSUM(NEWID())) < 0.3 THEN FLOOR(RAND(CHECKSUM(NEWID())) * 5) + 1 -- Clientes más frecuentes (1 a 5)
        ELSE FLOOR(RAND(CHECKSUM(NEWID())) * 5) + 6 -- Clientes menos frecuentes (6 a 10)
    END AS cliente_id,
    
    -- suscripcion_id aleatorio entre 1 y 5
    CASE
        WHEN RAND(CHECKSUM(NEWID())) < 0.5 THEN 1 -- Mayor tendencia hacia suscripcion_id 1
        ELSE FLOOR(RAND(CHECKSUM(NEWID())) * 4) + 2
    END AS suscripcion_id,
    
    -- dias_restantes aleatorio entre 1 y 365
    FLOOR(RAND(CHECKSUM(NEWID())) * 365) + 1 AS dias_restantes,
    
    -- fecha_inicio aleatoria dentro del último año
    DATEADD(DAY, FLOOR(RAND(CHECKSUM(NEWID())) * 365), '2023-01-01') AS fecha_inicio,
    
    -- fecha_fin aleatoria basada en fecha_inicio + número aleatorio de días
    DATEADD(DAY, FLOOR(RAND(CHECKSUM(NEWID())) * 365), DATEADD(DAY, FLOOR(RAND(CHECKSUM(NEWID())) * 365), '2023-01-01')) AS fecha_fin
FROM
    -- Usar una tabla dummy con suficientes filas para generar 1000 filas de datos
    (SELECT TOP (1000) 1 AS n FROM sys.columns) AS dummy;


-- Insertar 1000 filas en transacciones, coincidiendo con cliente_suscripcion
INSERT INTO transacciones (importe, datos_pagos_id, cliente_suscripcion_id, fecha_importe)
SELECT
    -- Importe: Mayor dias_restantes resulta en mayor pago
    CASE
        WHEN cs.dias_restantes >= 300 THEN 100 + (RAND(CHECKSUM(NEWID())) * 50) -- Pago alto para más de 300 días
        WHEN cs.dias_restantes >= 200 THEN 70 + (RAND(CHECKSUM(NEWID())) * 30)  -- Pago medio-alto para 200-299 días
        WHEN cs.dias_restantes >= 100 THEN 50 + (RAND(CHECKSUM(NEWID())) * 20)  -- Pago medio para 100-199 días
        ELSE 20 + (RAND(CHECKSUM(NEWID())) * 30)                               -- Pago bajo para menos de 100 días
    END AS importe,
    
    CASE
        WHEN RAND(CHECKSUM(NEWID())) < 0.4 THEN 1  -- Mayor tendencia a 'Tarjeta de Crédito'
        WHEN RAND(CHECKSUM(NEWID())) < 0.6 THEN 2  -- Alguna tendencia a 'Efectivo'
        ELSE FLOOR(RAND(CHECKSUM(NEWID())) * 2) + 3 -- Otros métodos de pago ('Transferencia Bancaria', 'PayPal')
    END AS datos_pagos_id,

    -- Coincidir cliente_suscripcion_id
    cs.id AS cliente_suscripcion_id,

    -- fecha_importe aleatoria basada en la fecha_inicio de la suscripción
    DATEADD(DAY, FLOOR(RAND(CHECKSUM(NEWID())) * 30), cs.fecha_inicio) AS fecha_importe
FROM 
    cliente_suscripcion cs
ORDER BY NEWID(); -- Aleatorizar el orden para asegurar variedad
