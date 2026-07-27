-- Q3. Mostrá, para cada cuenta, el saldo acumulado transacción por
-- transacción (running balance) en orden cronológico. Incluí solo
-- transacciones completadas.

SELECT
    t.account_id,
    t.transaction_id,
    t.created_at,
    t.amount,
    SUM(t.amount) OVER (
        PARTITION BY t.account_id
        ORDER BY t.created_at, t.transaction_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS saldo_acumulado
FROM transactions t
WHERE t.status = 'completed'
ORDER BY t.account_id, t.created_at, t.transaction_id;
