
# Carpeta Info

Esta carpeta contiene la documentación y las referencias utilizadas en el proyecto **Comparación de estrategias de apuestas en ruletas europeas y americanas mediante simulaciones de Monte Carlo en R**.

## 1. Contenido

| Archivo | Descripción |
|---|---|
| `01_reglas_ruletas.md` | Funcionamiento de las ruletas europea y americana, clasificación de las casillas, probabilidades y pagos. |
| `02_estrategias_apuestas.md` | Descripción de las cuatro estrategias analizadas: número, docena, color y combinada. |
| `03_supuestos_y_metodologia.md` | Explicación del método de Monte Carlo, parámetros, supuestos y metodología de los tres experimentos. |
| `04_fuentes_y_referencias.md` | Fuentes bibliográficas utilizadas y relación con los componentes del proyecto. |
| `referencias.bib` | Referencias en formato BibTeX para generar citas y bibliografía en Quarto. |
| `apa.csl` | Archivo utilizado para establecer el formato APA 7 de las citas y referencias bibliográficas. |
| `VistaPrevia/` | Versiones HTML locales de los documentos Markdown para facilitar su consulta. |

## 2. Origen de los datos

Las bases de datos de las ruletas fueron construidas a partir de las reglas del juego.

Los resultados analizados fueron generados mediante simulaciones de Monte Carlo realizadas en R. No se utilizaron registros históricos de casinos ni datos de jugadores reales.

## 3. Fundamento matemático

El proyecto utiliza diferentes conceptos de probabilidad y estadística para analizar e interpretar los resultados de las simulaciones:

- Valor esperado y linealidad de la esperanza.
- Varianza y dispersión de los resultados.
- Distribución binomial.
- Distribución multinomial.
- Ley de los grandes números.
- Error estándar.

Estos conceptos se respaldan mediante la bibliografía académica incorporada en el informe, incluyendo el libro *Introduction to Probability* de Blitzstein y Hwang (2019).

Los cálculos específicos para las estrategias estudiadas son de elaboración propia.

## 4. Relación con otras carpetas

- `cod/`: contiene los scripts que construyen los datos, implementan las estrategias y ejecutan los experimentos.
- `data/`: contiene los archivos CSV de las ruletas.
- `config/`: contiene la documentación de los parámetros utilizados.
- `res/`: contiene las tablas, gráficos y resultados de las simulaciones.

## 5. Propósito

Esta documentación permite comprender los fundamentos del modelo, justificar las decisiones metodológicas y facilitar la interpretación y reproducción de los resultados.

También sirve como material de apoyo para el informe académico del proyecto y su presentación.

## 6. Referencias bibliográficas

Esta carpeta contiene dos archivos utilizados para gestionar las citas y referencias del informe académico:

- `referencias.bib`: contiene las fuentes bibliográficas y sus respectivas claves de citación en formato BibTeX.
- `apa.csl`: establece el formato APA 7 para las citas y referencias bibliográficas.

Ambos archivos están vinculados al encabezado YAML de `informe_final.qmd`, lo que permite generar automáticamente las citas y la bibliografía durante la renderización del documento.

## 7. Relación con el informe final

El informe académico presenta la metodología, los resultados y las interpretaciones de los tres experimentos realizados.

Adicionalmente, incorpora cuatro anexos matemáticos:

- Anexo A: rendimiento teórico de las estrategias.
- Anexo B: probabilidades teóricas por giro.
- Anexo C: varianza teórica por giro y sesión.
- Anexo D: probabilidad teórica de ganancia por sesión.

Estos anexos permiten comparar los resultados obtenidos mediante las simulaciones con los valores matemáticos esperados bajo los supuestos del modelo.
