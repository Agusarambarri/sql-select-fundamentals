sql
-- ══════════════════════════════════════════
-- TechStore — Consultas Básicas SELECT
-- Autor: Agustina Arambarri
-- Fecha: 05/08/2026
-- ══════════════════════════════════════════
-- Consulta 1: Exploración general de la tabla sales
Select * From sales;

-- Consulta 2: Selección de columnas específicas para finanzas
Select customer_id, product_id, total_amount From sales;

-- Consulta 3: Selección con alias en español para stakeholders
Select order_date AS fecha_pedido, product_name AS nombre_producto, quantity AS cantidad_unidades From SALES;

