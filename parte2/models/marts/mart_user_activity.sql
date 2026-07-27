-- 2.b — Modelo mart
-- Creá el modelo mart_user_activity.sql que consolide, por usuario y mes:
-- - Cantidad de transacciones completadas
-- - Monto total de créditos (depósitos e ingresos)
-- - Monto total de débitos (pagos y retiros)
-- - Saldo neto del mes
-- El modelo debe referenciar stg_transactions usando {{ ref() }}.

with stg_transactions as (

    select * from {{ ref('stg_transactions') }}

),

accounts as (

    select * from {{ source('raw', 'accounts') }}

),

completed_only as (

    select *
    from stg_transactions
    where status = 'completed'

),

joined as (

    select
        a.user_id,
        date_format(t.created_at, '%Y-%m') as mes,
        t.amount,
        t.is_credit

    from completed_only t
    inner join accounts a
        on a.account_id = t.account_id

),

monthly_activity as (

    select
        user_id,
        mes,
        count(*)                                                      as cantidad_transacciones_completadas,
        sum(case when is_credit = 'TRUE' then amount else 0 end)      as monto_total_creditos,
        sum(case when is_credit = 'FALSE' then amount else 0 end)     as monto_total_debitos,
        sum(amount)                                                   as saldo_neto_mes

    from joined
    group by user_id, mes

)

select * from monthly_activity
order by user_id, mes
