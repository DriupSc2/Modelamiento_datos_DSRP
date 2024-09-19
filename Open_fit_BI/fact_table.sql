--
SELECT
    t.id AS transaccion_id,
    cs.cliente_id AS cliente_id,
    cs.suscripcion_id AS suscripcion_id,
    t.datos_pagos_id AS datos_pagos_id,
    t.importe AS importe,
    df.fecha_id AS fecha_id,
    cs.dias_restantes AS dias_restantes,
    t.fecha_importe AS fecha_importe
INTO #temp_transacciones
FROM transacciones t
INNER JOIN cliente_suscripcion cs ON t.cliente_suscripcion_id = cs.id
INNER JOIN datamart_open_fit.dbo.dim_fecha df ON CAST(t.fecha_importe AS DATE) = df.fecha
WHERE t.fecha_importe IS NOT NULL;


--

SELECT transaccion_id, COUNT(*)
FROM #temp_transacciones
GROUP BY transaccion_id
HAVING COUNT(*) > 1;
--

;WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY transaccion_id ORDER BY (SELECT NULL)) AS rn
    FROM #temp_transacciones
)
DELETE FROM CTE
WHERE rn > 1;


-- Paso 2: Insertar en la tabla de hechos

INSERT INTO datamart_open_fit.dbo.fact_transacciones
(transaccion_id, cliente_id, suscripcion_id, datos_pagos_id, importe, fecha_id, dias_restantes, fecha_importe)
SELECT
    t.transaccion_id,
    t.cliente_id,
    t.suscripcion_id,
    t.datos_pagos_id,
    t.importe,
    t.fecha_id,
    t.dias_restantes,
    t.fecha_importe
FROM #temp_transacciones t;

DROP TABLE #temp_transacciones;
SELECT * FROM datamart_open_fit.dbo.fact_transacciones;


