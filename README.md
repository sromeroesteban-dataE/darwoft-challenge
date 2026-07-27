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
  únicamente transacciones completadas. Devolvé:
