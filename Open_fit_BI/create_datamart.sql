CREATE TABLE dim_clientes (
    cliente_id             BIGINT PRIMARY KEY,
    nombre_completo        TEXT,
    telefono               TEXT,
    dni                    TEXT
);


CREATE TABLE dim_suscripcion (
    suscripcion_id         BIGINT PRIMARY KEY, 

CREATE TABLE dim_datos_pagos (
    datos_pagos_id         BIGINT PRIMARY KEY, 
    tipo_pago              TEXT
);


CREATE TABLE dim_fecha (
    fecha_id               INT PRIMARY KEY,
    fecha                  DATE,
	anio                   INT,              
    mes                    INT,              
    dia                    INT,              
    trimestre              INT,              
    semana_anio            INT,              
    dia_semana             VARCHAR(20),      
);


CREATE TABLE fact_transacciones (
    transaccion_id         BIGINT PRIMARY KEY,
    cliente_id             BIGINT, 
    suscripcion_id         BIGINT,
    datos_pagos_id         BIGINT, 
    importe                NUMERIC,
    fecha_id               INT,    
    dias_restantes         INT,    
    fecha_importe          DATETIMEOFFSET, 

    FOREIGN KEY (cliente_id) REFERENCES dim_clientes(cliente_id),
    FOREIGN KEY (suscripcion_id) REFERENCES dim_suscripcion(suscripcion_id),
    FOREIGN KEY (datos_pagos_id) REFERENCES dim_datos_pagos(datos_pagos_id),
    FOREIGN KEY (fecha_id) REFERENCES dim_fecha(fecha_id)
);