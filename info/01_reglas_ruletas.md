---
title: "01_reglas_ruletas"
output: html_document
---

## 1. Funcionamiento general

La ruleta es un juego de azar en el cual una bola termina en una casilla numerada después de cada giro. Los jugadores realizan apuestas antes de conocer el resultado y reciben ganancias o pérdidas dependiendo de la casilla ganadora.

En este proyecto se estudian dos variantes: la ruleta europea y la americana. Se supone que todas las casillas tienen la misma probabilidad de resultar ganadoras y que los giros son independientes.

## 2. Diferencias entre las ruletas

| Característica | Europea | Americana |
|---|---|---|
| Total de casillas | 37 | 38 |
| Números ordinarios | 1 al 36 | 1 al 36 |
| Casillas verdes | 0 | 0 y 00 |
| Casillas rojas | 18 | 18 |
| Casillas negras | 18 | 18 |
| Probabilidad de un número específico | 1/37 | 1/38 |
| Ventaja matemática de la casa | 2,70 % | 5,26 % |

La principal diferencia es que la ruleta americana incorpora una casilla adicional, el doble cero (00). Esto reduce las probabilidades de ganar las apuestas estudiadas sin aumentar sus pagos.

En el archivo `01_crear_datos_ruletas.R`, el número 37 se utiliza para representar el doble cero (00), exclusivamente por razones de programación.

## 3. Clasificación de los números

Los números del 1 al 36 se clasifican en rojos y negros.

**Números rojos:** 1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34 y 36.

**Números negros:** los restantes números del 1 al 36.

Las casillas 0 y 00 son verdes.

También existen agrupaciones de números:

- Primera docena: 1 al 12.
- Segunda docena: 13 al 24.
- Tercera docena: 25 al 36.
- Primera columna: 1, 4, 7, ..., 34.
- Segunda columna: 2, 5, 8, ..., 35.
- Tercera columna: 3, 6, 9, ..., 36.

Las casillas verdes no pertenecen a ninguna docena ni columna.

## 4. Reglas de pago

Las estrategias analizadas utilizan los siguientes pagos convencionales:

| Apuesta | Números cubiertos | Ganancia neta al acertar |
|---|---|---|
| Número individual | 1 | 35 veces lo apostado |
| Docena | 12 | 2 veces lo apostado |
| Color | 18 | 1 vez lo apostado |
| Columna | 12 | 2 veces lo apostado |

Cuando una apuesta pierde, se pierde el monto completo apostado.

Es importante distinguir la ganancia neta del dinero total recibido. Por ejemplo, una apuesta de 50 unidades monetarias a un número ganador produce una ganancia neta de 1.750 unidades, además de la devolución de las 50 apostadas.

El proyecto utiliza las ganancias netas para calcular los indicadores estadísticos.

## 5. Tratamiento del cero y doble cero

En nuestro modelo, cuando el resultado es 0 o 00, las apuestas al número 17, primera docena, negro y tercera columna pierden.

No se consideran reglas especiales como *la partage* o *en prison*, que pueden modificar las pérdidas de determinadas apuestas cuando aparece el cero.

## 6. Ventaja matemática de la casa

La ventaja de la casa representa la pérdida esperada del jugador como porcentaje de la cantidad apostada.

En las apuestas estudiadas, la ruleta europea tiene una pérdida esperada del 2,7027 % del monto apostado, mientras que la americana tiene una pérdida esperada del 5,2632 %.

Estos valores no representan pérdidas garantizadas en cada sesión, sino promedios matemáticos esperados a largo plazo.

Aunque las estrategias pueden producir diferentes ganancias y pérdidas en una simulación, todas mantienen el mismo rendimiento esperado negativo dentro de una misma ruleta bajo las reglas utilizadas.

## 7. Fuentes consultadas

1. Ministerio de Economía y Hacienda de España. (2011). *Orden EHA/3085/2011, de 8 de noviembre, por la que se aprueba la reglamentación básica del juego de la ruleta*. Boletín Oficial del Estado. https://www.boe.es/eli/es/o/2011/11/08/eha3085/con

2. New York Codes, Rules and Regulations. *Título 9, sección 5324.4: Roulette*. Legal Information Institute, Cornell Law School. https://www.law.cornell.edu/regulations/new-york/9-NYCRR-5324.4

**Nota:** las fuentes externas respaldan las reglas generales del juego. Los parámetros específicos y las estrategias seleccionadas son decisiones propias del proyecto.