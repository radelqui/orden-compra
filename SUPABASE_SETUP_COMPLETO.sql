-- ========================================
-- SETUP COMPLETO DE SUPABASE
-- ========================================
--
-- Este script hace una instalación limpia:
-- 1. Elimina políticas existentes (si las hay)
-- 2. Crea la tabla si no existe
-- 3. Crea las políticas RLS
--
-- ========================================

-- PASO 1: Eliminar políticas existentes (si las hay)
DROP POLICY IF EXISTS "Permitir crear órdenes" ON ordenes_servicio;
DROP POLICY IF EXISTS "Permitir leer órdenes" ON ordenes_servicio;
DROP POLICY IF EXISTS "Permitir actualizar firma cliente" ON ordenes_servicio;

-- PASO 2: Crear la tabla (solo si no existe)
CREATE TABLE IF NOT EXISTS ordenes_servicio (
    id UUID PRIMARY KEY,
    cliente_nombre VARCHAR(255),
    cliente_telefono VARCHAR(50),
    cliente_email VARCHAR(255),
    cliente_direccion TEXT,
    cliente_rnc VARCHAR(50),
    orden_numero VARCHAR(50),
    fecha_emision DATE,
    servicios JSONB,
    subtotal DECIMAL(10,2),
    itbis DECIMAL(10,2),
    descuentos DECIMAL(10,2),
    total DECIMAL(10,2),
    observaciones TEXT,
    modalidad_pago VARCHAR(100),
    condiciones_pago VARCHAR(255),
    firma_hyghu TEXT,
    hyghu_firmante VARCHAR(255),
    fecha_firma_hyghu TIMESTAMP,
    firma_cliente TEXT,
    cliente_firmante VARCHAR(255),
    fecha_firma_cliente TIMESTAMP,
    estado VARCHAR(50),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- PASO 2.5: Agregar columna condiciones_pago si la tabla ya existe
-- (Este comando fallará si la columna ya existe, pero eso es OK)
ALTER TABLE ordenes_servicio ADD COLUMN IF NOT EXISTS condiciones_pago VARCHAR(255);

-- PASO 3: Habilitar RLS
ALTER TABLE ordenes_servicio ENABLE ROW LEVEL SECURITY;

-- PASO 4: Crear políticas RLS (ahora que están eliminadas)
CREATE POLICY "Permitir crear órdenes"
ON ordenes_servicio
FOR INSERT
TO anon, authenticated
WITH CHECK (true);

CREATE POLICY "Permitir leer órdenes"
ON ordenes_servicio
FOR SELECT
TO anon, authenticated
USING (true);

CREATE POLICY "Permitir actualizar firma cliente"
ON ordenes_servicio
FOR UPDATE
TO anon, authenticated
USING (true)
WITH CHECK (true);

-- PASO 5: Crear índices para mejor rendimiento
CREATE INDEX IF NOT EXISTS idx_ordenes_orden_numero ON ordenes_servicio(orden_numero);
CREATE INDEX IF NOT EXISTS idx_ordenes_estado ON ordenes_servicio(estado);
CREATE INDEX IF NOT EXISTS idx_ordenes_created_at ON ordenes_servicio(created_at);

-- ========================================
-- ✅ LISTO! Tu base de datos está configurada
-- ========================================
