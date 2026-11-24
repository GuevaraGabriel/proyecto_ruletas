---
title: "03_supuestos_y_metodologia"
output: html_document
---

## 1. Objetivo metodológico

El proyecto utiliza simulaciones de Monte Carlo implementadas en R para comparar cuatro estrategias de apuestas en las ruletas europea y americana.

El análisis se desarrolla mediante tres experimentos:

1. Comparación del rendimiento, las pérdidas y la variabilidad de las estrategias.
2. Estudio de la convergencia del rendimiento observado hacia su valor teórico.
3. Estudio de la probabilidad de terminar una sesión con ganancias al aumentar la cantidad de giros.

## 2. Método de Monte Carlo

Monte Carlo es una técnica de simulación que utiliza la generación repetida de resultados aleatorios para estudiar el comportamiento de un modelo matemático o estadístico.

En este proyecto, cada giro de ruleta se modela mediante una selección aleatoria entre las casillas posibles, suponiendo que todas tienen la misma probabilidad.

Los resultados se generan mediante funciones de R como `sample.int()` y `rmultinom()`.

Posteriormente se aplican las reglas de pago de las estrategias, se calculan los saldos finales y se obtienen estadísticas descriptivas.

Los datos generados son simulados, no observaciones históricas de un casino.

## 3. Supuestos del modelo

Para realizar los experimentos se establecen los siguientes supuestos:

- **Equiprobabilidad:** todas las casillas de una misma ruleta tienen igual probabilidad de resultar ganadoras.
- **Independencia:** el resultado de un giro no afecta las probabilidades del siguiente.
- **Apuestas fijas:** cada estrategia mantiene sus reglas y distribuciones de apuesta durante toda la sesión.
- **Monto constante:** se apuesta el mismo monto total en cada giro.
- **Sin límite de capital:** las personas simuladas completan todos los giros establecidos, aunque acumulen pérdidas superiores a un presupuesto inicial hipotético.
- **Sin límites de mesa:** no se consideran restricciones de apuestas mínimas o máximas.
- **Pagos convencionales:** se utilizan pagos netos de 35:1 para números, 2:1 para docenas y columnas y 1:1 para colores.
- **Sin reglas especiales para los ceros:** no se aplican mecanismos como *la partage* o *en prison*.
- **Sin costos adicionales:** no se consideran impuestos, comisiones ni otros gastos.

Estos supuestos permiten comparar las estrategias bajo condiciones controladas, pero limitan la representación de situaciones reales de juego.

## 4. Parámetros generales

Los parámetros principales se establecen en `cod/00_configuracion.R`.

| Parámetro | Valor | Descripción |
|---|---:|---|
| `n_personas` | 1.000 | Sesiones simuladas por estrategia y tipo de ruleta en el escenario base |
| `n_giros` | 100 | Giros por sesión en el escenario base |
| `monto` | 50 | Unidades monetarias apostadas por giro |
| `semilla` | 54321 | Semilla base del generador pseudoaleatorio |
| `escala` | 5 | Factor utilizado para representar pagos como enteros |
| `max_personas` | 100.000 | Número máximo de personas en el experimento de convergencia |

En el tercer experimento se estudian sesiones de 20, 50, 100, 200, 500, 1.000, 2.000, 5.000, 10.000, 20.000 y 50.000 giros.

Las cantidades se comparan por separado para la ruleta europea y la americana.

## 5. Construcción y generación de datos

El archivo `cod/01_crear_datos_ruletas.R` crea las bases de datos de ambas ruletas, identificando cada casilla mediante su número, color, docena y columna.

La ruleta europea incluye 37 casillas, mientras que la americana incluye 38.

En `cod/02_reglas_apuestas.R` se definen funciones que calculan las ganancias o pérdidas netas de las cuatro estrategias.

En el experimento base, el script `cod/06_comparacion_ruletas.R` genera una matriz de índices aleatorios mediante `sample.int()`, utilizando reemplazo para representar giros independientes.

Cada fila de la matriz corresponde a una persona y cada columna a un giro.

Las cuatro estrategias se evalúan sobre los mismos resultados aleatorios dentro de cada tipo de ruleta. Esto permite comparar sus resultados bajo una secuencia común de giros.

Los pagos posibles se calculan previamente para cada casilla y estrategia. Después se asignan esos pagos a los resultados simulados y se suman para obtener las ganancias netas de cada persona.

Para evitar problemas derivados de la representación de decimales, los pagos se multiplican temporalmente por un factor de cinco, se acumulan como enteros y posteriormente se convierten a unidades monetarias.

## 6. Experimento 1: comparación de estrategias

**Script:** `cod/06_comparacion_ruletas.R`

Este experimento utiliza 1.000 personas, 100 giros por persona y un monto constante de 50 unidades monetarias por giro.

Cada estrategia se evalúa sobre 100.000 resultados de ruleta por tipo de ruleta, reutilizando los mismos resultados aleatorios para realizar la comparación.

Se calculan los siguientes indicadores:

- **Ganancia neta:** suma de las ganancias y pérdidas de todos los giros de una sesión.
- **Rendimiento porcentual:** ganancia neta dividida entre el total apostado, multiplicada por 100.
- **Pérdida media:** negativo del promedio de las ganancias netas de las personas.
- **Varianza de sesión:** varianza muestral de los saldos finales.
- **Probabilidad estimada de ganar un giro:** porcentaje de resultados individuales cuyo pago neto es positivo.
- **Probabilidad teórica de ganar un giro:** proporción de casillas que generan un pago neto positivo.
- **Probabilidad estimada de terminar ganando:** porcentaje de personas cuyo saldo final es positivo.
- **Rendimiento teórico:** promedio de los pagos posibles, considerando la probabilidad uniforme de las casillas.

Los resultados se exportan a archivos CSV y se presentan mediante tablas.

El script también guarda un archivo RDS que contiene los parámetros y resultados necesarios para los experimentos siguientes.

## 7. Experimento 2: convergencia del rendimiento

**Script:** `cod/07_rendimiento_teorico.R`

Este experimento estudia cómo cambia el rendimiento promedio observado cuando aumenta la cantidad de personas simuladas.

Se mantienen constantes los 100 giros por persona, el monto de 50 unidades monetarias y las reglas de las cuatro estrategias.

Se reutilizan las 1.000 personas del experimento base y se simulan personas adicionales hasta alcanzar 100.000 por ruleta.

Para generar los resultados de las personas adicionales se utiliza `rmultinom()`, que produce los conteos de las casillas obtenidas durante los 100 giros de cada persona.

Estos conteos permiten calcular los saldos finales sin almacenar individualmente todos los giros adicionales.

El rendimiento promedio acumulado se compara con el rendimiento matemático esperado:

- Ruleta europea: aproximadamente −2,7027 %.
- Ruleta americana: aproximadamente −5,2632 %.

El objetivo es observar la aproximación del rendimiento promedio simulado hacia su valor teórico, en relación con la ley de los grandes números.

Los gráficos utilizan una escala logarítmica en el eje horizontal para representar cantidades de personas de diferentes órdenes de magnitud.

## 8. Experimento 3: probabilidad de terminar con ganancias

**Script:** `cod/08_prob_ganancia.R`

Este experimento estudia cómo cambia la proporción de personas que terminan una sesión con ganancia neta positiva al aumentar el número de giros.

Se mantienen constantes 1.000 personas, un monto de 50 unidades monetarias por giro y las cuatro estrategias de apuestas.

Se evalúan sesiones desde 20 hasta 50.000 giros por persona.

Para las duraciones inferiores o iguales a 100 giros, se reutilizan los resultados iniciales del experimento base.

Para duraciones mayores se generan únicamente los giros adicionales mediante una distribución multinomial, acumulando las ganancias de las mismas personas simuladas.

La probabilidad estimada de terminar ganando se calcula como:

**Probabilidad estimada (%) = (personas con ganancia neta positiva / personas simuladas) × 100.**

También se calculan las cantidades de personas con pérdidas y empates, la pérdida media y el rendimiento observado.

Un resultado de 0 % significa que ninguna persona de la muestra terminó con ganancias en ese escenario; no implica necesariamente que la probabilidad matemática sea exactamente cero.

## 9. Reproducibilidad

El proyecto utiliza `set.seed()` para controlar el generador de números pseudoaleatorios.

Esto permite obtener los mismos resultados cuando se ejecutan los scripts con los mismos parámetros y en condiciones computacionales equivalentes.

Los experimentos utilizan semillas derivadas de una semilla base para separar las secuencias aleatorias de las diferentes etapas del análisis.

Los scripts 07 y 08 requieren que el script 06 se haya ejecutado previamente, ya que reutilizan el archivo `res/06_comparacion_ruletas/base_ruletas.rds`.

El orden recomendado para reproducir los tres experimentos finales es:

1. Ejecutar `01_crear_datos_ruletas.R` para generar los CSV si aún no existen.
2. Ejecutar `06_comparacion_ruletas.R`.
3. Ejecutar `07_rendimiento_teorico.R`.
4. Ejecutar `08_prob_ganancia.R`.

La ejecución debe realizarse desde la carpeta raíz del proyecto para que las rutas relativas funcionen correctamente.

## 10. Limitaciones de la investigación

Los resultados dependen de los supuestos matemáticos utilizados para representar la ruleta.

La investigación no modela presupuestos iniciales, abandono del juego por pérdidas, límites de apuesta ni modificaciones dinámicas de las estrategias.

Además, las probabilidades estimadas mediante Monte Carlo presentan variabilidad aleatoria. Por esta razón, los valores simulados pueden diferir de los resultados teóricos, especialmente cuando se utilizan cantidades relativamente pequeñas de observaciones.

El aumento de las simulaciones permite obtener estimaciones más estables, pero no elimina las limitaciones de los supuestos establecidos.

El proyecto busca comparar el comportamiento estadístico de las estrategias bajo condiciones controladas, no predecir resultados específicos de una ruleta real ni demostrar un sistema de apuestas que garantice ganancias.