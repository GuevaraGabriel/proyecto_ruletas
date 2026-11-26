---
title: "04_fuentes_y_referencias"
output: html_document
---

## 1. Origen de la información

El proyecto utiliza dos tipos de información:

**Información externa:** reglas generales de las ruletas europea y americana, modalidades de apuestas, pagos y fundamentos del método de simulación de Monte Carlo.

**Elaboración propia:** construcción de las bases de datos, selección de las cuatro estrategias, programación de las simulaciones en R y análisis de los resultados.

Los datos analizados son simulados. No se utilizaron registros históricos de casinos ni bases de datos de jugadores reales.

## 2. Fuentes sobre las reglas de la ruleta

### 2.1. Boletín Oficial del Estado de España

**Referencia:**

Ministerio de Economía y Hacienda. (2011). *Orden EHA/3085/2011, de 8 de noviembre, por la que se aprueba la reglamentación básica del juego de la ruleta*. Boletín Oficial del Estado.

https://www.boe.es/eli/es/o/2011/11/08/eha3085/con

**Información respaldada:**

- Funcionamiento general del juego de ruleta.
- Apuestas basadas en números, colores y posiciones.
- Determinación de resultados y premios.
- Existencia de reglas particulares según el operador.

**Aplicación en el proyecto:** descripción general de la ruleta y su funcionamiento.

### 2.2. Regulación del estado de Nueva York

**Referencia:**

New York State Gaming Commission. (2016). *Roulette*. New York Codes, Rules and Regulations, título 9, sección 5324.4. Legal Information Institute, Cornell Law School.

https://www.law.cornell.edu/regulations/new-york/9-NYCRR-5324.4

**Información respaldada:**

- Apuestas a números individuales.
- Apuestas por docenas y columnas.
- Apuestas por colores.
- Pagos convencionales de 35:1, 2:1 y 1:1.
- Disposición general de las apuestas sobre la mesa.

**Aplicación en el proyecto:** definición y verificación de los pagos utilizados en `02_reglas_apuestas.R`.

## 3. Fuentes sobre Monte Carlo

### 3.1. National Institute of Standards and Technology (NIST)

**Referencia:**

National Institute of Standards and Technology. (2025). *Monte Carlo Tool*.

https://www.nist.gov/services-resources/software/monte-carlo-tool

**Información respaldada:**

- Utilización de muestreo aleatorio para estudiar modelos.
- Definición de variables y distribuciones de probabilidad.
- Repetición de simulaciones.
- Análisis de resultados bajo incertidumbre.

**Aplicación en el proyecto:** justificación general del método de simulación utilizado.

## 4. Documentación técnica de R

### 4.1. Muestreo aleatorio

**Fuente:** R Documentation — *Random Samples and Permutations*.

https://stat.ethz.ch/R-manual/R-devel/library/base/html/sample.html

**Aplicación:** generación de índices aleatorios mediante `sample.int()`.

### 4.2. Distribución multinomial

**Fuente:** R Documentation — *The Multinomial Distribution*.

https://stat.ethz.ch/R-manual/R-devel/library/stats/html/Multinom.html

**Aplicación:** generación de conteos de resultados por casilla mediante `rmultinom()` en los experimentos de convergencia y duración de sesiones.

### 4.3. Generación de números pseudoaleatorios

**Fuente:** R Documentation — *Random Number Generation*.

https://stat.ethz.ch/R-manual/R-devel/library/base/html/Random.html

**Aplicación:** utilización de `set.seed()` para controlar la reproducibilidad de las simulaciones.

## 5. Elaboración propia

Las siguientes decisiones y productos corresponden al desarrollo de este proyecto:

- Construcción de los archivos `ruleta_europea.csv` y `ruleta_americana.csv`.
- Representación del doble cero como número 37 en R.
- Selección del número 17, primera docena y color negro.
- Diseño de la apuesta combinada: 60 % negro y 40 % tercera columna.
- Definición de los parámetros de las simulaciones.
- Implementación de las funciones de ganancias y pérdidas.
- Cálculo de los indicadores estadísticos.
- Generación de tablas, gráficos y resultados.
- Interpretación y comparación de los tres experimentos.

Los rendimientos teóricos de −2,7027 % y −5,2632 % se obtuvieron mediante cálculos matemáticos basados en las probabilidades y pagos establecidos en el modelo.

No deben presentarse como estimaciones tomadas de una base de datos externa.

## 6. Relación entre fuentes y archivos

| Archivo o componente | Fuente principal |
|---|---|
| `01_crear_datos_ruletas.R` | Reglas generales de la ruleta y elaboración propia |
| `02_reglas_apuestas.R` | Regulación de apuestas y pagos; elaboración propia |
| `06_comparacion_ruletas.R` | Elaboración propia y documentación de R |
| `07_rendimiento_teorico.R` | Elaboración propia y documentación de R |
| `08_prob_ganancia.R` | Elaboración propia y documentación de R |
| Gráficos y tablas | Resultados de las simulaciones realizadas en R |

## 7. Consideraciones para el informe académico

Las fuentes externas deben utilizarse para respaldar las reglas del juego y la metodología general.

Los resultados numéricos obtenidos mediante las simulaciones deben identificarse como elaboración propia.

Se debe distinguir entre:

- Probabilidades teóricas calculadas a partir de las reglas.
- Estimaciones obtenidas mediante Monte Carlo.
- Supuestos establecidos por el investigador.
- Limitaciones del modelo.

Las referencias incluidas en este documento servirán como base para construir posteriormente la bibliografía del informe en Quarto.