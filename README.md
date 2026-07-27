# Darwoft — Take-Home Challenge

**Rol:** Analytics Engineer (SQL / BI / dbt) · Senior
**Empresa:** Darwoft — producto fintech / servicios financieros

## 1. Contexto

Trabajás en el equipo de datos de un producto fintech de pagos digitales. El
sistema procesa transacciones de usuarios en múltiples países y tipos de
cuenta. Tu misión en este challenge es la misma que tendrías en el día a día:
transformar datos crudos en información accionable y construir los modelos
que permitan a los equipos de negocio tomar mejores decisiones.

El challenge está dividido en tres partes independientes. La Parte 1 (SQL)
alimenta conceptualmente a la Parte 2 (dbt).

## 2. Dataset

Tres tablas que representan la capa raw de un data warehouse:

| Tabla | Filas aprox. | Descripción |
|---|---|---|
| `users` | 500 | Usuarios del producto. Campos: `user_id`, `signup_date`, `country`, `plan_type` (free / premium). |
| `accounts` | 620 | Cuentas asociadas a cada usuario. Campos: `account_id`, `user_id`, `account_type` (checking / savings), `created_at`. |
| `transactions` | ~3.700 | Transacciones. Campos: `transaction_id`, `account_id`, `amount`, `currency` (ARS / USD), `transaction_type` (deposit / withdrawal / payment / transfer), `status` (completed / failed / pending), `created_at`. |

Relaciones: `users` → `accounts` (1:N) → `transactions` (1:N)

## 3. Las tres partes del challenge

### Parte 1 — SQL (MySQL 9)

Queries para responder 5 preguntas sobre el dataset — cada una en su propio
archivo (`q1.sql` a `q5.sql`), devolviendo exactamente lo pedido:

- **Q1.** ¿Cuántas transacciones completadas hubo por mes? Devolvé: mes
  (formato YYYY-MM), cantidad de transacciones y monto total (solo moneda ARS).
- **Q2.** Para cada usuario, calculá el saldo neto acumulado considerando
  únicamente transacciones completadas. Devolvé: `user_id` y `saldo_neto`.
  Ordená de mayor a menor saldo.
- **Q3.** Mostrá, para cada cuenta, el saldo acumulado transacción por
  transacción (running balance) en orden cronológico. Incluí solo
  transacciones completadas.
- **Q4.** ¿Qué porcentaje de transacciones falló, por tipo de transacción?
  Devolvé: `transaction_type`, total de transacciones, cantidad fallidas y
  tasa de fallo (redondeada a 2 decimales).
- **Q5.** Identificá los usuarios que se registraron en enero 2024 y
  realizaron al menos una transacción completada en cada uno de los 2 meses
  siguientes a su signup. Devolvé sus `user_id`.

### Parte 2 — Modelado con dbt

Archivos `.sql` y `.yml` como parte de un proyecto dbt real:

- **2.a** — `stg_transactions.sql`: lee desde `{{ source('raw', 'transactions') }}`,
  castea `amount` a DECIMAL y `created_at` a TIMESTAMP, excluye `status = 'failed'`,
  y agrega `is_credit` (TRUE si `amount > 0`, FALSE si `amount ≤ 0`).
- **2.b** — `mart_user_activity.sql`: consolida por usuario y mes la cantidad
  de transacciones completadas, monto total de créditos, monto total de
  débitos, y saldo neto del mes. Referencia `stg_transactions` con `{{ ref() }}`.
- **2.c** — `schema.yml`: test de unicidad y de not_null sobre
  `stg_transactions`, un test de integridad referencial (`relationships`)
  relevante, y un test genérico adicional a elección, justificado.
- **2.d** — Pregunta conceptual (`respuesta_2d.md`, máx. 10 líneas): si la
  tabla de transacciones crece a 50M de filas por mes, ¿qué materialización
  de dbt elegirías para `stg_transactions` y para `mart_user_activity`?

### Parte 3 — Análisis e insights

Análisis exploratorio sobre el mismo dataset, respondiendo:

- ¿Existe algún período donde el volumen de transacciones haya caído de
  forma anómala? ¿A qué podría deberse?
- ¿Hay diferencias relevantes en el comportamiento entre usuarios free y
  premium que justifiquen una acción de producto?
- ¿Qué tipo de transacción tiene la mayor tasa de error y qué impacto tiene
  eso en el negocio?

Formato: máximo 1 página de texto + visualizaciones de soporte, documentando
los supuestos.

## 4. Criterios de evaluación

Las tres partes se evalúan con el mismo peso. Dentro de cada parte, se
prioriza: correctitud, claridad del código, razonamiento (por qué se tomó
cada decisión), impacto de negocio (Parte 3), y manejo de edge cases
(usuarios sin transacciones, monedas mixtas, valores nulos).

## Estructura de este repositorio

```
challenge/
├── parte1/
│   ├── q1.sql ... q5.sql
├── parte2/
│   ├── models/
│   │   ├── staging/stg_transactions.sql
│   │   └── marts/mart_user_activity.sql
│   ├── schema.yml
│   └── respuesta_2d.md
└── parte3/
    └── README.md   (link al dashboard interactivo en Tableau Public)
```
