# Parte 3 — Análisis e insights

El análisis completo fue desarrollado en **Tableau Public**, como dashboard interactivo.

## Qué falta agregar acá (desde tu Mac)

Tableau Public guarda el trabajo en tu perfil online o como archivo local — este
entregable no puede armarse desde el sandbox, así que agregá vos uno de los
siguientes antes de comprimir la carpeta final:

**Opción A — Link público (recomendado):**
1. En Tableau Public, `Archivo > Guardar en la Web` (o el botón "Publicar").
2. Copiá el link público que te genera.
3. Pegalo en un archivo de texto acá mismo, por ejemplo `link_dashboard.txt`.

**Opción B — Archivo empaquetado (.twbx):**
1. En Tableau Public, `Archivo > Guardar como` → formato **Packaged Workbook (.twbx)**.
2. Copiá ese archivo `.twbx` a esta carpeta (`parte3/`).

## Contenido del dashboard

- Portada con KPIs generales (usuarios, transacciones, volumen ARS/USD, tasa de fallo general)
- Hallazgo 1: caída anómala de volumen en mayo 2024 (-44%)
- Hallazgo 2: Premium concentra el 61% del volumen monetario con solo 36% de usuarios
- Hallazgo 3: `withdrawal` con la mayor tasa de fallo (20.9%), concentrada en USD (28.7% vs. 19.9% ARS)
- Otros patrones: tasa de fallo por país (mapa), checking vs. savings, moneda por plan
- Resumen ejecutivo con las 3 acciones recomendadas

## Alternativa incluida en esta carpeta

Se adjunta también `analisis_darwoft.ipynb` (notebook de Python/Colab) con el
mismo análisis y hallazgos, con los CSV de datos, por si preferís entregar en
ese formato en vez de o además del dashboard de Tableau.
