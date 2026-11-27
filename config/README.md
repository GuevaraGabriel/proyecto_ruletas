# Carpeta Config

Esta carpeta está destinada a documentar la configuración general utilizada en las simulaciones de Monte Carlo.

Actualmente, los parámetros se encuentran centralizados en el archivo `cod/00_configuracion.R`, por lo que no es necesario duplicarlos en esta carpeta.

## 1. Archivo de configuración

**Ubicación:** `cod/00_configuracion.R`

Este script contiene los parámetros utilizados por los tres experimentos principales.

## 2. Parámetros generales

| Parámetro | Valor | Descripción |
|----------------------|----------------------------:|----------------------|
| `n.personas` | 1.000 | Cantidad de personas simuladas en el escenario base. |
| `n.giros` | 100 | Cantidad de giros por persona en el escenario base. |
| `monto` | 50 | Unidades monetarias apostadas por giro. |
| `semilla` | 54321 | Semilla para reproducir las simulaciones. |
| `escala` | 5 | Factor para representar los pagos mediante números enteros. |
| `max.personas` | 100.000 | Máximo de personas en el análisis de convergencia. |

## 3. Cantidades de giros

Para el análisis de probabilidad de terminar con ganancias se utilizan las siguientes cantidades de giros por persona:

20, 50, 100, 200, 500, 1.000, 2.000, 5.000, 10.000, 20.000 y 50.000.

Estos valores se definen mediante el vector `cantidades.giros`.

## 4. Estrategias

Las estrategias consideradas son:

- `Numero`: apuesta al número 17.
- `Docena`: apuesta a la primera docena.
- `Color`: apuesta al negro.
- `Combinada`: apuesta del 60 % al negro y 40 % a la tercera columna.

El archivo de configuración también establece las etiquetas y los colores utilizados para representar cada estrategia en los gráficos.

## 5. Modificación de parámetros

Para cambiar las condiciones de los experimentos se deben modificar los valores correspondientes en `cod/00_configuracion.R`.

Después es necesario ejecutar nuevamente los scripts:

1.  `06_comparacion_ruletas.R`
2.  `07_rendimiento_teorico.R`
3.  `08_prob_ganancia.R`

El script 06 genera los resultados base que reutilizan los scripts 07 y 08.

## 6. Reproducibilidad

El parámetro `semilla` permite controlar la generación de números pseudoaleatorios mediante `set.seed()`.

Esto facilita reproducir los resultados utilizando los mismos parámetros y condiciones computacionales.

## 7. Organización

Se mantiene la configuración en `cod/00_configuracion.R` para conservar las rutas actuales de ejecución.

La carpeta `config/` funciona como referencia documental de esos parámetros y puede utilizarse para almacenar configuraciones adicionales en futuras ampliaciones del proyecto.
