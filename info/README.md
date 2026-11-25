# Carpeta Info

Esta carpeta contiene la documentación y las referencias utilizadas en el proyecto **Comparación de estrategias de apuestas en ruletas europeas y americanas mediante simulaciones de Monte Carlo en R**.

## Contenido

| Archivo | Descripción |
|----|----|
| `01_reglas_ruletas.md` | Funcionamiento de las ruletas europea y americana, clasificación de las casillas, probabilidades y pagos. |
| `02_estrategias_apuestas.md` | Descripción de las cuatro estrategias analizadas: número, docena, color y combinada. |
| `03_supuestos_y_metodologia.md` | Explicación del método de Monte Carlo, parámetros, supuestos y metodología de los tres experimentos. |
| `04_fuentes_y_referencias.md` | Fuentes bibliográficas utilizadas y relación con los componentes del proyecto. |
| `referencias.bib` | Referencias en formato BibTeX para generar citas y bibliografía en Quarto. |
| `VistaPrevia/` | Versiones HTML de los documentos Markdown para facilitar su consulta. |

## Origen de los datos

Las bases de datos de las ruletas fueron construidas a partir de las reglas del juego.

Los resultados analizados fueron generados mediante simulaciones de Monte Carlo realizadas en R. No se utilizaron registros históricos de casinos.

## Relación con otras carpetas

- `cod/`: contiene los scripts que construyen los datos, implementan las estrategias y ejecutan los experimentos.
- `data/`: contiene los archivos CSV de las ruletas.
- `res/`: contiene las tablas, gráficos y resultados de las simulaciones.

## Propósito

Esta documentación permite comprender los fundamentos del modelo, justificar las decisiones metodológicas y facilitar la interpretación y reproducción de los resultados.

También sirve como material de apoyo para la elaboración del informe académico del proyecto.

## Referencias bibliográficas

Esta carpeta contiene dos archivos utilizados para gestionar las citas y referencias del informe académico:

- `referencias.bib`: contiene las fuentes bibliográficas y sus respectivas claves de citación en formato BibTeX.

- `apa.csl`: establece el formato APA 7 para las citas y referencias bibliográficas.

Ambos archivos están vinculados al encabezado YAML de `informe_final.qmd`, lo que permite generar automáticamente las citas y la bibliografía durante la renderización del documento.
