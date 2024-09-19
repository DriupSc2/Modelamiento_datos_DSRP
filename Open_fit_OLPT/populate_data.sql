INSERT INTO clientes (nombre, apellido_paterno, apellido_materno, edad, telefono, dni, observacion)
VALUES
('GIANMARCO ENDERSON', 'CORNEJO', 'ZAIRA', 30, '987654321', '12345678', 'Cliente activo'),
('ELISEA ETERIA', 'QUISPE', 'YAPO', 28, '987654322', '22345679', 'Consulta mensual'),
('VALDEMARD', 'CHINO', 'RAMIREZ', 35, '987654323', '32345670', 'Cliente con alta demanda'),
('ALEX ELMER', 'PÉREZ', 'PACOMPIA', 22, '987654324', '42345671', 'Requiere seguimiento'),
('LILIBET MARIA', 'ATO', 'RAYMUNDO', 29, '987654325', '52345672', 'Cliente nuevo'),
('JUAN RODRIGO', 'VILLALTA', 'VILCA', 40, '987654326', '62345673', 'Cliente leal'),
('EDMUNDO JAVIER', 'MUÑOZ', 'BARRIENTOS', 45, '987654327', '72345674', 'Historial de pagos atrasados'),
('ELVIS JHORDY', 'TIPULA', 'TICONA', 33, '987654328', '82345675', 'Preferencia por servicios premium'),
('MOISES', 'CONDORI', 'CHAÑI', 38, '987654329', '92345676', 'Cliente que asiste regularmente'),
('ARNALDO', 'YANA', 'TORRES', 27, '987654330', '10234567', 'Cliente ocasional');


INSERT INTO suscripcion (programa)
VALUES
('Personalizado'),
('Semipersonalizado'),
('Maquinas'),
('Xbox'),
('Baile');


INSERT INTO datos_pagos (tipo_pago)
VALUES
('Tarjeta de Crédito'),
('Efectivo'),
('Transferencia Bancaria'),
('Yape'),
('Plin');


SELECT TOP (1000) [id]
      ,[importe]
      ,[datos_pagos_id]
      ,[cliente_suscripcion_id]
      ,[fecha_importe]
      ,[created_at]
      ,[updated_at]
      ,[deleted_at]
  FROM [open_fit_db].[dbo].[transacciones]


UPDATE transacciones
SET importe = importe * 3.77;