-- Q1. ¿Cuántas transacciones completadas hubo por mes? Devolvé: mes (formato
-- YYYY-MM), cantidad de transacciones y monto total (solo moneda ARS).

SELECT
    DATE_FORMAT(t.created_at, '%Y-%m') AS mes,
    COUNT(*)                           AS cantidad_transacciones,
    SUM(t.amount)                      AS monto_total_ars
FROM transactions t
WHERE t.status = 'completed'
  AND t.currency = 'ARS'
GROUP BY mes
ORDER BY mes;
