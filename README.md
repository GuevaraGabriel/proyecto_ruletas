# Simulación de estrategias de ruleta

## 1. Descripción

Proyecto individual del curso **Herramientas de Datos I**.

El proyecto realiza un análisis comparativo de las ruletas europea y americana mediante simulaciones de Monte Carlo desarrolladas en R.

Su objetivo es estudiar el rendimiento, la variabilidad de las ganancias y pérdidas, y la probabilidad de terminar con ganancias al aplicar diferentes estrategias de apuestas.

Se analizan cuatro estrategias:

1.  **Número:** apuesta al número 17.
2.  **Docena:** apuesta a la primera docena (1–12).
3.  **Color:** apuesta al negro.
4.  **Combinada:** distribución del 60 % del monto al negro y 40 % a la tercera columna.

## 2. Objetivos del análisis

El proyecto desarrolla tres experimentos principales:

- **Comparación de estrategias:** evaluar el rendimiento, la pérdida media, la varianza y las probabilidades de obtener ganancias en ambas ruletas.
- **Convergencia del rendimiento:** estudiar cómo el rendimiento promedio simulado se aproxima al rendimiento teórico al aumentar la cantidad de personas.
- **Probabilidad de ganancia:** analizar cómo cambia la proporción de sesiones ganadoras al aumentar la cantidad de giros.

## 3. Estructura del proyecto

| Carpeta | Contenido |
|------------------------------------|------------------------------------|
| `cod/` | Scripts de R para crear datos, definir estrategias y realizar simulaciones. |
| `data/` | Bases de datos CSV de las ruletas europea y americana. |
| `info/` | Documentación de las reglas, estrategias, metodología y referencias bibliográficas. |
| `config/` | Documentación de los parámetros generales de simulación. |
| `res/` | Resultados, tablas, gráficos y archivos generados por los experimentos. |

Los parámetros generales se encuentran en `cod/00_configuracion.R`.

## 4. Metodología

Se utiliza el método de simulación de Monte Carlo para generar resultados aleatorios de giros de ruleta y calcular las ganancias y pérdidas de cada estrategia.

El escenario base considera:

- 1.000 personas simuladas.
- 100 giros por persona.
- 50 unidades monetarias apostadas por giro.
- Las mismas secuencias de resultados para comparar las cuatro estrategias dentro de cada ruleta.

También se realizan experimentos adicionales con hasta 100.000 personas y sesiones de hasta 50.000 giros.

Los datos son simulados y no corresponden a registros históricos de casinos.

## 5. Scripts principales

| Script | Función |
|------------------------------------|------------------------------------|
| `01_crear_datos_ruletas.R` | Construye las bases de datos de ambas ruletas. |
| `02_reglas_apuestas.R` | Define las reglas de pago de las cuatro estrategias. |
| `03_simulaciones.R` | Contiene funciones generales para simular y analizar sesiones. |
| `00_configuracion.R` | Define los parámetros de los experimentos finales. |
| `06_comparacion_ruletas.R` | Ejecuta la comparación de las cuatro estrategias. |
| `07_rendimiento_teorico.R` | Estudia la convergencia del rendimiento. |
| `08_prob_ganancia.R` | Analiza la probabilidad de terminar con ganancias. |

Los scripts se encuentran dentro de `cod/`.

## 6. Reproducción de resultados

Para reproducir los experimentos finales:

1.  Abrir el proyecto en RStudio.
2.  Verificar que estén instalados los paquetes necesarios.
3.  Ejecutar `cod/01_crear_datos_ruletas.R` si es necesario generar nuevamente los CSV.
4.  Ejecutar `cod/06_comparacion_ruletas.R`.
5.  Ejecutar `cod/07_rendimiento_teorico.R`.
6.  Ejecutar `cod/08_prob_ganancia.R`.

Los scripts deben ejecutarse desde la carpeta raíz del proyecto.

Los experimentos 07 y 08 utilizan el archivo `base_ruletas.rds` generado por el script 06.

## 7. Resultados

Los resultados finales se almacenan en tres carpetas:

- `res/06_comparacion_ruletas/`: tablas e indicadores estadísticos.
- `res/07_rendimiento_teorico/`: gráficos y datos de convergencia.
- `res/08_prob_ganancia/`: gráficos y datos de probabilidad de terminar con ganancias.

Los archivos incluyen resultados en formato CSV y gráficos en PNG y PDF.

## 8. Herramientas utilizadas

- R y RStudio.
- `dplyr` y `tidyr` para manipulación de datos.
- `ggplot2` para visualización.
- `gridExtra` para tablas.
- Quarto para la elaboración del informe académico.
- Git para el control de versiones.

## 9. Documentación y referencias

La carpeta `info/` contiene la documentación del proyecto:

- Reglas de las ruletas europea y americana.
- Descripción de las cuatro estrategias.
- Supuestos y metodología de Monte Carlo.
- Fuentes y referencias bibliográficas.

Las referencias también se encuentran disponibles en `info/referencias.bib`.

## 10. Consideraciones

Las simulaciones suponen giros independientes, casillas equiprobables y apuestas de monto constante.

No se consideran límites de capital, restricciones de mesa ni estrategias que modifiquen las apuestas según los resultados anteriores.

Los resultados deben interpretarse como estimaciones estadísticas bajo las condiciones establecidas en el modelo.

## Informe final

El informe académico del proyecto fue elaborado mediante Quarto y presenta la metodología, los resultados y las conclusiones de los tres experimentos realizados.

Los archivos correspondientes son:

- `informe_final.qmd`: documento fuente del informe.

- `informe_final.pdf`: versión final del informe académico.

- `info/referencias.bib`: fuentes bibliográficas utilizadas.

- `info/apa.csl`: archivo de estilo bibliográfico APA 7.

El documento utiliza las tablas, los datos y los gráficos generados previamente por los scripts de R y almacenados en la carpeta `res/`.

Para reproducir el informe, se debe abrir el archivo `informe_final.qmd` en RStudio y seleccionar la opción Render, teniendo instalados Quarto, LaTeX y los paquetes de R necesarios.
