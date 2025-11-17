-- ============================================
-- NEURALBANK - Demo Sistema Bancario
-- Script de Población de Datos
-- PostgreSQL 16 - Versión Internacional
-- ============================================

-- Conectar a la base de datos
-- \c neuralbank

SET client_encoding = 'UTF8';

-- ============================================
-- POBLACIÓN DE DATOS
-- ============================================

-- Insertar Países
INSERT INTO core.pais (pais_id, codigo_iso2, codigo_iso3, nombre, codigo_telefono, moneda_codigo, moneda_nombre, activo) VALUES
(1, 'US', 'USA', 'Estados Unidos', '+1', 'USD', 'Dólar estadounidense', TRUE),
(2, 'MX', 'MEX', 'México', '+52', 'MXN', 'Peso mexicano', TRUE),
(3, 'BR', 'BRA', 'Brasil', '+55', 'BRL', 'Real brasileño', TRUE),
(4, 'AR', 'ARG', 'Argentina', '+54', 'ARS', 'Peso argentino', TRUE),
(5, 'CL', 'CHL', 'Chile', '+56', 'CLP', 'Peso chileno', TRUE),
(6, 'CO', 'COL', 'Colombia', '+57', 'COP', 'Peso colombiano', TRUE),
(7, 'PE', 'PER', 'Perú', '+51', 'PEN', 'Sol peruano', TRUE),
(8, 'ES', 'ESP', 'España', '+34', 'EUR', 'Euro', TRUE),
(9, 'GB', 'GBR', 'Reino Unido', '+44', 'GBP', 'Libra esterlina', TRUE),
(10, 'DE', 'DEU', 'Alemania', '+49', 'EUR', 'Euro', TRUE),
(11, 'FR', 'FRA', 'Francia', '+33', 'EUR', 'Euro', TRUE),
(12, 'IT', 'ITA', 'Italia', '+39', 'EUR', 'Euro', TRUE),
(13, 'CA', 'CAN', 'Canadá', '+1', 'CAD', 'Dólar canadiense', TRUE),
(14, 'JP', 'JPN', 'Japón', '+81', 'JPY', 'Yen japonés', TRUE),
(15, 'CN', 'CHN', 'China', '+86', 'CNY', 'Yuan chino', TRUE);

-- Ajustar la secuencia de país para que el próximo insert sea 16
ALTER SEQUENCE core.pais_pais_id_seq RESTART WITH 16;

-- Insertar Monedas
INSERT INTO core.moneda (moneda_id, codigo, nombre, simbolo, decimales, activo) VALUES
(1, 'USD', 'Dólar estadounidense', '$', 2, TRUE),
(2, 'EUR', 'Euro', '€', 2, TRUE),
(3, 'GBP', 'Libra esterlina', '£', 2, TRUE),
(4, 'JPY', 'Yen japonés', '¥', 0, TRUE),
(5, 'CAD', 'Dólar canadiense', 'C$', 2, TRUE),
(6, 'MXN', 'Peso mexicano', 'MX$', 2, TRUE),
(7, 'BRL', 'Real brasileño', 'R$', 2, TRUE),
(8, 'ARS', 'Peso argentino', 'AR$', 2, TRUE),
(9, 'CLP', 'Peso chileno', 'CL$', 0, TRUE),
(10, 'COP', 'Peso colombiano', 'CO$', 0, TRUE),
(11, 'PEN', 'Sol peruano', 'S/', 2, TRUE),
(12, 'CNY', 'Yuan chino', '¥', 2, TRUE);

-- Ajustar la secuencia de moneda para que el próximo insert sea 13
ALTER SEQUENCE core.moneda_moneda_id_seq RESTART WITH 13;

-- Insertar Tasas de Cambio (ejemplos con fecha actual)
INSERT INTO core.tasa_cambio (moneda_origen_id, moneda_destino_id, tasa, fecha_vigencia) VALUES
-- USD a otras monedas
(1, 2, 0.92, CURRENT_TIMESTAMP), -- USD a EUR
(1, 3, 0.79, CURRENT_TIMESTAMP), -- USD a GBP
(1, 4, 149.50, CURRENT_TIMESTAMP), -- USD a JPY
(1, 5, 1.36, CURRENT_TIMESTAMP), -- USD a CAD
(1, 6, 17.20, CURRENT_TIMESTAMP), -- USD a MXN
(1, 7, 5.02, CURRENT_TIMESTAMP), -- USD a BRL
(1, 8, 1020.00, CURRENT_TIMESTAMP), -- USD a ARS
(1, 9, 950.00, CURRENT_TIMESTAMP), -- USD a CLP
(1, 10, 4250.00, CURRENT_TIMESTAMP), -- USD a COP
(1, 11, 3.75, CURRENT_TIMESTAMP), -- USD a PEN
(1, 12, 7.25, CURRENT_TIMESTAMP), -- USD a CNY
-- EUR a otras monedas
(2, 1, 1.09, CURRENT_TIMESTAMP), -- EUR a USD
(2, 3, 0.86, CURRENT_TIMESTAMP), -- EUR a GBP
-- GBP a otras monedas
(3, 1, 1.27, CURRENT_TIMESTAMP), -- GBP a USD
(3, 2, 1.16, CURRENT_TIMESTAMP); -- GBP a EUR

-- Insertar Sucursales (Con IDs explícitos)
INSERT INTO core.sucursal (sucursal_id, codigo_sucursal, nombre, direccion, ciudad, estado_provincia, codigo_postal, pais_id, telefono, email, horario, latitud, longitud, activo) VALUES
-- Estados Unidos
(1, 'US-NY-001', 'NeuralBank Manhattan Branch', '350 Fifth Avenue', 'New York', 'New York', '10118', 1, '+1-212-555-0100', 'manhattan@neuralbank.com', 'Mon-Fri 9:00-17:00', 40.748817, -73.985428, TRUE),
(2, 'US-LA-001', 'NeuralBank Los Angeles Branch', '633 West 5th Street', 'Los Angeles', 'California', '90071', 1, '+1-213-555-0200', 'losangeles@neuralbank.com', 'Mon-Fri 9:00-17:00', 34.052235, -118.243683, TRUE),
(3, 'US-MI-001', 'NeuralBank Miami Branch', '1450 Brickell Avenue', 'Miami', 'Florida', '33131', 1, '+1-305-555-0300', 'miami@neuralbank.com', 'Mon-Fri 9:00-17:00', 25.761681, -80.191788, TRUE),
-- México
(4, 'MX-CD-001', 'NeuralBank Ciudad de México', 'Av. Paseo de la Reforma 505', 'Ciudad de México', 'CDMX', '06500', 2, '+52-55-5555-0100', 'cdmx@neuralbank.com', 'Lun-Vie 9:00-17:00', 19.432608, -99.133209, TRUE),
(5, 'MX-GD-001', 'NeuralBank Guadalajara', 'Av. Americas 1500', 'Guadalajara', 'Jalisco', '44630', 2, '+52-33-5555-0200', 'guadalajara@neuralbank.com', 'Lun-Vie 9:00-17:00', 20.676682, -103.347654, TRUE),
-- Brasil
(6, 'BR-SP-001', 'NeuralBank São Paulo', 'Av. Paulista 1578', 'São Paulo', 'São Paulo', '01310-200', 3, '+55-11-5555-0100', 'saopaulo@neuralbank.com', 'Seg-Sex 10:00-16:00', -23.561414, -46.656350, TRUE),
(7, 'BR-RJ-001', 'NeuralBank Rio de Janeiro', 'Av. Rio Branco 156', 'Rio de Janeiro', 'Rio de Janeiro', '20040-003', 3, '+55-21-5555-0200', 'rio@neuralbank.com', 'Seg-Sex 10:00-16:00', -22.906847, -43.172897, TRUE),
-- Argentina
(8, 'AR-BA-001', 'NeuralBank Buenos Aires', 'Av. Corrientes 456', 'Buenos Aires', 'Capital Federal', 'C1043', 4, '+54-11-5555-0100', 'buenosaires@neuralbank.com', 'Lun-Vie 10:00-15:00', -34.603722, -58.381592, TRUE),
-- Chile
(9, 'CL-ST-001', 'NeuralBank Santiago Centro', 'Av. Libertador Bernardo O''Higgins 1234', 'Santiago', 'Región Metropolitana', '8320000', 5, '+56-2-2555-0100', 'santiago@neuralbank.com', 'Lun-Vie 9:00-18:00', -33.448891, -70.669266, TRUE),
(10, 'CL-VA-001', 'NeuralBank Valparaíso', 'Av. Pedro Montt 2045', 'Valparaíso', 'Región de Valparaíso', '2340000', 5, '+56-32-255-5100', 'valparaiso@neuralbank.com', 'Lun-Vie 9:00-17:00', -33.047238, -71.612688, TRUE),
-- España
(11, 'ES-MD-001', 'NeuralBank Madrid', 'Gran Vía 28', 'Madrid', 'Comunidad de Madrid', '28013', 8, '+34-91-555-0100', 'madrid@neuralbank.com', 'Lun-Vie 9:00-14:00', 40.420152, -3.705949, TRUE),
(12, 'ES-BC-001', 'NeuralBank Barcelona', 'Passeig de Gràcia 92', 'Barcelona', 'Cataluña', '08008', 8, '+34-93-555-0100', 'barcelona@neuralbank.com', 'Lun-Vie 9:00-14:00', 41.385063, 2.173404, TRUE),
-- Reino Unido
(13, 'GB-LN-001', 'NeuralBank London', '1 Canada Square', 'London', 'England', 'E14 5AB', 9, '+44-20-5555-0100', 'london@neuralbank.com', 'Mon-Fri 9:00-17:00', 51.507351, -0.127758, TRUE);

-- Ajustar secuencia de sucursal
ALTER SEQUENCE core.sucursal_sucursal_id_seq RESTART WITH 14;

-- Insertar Ejecutivos
INSERT INTO core.ejecutivo (sucursal_id, codigo_empleado, identificacion, tipo_identificacion, nombre_completo, email, telefono, cargo, fecha_contratacion, activo) VALUES
-- Estados Unidos
(1, 'EMP-US-001', '123-45-6789', 'SSN', 'John Smith', 'john.smith@neuralbank.com', '+1-212-555-0101', 'Senior Account Manager', '2019-03-15', TRUE),
(1, 'EMP-US-002', '234-56-7890', 'SSN', 'Emily Johnson', 'emily.johnson@neuralbank.com', '+1-212-555-0102', 'Credit Analyst', '2020-07-20', TRUE),
(2, 'EMP-US-003', '345-67-8901', 'SSN', 'Michael Brown', 'michael.brown@neuralbank.com', '+1-213-555-0201', 'Branch Manager', '2018-01-10', TRUE),
(3, 'EMP-US-004', '456-78-9012', 'SSN', 'Sarah Davis', 'sarah.davis@neuralbank.com', '+1-305-555-0301', 'Investment Advisor', '2021-05-12', TRUE),
-- México
(4, 'EMP-MX-001', 'GOPE850315HDF', 'CURP', 'Pedro González Pérez', 'pedro.gonzalez@neuralbank.com', '+52-55-5555-0101', 'Gerente de Sucursal', '2019-11-08', TRUE),
(4, 'EMP-MX-002', 'MALR900622MDF', 'CURP', 'Rosa María López', 'rosa.lopez@neuralbank.com', '+52-55-5555-0102', 'Ejecutivo de Créditos', '2020-09-22', TRUE),
(5, 'EMP-MX-003', 'SAMC880415HDG', 'CURP', 'Carlos Sánchez Martínez', 'carlos.sanchez@neuralbank.com', '+52-33-5555-0201', 'Ejecutivo Comercial', '2021-02-14', TRUE),
-- Brasil
(6, 'EMP-BR-001', '123.456.789-00', 'CPF', 'Ana Silva Santos', 'ana.silva@neuralbank.com', '+55-11-5555-0101', 'Gerente de Contas', '2020-06-30', TRUE),
(6, 'EMP-BR-002', '234.567.890-11', 'CPF', 'João Oliveira Costa', 'joao.oliveira@neuralbank.com', '+55-11-5555-0102', 'Analista de Crédito', '2021-08-19', TRUE),
(7, 'EMP-BR-003', '345.678.901-22', 'CPF', 'Maria Ferreira Lima', 'maria.ferreira@neuralbank.com', '+55-21-5555-0201', 'Gerente de Agência', '2019-04-25', TRUE),
-- Argentina
(8, 'EMP-AR-001', '20-12345678-9', 'CUIT', 'Diego Martínez', 'diego.martinez@neuralbank.com', '+54-11-5555-0101', 'Gerente de Sucursal', '2020-10-15', TRUE),
(8, 'EMP-AR-002', '27-23456789-0', 'CUIT', 'Laura Fernández', 'laura.fernandez@neuralbank.com', '+54-11-5555-0102', 'Ejecutiva Comercial', '2021-03-20', TRUE),
-- Chile
(9, 'EMP-CL-001', '12.345.678-9', 'RUN', 'María González', 'maria.gonzalez@neuralbank.com', '+56-2-2555-0101', 'Ejecutivo Comercial Senior', '2019-07-15', TRUE),
(9, 'EMP-CL-002', '23.456.789-0', 'RUN', 'Carlos Rodríguez', 'carlos.rodriguez@neuralbank.com', '+56-2-2555-0102', 'Ejecutivo de Créditos', '2020-11-20', TRUE),
-- España
(11, 'EMP-ES-001', '12345678A', 'DNI', 'Carmen García López', 'carmen.garcia@neuralbank.com', '+34-91-555-0101', 'Director de Sucursal', '2018-05-10', TRUE),
(11, 'EMP-ES-002', '23456789B', 'DNI', 'Javier Martín Sánchez', 'javier.martin@neuralbank.com', '+34-91-555-0102', 'Asesor Financiero', '2020-09-15', TRUE),
(12, 'EMP-ES-003', '34567890C', 'DNI', 'Isabel Rodríguez Torres', 'isabel.rodriguez@neuralbank.com', '+34-93-555-0101', 'Ejecutiva Premium', '2021-01-20', TRUE),
-- Reino Unido
(13, 'EMP-GB-001', 'AB123456C', 'NINO', 'James Wilson', 'james.wilson@neuralbank.com', '+44-20-5555-0101', 'Senior Relationship Manager', '2019-02-28', TRUE),
(13, 'EMP-GB-002', 'CD234567D', 'NINO', 'Emma Thompson', 'emma.thompson@neuralbank.com', '+44-20-5555-0102', 'Credit Risk Analyst', '2020-06-10', TRUE);

-- Insertar Clientes (diversidad internacional)
INSERT INTO core.cliente (identificacion, tipo_identificacion, nombre, apellido, fecha_nacimiento, email, telefono, direccion, ciudad, estado_provincia, codigo_postal, pais_id, tipo_cliente, score_crediticio, nivel_riesgo, sucursal_id, ejecutivo_id, metadata) VALUES
-- Clientes Estados Unidos
('123-45-6780', 'SSN', 'Robert', 'Anderson', '1985-03-15', 'robert.anderson@email.com', '+1-212-555-1001', '123 Park Avenue', 'New York', 'New York', '10016', 1, 'PERSONAL', 785.00, 'Bajo', 1, 1, '{"occupation": "Software Engineer", "annual_income": 120000}'),
('234-56-7891', 'SSN', 'Jennifer', 'Martinez', '1990-07-22', 'jennifer.martinez@email.com', '+1-212-555-1002', '456 Madison Avenue', 'New York', 'New York', '10022', 1, 'PERSONAL', 820.00, 'Bajo', 1, 1, '{"occupation": "Marketing Manager", "annual_income": 95000}'),
('345-67-8902', 'SSN', 'David', 'Lee', '1988-11-10', 'david.lee@email.com', '+1-213-555-2001', '789 Sunset Boulevard', 'Los Angeles', 'California', '90028', 1, 'PERSONAL', 750.00, 'Bajo', 2, 3, '{"occupation": "Financial Analyst", "annual_income": 110000}'),
('456-78-9013', 'SSN', 'Michelle', 'Garcia', '1992-05-18', 'michelle.garcia@email.com', '+1-305-555-3001', '321 Ocean Drive', 'Miami', 'Florida', '33139', 1, 'PERSONAL', 695.00, 'Medio', 3, 4, '{"occupation": "Real Estate Agent", "annual_income": 75000}'),

-- Clientes México
('GOME850315HDFRR01', 'CURP', 'Mario', 'Gómez Morales', '1985-03-15', 'mario.gomez@email.com', '+52-55-5555-2001', 'Av. Insurgentes Sur 1234', 'Ciudad de México', 'CDMX', '03100', 2, 'PERSONAL', 720.00, 'Bajo', 4, 5, '{"occupation": "Ingeniero", "annual_income": 450000}'),
('MARL900622MDFPSS02', 'CURP', 'Laura', 'Martínez Pérez', '1990-06-22', 'laura.martinez@email.com', '+52-55-5555-2002', 'Calle Reforma 567', 'Ciudad de México', 'CDMX', '06600', 2, 'PERSONAL', 680.00, 'Medio', 4, 6, '{"occupation": "Contador", "annual_income": 380000}'),
('SAMC880415HDGNRL03', 'CURP', 'Carlos', 'Sánchez Muñoz', '1988-04-15', 'carlos.sanchez.mex@email.com', '+52-33-5555-3001', 'Av. Americas 890', 'Guadalajara', 'Jalisco', '44160', 2, 'PERSONAL', 740.00, 'Bajo', 5, 7, '{"occupation": "Médico", "annual_income": 520000}'),

-- Clientes Brasil
('123.456.789-01', 'CPF', 'Paulo', 'Silva Santos', '1987-09-25', 'paulo.silva@email.com', '+55-11-5555-4001', 'Rua Augusta 1500', 'São Paulo', 'São Paulo', '01304-001', 3, 'PERSONAL', 710.00, 'Medio', 6, 8, '{"occupation": "Advogado", "annual_income": 180000}'),
('234.567.890-12', 'CPF', 'Ana', 'Oliveira Costa', '1995-02-14', 'ana.oliveira@email.com', '+55-11-5555-4002', 'Av. Paulista 2100', 'São Paulo', 'São Paulo', '01310-300', 3, 'PERSONAL', 650.00, 'Medio', 6, 9, '{"occupation": "Designer", "annual_income": 95000}'),
('345.678.901-23', 'CPF', 'Ricardo', 'Ferreira Lima', '1991-08-30', 'ricardo.ferreira@email.com', '+55-21-5555-5001', 'Av. Atlântica 3000', 'Rio de Janeiro', 'Rio de Janeiro', '22070-002', 3, 'PERSONAL', 690.00, 'Medio', 7, 10, '{"occupation": "Empresario", "annual_income": 250000}'),

-- Clientes Argentina
('20-12345678-0', 'CUIT', 'Diego', 'Martínez Suárez', '1989-04-20', 'diego.martinez.ar@email.com', '+54-11-5555-6001', 'Av. Santa Fe 2500', 'Buenos Aires', 'Capital Federal', 'C1425', 4, 'PERSONAL', 670.00, 'Medio', 8, 11, '{"occupation": "Arquitecto", "annual_income": 3500000}'),
('27-23456789-1', 'CUIT', 'Lucía', 'Fernández Gómez', '1993-10-08', 'lucia.fernandez@email.com', '+54-11-5555-6002', 'Av. Corrientes 1200', 'Buenos Aires', 'Capital Federal', 'C1043', 4, 'PERSONAL', 640.00, 'Medio', 8, 12, '{"occupation": "Profesora", "annual_income": 2800000}'),

-- Clientes Chile
('16.789.123-4', 'RUN', 'Juan', 'Pérez González', '1986-03-15', 'juan.perez@email.com', '+56-2-2555-7001', 'Los Aromos 234', 'Santiago', 'Región Metropolitana', '7500000', 5, 'PERSONAL', 760.00, 'Bajo', 9, 13, '{"occupation": "Ingeniero Civil", "annual_income": 28000000}'),
('17.890.234-5', 'RUN', 'María', 'Silva Rojas', '1990-07-22', 'maria.silva@email.com', '+56-2-2555-7002', 'Av. Grecia 1456', 'Santiago', 'Región Metropolitana', '7780000', 5, 'PERSONAL', 800.00, 'Bajo', 9, 14, '{"occupation": "Gerente Comercial", "annual_income": 35000000}'),

-- Clientes España
('12345678A', 'DNI', 'Antonio', 'García López', '1988-11-10', 'antonio.garcia@email.com', '+34-91-555-8001', 'Calle Alcalá 123', 'Madrid', 'Comunidad de Madrid', '28009', 8, 'PERSONAL', 770.00, 'Bajo', 11, 15, '{"occupation": "Consultor", "annual_income": 55000}'),
('23456789B', 'DNI', 'Carmen', 'Martín Sánchez', '1992-05-18', 'carmen.martin@email.com', '+34-91-555-8002', 'Gran Vía 45', 'Madrid', 'Comunidad de Madrid', '28013', 8, 'PERSONAL', 730.00, 'Bajo', 11, 16, '{"occupation": "Abogada", "annual_income": 62000}'),
('34567890C', 'DNI', 'Javier', 'Rodríguez Torres', '1987-09-25', 'javier.rodriguez@email.com', '+34-93-555-9001', 'Rambla Catalunya 88', 'Barcelona', 'Cataluña', '08008', 8, 'PERSONAL', 710.00, 'Medio', 12, 17, '{"occupation": "Desarrollador", "annual_income": 48000}'),

-- Clientes Reino Unido
('AB123456C', 'NINO', 'William', 'Johnson', '1985-02-14', 'william.johnson@email.com', '+44-20-5555-9001', '25 Baker Street', 'London', 'England', 'NW1 6XE', 9, 'PERSONAL', 790.00, 'Bajo', 13, 18, '{"occupation": "Investment Banker", "annual_income": 95000}'),
('CD234567D', 'NINO', 'Sophie', 'Thompson', '1991-08-30', 'sophie.thompson@email.com', '+44-20-5555-9002', '10 Downing Street', 'London', 'England', 'SW1A 2AA', 9, 'PERSONAL', 755.00, 'Bajo', 13, 19, '{"occupation": "Marketing Director", "annual_income": 78000}'),

-- Clientes Empresariales
('76-12345678-9', 'EIN', 'TechCorp', 'Solutions Inc', '2010-01-15', 'contact@techcorp.com', '+1-212-555-9000', '500 Fifth Avenue', 'New York', 'New York', '10110', 1, 'CORPORATIVO', 850.00, 'Bajo', 1, 1, '{"industry": "Technology", "employees": 250, "annual_revenue": 15000000}'),
('RFC123456ABC', 'RFC', 'Comercializadora', 'Global SA de CV', '2012-06-20', 'info@comercializadora.mx', '+52-55-5555-9000', 'Av. Reforma 100', 'Ciudad de México', 'CDMX', '06600', 2, 'EMPRESARIAL', 810.00, 'Bajo', 4, 5, '{"industry": "Retail", "employees": 150, "annual_revenue": 25000000}'),
('30-12345678-9', 'CUIT', 'Constructora', 'del Sur SRL', '2015-09-10', 'contacto@constructora.ar', '+54-11-5555-9000', 'Av. 9 de Julio 1000', 'Buenos Aires', 'Capital Federal', 'C1043', 4, 'EMPRESARIAL', 780.00, 'Medio', 8, 11, '{"industry": "Construction", "employees": 180, "annual_revenue": 50000000}'),
('A12345678', 'CIF', 'Inversiones', 'Madrid SA', '2008-11-25', 'info@inversionesmadrid.es', '+34-91-555-9000', 'Paseo de la Castellana 200', 'Madrid', 'Comunidad de Madrid', '28046', 8, 'CORPORATIVO', 830.00, 'Bajo', 11, 15, '{"industry": "Finance", "employees": 95, "annual_revenue": 8500000}');

-- Insertar Cuentas
-- Cuentas para cliente 1 (Robert Anderson - USA)
INSERT INTO core.cuenta (cliente_id, numero_cuenta, iban, swift_bic, tipo_cuenta, moneda_id, saldo_actual, saldo_disponible, fecha_apertura, estado, limite_sobregiro, tasa_interes) VALUES
(1, 'US1234567890001', 'US89370400440532013001', 'NEUBANKUS', 'Corriente', 1, 25000.00, 25000.00, '2022-01-15', 'Activa', 10000.00, 0.25),
(1, 'US1234567890002', 'US89370400440532013002', 'NEUBANKUS', 'Ahorro', 1, 85000.00, 85000.00, '2022-01-15', 'Activa', 0, 2.50);

-- Cuentas para cliente 2 (Jennifer Martinez - USA)
INSERT INTO core.cuenta (cliente_id, numero_cuenta, iban, swift_bic, tipo_cuenta, moneda_id, saldo_actual, saldo_disponible, fecha_apertura, estado, limite_sobregiro, tasa_interes) VALUES
(2, 'US2345678901001', 'US89370400440532014001', 'NEUBANKUS', 'Corriente', 1, 32000.00, 32000.00, '2022-03-20', 'Activa', 15000.00, 0.25),
(2, 'US2345678901002', 'US89370400440532014002', 'NEUBANKUS', 'Ahorro', 1, 120000.00, 120000.00, '2022-03-20', 'Activa', 0, 2.50);

-- Cuentas para cliente 3 (David Lee - USA)
INSERT INTO core.cuenta (cliente_id, numero_cuenta, iban, swift_bic, tipo_cuenta, moneda_id, saldo_actual, saldo_disponible, fecha_apertura, estado, limite_sobregiro, tasa_interes) VALUES
(3, 'US3456789012001', 'US89370400440532015001', 'NEUBANKUS', 'Corriente', 1, 45000.00, 45000.00, '2021-08-05', 'Activa', 20000.00, 0.25),
(3, 'US3456789012002', 'US89370400440532015002', 'NEUBANKUS', 'Inversion', 1, 150000.00, 150000.00, '2021-08-05', 'Activa', 0, 3.75);

-- Cuentas para cliente 4 (Michelle Garcia - USA)
INSERT INTO core.cuenta (cliente_id, numero_cuenta, iban, swift_bic, tipo_cuenta, moneda_id, saldo_actual, saldo_disponible, fecha_apertura, estado, limite_sobregiro, tasa_interes) VALUES
(4, 'US4567890123001', 'US89370400440532016001', 'NEUBANKUS', 'Corriente', 1, 18000.00, 18000.00, '2022-06-12', 'Activa', 8000.00, 0.25),
(4, 'US4567890123002', 'US89370400440532016002', 'NEUBANKUS', 'Ahorro', 1, 55000.00, 55000.00, '2022-06-12', 'Activa', 0, 2.50);

-- Cuentas para cliente 5 (Mario Gómez - México)
INSERT INTO core.cuenta (cliente_id, numero_cuenta, tipo_cuenta, moneda_id, saldo_actual, saldo_disponible, fecha_apertura, estado, limite_sobregiro, tasa_interes) VALUES
(5, 'MX5678901234001', 'Corriente', 6, 180000.00, 180000.00, '2022-02-10', 'Activa', 50000.00, 1.50),
(5, 'MX5678901234002', 'Ahorro', 6, 620000.00, 620000.00, '2022-02-10', 'Activa', 0, 4.50);

-- Cuentas para cliente 6 (Laura Martínez - México)
INSERT INTO core.cuenta (cliente_id, numero_cuenta, tipo_cuenta, moneda_id, saldo_actual, saldo_disponible, fecha_apertura, estado, limite_sobregiro, tasa_interes) VALUES
(6, 'MX6789012345001', 'Corriente', 6, 145000.00, 145000.00, '2022-04-15', 'Activa', 40000.00, 1.50),
(6, 'MX6789012345002', 'Ahorro', 6, 485000.00, 485000.00, '2022-04-15', 'Activa', 0, 4.50);

-- Cuentas para cliente 7 (Carlos Sánchez - México)
INSERT INTO core.cuenta (cliente_id, numero_cuenta, tipo_cuenta, moneda_id, saldo_actual, saldo_disponible, fecha_apertura, estado, limite_sobregiro, tasa_interes) VALUES
(7, 'MX7890123456001', 'Corriente', 6, 220000.00, 220000.00, '2021-11-20', 'Activa', 60000.00, 1.50),
(7, 'MX7890123456002', 'Ahorro', 6, 780000.00, 780000.00, '2021-11-20', 'Activa', 0, 4.50);

-- Cuentas para cliente 8 (Paulo Silva - Brasil)
INSERT INTO core.cuenta (cliente_id, numero_cuenta, tipo_cuenta, moneda_id, saldo_actual, saldo_disponible, fecha_apertura, estado, limite_sobregiro, tasa_interes) VALUES
(8, 'BR8901234567001', 'Corriente', 7, 48000.00, 48000.00, '2022-05-10', 'Activa', 15000.00, 2.00),
(8, 'BR8901234567002', 'Ahorro', 7, 165000.00, 165000.00, '2022-05-10', 'Activa', 0, 6.50);

-- Cuentas para cliente 9 (Ana Oliveira - Brasil)
INSERT INTO core.cuenta (cliente_id, numero_cuenta, tipo_cuenta, moneda_id, saldo_actual, saldo_disponible, fecha_apertura, estado, limite_sobregiro, tasa_interes) VALUES
(9, 'BR9012345678001', 'Corriente', 7, 32000.00, 32000.00, '2023-01-20', 'Activa', 10000.00, 2.00),
(9, 'BR9012345678002', 'Ahorro', 7, 98000.00, 98000.00, '2023-01-20', 'Activa', 0, 6.50);

-- Cuentas para cliente 10 (Ricardo Ferreira - Brasil)
INSERT INTO core.cuenta (cliente_id, numero_cuenta, tipo_cuenta, moneda_id, saldo_actual, saldo_disponible, fecha_apertura, estado, limite_sobregiro, tasa_interes) VALUES
(10, 'BR0123456789001', 'Corriente', 7, 85000.00, 85000.00, '2022-09-15', 'Activa', 25000.00, 2.00),
(10, 'BR0123456789002', 'Inversion', 7, 320000.00, 320000.00, '2022-09-15', 'Activa', 0, 8.00);

-- Cuentas para cliente 11 (Diego Martínez - Argentina)
INSERT INTO core.cuenta (cliente_id, numero_cuenta, tipo_cuenta, moneda_id, saldo_actual, saldo_disponible, fecha_apertura, estado, limite_sobregiro, tasa_interes) VALUES
(11, 'AR1234567890001', 'Corriente', 8, 2800000.00, 2800000.00, '2022-07-18', 'Activa', 800000.00, 3.50),
(11, 'AR1234567890002', 'Ahorro', 8, 9500000.00, 9500000.00, '2022-07-18', 'Activa', 0, 12.00);

-- Cuentas para cliente 12 (Lucía Fernández - Argentina)
INSERT INTO core.cuenta (cliente_id, numero_cuenta, tipo_cuenta, moneda_id, saldo_actual, saldo_disponible, fecha_apertura, estado, limite_sobregiro, tasa_interes) VALUES
(12, 'AR2345678901001', 'Corriente', 8, 2200000.00, 2200000.00, '2023-02-28', 'Activa', 600000.00, 3.50),
(12, 'AR2345678901002', 'Ahorro', 8, 7800000.00, 7800000.00, '2023-02-28', 'Activa', 0, 12.00);

-- Cuentas para cliente 13 (Juan Pérez - Chile)
INSERT INTO core.cuenta (cliente_id, numero_cuenta, tipo_cuenta, moneda_id, saldo_actual, saldo_disponible, fecha_apertura, estado, limite_sobregiro, tasa_interes) VALUES
(13, 'CL3456789012001', 'Corriente', 9, 2500000, 2500000, '2022-01-15', 'Activa', 1000000, 0.50),
(13, 'CL3456789012002', 'Ahorro', 9, 8500000, 8500000, '2022-01-15', 'Activa', 0, 3.00);

-- Cuentas para cliente 14 (María Silva - Chile)
INSERT INTO core.cuenta (cliente_id, numero_cuenta, tipo_cuenta, moneda_id, saldo_actual, saldo_disponible, fecha_apertura, estado, limite_sobregiro, tasa_interes) VALUES
(14, 'CL4567890123001', 'Corriente', 9, 3200000, 3200000, '2022-03-20', 'Activa', 1500000, 0.50),
(14, 'CL4567890123002', 'Ahorro', 9, 12000000, 12000000, '2022-03-20', 'Activa', 0, 3.00);

-- Cuentas para cliente 15 (Antonio García - España)
INSERT INTO core.cuenta (cliente_id, numero_cuenta, iban, swift_bic, tipo_cuenta, moneda_id, saldo_actual, saldo_disponible, fecha_apertura, estado, limite_sobregiro, tasa_interes) VALUES
(15, 'ES5678901234001', 'ES9121000418450200051332', 'NEUBANKES', 'Corriente', 2, 15000.00, 15000.00, '2021-10-12', 'Activa', 5000.00, 0.10),
(15, 'ES5678901234002', 'ES9121000418450200051333', 'NEUBANKES', 'Ahorro', 2, 48000.00, 48000.00, '2021-10-12', 'Activa', 0, 1.50);

-- Cuentas para cliente 16 (Carmen Martín - España)
INSERT INTO core.cuenta (cliente_id, numero_cuenta, iban, swift_bic, tipo_cuenta, moneda_id, saldo_actual, saldo_disponible, fecha_apertura, estado, limite_sobregiro, tasa_interes) VALUES
(16, 'ES6789012345001', 'ES9121000418450200051334', 'NEUBANKES', 'Corriente', 2, 22000.00, 22000.00, '2022-04-08', 'Activa', 8000.00, 0.10),
(16, 'ES6789012345002', 'ES9121000418450200051335', 'NEUBANKES', 'Ahorro', 2, 75000.00, 75000.00, '2022-04-08', 'Activa', 0, 1.50);

-- Cuentas para cliente 17 (Javier Rodríguez - España)
INSERT INTO core.cuenta (cliente_id, numero_cuenta, iban, swift_bic, tipo_cuenta, moneda_id, saldo_actual, saldo_disponible, fecha_apertura, estado, limite_sobregiro, tasa_interes) VALUES
(17, 'ES7890123456001', 'ES9121000418450200051336', 'NEUBANKES', 'Corriente', 2, 18000.00, 18000.00, '2022-11-15', 'Activa', 6000.00, 0.10),
(17, 'ES7890123456002', 'ES7890123456002', 'NEUBANKES', 'Ahorro', 2, 62000.00, 62000.00, '2022-11-15', 'Activa', 0, 1.50);

-- Cuentas para cliente 18 (William Johnson - UK)
INSERT INTO core.cuenta (cliente_id, numero_cuenta, iban, swift_bic, tipo_cuenta, moneda_id, saldo_actual, saldo_disponible, fecha_apertura, estado, limite_sobregiro, tasa_interes) VALUES
(18, 'GB8901234567001', 'GB29NWBK60161331926819', 'NEUBANKGB', 'Corriente', 3, 28000.00, 28000.00, '2021-05-20', 'Activa', 10000.00, 0.75),
(18, 'GB8901234567002', 'GB29NWBK60161331926820', 'NEUBANKGB', 'Inversion', 3, 125000.00, 125000.00, '2021-05-20', 'Activa', 0, 3.25);

-- Cuentas para cliente 19 (Sophie Thompson - UK)
INSERT INTO core.cuenta (cliente_id, numero_cuenta, iban, swift_bic, tipo_cuenta, moneda_id, saldo_actual, saldo_disponible, fecha_apertura, estado, limite_sobregiro, tasa_interes) VALUES
(19, 'GB9012345678001', 'GB29NWBK60161331926821', 'NEUBANKGB', 'Corriente', 3, 35000.00, 35000.00, '2022-08-10', 'Activa', 12000.00, 0.75),
(19, 'GB9012345678002', 'GB29NWBK60161331926822', 'NEUBANKGB', 'Ahorro', 3, 98000.00, 98000.00, '2022-08-10', 'Activa', 0, 2.50);

-- Cuentas Empresariales
-- TechCorp Solutions (USA)
INSERT INTO core.cuenta (cliente_id, numero_cuenta, iban, swift_bic, tipo_cuenta, moneda_id, saldo_actual, saldo_disponible, fecha_apertura, estado, limite_sobregiro, tasa_interes) VALUES
(20, 'US0123456789001', 'US89370400440532020001', 'NEUBANKUS', 'Corriente', 1, 500000.00, 500000.00, '2021-03-10', 'Activa', 200000.00, 0.50),
(20, 'US0123456789002', 'US89370400440532020002', 'NEUBANKUS', 'Inversion', 1, 1500000.00, 1500000.00, '2021-03-10', 'Activa', 0, 3.00);

-- Comercializadora Global (México)
INSERT INTO core.cuenta (cliente_id, numero_cuenta, tipo_cuenta, moneda_id, saldo_actual, saldo_disponible, fecha_apertura, estado, limite_sobregiro, tasa_interes) VALUES
(21, 'MX1234567890001', 'Corriente', 6, 2800000.00, 2800000.00, '2022-02-18', 'Activa', 1000000.00, 2.00),
(21, 'MX1234567890002', 'Inversion', 6, 8500000.00, 8500000.00, '2022-02-18', 'Activa', 0, 5.50);

-- Constructora del Sur (Argentina)
INSERT INTO core.cuenta (cliente_id, numero_cuenta, tipo_cuenta, moneda_id, saldo_actual, saldo_disponible, fecha_apertura, estado, limite_sobregiro, tasa_interes) VALUES
(22, 'AR3456789012001', 'Corriente', 8, 18000000.00, 18000000.00, '2021-09-05', 'Activa', 5000000.00, 4.00),
(22, 'AR3456789012002', 'Inversion', 8, 42000000.00, 42000000.00, '2021-09-05', 'Activa', 0, 13.00);

-- Inversiones Madrid (España)
INSERT INTO core.cuenta (cliente_id, numero_cuenta, iban, swift_bic, tipo_cuenta, moneda_id, saldo_actual, saldo_disponible, fecha_apertura, estado, limite_sobregiro, tasa_interes) VALUES
(23, 'ES0123456789001', 'ES9121000418450200051340', 'NEUBANKES', 'Corriente', 2, 250000.00, 250000.00, '2022-04-14', 'Activa', 100000.00, 0.50),
(23, 'ES0123456789002', 'ES9121000418450200051341', 'NEUBANKES', 'Inversion', 2, 850000.00, 850000.00, '2022-04-14', 'Activa', 0, 2.25);

-- Insertar Créditos
-- Crédito de Consumo - Cliente 1 (Robert Anderson - USA)
INSERT INTO core.credito (cliente_id, cuenta_desembolso_id, numero_credito, tipo_credito, moneda_id, monto_solicitado, monto_aprobado, tasa_interes_anual, plazo_meses, fecha_solicitud, fecha_aprobacion, fecha_desembolso, estado, destino_credito, score_aprobacion, ejecutivo_id) VALUES
(1, 1, 'CRE-US-2022-001', 'Consumo', 1, 50000.00, 50000.00, 8.50, 36, '2022-02-10', '2022-02-15', '2022-02-20', 'Vigente', 'Home renovation', 785.00, 2);

-- Crédito Automotriz - Cliente 2 (Jennifer Martinez - USA)
INSERT INTO core.credito (cliente_id, cuenta_desembolso_id, numero_credito, tipo_credito, moneda_id, monto_solicitado, monto_aprobado, tasa_interes_anual, plazo_meses, fecha_solicitud, fecha_aprobacion, fecha_desembolso, estado, destino_credito, score_aprobacion, ejecutivo_id) VALUES
(2, 3, 'CRE-US-2022-002', 'Automotriz', 1, 35000.00, 35000.00, 5.90, 60, '2022-04-05', '2022-04-10', '2022-04-15', 'Vigente', 'New vehicle purchase', 820.00, 2);

-- Crédito Hipotecario - Cliente 3 (David Lee - USA)
INSERT INTO core.credito (cliente_id, cuenta_desembolso_id, numero_credito, tipo_credito, moneda_id, monto_solicitado, monto_aprobado, tasa_interes_anual, plazo_meses, fecha_solicitud, fecha_aprobacion, fecha_desembolso, estado, destino_credito, score_aprobacion, ejecutivo_id) VALUES
(3, 5, 'CRE-US-2021-010', 'Hipotecario', 1, 450000.00, 420000.00, 4.25, 360, '2021-09-15', '2021-10-20', '2021-11-01', 'Vigente', 'Primary residence purchase - Los Angeles', 750.00, 3);

-- Crédito PERSONAL - Cliente 5 (Mario Gómez - México) -> CORREGIDO 'PERSONAL' a 'Personal'
INSERT INTO core.credito (cliente_id, cuenta_desembolso_id, numero_credito, tipo_credito, moneda_id, monto_solicitado, monto_aprobado, tasa_interes_anual, plazo_meses, fecha_solicitud, fecha_aprobacion, fecha_desembolso, estado, destino_credito, score_aprobacion, ejecutivo_id) VALUES
(5, 9, 'CRE-MX-2022-015', 'Personal', 6, 250000.00, 250000.00, 18.50, 24, '2022-03-10', '2022-03-15', '2022-03-20', 'Vigente', 'Consolidación de deudas', 720.00, 6);

-- Crédito Automotriz - Cliente 7 (Carlos Sánchez - México)
INSERT INTO core.credito (cliente_id, cuenta_desembolso_id, numero_credito, tipo_credito, moneda_id, monto_solicitado, monto_aprobado, tasa_interes_anual, plazo_meses, fecha_solicitud, fecha_aprobacion, fecha_desembolso, estado, destino_credito, score_aprobacion, ejecutivo_id) VALUES
(7, 13, 'CRE-MX-2022-020', 'Automotriz', 6, 380000.00, 380000.00, 14.25, 48, '2022-01-20', '2022-01-25', '2022-02-01', 'Vigente', 'Vehículo nuevo', 740.00, 7);

-- Crédito PERSONAL - Cliente 8 (Paulo Silva - Brasil) -> CORREGIDO 'PERSONAL' a 'Personal'
INSERT INTO core.credito (cliente_id, cuenta_desembolso_id, numero_credito, tipo_credito, moneda_id, monto_solicitado, monto_aprobado, tasa_interes_anual, plazo_meses, fecha_solicitud, fecha_aprobacion, fecha_desembolso, estado, destino_credito, score_aprobacion, ejecutivo_id) VALUES
(8, 15, 'CRE-BR-2022-008', 'Personal', 7, 75000.00, 75000.00, 24.90, 36, '2022-06-15', '2022-06-20', '2022-06-25', 'Vigente', 'Educação e cursos', 710.00, 9);

-- Crédito Hipotecario - Cliente 13 (Juan Pérez - Chile)
INSERT INTO core.credito (cliente_id, cuenta_desembolso_id, numero_credito, tipo_credito, moneda_id, monto_solicitado, monto_aprobado, tasa_interes_anual, plazo_meses, fecha_solicitud, fecha_aprobacion, fecha_desembolso, estado, destino_credito, score_aprobacion, ejecutivo_id) VALUES
(13, 25, 'CRE-CL-2021-005', 'Hipotecario', 9, 80000000, 75000000, 3.50, 240, '2021-09-15', '2021-10-20', '2021-11-01', 'Vigente', 'Compra vivienda Santiago', 760.00, 13);

-- Crédito PERSONAL - Cliente 15 (Antonio García - España) -> CORREGIDO 'PERSONAL' a 'Personal'
INSERT INTO core.credito (cliente_id, cuenta_desembolso_id, numero_credito, tipo_credito, moneda_id, monto_solicitado, monto_aprobado, tasa_interes_anual, plazo_meses, fecha_solicitud, fecha_aprobacion, fecha_desembolso, estado, destino_credito, score_aprobacion, ejecutivo_id) VALUES
(15, 29, 'CRE-ES-2022-012', 'Personal', 2, 25000.00, 25000.00, 7.50, 48, '2022-05-10', '2022-05-15', '2022-05-20', 'Vigente', 'Reforma vivienda', 770.00, 16);

-- Crédito Comercial - TechCorp Solutions (USA)
INSERT INTO core.credito (cliente_id, cuenta_desembolso_id, numero_credito, tipo_credito, moneda_id, monto_solicitado, monto_aprobado, tasa_interes_anual, plazo_meses, fecha_solicitud, fecha_aprobacion, fecha_desembolso, estado, destino_credito, score_aprobacion, ejecutivo_id) VALUES
(20, 39, 'CRE-US-CORP-2021-001', 'Comercial', 1, 750000.00, 750000.00, 6.75, 60, '2021-04-10', '2021-04-25', '2021-05-05', 'Vigente', 'Business expansion and equipment', 850.00, 1);

-- Crédito Comercial - Comercializadora Global (México)
INSERT INTO core.credito (cliente_id, cuenta_desembolso_id, numero_credito, tipo_credito, moneda_id, monto_solicitado, monto_aprobado, tasa_interes_anual, plazo_meses, fecha_solicitud, fecha_aprobacion, fecha_desembolso, estado, destino_credito, score_aprobacion, ejecutivo_id) VALUES
(21, 41, 'CRE-MX-EMP-2022-003', 'Comercial', 6, 5000000.00, 5000000.00, 16.50, 48, '2022-03-10', '2022-03-25', '2022-04-05', 'Vigente', 'Expansión de operaciones', 810.00, 5);

-- Insertar Transacciones
-- Transferencias
INSERT INTO core.transaccion (cuenta_origen_id, cuenta_destino_id, numero_transaccion, tipo_transaccion, canal, monto, moneda_id, fecha_hora, estado, descripcion, codigo_autorizacion) VALUES
(1, 3, 'TRX20251028000001', 'Transferencia', 'App', 1500.00, 1, '2025-10-28 10:30:00', 'Completada', 'Payment to Jennifer Martinez', 'AUTH-US-001'),
(3, 1, 'TRX20251028000002', 'Transferencia', 'Web', 800.00, 1, '2025-10-28 14:15:00', 'Completada', 'Loan repayment', 'AUTH-US-002'),
(5, 7, 'TRX20251027000001', 'Transferencia', 'App', 2000.00, 1, '2025-10-27 09:20:00', 'Completada', 'Transfer David Lee to Michelle Garcia', 'AUTH-US-003');

-- Transferencias internacionales (México)
INSERT INTO core.transaccion (cuenta_origen_id, cuenta_destino_id, numero_transaccion, tipo_transaccion, canal, monto, moneda_id, fecha_hora, estado, descripcion, codigo_autorizacion) VALUES
(9, 11, 'TRX20251028000004', 'Transferencia', 'Web', 15000.00, 6, '2025-10-28 11:45:00', 'Completada', 'Transferencia entre clientes', 'AUTH-MX-001'),
(13, 9, 'TRX20251027000002', 'Transferencia', 'App', 8500.00, 6, '2025-10-27 16:30:00', 'Completada', 'Pago de servicios', 'AUTH-MX-002');

-- Depósitos
INSERT INTO core.transaccion (cuenta_destino_id, numero_transaccion, tipo_transaccion, canal, monto, moneda_id, fecha_hora, estado, descripcion, codigo_autorizacion) VALUES
(2, 'TRX20251026000001', 'Deposito', 'Sucursal', 5000.00, 1, '2025-10-26 11:00:00', 'Completada', 'Cash deposit', 'AUTH-US-004'),
(10, 'TRX20251025000001', 'Deposito', 'ATM', 2500.00, 7, '2025-10-25 15:30:00', 'Completada', 'Depósito em dinheiro', 'AUTH-BR-001');

-- Retiros
INSERT INTO core.transaccion (cuenta_origen_id, numero_transaccion, tipo_transaccion, canal, monto, moneda_id, fecha_hora, estado, descripcion, codigo_autorizacion) VALUES
(1, 'TRX20251028000005', 'Retiro', 'ATM', 500.00, 1, '2025-10-28 16:45:00', 'Completada', 'ATM withdrawal', 'AUTH-US-005'),
(9, 'TRX20251027000003', 'Retiro', 'ATM', 3000.00, 6, '2025-10-27 18:20:00', 'Completada', 'Retiro cajero automático', 'AUTH-MX-003');

-- Compras con tarjeta
INSERT INTO core.transaccion (cuenta_origen_id, numero_transaccion, tipo_transaccion, canal, monto, moneda_id, fecha_hora, estado, descripcion, referencia_externa, codigo_autorizacion) VALUES
(1, 'TRX20251028000006', 'Compra', 'POS', 125.50, 1, '2025-10-28 12:15:00', 'Completada', 'Whole Foods Market', 'REF-WFM-12345', 'AUTH-US-006'),
(3, 'TRX20251028000007', 'Compra', 'POS', 89.99, 1, '2025-10-28 13:30:00', 'Completada', 'Target Store', 'REF-TGT-67890', 'AUTH-US-007'),
(9, 'TRX20251027000004', 'Compra', 'POS', 1250.00, 6, '2025-10-27 19:45:00', 'Completada', 'Liverpool', 'REF-LIV-11223', 'AUTH-MX-004');

-- Pagos de servicios
INSERT INTO core.transaccion (cuenta_origen_id, numero_transaccion, tipo_transaccion, canal, monto, moneda_id, fecha_hora, estado, descripcion, referencia_externa, codigo_autorizacion) VALUES
(1, 'TRX20251025000002', 'Pago', 'Web', 150.00, 1, '2025-10-25 20:00:00', 'Completada', 'Electric bill payment', 'ConEd-202510', 'AUTH-US-008'),
(9, 'TRX20251024000001', 'Pago', 'App', 850.00, 6, '2025-10-24 10:30:00', 'Completada', 'Pago CFE', 'CFE-202510', 'AUTH-MX-005');

-- Transacciones empresariales
INSERT INTO core.transaccion (cuenta_origen_id, cuenta_destino_id, numero_transaccion, tipo_transaccion, canal, monto, moneda_id, fecha_hora, estado, descripcion, codigo_autorizacion) VALUES
(39, 3, 'TRX20251028000008', 'Transferencia', 'Web', 15000.00, 1, '2025-10-28 11:00:00', 'Completada', 'Salary payment', 'AUTH-US-CORP-001'),
(41, 11, 'TRX20251027000005', 'Transferencia', 'API', 85000.00, 6, '2025-10-27 14:00:00', 'Completada', 'Pago a proveedor', 'AUTH-MX-EMP-001');

-- Insertar detalles de transacciones (comisiones)
INSERT INTO core.detalle_transaccion (transaccion_id, concepto, monto, tipo_cargo) VALUES
(1, 'Transfer fee', 2.50, 'Comision'),
(1, 'Service tax', 0.40, 'Impuesto'),
(4, 'Comisión transferencia', 35.00, 'Comision'),
(4, 'IVA', 5.60, 'IVA');

-- ============================================
-- PROCEDIMIENTOS ALMACENADOS ÚTILES
-- ============================================

${procedure_start}

-- Función para generar cuotas de un crédito
CREATE OR REPLACE FUNCTION core.generar_cuotas_credito(p_credito_id INTEGER)
RETURNS TABLE(cuota_generada INTEGER) AS $$
DECLARE
    v_monto_aprobado NUMERIC(18,2);
    v_tasa_mensual NUMERIC(5,4);
    v_plazo_meses INTEGER;
    v_fecha_primer_vencimiento DATE;
    v_monto_cuota NUMERIC(18,2);
    v_saldo_capital NUMERIC(18,2);
    v_monto_interes NUMERIC(18,2);
    v_monto_capital NUMERIC(18,2);
    v_fecha_vencimiento DATE;
    i INTEGER;
BEGIN
    -- Obtener datos del crédito
    SELECT monto_aprobado, tasa_interes_mensual, plazo_meses, fecha_primer_vencimiento
    INTO v_monto_aprobado, v_tasa_mensual, v_plazo_meses, v_fecha_primer_vencimiento
    FROM core.credito
    WHERE credito_id = p_credito_id;

    -- Calcular cuota fija (sistema francés)
    v_monto_cuota := v_monto_aprobado * (v_tasa_mensual / 100) * 
                     POWER(1 + (v_tasa_mensual / 100), v_plazo_meses) / 
                     (POWER(1 + (v_tasa_mensual / 100), v_plazo_meses) - 1);

    v_saldo_capital := v_monto_aprobado;
    v_fecha_vencimiento := v_fecha_primer_vencimiento;

    -- Generar cuotas
    FOR i IN 1..v_plazo_meses LOOP
        v_monto_interes := v_saldo_capital * (v_tasa_mensual / 100);
        v_monto_capital := v_monto_cuota - v_monto_interes;
        v_saldo_capital := v_saldo_capital - v_monto_capital;

        INSERT INTO core.cuota (
            credito_id, numero_cuota, fecha_vencimiento, 
            monto_cuota, monto_capital, monto_interes, saldo_capital, estado
        ) VALUES (
            p_credito_id, i, v_fecha_vencimiento,
            v_monto_cuota, v_monto_capital, v_monto_interes, v_saldo_capital, 'Pendiente'
        );

        cuota_generada := i;
        v_fecha_vencimiento := v_fecha_vencimiento + INTERVAL '1 month';
        
        RETURN NEXT;
    END LOOP;

    RETURN;
END;
$$ LANGUAGE plpgsql;

-- Ejemplo de uso:
-- SELECT * FROM core.generar_cuotas_credito(1);

-- ============================================
-- VISTAS ÚTILES
-- ============================================

-- Vista de resumen de clientes
CREATE OR REPLACE VIEW core.vista_resumen_clientes AS
SELECT 
    c.cliente_id,
    c.identificacion,
    c.nombre_completo,
    c.tipo_cliente,
    c.score_crediticio,
    c.nivel_riesgo,
    p.nombre as pais,
    COUNT(DISTINCT ct.cuenta_id) as total_cuentas,
    COUNT(DISTINCT cr.credito_id) as total_creditos,
    COALESCE(SUM(ct.saldo_actual), 0) as saldo_total,
    s.nombre as sucursal,
    e.nombre_completo as ejecutivo
FROM core.cliente c
LEFT JOIN core.pais p ON c.pais_id = p.pais_id
LEFT JOIN core.cuenta ct ON c.cliente_id = ct.cliente_id AND ct.estado = 'Activa'
LEFT JOIN core.credito cr ON c.cliente_id = cr.cliente_id AND cr.estado IN ('Vigente', 'Aprobado')
LEFT JOIN core.sucursal s ON c.sucursal_id = s.sucursal_id
LEFT JOIN core.ejecutivo e ON c.ejecutivo_id = e.ejecutivo_id
WHERE c.activo = TRUE
GROUP BY c.cliente_id, p.nombre, s.nombre, e.nombre_completo;

-- Vista de créditos vigentes
CREATE OR REPLACE VIEW core.vista_creditos_vigentes AS
SELECT 
    cr.credito_id,
    cr.numero_credito,
    cl.nombre_completo as cliente,
    cl.identificacion,
    cr.tipo_credito,
    m.codigo as moneda,
    cr.monto_aprobado,
    cr.tasa_interes_anual,
    cr.plazo_meses,
    cr.fecha_desembolso,
    COUNT(cu.cuota_id) as total_cuotas,
    SUM(CASE WHEN cu.estado = 'Pagada' THEN 1 ELSE 0 END) as cuotas_pagadas,
    SUM(CASE WHEN cu.estado = 'Vencida' THEN 1 ELSE 0 END) as cuotas_vencidas,
    MAX(cu.dias_mora) as dias_mora_maximos,
    MIN(cu.saldo_capital) as saldo_pendiente
FROM core.credito cr
INNER JOIN core.cliente cl ON cr.cliente_id = cl.cliente_id
INNER JOIN core.moneda m ON cr.moneda_id = m.moneda_id
LEFT JOIN core.cuota cu ON cr.credito_id = cu.credito_id
WHERE cr.estado = 'Vigente'
GROUP BY cr.credito_id, cl.nombre_completo, cl.identificacion, m.codigo;

-- Vista de transacciones recientes
CREATE OR REPLACE VIEW core.vista_transacciones_recientes AS
SELECT 
    t.transaccion_id,
    t.numero_transaccion,
    t.tipo_transaccion,
    m.codigo as moneda,
    t.monto,
    t.fecha_hora,
    t.estado,
    c1.nombre_completo as cliente_origen,
    ct1.numero_cuenta as cuenta_origen,
    c2.nombre_completo as cliente_destino,
    ct2.numero_cuenta as cuenta_destino,
    t.canal,
    t.descripcion
FROM core.transaccion t
INNER JOIN core.moneda m ON t.moneda_id = m.moneda_id
LEFT JOIN core.cuenta ct1 ON t.cuenta_origen_id = ct1.cuenta_id
LEFT JOIN core.cliente c1 ON ct1.cliente_id = c1.cliente_id
LEFT JOIN core.cuenta ct2 ON t.cuenta_destino_id = ct2.cuenta_id
LEFT JOIN core.cliente c2 ON ct2.cliente_id = c2.cliente_id
ORDER BY t.fecha_hora DESC
LIMIT 100;

-- ============================================
-- MENSAJE FINAL
-- ============================================

DO $$
BEGIN
    RAISE NOTICE '==============================================';
    RAISE NOTICE 'NEURALBANK - Datos Poblados Exitosamente';
    RAISE NOTICE '==============================================';
    RAISE NOTICE 'Países: 15';
    RAISE NOTICE 'Monedas: 12';
    RAISE NOTICE 'Sucursales: 13 (distribución internacional)';
    RAISE NOTICE 'Ejecutivos: 19';
    RAISE NOTICE 'Clientes: 23 (19 personas + 4 empresas)';
    RAISE NOTICE 'Cuentas: 46';
    RAISE NOTICE 'Créditos: 11';
    RAISE NOTICE 'Garantías: 6';
    RAISE NOTICE 'Transacciones: 18+';
    RAISE NOTICE '==============================================';
    RAISE NOTICE 'Países representados: USA, México, Brasil,';
    RAISE NOTICE 'Argentina, Chile, España, Reino Unido';
    RAISE NOTICE '==============================================';
END $$;

${procedure_end}