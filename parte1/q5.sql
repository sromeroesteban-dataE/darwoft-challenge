-- Q5. Identificá los usuarios que se registraron en enero 2024 y realizaron
-- al menos una transacción completada en cada uno de los 2 meses siguientes
-- a su signup. Devolvé sus user_id.

SELECT u.user_id
FROM users u
JOIN accounts a
    ON a.user_id = u.user_id
JOIN transactions t
    ON t.account_id = a.account_id
    AND t.status = 'completed'
WHERE u.signup_date BETWEEN '2024-01-01' AND '2024-01-31'
GROUP BY u.user_id
HAVING
    COUNT(CASE WHEN t.created_at >= '2024-02-01' AND t.created_at < '2024-03-01' THEN 1 END) > 0
    AND
    COUNT(CASE WHEN t.created_at >= '2024-03-01' AND t.created_at < '2024-04-01' THEN 1 END) > 0
ORDER BY u.user_id;
