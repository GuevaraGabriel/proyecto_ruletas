# ruleta europea

# vector con números del 0 al 36
numeros_europea <- 0:36
numeros_europea

# ruleta americana

# vector con números del 0 al 37, aquí se agrega el 37 que va a representar el 00 ya que R toma el valor del 00 como un 0 normal
numeros_americana <- 0:37
numeros_americana

# asignar los colores a cada casilla y crear las tablas
crear_tabla <- function(numeros) {
  # Números rojos de la ruleta
  rojos <- c(1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36)
  
  # Clasificar cada numero
  colores <- ifelse(numeros %in% rojos,
                    "Rojo",
                    ifelse(numeros %in% c(0, 37), "Verde", "Negro"))
  # Clasificar las casillas por docenas
  docenas <- ifelse(numeros %in% 1:12, 1, ifelse(
    numeros %in% 13:24,
    2,
    ifelse(numeros %in% 25:36, 3, NA_integer_)
  ))
  # Clasificar las casillas por columnas
  columnas <- ifelse(numeros %in% 1:36, ((numeros - 1) %% 3) + 1, NA_integer_)
  # Crear tabla de resultados
  data.frame(
    numero = numeros,
    color = colores,
    docena = docenas,
    columna = columnas
  )
}

# crear las ruletas
ruleta_europea <- crear_tabla(numeros_europea)
ruleta_americana <- crear_tabla(numeros_americana)

# guardar las ruletas
write.csv(ruleta_europea, "data/ruleta_europea.csv", row.names = FALSE)
write.csv(ruleta_americana, "data/ruleta_americana.csv", row.names = FALSE)













