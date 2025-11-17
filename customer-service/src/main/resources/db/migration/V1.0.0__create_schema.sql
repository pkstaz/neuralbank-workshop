-- ============================================
-- NEURALBANK - Demo Sistema Bancario
-- Script de Creación de Estructura de Base de Datos
-- PostgreSQL - Versión Internacional
-- ACTUALIZADO: IDs con BIGINT para mejor escalabilidad
-- ============================================

-- Crear Base de Datos (ejecutar como superusuario)
-- CREATE DATABASE neuralbank WITH ENCODING 'UTF8';
-- \c neuralbank

-- ============================================
-- EXTENSIONES
-- ============================================
${create_extensions}

-- ============================================
-- SCHEMAS
-- ============================================
CREATE SCHEMA IF NOT EXISTS core;
CREATE SCHEMA IF NOT EXISTS audit;

-- ============================================
-- TIPOS ENUMERADOS
-- ============================================

CREATE TYPE core.tipo_cliente_enum AS ENUM ('Personal', 'Empresarial', 'Corporativo');
CREATE TYPE core.tipo_cuenta_enum AS ENUM ('Corriente', 'Ahorro', 'Inversion', 'Nomina');
CREATE TYPE core.estado_cuenta_enum AS ENUM ('Activa', 'Bloqueada', 'Cerrada', 'Suspendida');
CREATE TYPE core.tipo_credito_enum AS ENUM ('Consumo', 'Hipotecario', 'Comercial', 'Automotriz', 'Microempresa', 'Personal');
CREATE TYPE core.estado_credito_enum AS ENUM ('Solicitado', 'EnRevision', 'Aprobado', 'Rechazado', 'Desembolsado', 'Vigente', 'Cancelado', 'Vencido', 'Refinanciado');
CREATE TYPE core.estado_cuota_enum AS ENUM ('Pendiente', 'Pagada', 'Vencida', 'Parcial', 'Condonada');
CREATE TYPE core.tipo_garantia_enum AS ENUM ('Hipotecaria', 'Vehicular', 'Valores', 'Efectivo', 'Personal', 'Aval', 'Ninguna');
CREATE TYPE core.estado_garantia_enum AS ENUM ('Vigente', 'Liberada', 'Ejecutada', 'EnProceso');
CREATE TYPE core.tipo_transaccion_enum AS ENUM ('Transferencia', 'Deposito', 'Retiro', 'Pago', 'Compra', 'Reversion', 'Ajuste');
CREATE TYPE core.canal_enum AS ENUM ('Web', 'App', 'ATM', 'Sucursal', 'POS', 'Telefono', 'API');
CREATE TYPE core.estado_transaccion_enum AS ENUM ('Pendiente', 'Procesando', 'Completada', 'Rechazada', 'Reversada', 'Cancelada');
CREATE TYPE core.tipo_cargo_enum AS ENUM ('Comision', 'IVA', 'Impuesto', 'Interes', 'Capital', 'Penalizacion', 'Seguro');

-- ============================================
-- TABLAS
-- ============================================

-- Tabla: PAIS
CREATE TABLE core.pais (
    pais_id BIGSERIAL PRIMARY KEY,
    codigo_iso2 VARCHAR(2) UNIQUE NOT NULL,
    codigo_iso3 VARCHAR(3) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    codigo_telefono VARCHAR(5),
    moneda_codigo VARCHAR(3),
    moneda_nombre VARCHAR(50),
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_pais_codigo_iso2 ON core.pais(codigo_iso2);
CREATE INDEX idx_pais_codigo_iso3 ON core.pais(codigo_iso3);

COMMENT ON TABLE core.pais IS 'Catálogo de países';
COMMENT ON COLUMN core.pais.codigo_iso2 IS 'Código ISO 3166-1 alpha-2';
COMMENT ON COLUMN core.pais.codigo_iso3 IS 'Código ISO 3166-1 alpha-3';

-- Tabla: MONEDA
CREATE TABLE core.moneda (
    moneda_id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(3) UNIQUE NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    simbolo VARCHAR(5),
    decimales SMALLINT DEFAULT 2,
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_moneda_codigo ON core.moneda(codigo);

COMMENT ON TABLE core.moneda IS 'Catálogo de monedas soportadas';
COMMENT ON COLUMN core.moneda.codigo IS 'Código ISO 4217';

-- Tabla: TASA_CAMBIO
CREATE TABLE core.tasa_cambio (
    tasa_cambio_id BIGSERIAL PRIMARY KEY,
    moneda_origen_id BIGINT NOT NULL,
    moneda_destino_id BIGINT NOT NULL,
    tasa NUMERIC(15,6) NOT NULL CHECK (tasa > 0),
    fecha_vigencia TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_tasa_moneda_origen FOREIGN KEY (moneda_origen_id) 
        REFERENCES core.moneda(moneda_id),
    CONSTRAINT fk_tasa_moneda_destino FOREIGN KEY (moneda_destino_id) 
        REFERENCES core.moneda(moneda_id),
    CONSTRAINT uk_tasa_cambio UNIQUE (moneda_origen_id, moneda_destino_id, fecha_vigencia)
);

CREATE INDEX idx_tasa_cambio_fecha ON core.tasa_cambio(fecha_vigencia DESC);

COMMENT ON TABLE core.tasa_cambio IS 'Tasas de cambio entre monedas';

-- Tabla: SUCURSAL
CREATE TABLE core.sucursal (
    sucursal_id BIGSERIAL PRIMARY KEY,
    codigo_sucursal VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    direccion VARCHAR(300),
    ciudad VARCHAR(100),
    estado_provincia VARCHAR(100),
    codigo_postal VARCHAR(20),
    pais_id BIGINT,
    telefono VARCHAR(20),
    email VARCHAR(100),
    horario TEXT,
    latitud NUMERIC(10,8),
    longitud NUMERIC(11,8),
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_sucursal_pais FOREIGN KEY (pais_id) 
        REFERENCES core.pais(pais_id)
);

CREATE INDEX idx_sucursal_pais ON core.sucursal(pais_id);
CREATE INDEX idx_sucursal_ciudad ON core.sucursal(ciudad);
CREATE INDEX idx_sucursal_activo ON core.sucursal(activo);
CREATE INDEX idx_sucursal_ubicacion ON core.sucursal(latitud, longitud);

COMMENT ON TABLE core.sucursal IS 'Sucursales del banco a nivel internacional';

-- Tabla: EJECUTIVO
CREATE TABLE core.ejecutivo (
    ejecutivo_id BIGSERIAL PRIMARY KEY,
    sucursal_id BIGINT,
    codigo_empleado VARCHAR(20) UNIQUE NOT NULL,
    identificacion VARCHAR(50) UNIQUE NOT NULL,
    tipo_identificacion VARCHAR(20),
    nombre_completo VARCHAR(200) NOT NULL,
    email VARCHAR(100),
    telefono VARCHAR(20),
    cargo VARCHAR(100),
    fecha_contratacion DATE,
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_ejecutivo_sucursal FOREIGN KEY (sucursal_id) 
        REFERENCES core.sucursal(sucursal_id) ON DELETE SET NULL
);

CREATE INDEX idx_ejecutivo_sucursal ON core.ejecutivo(sucursal_id);
CREATE INDEX idx_ejecutivo_identificacion ON core.ejecutivo(identificacion);
CREATE INDEX idx_ejecutivo_activo ON core.ejecutivo(activo);

COMMENT ON TABLE core.ejecutivo IS 'Ejecutivos bancarios';
COMMENT ON COLUMN core.ejecutivo.tipo_identificacion IS 'Tipo de documento: DNI, Passport, SSN, RFC, etc.';

-- Tabla: CLIENTE
CREATE TABLE core.cliente (
    cliente_id BIGSERIAL PRIMARY KEY,
    identificacion VARCHAR(50) UNIQUE NOT NULL,
    tipo_identificacion VARCHAR(20),
    nombre VARCHAR(150) NOT NULL,
    apellido VARCHAR(150),
    nombre_completo VARCHAR(300) ${generated_always_as} (nombre || ' ' || COALESCE(apellido, '')) ${generated_stored},
    fecha_nacimiento DATE,
    email VARCHAR(150) UNIQUE,
    telefono VARCHAR(20),
    telefono_alternativo VARCHAR(20),
    direccion VARCHAR(300),
    ciudad VARCHAR(100),
    estado_provincia VARCHAR(100),
    codigo_postal VARCHAR(20),
    pais_id BIGINT,
    tipo_cliente VARCHAR(255) DEFAULT 'PERSONAL',
    score_crediticio NUMERIC(5,2) CHECK (score_crediticio >= 0 AND score_crediticio <= 999.99),
    nivel_riesgo VARCHAR(20),
    fecha_registro DATE DEFAULT CURRENT_DATE,
    activo BOOLEAN DEFAULT TRUE,
    sucursal_id BIGINT,
    ejecutivo_id BIGINT,
    metadata JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_cliente_pais FOREIGN KEY (pais_id) 
        REFERENCES core.pais(pais_id),
    CONSTRAINT fk_cliente_sucursal FOREIGN KEY (sucursal_id) 
        REFERENCES core.sucursal(sucursal_id) ON DELETE SET NULL,
    CONSTRAINT fk_cliente_ejecutivo FOREIGN KEY (ejecutivo_id) 
        REFERENCES core.ejecutivo(ejecutivo_id) ON DELETE SET NULL
);

CREATE INDEX idx_cliente_identificacion ON core.cliente(identificacion);
CREATE INDEX idx_cliente_email ON core.cliente(email);
CREATE INDEX idx_cliente_score ON core.cliente(score_crediticio);
CREATE INDEX idx_cliente_tipo ON core.cliente(tipo_cliente);
CREATE INDEX idx_cliente_pais ON core.cliente(pais_id);
CREATE INDEX idx_cliente_activo ON core.cliente(activo);
CREATE INDEX idx_cliente_metadata ON core.cliente ${using_gin}(metadata);

COMMENT ON TABLE core.cliente IS 'Clientes del banco a nivel internacional';
COMMENT ON COLUMN core.cliente.tipo_identificacion IS 'Tipo de documento: DNI, Passport, SSN, RFC, CURP, etc.';
COMMENT ON COLUMN core.cliente.nivel_riesgo IS 'Clasificación de riesgo: Bajo, Medio, Alto, Muy Alto';
COMMENT ON COLUMN core.cliente.tipo_cliente IS 'Tipo de cliente: PERSONAL, EMPRESARIAL, CORPORATIVO (almacenado como VARCHAR para compatibilidad con Java Enum)';

-- Tabla: CUENTA
CREATE TABLE core.cuenta (
    cuenta_id BIGSERIAL PRIMARY KEY,
    cliente_id BIGINT NOT NULL,
    numero_cuenta VARCHAR(50) UNIQUE NOT NULL,
    iban VARCHAR(34),
    swift_bic VARCHAR(11),
    tipo_cuenta core.tipo_cuenta_enum NOT NULL,
    moneda_id BIGINT NOT NULL,
    saldo_actual NUMERIC(18,2) DEFAULT 0,
    saldo_disponible NUMERIC(18,2) DEFAULT 0,
    saldo_bloqueado NUMERIC(18,2) DEFAULT 0,
    fecha_apertura DATE DEFAULT CURRENT_DATE,
    fecha_cierre DATE,
    estado core.estado_cuenta_enum DEFAULT 'Activa',
    limite_sobregiro NUMERIC(18,2) DEFAULT 0 CHECK (limite_sobregiro >= 0),
    tasa_interes NUMERIC(5,2) DEFAULT 0,
    metadata JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_cuenta_cliente FOREIGN KEY (cliente_id) 
        REFERENCES core.cliente(cliente_id) ON DELETE CASCADE,
    CONSTRAINT fk_cuenta_moneda FOREIGN KEY (moneda_id) 
        REFERENCES core.moneda(moneda_id),
    CONSTRAINT chk_cuenta_fecha_cierre CHECK (fecha_cierre IS NULL OR fecha_cierre >= fecha_apertura),
    CONSTRAINT chk_cuenta_saldos CHECK (saldo_actual = saldo_disponible + saldo_bloqueado)
);

CREATE INDEX idx_cuenta_cliente ON core.cuenta(cliente_id);
CREATE INDEX idx_cuenta_numero ON core.cuenta(numero_cuenta);
CREATE INDEX idx_cuenta_iban ON core.cuenta(iban);
CREATE INDEX idx_cuenta_estado ON core.cuenta(estado);
CREATE INDEX idx_cuenta_tipo ON core.cuenta(tipo_cuenta);
CREATE INDEX idx_cuenta_moneda ON core.cuenta(moneda_id);
CREATE INDEX idx_cuenta_metadata ON core.cuenta ${using_gin}(metadata);

COMMENT ON TABLE core.cuenta IS 'Cuentas bancarias';
COMMENT ON COLUMN core.cuenta.iban IS 'International Bank Account Number';
COMMENT ON COLUMN core.cuenta.swift_bic IS 'Bank Identifier Code';

-- Tabla: CREDITO
CREATE TABLE core.credito (
    credito_id BIGSERIAL PRIMARY KEY,
    cliente_id BIGINT NOT NULL,
    cuenta_desembolso_id BIGINT,
    numero_credito VARCHAR(50) UNIQUE NOT NULL,
    tipo_credito core.tipo_credito_enum NOT NULL,
    moneda_id BIGINT NOT NULL,
    monto_solicitado NUMERIC(18,2) NOT NULL CHECK (monto_solicitado > 0),
    monto_aprobado NUMERIC(18,2) CHECK (monto_aprobado > 0),
    tasa_interes_anual NUMERIC(5,2) NOT NULL CHECK (tasa_interes_anual >= 0),
    tasa_interes_mensual NUMERIC(5,4) ${generated_always_as} (tasa_interes_anual / 12) ${generated_stored},
    plazo_meses INTEGER NOT NULL CHECK (plazo_meses > 0),
    fecha_solicitud DATE NOT NULL,
    fecha_aprobacion DATE,
    fecha_desembolso DATE,
    fecha_primer_vencimiento DATE,
    estado core.estado_credito_enum DEFAULT 'Solicitado',
    destino_credito VARCHAR(300),
    score_aprobacion NUMERIC(5,2),
    ejecutivo_id BIGINT,
    metadata JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_credito_cliente FOREIGN KEY (cliente_id) 
        REFERENCES core.cliente(cliente_id) ON DELETE CASCADE,
    CONSTRAINT fk_credito_cuenta FOREIGN KEY (cuenta_desembolso_id) 
        REFERENCES core.cuenta(cuenta_id) ON DELETE SET NULL,
    CONSTRAINT fk_credito_moneda FOREIGN KEY (moneda_id) 
        REFERENCES core.moneda(moneda_id),
    CONSTRAINT fk_credito_ejecutivo FOREIGN KEY (ejecutivo_id) 
        REFERENCES core.ejecutivo(ejecutivo_id) ON DELETE SET NULL,
    CONSTRAINT chk_credito_fechas CHECK (
        fecha_aprobacion IS NULL OR fecha_aprobacion >= fecha_solicitud
    ),
    CONSTRAINT chk_credito_desembolso CHECK (
        fecha_desembolso IS NULL OR fecha_desembolso >= fecha_aprobacion
    )
);

CREATE INDEX idx_credito_cliente ON core.credito(cliente_id);
CREATE INDEX idx_credito_estado ON core.credito(estado);
CREATE INDEX idx_credito_tipo ON core.credito(tipo_credito);
CREATE INDEX idx_credito_numero ON core.credito(numero_credito);
CREATE INDEX idx_credito_ejecutivo ON core.credito(ejecutivo_id);
CREATE INDEX idx_credito_moneda ON core.credito(moneda_id);
CREATE INDEX idx_credito_metadata ON core.credito ${using_gin}(metadata);

COMMENT ON TABLE core.credito IS 'Créditos otorgados';
COMMENT ON COLUMN core.credito.tasa_interes_anual IS 'Tasa de interés nominal anual';

-- Tabla: CUOTA
CREATE TABLE core.cuota (
    cuota_id BIGSERIAL PRIMARY KEY,
    credito_id BIGINT NOT NULL,
    numero_cuota INTEGER NOT NULL CHECK (numero_cuota > 0),
    fecha_vencimiento DATE NOT NULL,
    monto_cuota NUMERIC(18,2) NOT NULL CHECK (monto_cuota > 0),
    monto_capital NUMERIC(18,2) NOT NULL CHECK (monto_capital >= 0),
    monto_interes NUMERIC(18,2) NOT NULL CHECK (monto_interes >= 0),
    monto_otros_cargos NUMERIC(18,2) DEFAULT 0 CHECK (monto_otros_cargos >= 0),
    saldo_capital NUMERIC(18,2) NOT NULL CHECK (saldo_capital >= 0),
    fecha_pago DATE,
    monto_pagado NUMERIC(18,2) DEFAULT 0 CHECK (monto_pagado >= 0),
    estado core.estado_cuota_enum DEFAULT 'Pendiente',
    dias_mora INTEGER DEFAULT 0 CHECK (dias_mora >= 0),
    monto_mora NUMERIC(18,2) DEFAULT 0 CHECK (monto_mora >= 0),
    metadata JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_cuota_credito FOREIGN KEY (credito_id) 
        REFERENCES core.credito(credito_id) ON DELETE CASCADE,
    CONSTRAINT uk_cuota_credito_numero UNIQUE (credito_id, numero_cuota)
);

CREATE INDEX idx_cuota_credito ON core.cuota(credito_id);
CREATE INDEX idx_cuota_fecha_vencimiento ON core.cuota(fecha_vencimiento);
CREATE INDEX idx_cuota_estado ON core.cuota(estado);
CREATE INDEX idx_cuota_mora ON core.cuota(dias_mora) ${partial_index_filter};

COMMENT ON TABLE core.cuota IS 'Cuotas de créditos';
COMMENT ON COLUMN core.cuota.dias_mora IS 'Días transcurridos desde el vencimiento sin pago';

-- Tabla: GARANTIA
CREATE TABLE core.garantia (
    garantia_id BIGSERIAL PRIMARY KEY,
    credito_id BIGINT NOT NULL,
    tipo_garantia core.tipo_garantia_enum NOT NULL,
    descripcion TEXT,
    valor_tasacion NUMERIC(18,2) CHECK (valor_tasacion >= 0),
    moneda_id BIGINT,
    direccion VARCHAR(300),
    fecha_tasacion DATE,
    estado core.estado_garantia_enum DEFAULT 'Vigente',
    metadata JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_garantia_credito FOREIGN KEY (credito_id) 
        REFERENCES core.credito(credito_id) ON DELETE CASCADE,
    CONSTRAINT fk_garantia_moneda FOREIGN KEY (moneda_id) 
        REFERENCES core.moneda(moneda_id)
);

CREATE INDEX idx_garantia_credito ON core.garantia(credito_id);
CREATE INDEX idx_garantia_tipo ON core.garantia(tipo_garantia);
CREATE INDEX idx_garantia_estado ON core.garantia(estado);

COMMENT ON TABLE core.garantia IS 'Garantías asociadas a créditos';

-- Tabla: TRANSACCION
CREATE TABLE core.transaccion (
    transaccion_id BIGSERIAL PRIMARY KEY,
    cuenta_origen_id BIGINT,
    cuenta_destino_id BIGINT,
    numero_transaccion VARCHAR(50) UNIQUE NOT NULL,
    uuid_transaccion UUID DEFAULT ${uuid_function},
    tipo_transaccion core.tipo_transaccion_enum NOT NULL,
    canal core.canal_enum NOT NULL,
    monto NUMERIC(18,2) NOT NULL CHECK (monto > 0),
    moneda_id BIGINT NOT NULL,
    tasa_cambio NUMERIC(15,6),
    monto_convertido NUMERIC(18,2),
    moneda_convertida_id BIGINT,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_valor DATE,
    estado core.estado_transaccion_enum DEFAULT 'Completada',
    descripcion VARCHAR(300),
    referencia_externa VARCHAR(100),
    codigo_autorizacion VARCHAR(50),
    ip_origen ${type_inet},
    metadata JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_transaccion_cuenta_origen FOREIGN KEY (cuenta_origen_id) 
        REFERENCES core.cuenta(cuenta_id) ON DELETE SET NULL,
    CONSTRAINT fk_transaccion_cuenta_destino FOREIGN KEY (cuenta_destino_id) 
        REFERENCES core.cuenta(cuenta_id) ON DELETE SET NULL,
    CONSTRAINT fk_transaccion_moneda FOREIGN KEY (moneda_id) 
        REFERENCES core.moneda(moneda_id),
    CONSTRAINT fk_transaccion_moneda_convertida FOREIGN KEY (moneda_convertida_id) 
        REFERENCES core.moneda(moneda_id),
    CONSTRAINT chk_transaccion_cuentas CHECK (
        cuenta_origen_id IS NOT NULL OR cuenta_destino_id IS NOT NULL
    )
);

CREATE INDEX idx_transaccion_cuenta_origen ON core.transaccion(cuenta_origen_id);
CREATE INDEX idx_transaccion_cuenta_destino ON core.transaccion(cuenta_destino_id);
CREATE INDEX idx_transaccion_fecha_hora ON core.transaccion(fecha_hora DESC);
CREATE INDEX idx_transaccion_tipo ON core.transaccion(tipo_transaccion);
CREATE INDEX idx_transaccion_estado ON core.transaccion(estado);
CREATE INDEX idx_transaccion_numero ON core.transaccion(numero_transaccion);
CREATE INDEX idx_transaccion_uuid ON core.transaccion(uuid_transaccion);
CREATE INDEX idx_transaccion_metadata ON core.transaccion ${using_gin}(metadata);

COMMENT ON TABLE core.transaccion IS 'Transacciones bancarias';
COMMENT ON COLUMN core.transaccion.fecha_valor IS 'Fecha en que la transacción es efectiva';

-- Tabla: DETALLE_TRANSACCION
CREATE TABLE core.detalle_transaccion (
    detalle_id BIGSERIAL PRIMARY KEY,
    transaccion_id BIGINT NOT NULL,
    concepto VARCHAR(150),
    monto NUMERIC(18,2) NOT NULL CHECK (monto >= 0),
    tipo_cargo core.tipo_cargo_enum NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_detalle_transaccion FOREIGN KEY (transaccion_id) 
        REFERENCES core.transaccion(transaccion_id) ON DELETE CASCADE
);

CREATE INDEX idx_detalle_transaccion ON core.detalle_transaccion(transaccion_id);
CREATE INDEX idx_detalle_tipo_cargo ON core.detalle_transaccion(tipo_cargo);

COMMENT ON TABLE core.detalle_transaccion IS 'Detalles de transacciones (comisiones, impuestos, etc.)';

-- Tabla: AUDITORIA
CREATE TABLE audit.auditoria (
    auditoria_id BIGSERIAL PRIMARY KEY,
    tabla_afectada VARCHAR(100) NOT NULL,
    registro_id BIGINT NOT NULL,
    accion VARCHAR(20) NOT NULL,
    usuario VARCHAR(150),
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    datos_anteriores JSONB,
    datos_nuevos JSONB,
    ip_address ${type_inet},
    user_agent TEXT,
    session_id VARCHAR(100)
);

CREATE INDEX idx_auditoria_tabla ON audit.auditoria(tabla_afectada);
CREATE INDEX idx_auditoria_fecha ON audit.auditoria(fecha_hora DESC);
CREATE INDEX idx_auditoria_registro ON audit.auditoria(tabla_afectada, registro_id);
CREATE INDEX idx_auditoria_usuario ON audit.auditoria(usuario);

COMMENT ON TABLE audit.auditoria IS 'Registro de auditoría de operaciones';


UPDATE core.cliente 
SET tipo_cliente = CASE 
    WHEN tipo_cliente = 'Personal' THEN 'PERSONAL'
    WHEN tipo_cliente = 'Empresarial' THEN 'EMPRESARIAL'
    WHEN tipo_cliente = 'Corporativo' THEN 'CORPORATIVO'
    ELSE tipo_cliente
END;

-- ============================================
-- FUNCIONES Y TRIGGERS
-- ============================================

${procedure_start}

-- Función para actualizar updated_at
CREATE OR REPLACE FUNCTION core.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Aplicar trigger a todas las tablas con updated_at
CREATE TRIGGER update_pais_updated_at BEFORE UPDATE ON core.pais
    FOR EACH ROW EXECUTE FUNCTION core.update_updated_at_column();

CREATE TRIGGER update_moneda_updated_at BEFORE UPDATE ON core.moneda
    FOR EACH ROW EXECUTE FUNCTION core.update_updated_at_column();

CREATE TRIGGER update_sucursal_updated_at BEFORE UPDATE ON core.sucursal
    FOR EACH ROW EXECUTE FUNCTION core.update_updated_at_column();

CREATE TRIGGER update_ejecutivo_updated_at BEFORE UPDATE ON core.ejecutivo
    FOR EACH ROW EXECUTE FUNCTION core.update_updated_at_column();

CREATE TRIGGER update_cliente_updated_at BEFORE UPDATE ON core.cliente
    FOR EACH ROW EXECUTE FUNCTION core.update_updated_at_column();

CREATE TRIGGER update_cuenta_updated_at BEFORE UPDATE ON core.cuenta
    FOR EACH ROW EXECUTE FUNCTION core.update_updated_at_column();

CREATE TRIGGER update_credito_updated_at BEFORE UPDATE ON core.credito
    FOR EACH ROW EXECUTE FUNCTION core.update_updated_at_column();

CREATE TRIGGER update_cuota_updated_at BEFORE UPDATE ON core.cuota
    FOR EACH ROW EXECUTE FUNCTION core.update_updated_at_column();

CREATE TRIGGER update_garantia_updated_at BEFORE UPDATE ON core.garantia
    FOR EACH ROW EXECUTE FUNCTION core.update_updated_at_column();

CREATE TRIGGER update_transaccion_updated_at BEFORE UPDATE ON core.transaccion
    FOR EACH ROW EXECUTE FUNCTION core.update_updated_at_column();

-- Función para calcular días de mora
CREATE OR REPLACE FUNCTION core.calcular_dias_mora()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.estado IN ('Vencida', 'Parcial') AND NEW.fecha_pago IS NULL THEN
        NEW.dias_mora := EXTRACT(DAY FROM (CURRENT_DATE - NEW.fecha_vencimiento))::INTEGER;
        IF NEW.dias_mora < 0 THEN
            NEW.dias_mora := 0;
        END IF;
    ELSIF NEW.estado = 'Pagada' THEN
        NEW.dias_mora := 0;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_calcular_dias_mora BEFORE INSERT OR UPDATE ON core.cuota
    FOR EACH ROW EXECUTE FUNCTION core.calcular_dias_mora();

-- Función para generar número de transacción
CREATE OR REPLACE FUNCTION core.generar_numero_transaccion()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.numero_transaccion IS NULL OR NEW.numero_transaccion = '' THEN
        NEW.numero_transaccion := 'TRX' || 
            TO_CHAR(CURRENT_TIMESTAMP, 'YYYYMMDD') || 
            LPAD(nextval('core.transaccion_transaccion_id_seq')::TEXT, 10, '0');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_generar_numero_transaccion 
    BEFORE INSERT ON core.transaccion
    FOR EACH ROW EXECUTE FUNCTION core.generar_numero_transaccion();

-- Función para auditoría automática (actualizada para BIGINT)
CREATE OR REPLACE FUNCTION audit.registrar_auditoria()
RETURNS TRIGGER AS $$
DECLARE
    registro_id_value BIGINT;
BEGIN
    -- Intentar obtener el ID del registro
    IF (TG_OP = 'DELETE') THEN
        registro_id_value := OLD.cliente_id;
        INSERT INTO audit.auditoria (
            tabla_afectada, 
            registro_id, 
            accion, 
            usuario, 
            datos_anteriores
        ) VALUES (
            TG_TABLE_SCHEMA || '.' || TG_TABLE_NAME, 
            registro_id_value, 
            TG_OP, 
            current_user, 
            row_to_json(OLD)
        );
        RETURN OLD;
    ELSIF (TG_OP = 'UPDATE') THEN
        registro_id_value := NEW.cliente_id;
        INSERT INTO audit.auditoria (
            tabla_afectada, 
            registro_id, 
            accion, 
            usuario, 
            datos_anteriores, 
            datos_nuevos
        ) VALUES (
            TG_TABLE_SCHEMA || '.' || TG_TABLE_NAME, 
            registro_id_value, 
            TG_OP, 
            current_user, 
            row_to_json(OLD), 
            row_to_json(NEW)
        );
        RETURN NEW;
    ELSIF (TG_OP = 'INSERT') THEN
        registro_id_value := NEW.cliente_id;
        INSERT INTO audit.auditoria (
            tabla_afectada, 
            registro_id, 
            accion, 
            usuario, 
            datos_nuevos
        ) VALUES (
            TG_TABLE_SCHEMA || '.' || TG_TABLE_NAME, 
            registro_id_value, 
            TG_OP, 
            current_user, 
            row_to_json(NEW)
        );
        RETURN NEW;
    END IF;
    RETURN NULL;
EXCEPTION
    WHEN OTHERS THEN
        -- Si hay error, continuar sin auditar
        RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

-- ============================================
-- FIN DEL SCRIPT DE ESTRUCTURA
-- ============================================

-- Mensaje de confirmación
DO $$
BEGIN
    RAISE NOTICE '==============================================';
    RAISE NOTICE 'NEURALBANK - Estructura de Base de Datos Creada';
    RAISE NOTICE 'PostgreSQL - Versión Internacional';
    RAISE NOTICE 'ACTUALIZADO: IDs con BIGINT para escalabilidad';
    RAISE NOTICE '==============================================';
    RAISE NOTICE 'Schemas: core, audit';
    RAISE NOTICE 'Tablas principales: 14';
    RAISE NOTICE 'Tipos enumerados: 12';
    RAISE NOTICE 'Funciones: 5';
    RAISE NOTICE 'Triggers: 13';
    RAISE NOTICE '==============================================';
    RAISE NOTICE 'Soporte multi-país, multi-moneda';
    RAISE NOTICE 'Soporte IBAN, SWIFT/BIC';
    RAISE NOTICE 'Campos metadata JSONB para flexibilidad';
    RAISE NOTICE 'IDs: BIGSERIAL para mejor escalabilidad';
    RAISE NOTICE '==============================================';
END $$;

${procedure_end}