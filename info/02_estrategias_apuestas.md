---
title: "02_estrategias_apuestas"
output: html_document
---

## 1. Descripción general

El proyecto analiza cuatro estrategias de apuestas en las ruletas europea y americana, con el objetivo de comparar sus ganancias, pérdidas, variabilidad y probabilidades de obtener resultados favorables.

Las estrategias se implementaron mediante funciones en el archivo `cod/02_reglas_apuestas.R`.

En los experimentos se utiliza el mismo monto total por giro para todas las estrategias, lo que permite realizar comparaciones bajo condiciones equivalentes.

Las funciones calculan ganancias netas. Los valores positivos representan ganancias y los negativos representan pérdidas.

## 2. Estrategia 1: apuesta a un número

Consiste en apostar a una única casilla de la ruleta.

En este proyecto se seleccionó el número 17.

**Reglas:**

- Si el resultado es 17, se obtiene una ganancia neta de 35 veces el monto apostado.
- Si aparece cualquier otro resultado, se pierde la totalidad de la apuesta.

**Probabilidades teóricas:**

| Ruleta | Probabilidad de acertar |
|---|---|
| Europea | 1/37 = 2,70 % |
| Americana | 1/38 = 2,63 % |

**Ejemplo con 50 unidades monetarias:**

- Si sale el 17: ganancia neta de +1.750.
- Si sale otro número: pérdida de −50.

Esta estrategia presenta ganancias poco frecuentes, pero de gran magnitud, por lo que puede producir una elevada variabilidad en los resultados acumulados.

**Función de R:** `apostar.numero()`

## 3. Estrategia 2: apuesta a una docena

Consiste en apostar a un conjunto de 12 números consecutivos.

En este proyecto se seleccionó la primera docena, que comprende los números del 1 al 12.

**Reglas:**

- Si aparece un número entre 1 y 12, se obtiene una ganancia neta de dos veces el monto apostado.
- Si aparece otro resultado, se pierde el monto apostado.

**Probabilidades teóricas:**

| Ruleta | Probabilidad de acertar |
|---|---|
| Europea | 12/37 = 32,43 % |
| Americana | 12/38 = 31,58 % |

**Ejemplo con 50 unidades monetarias:**

- Si sale el 8: ganancia neta de +100.
- Si sale el 17: pérdida de −50.

**Función de R:** `apostar.docena()`

## 4. Estrategia 3: apuesta a un color

Consiste en apostar a que la casilla ganadora sea roja o negra.

En este proyecto se seleccionó el color negro.

Ambas ruletas tienen 18 casillas negras y 18 rojas.

**Reglas:**

- Si aparece una casilla negra, se obtiene una ganancia neta igual al monto apostado.
- Si aparece una casilla roja o verde, se pierde el monto apostado.

**Probabilidades teóricas:**

| Ruleta | Probabilidad de acertar |
|---|---|
| Europea | 18/37 = 48,65 % |
| Americana | 18/38 = 47,37 % |

**Ejemplo con 50 unidades monetarias:**

- Si sale el 17 (negro): ganancia neta de +50.
- Si sale el 18 (rojo): pérdida de −50.

**Función de R:** `apostar.color()`

## 5. Estrategia 4: apuesta combinada

Esta estrategia consiste en distribuir un mismo monto entre dos apuestas simultáneas.

En el escenario estudiado se combina una apuesta al color negro con una apuesta a la tercera columna.

El monto se divide de la siguiente manera:

- 60 % del monto al negro.
- 40 % del monto a la tercera columna.

La tercera columna contiene los números 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33 y 36.

En el código, la función también permite seleccionar el color rojo, en cuyo caso utiliza la segunda columna. Sin embargo, los experimentos finales utilizan negro y tercera columna.

### Ejemplo con 50 unidades monetarias

Se distribuyen las apuestas de esta forma:

- 30 unidades al negro.
- 20 unidades a la tercera columna.

Según el resultado, existen cuatro situaciones:

| Resultado | Ganancia neta |
|---|---:|
| Ganan ambas apuestas | +70 |
| Gana únicamente el negro | +10 |
| Gana únicamente la columna | +10 |
| Pierden ambas apuestas | −50 |

### Probabilidades de obtener una ganancia neta positiva

En la ruleta europea:

- 4 casillas permiten ganar ambas apuestas.
- 22 casillas permiten ganar únicamente una.
- 11 casillas provocan la pérdida de ambas.

Por tanto:

**P(ganar un giro) = 26/37 = 70,27 %.**

En la ruleta americana:

**P(ganar un giro) = 26/38 = 68,42 %.**

Aunque esta estrategia tiene una probabilidad relativamente alta de obtener ganancias en un giro individual, eso no implica que tenga una rentabilidad esperada positiva.

Las ganancias pequeñas pueden ser compensadas por pérdidas de mayor magnitud.

**Función de R:** `apostar.combinada()`

## 6. Comparación general de las estrategias

| Estrategia | Apuesta utilizada | Pago neto al acertar |
|---|---|---|
| Número | Número 17 | 35:1 |
| Docena | Primera docena | 2:1 |
| Color | Negro | 1:1 |
| Combinada | 60 % negro y 40 % columna 3 | Variable |

Todas las estrategias utilizan el mismo monto total por giro.

Sin embargo, sus distribuciones de ganancias y pérdidas son diferentes.

La apuesta a un número tiene una probabilidad de acierto baja, pero ofrece ganancias grandes. La apuesta al color presenta pagos más pequeños y frecuentes. Por su parte, la estrategia combinada permite obtener ganancias netas positivas con mayor frecuencia en un giro, aunque muchas de esas ganancias son reducidas.

## 7. Rendimiento esperado

Bajo las reglas utilizadas en el proyecto, las cuatro estrategias tienen el mismo rendimiento esperado dentro de cada tipo de ruleta.

| Ruleta | Rendimiento esperado |
|---|---:|
| Europea | −2,7027 % |
| Americana | −5,2632 % |

Esto se debe a que los pagos y las probabilidades de cada apuesta mantienen la ventaja matemática de la casa.

Por lo tanto, la selección de una estrategia modifica la frecuencia de los aciertos y la variabilidad de los resultados, pero no elimina la pérdida esperada.

## 8. Implementación en el proyecto

Las estrategias fueron definidas en `cod/02_reglas_apuestas.R`.

Posteriormente, el script `cod/06_comparacion_ruletas.R` utiliza estas funciones para construir una matriz de pagos y evaluar las cuatro estrategias sobre los mismos resultados aleatorios.

Los scripts `07_rendimiento_teorico.R` y `08_prob_ganancia.R` reutilizan los resultados y las reglas de pago para estudiar la convergencia del rendimiento y la probabilidad de terminar con ganancias.

Las estrategias se mantienen constantes durante los experimentos: no se realizan cambios de apuesta basados en resultados anteriores.

## 9. Fuentes

Las reglas generales de las apuestas y los pagos están documentadas en `01_reglas_ruletas.md`.

La selección específica de las cuatro estrategias, la distribución 60/40 de la estrategia combinada y su implementación en R corresponden a decisiones metodológicas propias del proyecto.
