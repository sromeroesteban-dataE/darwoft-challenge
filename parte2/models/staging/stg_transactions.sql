-- 2.a — Modelo de staging
-- Creá el modelo stg_transactions.sql que:
-- - Lea desde {{ source('raw', 'transactions') }}
-- - Castee amount a DECIMAL y created_at a TIMESTAMP
-- - Excluya transacciones con status = 'failed'
-- - Agregue una columna calculada is_credit (TRUE si amount > 0, FALSE si amount <= 0)

with source as (

    select * from {{ source('raw', 'transactions') }}

),

renamed as (

    select
        transaction_id,
        account_id,
        cast(amount as decimal(10, 2))                    as amount,
        currency,
        transaction_type,
        status,
        cast(created_at as timestamp)                     as created_at,
        case when amount > 0 then 'TRUE' else 'FALSE' end  as is_credit

    from source
    where status != 'failed'

)

select * from renamed
