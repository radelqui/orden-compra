# 🔧 SOLUCIÓN: Error de Firma del Cliente

## ❌ Error Actual

```
Error al guardar la firma: new row violates row-level security policy for table "ordenes_servicio"
401 Unauthorized
```

## ✅ Solución: Configurar Políticas RLS en Supabase

El cliente no puede firmar porque Supabase tiene **Row-Level Security (RLS)** habilitado pero **sin políticas**.

### Pasos para Solucionar:

#### 1. Acceder al Panel de Supabase

1. Ve a https://supabase.com/dashboard
2. Login con tu cuenta
3. Selecciona tu proyecto: **trgqcvfhmrkceyguckol**

#### 2. Abrir el SQL Editor

1. En el menú lateral, busca **SQL Editor** (icono de consola)
2. Click en **New Query**

#### 3. Ejecutar el SQL

1. Abre el archivo `SUPABASE_RLS_POLICIES.sql` de este repositorio
2. **Copia TODO el contenido**
3. **Pega** en el SQL Editor de Supabase
4. Click en **RUN** (botón verde en la esquina inferior derecha)

#### 4. Verificar que Funcionó

Deberías ver un mensaje de éxito:

```
Success. No rows returned
```

Luego ejecuta esta query de verificación:

```sql
SELECT schemaname, tablename, policyname, roles, cmd
FROM pg_policies
WHERE tablename = 'ordenes_servicio';
```

Deberías ver **3 políticas**:
1. ✅ `Permitir crear órdenes` (INSERT)
2. ✅ `Permitir leer órdenes` (SELECT)
3. ✅ `Permitir actualizar firma cliente` (UPDATE)

### 5. Probar la Firma del Cliente

1. Ve a https://app.huyghusrl.com/orden-compra/online.html
2. Crea una nueva orden
3. Copia el link del cliente
4. Abre el link en otra pestaña
5. Firma como cliente
6. Click en "Firmar y Descargar PDF"
7. ✅ Debería funcionar ahora!

---

## 🔒 Seguridad

Estas políticas son **permisivas** (permiten a todos leer y actualizar) porque:

- ✅ Es una aplicación **interna** de HYGHU
- ✅ Los links usan **UUID únicos** imposibles de adivinar
- ✅ Solo HYGHU conoce los links y los comparte con clientes específicos
- ✅ No hay información sensible más allá de facturas de negocio

Si en el futuro necesitas más seguridad, puedes:
- Agregar autenticación de usuarios
- Limitar políticas por `auth.uid()`
- Agregar validaciones por IP o dominio

---

## 📞 Soporte

Si tienes problemas:
1. Revisa que las 3 políticas estén creadas
2. Verifica que RLS esté habilitado: `ALTER TABLE ordenes_servicio ENABLE ROW LEVEL SECURITY;`
3. Revisa la consola del navegador (F12) para ver errores específicos

¡Listo! Tu sistema de órdenes debería funcionar perfectamente después de ejecutar el SQL. 🎉
