# 2.d — Pregunta conceptual: materialización a 50M filas/mes

Para **`stg_transactions`** elegiría **`incremental`**: es una tabla de hechos que crece solo por inserción (una transacción no se modifica una vez ocurrida), así que reprocesar todo el historial en cada corrida (`table`) sería un desperdicio de cómputo a ese volumen; `incremental` procesa solo las filas nuevas desde la última corrida, filtrando por `created_at`.

Para **`mart_user_activity`** elegiría también **`incremental`**, pero con `incremental_strategy='merge'` y `unique_key=['user_id','mes']`: una transacción tardía puede modificar la agregación de un mes ya procesado, así que necesito que dbt actualice esa fila puntual en vez de solo insertar, evitando reconstruir la tabla completa en cada corrida con actualización diaria.
