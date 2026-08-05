# sql-select-fundamentals

Consultas básicas SELECT y alias — TechStore
**Autora:** Agustina Arambarri | **Fecha:** 05/08/2026

---

## 1. ¿Por qué es mala práctica usar `SELECT *` en producción?

**Rendimiento.** Pedir todas las columnas obliga a la base a leer, procesar y enviar datos que después se descartan. El equipo de finanzas necesita 3 columnas de las 9 que tiene `sales`: las otras 6 viajan al pedo.

```sql
SELECT * FROM sales;                                        -- 9 columnas
SELECT customer_id, product_id, total_amount FROM sales;    -- 3 columnas
```

Con 10 filas no se nota. Con millones de registros y columnas de texto largo, se traduce en consultas lentas y más costo de infraestructura.

**Mantenibilidad.** `SELECT *` devuelve lo que la tabla tenga al momento de ejecutarse, no lo que tenía cuando escribiste la consulta. Si alguien agrega una columna, tu reporte la incorpora sin avisar; si alguien la elimina o renombra, el proceso se rompe. Nombrando las columnas, la consulta declara qué necesita y falla con un error claro en vez de arrastrar el problema hasta el dashboard.

**Seguridad.** Si mañana a `sales` le agregan el email o el documento del cliente, todo reporte con `SELECT *` empieza a incluirlo automáticamente. Nombrar columnas es exposición mínima: solo sale lo que decidiste que salga.

> `SELECT *` sirve para explorar una tabla que no conocés. En cualquier consulta que quede escrita en un reporte o un pipeline, las columnas van nombradas una por una.

---

## 2. ¿Por qué son importantes los alias para un stakeholder no técnico?

Los nombres de columna están escritos para el motor y para quien programa: técnicos, en inglés, abreviados. Quien recibe el reporte no conoce el esquema ni tiene por qué conocerlo. La cláusula `AS` renombra la columna solo en el resultado, sin tocar la tabla.

**Ejemplo con `total_amount`:**

| order_date | product_name | quantity | total_amount |
|---|---|---|---|
| 2024-01-05 | Laptop Pro 15 | 2 | 2400.00 |

Frente a `total_amount`, finanzas tiene que preguntar: ¿es el total del pedido o de esta línea? ¿Incluye IVA? El nombre técnico no lo aclara, y la duda vuelve al analista.

```sql
SELECT total_amount AS monto_total FROM sales;
```

| fecha_pedido | nombre_producto | cantidad_unidades | monto_total |
|---|---|---|---|
| 2024-01-05 | Laptop Pro 15 | 2 | 2400.00 |

`total_amount` pasó de ser un campo que hay que interpretar a `monto_total`: una etiqueta que cualquiera del área entiende sin consultar a nadie. Además, si estos datos se exportan a Excel o Power BI, los encabezados ya vienen listos y no hay que renombrarlos en cada actualización.

**Siempre `snake_case`:** `AS Monto Total` da error de sintaxis y `AS "Monto Total"` obliga a usar comillas en toda referencia posterior. Minúsculas, sin acentos, guion bajo.
