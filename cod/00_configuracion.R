# 00. Configuracion general de los tres experimentos.
# Cambia los parametros aqui y vuelve a ejecutar 06, 07 y 08.

# Escenario base (script 06)
n_personas <- 1000
n_giros <- 100
monto <- 50
semilla <- 54321

# Factor para trabajar con pagos enteros
escala <- 5

# Experimento de convergencia (script 07)
max_personas <- 100000

# Experimento de probabilidad de ganancia (script 08)
cantidades_giros <- sort(unique(c(
  20, 50, n_giros, 200, 500, 1000, 2000, 5000, 10000, 20000, 50000
)))

# Estrategias y nombres para los graficos
estrategias <- c("Numero", "Docena", "Color", "Combinada")
etiquetas <- c("Número", "Docena", "Color", "Combinada")

colores <- c(
  Numero = "#8754B3",
  Docena = "#CE7925",
  Color = "#28679B",
  Combinada = "#008B7A"
)
