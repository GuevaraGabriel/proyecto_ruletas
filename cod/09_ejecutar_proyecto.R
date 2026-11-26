# 09. Ejecucion completa del proyecto de ruletas.
# Ejecutar desde la carpeta raiz del proyecto.
# Genera los datos y resultados de los tres experimentos finales.

# 1. Generar las bases de datos
message("Generando bases de datos...")
source("cod/01_crear_datos_ruletas.R")

# 2. Experimento de comparacion de estrategias
message("Ejecutando experimento 1...")
source("cod/06_comparacion_ruletas.R")

# 3. Experimento de convergencia del rendimiento
message("Ejecutando experimento 2...")
source("cod/07_rendimiento_teorico.R")

# 4. Experimento de probabilidad de ganancia
message("Ejecutando experimento 3...")
source("cod/08_prob_ganancia.R")

message("Proyecto ejecutado correctamente.")