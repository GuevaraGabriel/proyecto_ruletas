
# Carpeta Resultados

Esta carpeta contiene los resultados obtenidos mediante las simulaciones de Monte Carlo realizadas en R para comparar cuatro estrategias de apuestas en las ruletas europea y americana.

Los resultados principales se organizan según los tres experimentos finales del proyecto.

## 1. Estructura de la carpeta

| Carpeta | Contenido |
|---|---|
| `06_comparacion_ruletas/` | Comparación de las estrategias mediante indicadores estadísticos. |
| `07_rendimiento_teorico/` | Análisis de convergencia del rendimiento observado hacia el teórico. |
| `08_prob_ganancia/` | Análisis de la probabilidad de terminar con ganancias según la cantidad de giros. |
| `ResultadosExtra/` | Archivos conservados de experimentos realizados durante el desarrollo del proyecto. |

## 2. Experimento 1: comparación de estrategias

**Script:** `cod/06_comparacion_ruletas.R`

**Carpeta:** `06_comparacion_ruletas/`

Este experimento compara las cuatro estrategias utilizando 1.000 personas, 100 giros por persona y apuestas de 50 unidades monetarias por giro.

### Archivos principales

| Archivo | Descripción |
|---|---|
| `tabla_europea.csv` | Indicadores estadísticos de las cuatro estrategias en la ruleta europea. |
| `tabla_americana.csv` | Indicadores estadísticos de las cuatro estrategias en la ruleta americana. |
| `tabla_europea.png` y `.pdf` | Tabla visual de resultados europeos. |
| `tabla_americana.png` y `.pdf` | Tabla visual de resultados americanos. |
| `sesiones_base.csv` | Ganancias netas individuales de las personas simuladas. |
| `base_ruletas.rds` | Objeto de R con parámetros y resultados utilizados por los siguientes experimentos. |

Los indicadores incluyen rendimiento observado y teórico, pérdida media, varianza de sesión y probabilidades de obtener ganancias por giro y por sesión.

## 3. Experimento 2: convergencia del rendimiento

**Script:** `cod/07_rendimiento_teorico.R`

**Carpeta:** `07_rendimiento_teorico/`

Este experimento estudia cómo cambia el rendimiento observado cuando aumenta el número de personas simuladas, manteniendo constantes los 100 giros por persona.

Se analizan hasta 100.000 personas por ruleta.

### Archivos principales

| Archivo | Descripción |
|---|---|
| `convergencia_rendimiento.csv` | Rendimientos acumulados y diferencias respecto al valor teórico. |
| `convergencia_europea.png` y `.pdf` | Gráfico de convergencia de la ruleta europea. |
| `convergencia_americana.png` y `.pdf` | Gráfico de convergencia de la ruleta americana. |
| `convergencia_reporte.png` y `.pdf` | Gráfico comparativo de convergencia de ambas ruletas utilizado en el informe final. |

Los gráficos permiten comparar el comportamiento de las estrategias con los rendimientos teóricos de aproximadamente -2,70 % para la ruleta europea y -5,26 % para la americana.

El análisis permite estudiar la ley de los grandes números y cómo el aumento de la cantidad de personas simuladas mejora la precisión de la estimación del rendimiento promedio.

## 4. Experimento 3: probabilidad de terminar con ganancias

**Script:** `cod/08_prob_ganancia.R`

**Carpeta:** `08_prob_ganancia/`

Este experimento analiza cómo cambia la proporción de personas que terminan con un saldo positivo cuando aumenta la cantidad de giros de cada sesión.

Se utilizan 1.000 personas y se evalúan sesiones de entre 20 y 50.000 giros por persona.

### Archivos principales

| Archivo | Descripción |
|---|---|
| `probabilidad_ganancia.csv` | Resumen de personas ganadoras, perdedoras y con saldo cero, además de otros indicadores. |
| `sesiones_por_giros.csv` | Ganancias netas individuales para cada duración estudiada. |
| `probabilidad_europea.png` y `.pdf` | Gráfico de probabilidades de la ruleta europea. |
| `probabilidad_americana.png` y `.pdf` | Gráfico de probabilidades de la ruleta americana. |
| `probabilidad_reporte.png` y `.pdf` | Gráfico comparativo de la probabilidad de ganancia de ambas ruletas utilizado en el informe final. |

Los porcentajes obtenidos son estimaciones basadas en las sesiones simuladas y no deben interpretarse necesariamente como probabilidades matemáticas exactas.

## 5. Resultados anteriores

La carpeta `ResultadosExtra/` conserva archivos de experimentos realizados durante el desarrollo del proyecto que no forman parte de los tres análisis finales.

Se mantienen como respaldo del proceso de trabajo y permiten documentar la evolución de la investigación.

El informe académico utiliza los resultados de los experimentos 06, 07 y 08.

## 6. Reproducción de resultados

Todos los resultados de los experimentos finales pueden regenerarse ejecutando el siguiente comando desde la carpeta raíz del proyecto:

```r
source("cod/09_ejecutar_proyecto.R")
```

Este script ejecuta automáticamente los siguientes archivos en el orden correspondiente:

1. `cod/01_crear_datos_ruletas.R`
2. `cod/06_comparacion_ruletas.R`
3. `cod/07_rendimiento_teorico.R`
4. `cod/08_prob_ganancia.R`

Los parámetros generales se encuentran en `cod/00_configuracion.R`.

Los scripts 07 y 08 utilizan el archivo `base_ruletas.rds` generado por el script 06.

Se utilizan semillas fijas para garantizar la reproducibilidad de las simulaciones bajo las mismas condiciones de ejecución.

Una vez generados los resultados, se puede renderizar el archivo `informe_final.qmd` desde RStudio.

## 7. Consideraciones sobre los resultados

- Los datos son simulados y no provienen de jugadores reales.
- Las ganancias y pérdidas pueden variar entre ejecuciones con distintas semillas.
- La varianza representa la dispersión de las ganancias finales de las sesiones.
- Los rendimientos simulados pueden diferir temporalmente de los valores teóricos.
- Una mayor probabilidad de obtener ganancias por giro no implica necesariamente una mayor rentabilidad.
- Una probabilidad estimada del 0 % no implica necesariamente imposibilidad matemática.
- Los resultados deben interpretarse considerando los supuestos y limitaciones documentados en `info/03_supuestos_y_metodologia.md`.

## 8. Utilización en el informe

Las tablas y los gráficos definitivos de esta carpeta se utilizan en el informe académico generado mediante Quarto (`informe_final.qmd`).

Las figuras y tablas se identifican como elaboración propia a partir de simulaciones realizadas en R.

El informe también incluye cuatro anexos matemáticos:

- Anexo A: rendimiento teórico de las estrategias.
- Anexo B: probabilidades teóricas por giro.
- Anexo C: varianza teórica por giro y sesión.
- Anexo D: probabilidad teórica de ganancia por sesión.

Estos anexos permiten respaldar matemáticamente los resultados obtenidos mediante las simulaciones y comparar los valores observados con sus correspondientes valores teóricos.
