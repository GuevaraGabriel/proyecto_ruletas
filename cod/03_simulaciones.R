# Simulación de estrategias de ruleta

# Cargar las ruletas
ruleta_europea <- read.csv("data/ruleta_europea.csv")
ruleta_americana <- read.csv("data/ruleta_americana.csv")

# Cargar las funciones de las estrategias
source("cod/02_reglas_apuestas.R")

# giros de ruleta
simular_giros <- function(ruleta, n_giros) {
  # Seleccionar resultados aleatorios
  resultados <- sample(ruleta$numero, size = n_giros, replace = TRUE)
  
  return(resultados)
}

# Simular sesion de apuestas
simular_sesion <- function(ruleta, n_giros, monto, estrategia, eleccion) {
  # Generar los resultados aleatorios
  resultados <- simular_giros(ruleta, n_giros)
  # Aplicar la estrategia seleccionada
  if (estrategia == "Numero") {
    ganancias <- apostar_numero(resultados, monto, eleccion)
  } else if (estrategia == "Docena") {
    ganancias <- apostar_docena(resultados, monto, eleccion)
  } else if (estrategia == "Color") {
    ganancias <- apostar_color(resultados, monto, eleccion)
  } else if (estrategia == "Combinada") {
    ganancias <- apostar_combinada(resultados, monto, eleccion)
  } else {
    stop("Estrategia no valida")
  }
  # Crear la tabla con los resultados
  sesion <- data.frame(
    giro = seq_along(resultados),
    numero = resultados,
    ganancia = ganancias,
    acumulada = cumsum(ganancias)
  )
  
  return(sesion)
}

# Función para resumir los resultados de una sesión
resumir_sesion <- function(sesion, monto) {
  # Calcular los indicadores
  ganancia_neta <- sum(sesion$ganancia)
  total_apostado <- nrow(sesion) * monto
  rendimiento <- (ganancia_neta / total_apostado) * 100
  # Crear tabla resumen
  resumen <- data.frame(
    ganancia_neta = ganancia_neta,
    total_apostado = total_apostado,
    rendimiento = rendimiento
  )
  
  return(resumen)
}





