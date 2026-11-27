# Crear las 4 estrategias de apuestas y sus reglas

# 1. apostar a un numero
apostar.numero <- function(resultado, monto, elegido) {
  # Calcular la ganancia o perdida neta
  ganancia <- ifelse(resultado == elegido, monto * 35, -monto)
  
  return(ganancia)
}

# 2. apostar a un tercio de la mesa
apostar.docena <- function(resultado, monto, elegida) {
  # Determinar la docena del numero ganador
  docena.resultado <- ifelse(resultado %in% 1:36, ceiling(resultado / 12), NA_integer_)
  # Calcular la ganancia o perdida neta
  ganancia <- ifelse(!is.na(docena.resultado) &
                       docena.resultado == elegida,
                     monto * 2,-monto)
  
  return(ganancia)
}

# 3. apostar a un color
apostar.color <- function(resultado, monto, elegido) {
  # Números rojos de la ruleta
  rojos <- c(1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36)
  # Identificar el color del numero ganador
  color.resultado <- ifelse(resultado %in% c(0, 37),
                            "Verde",
                            ifelse(resultado %in% rojos, "Rojo", "Negro"))
  # Calcular la ganancia o perdida neta
  ganancia <- ifelse(color.resultado == elegido, monto, -monto)
  
  return(ganancia)
}

# 4. apuesta combinada
apostar.combinada <- function(resultado, monto, color.elegido) {
  # Verificar que el color sea valido
  if (!(color.elegido %in% c("Negro", "Rojo"))) {
    stop("El color debe ser Negro o Rojo")
  }
  # Asignar la columna según el color elegido
  columna.elegida <- ifelse(color.elegido == "Negro", 3, 2)
  # Dividir el monto total apostado
  monto.color <- monto * 0.6
  monto.columna <- monto * 0.4
  # Calcular la ganancia del color
  ganancia.color <- apostar.color(resultado, monto.color, color.elegido)
  # Calcular la ganancia de la columna
  ganancia.columna <- ifelse(resultado %in% seq(columna.elegida, 36, by = 3),
                             monto.columna * 2,-monto.columna)
  # Calcular la ganancia total
  ganancia.total <- ganancia.color + ganancia.columna
  
  return(ganancia.total)
}










