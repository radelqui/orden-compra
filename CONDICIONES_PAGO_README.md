# Condiciones de Pago - Nueva Funcionalidad

## Descripción

Se ha agregado un nuevo campo opcional **"Condiciones de Pago"** que permite a HYGHU especificar condiciones especiales de pago para clientes selectos.

## Características

- **Campo Opcional**: Solo se debe usar para clientes específicos que requieran condiciones especiales
- **No es Estándar**: La mayoría de órdenes NO necesitan este campo
- **Selectivo**: HYGHU decide cuándo aplicar estas condiciones

## Opciones Disponibles

1. **(Vacío)** - Dejar sin seleccionar (por defecto para la mayoría de clientes)
2. **Pago completo al finalizar el servicio** - Pago estándar después de completar el trabajo
3. **50% de anticipo + 50% al finalizar el servicio** - Para clientes que requieren pago adelantado

## Cómo Usar

### En online.html (Crear Orden)

1. Completa todos los datos del cliente y servicios como siempre
2. Selecciona la "Modalidad de Pago" (Transferencia o Cheque) - **OBLIGATORIO**
3. **Opcional**: Si el cliente requiere condiciones especiales:
   - Despliega el dropdown "Condiciones de Pago"
   - Selecciona la opción apropiada
   - Si no aplica, déjalo en "-- Seleccionar (dejar vacío si no aplica) --"

### Visualización para el Cliente

- Si se especificó una condición de pago, aparecerá en:
  - La vista HTML del cliente (sección destacada)
  - El PDF descargado (sección "CONDICIONES DE PAGO:")
- Si NO se especificó, no aparece ninguna sección (comportamiento normal)

## Actualizar Base de Datos Supabase

**IMPORTANTE**: Debes ejecutar este SQL en Supabase para agregar la columna:

### Opción 1: Ejecutar Todo el Script (Recomendado)

1. Ve a https://supabase.com/dashboard
2. Abre tu proyecto: **trgqcvfhmrkceyguckol**
3. Ve a **SQL Editor** → **New Query**
4. Copia y pega TODO el contenido de `SUPABASE_SETUP_COMPLETO.sql`
5. Click en **RUN**

### Opción 2: Solo Agregar la Columna (Si la tabla ya existe)

Si ya tienes la tabla creada y solo necesitas agregar la columna:

```sql
-- Agregar columna condiciones_pago a tabla existente
ALTER TABLE ordenes_servicio ADD COLUMN IF NOT EXISTS condiciones_pago VARCHAR(255);
```

1. Ve a https://supabase.com/dashboard
2. Abre tu proyecto: **trgqcvfhmrkceyguckol**
3. Ve a **SQL Editor** → **New Query**
4. Pega el comando de arriba
5. Click en **RUN**

### Verificar que Funcionó

Ejecuta esta query para ver la estructura de la tabla:

```sql
SELECT column_name, data_type, character_maximum_length
FROM information_schema.columns
WHERE table_name = 'ordenes_servicio'
ORDER BY ordinal_position;
```

Deberías ver la columna `condiciones_pago` con tipo `character varying` y longitud `255`.

## Ejemplo de Uso

### Caso 1: Cliente Normal (Sin Condiciones Especiales)

- Cliente: "Constructora ABC"
- Modalidad de Pago: "Transferencia Bancaria"
- Condiciones de Pago: **(Dejar vacío)**
- **Resultado**: La orden se crea normalmente sin sección de condiciones especiales

### Caso 2: Cliente con 50% Anticipo

- Cliente: "Empresa XYZ SRL"
- Modalidad de Pago: "Transferencia Bancaria"
- Condiciones de Pago: **"50% de anticipo + 50% al finalizar el servicio"**
- **Resultado**: El cliente ve en el PDF una sección destacada indicando que debe pagar 50% por adelantado

## Notas Importantes

- Este campo fue diseñado para ser **OPCIONAL Y SELECTIVO**
- NO todas las órdenes deben tener condiciones de pago especificadas
- Solo úsalo cuando el cliente específicamente requiera estas condiciones
- La mayoría de órdenes deben dejarlo vacío

## Soporte

Si tienes dudas sobre cuándo usar este campo, considera:

- ¿El cliente específicamente solicitó pagar por adelantado? → Usa "50% anticipo"
- ¿Es un cliente nuevo o de alto riesgo? → Considera "50% anticipo"
- ¿Es un cliente regular sin requisitos especiales? → Deja vacío
- ¿Quieres especificar el pago estándar explícitamente? → Usa "Pago completo al finalizar"

---

**Versión**: 1.0
**Fecha**: 2025-10-29
**Desarrollado por**: HYGHU & ASOCIADOS con Claude Code
