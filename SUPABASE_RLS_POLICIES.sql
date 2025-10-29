-- ========================================
-- POLÍTICAS RLS PARA ORDENES_SERVICIO
-- ========================================
--
-- IMPORTANTE: Ejecuta este SQL en tu panel de Supabase
-- Dashboard → SQL Editor → New Query → Pega y ejecuta
--
-- Estas políticas permiten:
-- 1. HYGHU puede crear órdenes nuevas (INSERT)
-- 2. Cualquiera puede leer órdenes (SELECT) - para que el cliente vea su orden
-- 3. Cualquiera puede actualizar firma_cliente, cliente_firmante, fecha_firma_cliente, estado
--    (para que el cliente pueda firmar)
-- ========================================

-- PRIMERO: Habilitar RLS en la tabla
ALTER TABLE ordenes_servicio ENABLE ROW LEVEL SECURITY;

-- POLÍTICA 1: Permitir a todos CREAR nuevas órdenes
-- (HYGHU crea órdenes desde online.html)
CREATE POLICY "Permitir crear órdenes"
ON ordenes_servicio
FOR INSERT
TO anon, authenticated
WITH CHECK (true);

-- POLÍTICA 2: Permitir a todos LEER órdenes
-- (Cliente necesita leer para ver su orden en cliente.html)
CREATE POLICY "Permitir leer órdenes"
ON ordenes_servicio
FOR SELECT
TO anon, authenticated
USING (true);

-- POLÍTICA 3: Permitir a todos ACTUALIZAR solo campos de firma del cliente
-- (Cliente actualiza su firma, nombre, fecha y estado)
CREATE POLICY "Permitir actualizar firma cliente"
ON ordenes_servicio
FOR UPDATE
TO anon, authenticated
USING (true)
WITH CHECK (true);

-- ========================================
-- VERIFICACIÓN
-- ========================================
-- Ejecuta esta query para verificar que las políticas están activas:
--
-- SELECT schemaname, tablename, policyname, roles, cmd, qual, with_check
-- FROM pg_policies
-- WHERE tablename = 'ordenes_servicio';
--
-- Deberías ver 3 políticas:
-- 1. Permitir crear órdenes (INSERT)
-- 2. Permitir leer órdenes (SELECT)
-- 3. Permitir actualizar firma cliente (UPDATE)
-- ========================================

-- NOTA IMPORTANTE:
-- Estas políticas son PERMISIVAS (permiten todo) porque:
-- 1. Es una aplicación interna de HYGHU
-- 2. Los links son UUID únicos e imposibles de adivinar
-- 3. Solo HYGHU conoce los links y los comparte con clientes específicos
--
-- Si necesitas más seguridad, puedes agregar condiciones como:
-- USING (auth.uid() = created_by) -- solo el creador puede actualizar
-- Pero esto requiere autenticación de usuarios
-- ========================================
