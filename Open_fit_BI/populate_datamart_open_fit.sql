-- poblar tabla clientes
INSERT INTO datamart_open_fit.dbo.dim_clientes (cliente_id, nombre_completo, telefono, dni)
SELECT 
    c.id AS cliente_id,
    CONCAT(c.nombre, ' ', c.apellido_paterno, ' ', c.apellido_materno) AS nombre_completo,
    c.telefono,
    c.dni
FROM open_fit_db.dbo.clientes c;

-- Poblar tabla suscripcion
INSERT INTO datamart_open_fit.dbo.dim_suscripcion (suscripcion_id, programa)
SELECT 
    s.id AS suscripcion_id,
    s.programa
FROM open_fit_db.dbo.suscripcion s;


-- Poblar tabla datos_pagos
INSERT INTO datamart_open_fit.dbo.dim_datos_pagos (datos_pagos_id, tipo_pago)
SELECT 
    dp.id AS datos_pagos_id,
    dp.tipo_pago
FROM open_fit_db.dbo.datos_pagos dp;

-- Poblar tabla dim_fecha
INSERT INTO datamart_open_fit.dbo.dim_fecha (fecha_id, fecha, anio, mes, dia, trimestre, semana_anio, dia_semana)
SELECT 
    ROW_NUMBER() OVER (ORDER BY t.fecha_importe) AS fecha_id,
    CAST(t.fecha_importe AS DATE) AS fecha,
    YEAR(t.fecha_importe) AS anio,
    MONTH(t.fecha_importe) AS mes,
    DAY(t.fecha_importe) AS dia,
    DATEPART(QUARTER, t.fecha_importe) AS trimestre,
    DATEPART(WEEK, t.fecha_importe) AS semana_anio,
    DATENAME(WEEKDAY, t.fecha_importe) AS dia_semana
FROM open_fit_db.dbo.transacciones t;


-- Poblar tabla fact_transacciones
