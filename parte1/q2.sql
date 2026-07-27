-- Q2. Para cada usuario, calculá el saldo neto acumulado considerando
-- únicamente transacciones completadas. Devolvé: user_id y saldo_neto.
-- Ordená de mayor a menor saldo.

SELECT
    u.user_id,
    COALESCE(SUM(t.amount), 0) AS saldo_neto
FROM users u
LEFT JOIN accounts a
    ON a.user_id = u.user_id
LEFT JOIN transactions t
    ON t.account_id = a.account_id
    AND t.status = 'completed'
GROUP BY u.user_id
ORDER BY saldo_neto DESC;
