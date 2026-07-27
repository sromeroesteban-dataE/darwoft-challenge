-- Q4. ¿Qué porcentaje de transacciones falló, por tipo de transacción?
-- Devolvé: transaction_type, total de transacciones, cantidad fallidas y
-- tasa de fallo (como porcentaje redondeado a 2 decimales).

SELECT
    t.transaction_type,
    COUNT(*)                                                       AS total_transacciones,
    COUNT(CASE WHEN t.status = 'failed' THEN 1 END)                AS cantidad_fallidas,
    ROUND(100 * COUNT(CASE WHEN t.status = 'failed' THEN 1 END) / COUNT(*), 2) AS tasa_fallo_pct
FROM transactions t
GROUP BY t.transaction_type
ORDER BY tasa_fallo_pct DESC;
