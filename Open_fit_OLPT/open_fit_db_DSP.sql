-- Creating the 'clientes' table
CREATE TABLE clientes
(
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(MAX) NOT NULL,
    apellido_paterno NVARCHAR(MAX) NOT NULL,
    apellido_materno NVARCHAR(MAX) NOT NULL,
    edad INT NOT NULL,
    telefono NVARCHAR(MAX) NOT NULL,
    dni NVARCHAR(MAX) NOT NULL,
    observacion NVARCHAR(MAX)
);

-- Creating the 'usuarios' table
CREATE TABLE usuarios
(
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    email NVARCHAR(MAX) NOT NULL,
    password NVARCHAR(MAX) NOT NULL,
    nombres NVARCHAR(MAX) NOT NULL,
    apellido_paterno NVARCHAR(MAX) NOT NULL,
    apellido_materno NVARCHAR(MAX) NOT NULL,
    rol NVARCHAR(MAX) NOT NULL,
    telefono NVARCHAR(MAX),
    fecha_creacion DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET(),
    estado NVARCHAR(MAX) NOT NULL
);

-- Creating the 'suscripcion' table
CREATE TABLE suscripcion
(
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    programa NVARCHAR(MAX) NOT NULL
);

-- Creating the 'datos_pagos' table
CREATE TABLE datos_pagos
(
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    tipo_pago NVARCHAR(MAX) NOT NULL
);

-- Creating the 'cliente_suscripcion' table
CREATE TABLE cliente_suscripcion
(
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    cliente_id BIGINT NOT NULL,
    suscripcion_id BIGINT NOT NULL,
    dias_restantes INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    CONSTRAINT FK_cliente FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    CONSTRAINT FK_suscripcion FOREIGN KEY (suscripcion_id) REFERENCES suscripcion(id)
);

-- Creating the 'transacciones' table
CREATE TABLE transacciones
(
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    importe DECIMAL(18,2) NOT NULL,
    datos_pagos_id BIGINT NOT NULL,
    cliente_suscripcion_id BIGINT NOT NULL,
    fecha_importe DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET() NOT NULL,
    CONSTRAINT FK_datos_pagos FOREIGN KEY (datos_pagos_id) REFERENCES datos_pagos(id),
    CONSTRAINT FK_cliente_suscripcion FOREIGN KEY (cliente_suscripcion_id) REFERENCES cliente_suscripcion(id)
);

-- Creating the 'asistencias' table
CREATE TABLE asistencias
(
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    cliente_suscripcion_id BIGINT NOT NULL,
    fecha_asistencia DATE NOT NULL,
    hora_asistencia TIME NOT NULL,
    compensacion BIT NOT NULL,
    CONSTRAINT FK_asistencias FOREIGN KEY (cliente_suscripcion_id) REFERENCES cliente_suscripcion(id)
);




-- Adding created_at, updated_at, and deleted_at columns to transacciones table
ALTER TABLE transacciones
ADD created_at DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET() NOT NULL,
    updated_at DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET() NOT NULL,
    deleted_at DATETIMEOFFSET NULL;
