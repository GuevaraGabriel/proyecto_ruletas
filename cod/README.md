# Carpeta cod

Esta carpeta contiene los scripts de R utilizados para construir los datos, definir las estrategias de apuestas y desarrollar los análisis estadísticos del proyecto.

Los archivos se organizan mediante una numeración que permite identificar su función dentro del proceso de trabajo.

## 1. Scripts del proyecto

| Archivo | Descripción |
|------------------------------------|------------------------------------|
| `00_configuracion.R` | Define los parámetros generales, las estrategias y los colores utilizados en los gráficos. |
| `01_crear_datos_ruletas.R` | Construye las bases de datos de las ruletas europea y americana. |
| `02_reglas_apuestas.R` | Define las funciones que calculan las ganancias y pérdidas de las cuatro estrategias. |
| `06_comparacion_ruletas.R` | Compara las cuatro estrategias mediante indicadores estadísticos en ambas ruletas. |
| `07_rendimiento_teorico.R` | Analiza la convergencia del rendimiento observado hacia el rendimiento teórico. |
| `08_prob_ganancia.R` | Estudia cómo cambia la probabilidad de terminar con ganancias al aumentar los giros. |

## 2. Experimentos principales

El proyecto desarrolla tres experimentos finales.

### Experimento 1: comparación de estrategias

**Script:** `06_comparacion_ruletas.R`

Se simulan inicialmente 1.000 personas, con 100 giros por persona y apuestas de 50 unidades monetarias por giro.

Se calculan indicadores como rendimiento, pérdida media, varianza y probabilidades de obtener ganancias.

### Experimento 2: convergencia del rendimiento

**Script:** `07_rendimiento_teorico.R`

Se aumenta la cantidad de personas simuladas hasta 100.000, manteniendo constantes los 100 giros por persona.

El objetivo es comparar el rendimiento observado con su valor matemático esperado.

### Experimento 3: probabilidad de terminar con ganancias

**Script:** `08_prob_ganancia.R`

Se estudian sesiones de diferentes duraciones, desde 20 hasta 50.000 giros por persona.

Se calcula la proporción de personas que termina cada sesión con una ganancia neta positiva.

## Orden de ejecución

Para reproducir los resultados finales del proyecto, se recomienda ejecutar desde la carpeta raíz:

``` r
source("cod/09_ejecutar_proyecto.R")
```

Este script ejecuta automáticamente los siguientes archivos:

1.  `01_crear_datos_ruletas.R`
2.  `06_comparacion_ruletas.R`
3.  `07_rendimiento_teorico.R`
4.  `08_prob_ganancia.R`

Los archivos de configuración y las funciones de apuestas son cargados automáticamente por los scripts correspondientes.

Una vez generados los resultados, se puede renderizar `informe_final.qmd` desde RStudio.

## 4. Resultados generados

Los resultados se almacenan en las siguientes carpetas:

- `res/06_comparacion_ruletas/`: tablas y resultados estadísticos.
- `res/07_rendimiento_teorico/`: gráficos y datos de convergencia.
- `res/08_prob_ganancia/`: gráficos y datos de probabilidad de ganancia.

Los archivos incluyen resultados en formato CSV, gráficos PNG y PDF, y objetos RDS utilizados para compartir información entre experimentos.

## 5. Herramientas utilizadas

Los scripts emplean principalmente:

- R base para generación aleatoria, cálculos y estructuras de datos.
- `dplyr` y `tidyr` para organización y manipulación de resultados.
- `ggplot2` para visualización.
- `gridExtra` para construcción de tablas.

## 6. Documentación

Las reglas de las ruletas, las estrategias, los supuestos metodológicos y las fuentes bibliográficas se encuentran documentados en la carpeta `info/`.

Los parámetros generales se explican también en `config/README.md`.

El informe académico se elaborará mediante Quarto utilizando los resultados de los tres experimentos finales.

El informe académico fue elaborado mediante Quarto y se encuentra en la carpeta raíz del proyecto, bajo el nombre `informe_final.qmd`. Este documento utiliza los resultados, las tablas y los gráficos generados por los scripts de R, sin necesidad de ejecutar nuevamente las simulaciones durante su renderización.
