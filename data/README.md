# Datos del proyecto

Esta carpeta contiene las bases de datos utilizadas para representar las ruletas europea y americana en las simulaciones de Monte Carlo.

## 1. Archivos disponibles

| Archivo | Descripción |
|---|---|
| `ruleta_europea.csv` | Contiene las 37 casillas de la ruleta europea, numeradas del 0 al 36. |
| `ruleta_americana.csv` | Contiene las 38 casillas de la ruleta americana, representadas mediante los números del 0 al 37. |

En la ruleta americana, el valor **37 representa el doble cero (00)**. Esta codificación se utiliza únicamente para facilitar el procesamiento de datos en R.

## 2. Variables

Ambas bases de datos contienen cuatro columnas:

| Variable | Tipo | Descripción |
|---|---|---|
| `numero` | Entero | Identificador numérico de cada casilla. |
| `color` | Carácter | Color de la casilla: Rojo, Negro o Verde. |
| `docena` | Entero | Docena a la que pertenece el número: 1, 2 o 3. |
| `columna` | Entero | Columna de la mesa a la que pertenece el número: 1, 2 o 3. |

Las casillas correspondientes al 0 y al 00 tienen valores faltantes (`NA`) en las variables `docena` y `columna`, porque no pertenecen a ninguno de esos grupos.

Estos valores faltantes son intencionales y no representan errores en los datos.

## 3. Origen de los datos

Las bases de datos fueron construidas mediante el script:

`cod/01_crear_datos_ruletas.R`

La clasificación de los números se basa en las reglas de las ruletas europea y americana, documentadas en `info/01_reglas_ruletas.md`.

Los archivos CSV son de elaboración propia y no provienen de una base de datos histórica de casinos.

## 4. Generación de los archivos

El script `01_crear_datos_ruletas.R` utiliza vectores y operaciones de clasificación para asignar a cada casilla su color, docena y columna.

Posteriormente, las tablas se exportan mediante la función `write.csv()`.

Los archivos pueden regenerarse ejecutando el script desde la carpeta raíz del proyecto.

## 5. Utilización en las simulaciones

Los archivos CSV son utilizados por los scripts de simulación para identificar los resultados posibles de cada ruleta.

Durante el análisis se generan resultados aleatorios a partir de estos conjuntos de casillas y se aplican las reglas de pago definidas en `cod/02_reglas_apuestas.R`.

Los resultados obtenidos mediante las simulaciones se almacenan en la carpeta `res/`.

## 6. Consideraciones

- Todas las casillas se consideran equiprobables.
- Los giros se consideran independientes.
- Los valores de las bases representan resultados posibles, no giros observados.
- No se requiere imputación de los valores `NA`, porque corresponden a características que no aplican a las casillas verdes.
- Los archivos originales se conservan sin modificaciones durante los análisis.