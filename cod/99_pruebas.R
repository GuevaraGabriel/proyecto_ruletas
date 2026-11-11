# Pruebas del proyecto de ruletas

# Cargar las funciones del proyecto
source("cod/03_simulaciones.R")

# 1. Prueba de rentabilidad de una sesión

set.seed(2026)

monto <- 50
sesion_prueba <- simular_sesion(ruleta_europea, 100, monto, "Combinada", "Negro")
ganancia_neta <- sum(sesion_prueba$ganancia)
total_apostado <- nrow(sesion_prueba) * monto
rendimiento <- (ganancia_neta / total_apostado) * 100

print(ganancia_neta)
print(total_apostado)
print(rendimiento)

# 3. Prueba de la función resumen
resumen_prueba <- resumir_sesion(sesion_prueba, monto)
print(resumen_prueba)
# Prueba de múltiples sesiones
set.seed(2026)
# Cantidad de sesiones a simular
n_sesiones <- 5
# Vector para guardar las ganancias finales
ganancias_sesiones <- numeric(n_sesiones)
# Repetir la simulación
for (i in 1:n_sesiones) {
  sesion_actual <- simular_sesion(ruleta_europea, 100, 50, "Combinada", "Negro")
  ganancias_sesiones[i] <- sum(sesion_actual$ganancia)
}
print(ganancias_sesiones)

# 4. Prueba de la función de múltiples sesiones
set.seed(2026)
prueba_multiples <- simular_multiples_sesiones(ruleta_europea, 5, 100, 50, "Combinada", "Negro")
print(prueba_multiples)

# 5. Estadísticas de múltiples sesiones
# Ganancia o perdida promedio
ganancia_promedio <- mean(prueba_multiples$ganancia_neta)
# Porcentaje de sesiones con ganancias
probabilidad_ganar <- mean(prueba_multiples$ganancia_neta > 0) * 100
# Desviación estándar de las ganancias
desviacion_ganancias <- sd(prueba_multiples$ganancia_neta)
# Rendimiento promedio
rendimiento_promedio <- mean(prueba_multiples$rendimiento)
print(ganancia_promedio)
print(probabilidad_ganar)
print(desviacion_ganancias)
print(rendimiento_promedio)


# 6. Prueba con 1000 sesiones
set.seed(2026)
# Simular 1000 sesiones de 100 giros
prueba_1000 <- simular_multiples_sesiones(ruleta_europea, 1000, 100, 50, "Combinada", "Negro")
analisis_1000 <- analizar_sesiones(prueba_1000)
print(analisis_1000)


# 7. Comparación de las cuatro estrategias
# Definir las estrategias y sus elecciones
estrategias <- c("Numero", "Docena", "Color", "Combinada")
elecciones <- list(17, 1, "Negro", "Negro")
# Crear tabla para guardar la comparación
comparacion <- data.frame()
# Simular y analizar cada estrategia
for (i in seq_along(estrategias)) {
  set.seed(2026)
  sesiones <- simular_multiples_sesiones(ruleta_europea, 1000, 100, 50, estrategias[i], elecciones[[i]])
  resumen <- analizar_sesiones(sesiones)
  # Identificar la estrategia
  resumen$estrategia <- estrategias[i]
  # Agregar los resultados a la tabla
  comparacion <- rbind(comparacion, resumen)
}
# Organizar las columnas
comparacion <- comparacion[, c(
  "estrategia",
  "ganancia_promedio",
  "probabilidad_ganar",
  "desviacion_ganancias",
  "rendimiento_promedio"
)]

print(comparacion)


# 8. Comparacion de estrategias en ruleta americana
# Crear tabla para guardar los resultados
comparacion_americana <- data.frame()
# Simular cada estrategia
for (i in seq_along(estrategias)) {
  set.seed(2026)
  sesiones <- simular_multiples_sesiones(ruleta_americana, 1000, 100, 50, estrategias[i], elecciones[[i]])
  # Calcular los indicadores
  resumen <- analizar_sesiones(sesiones)
  # Identificar la estrategia
  resumen$estrategia <- estrategias[i]
  # Agregar los resultados a la tabla
  comparacion_americana <- rbind(comparacion_americana, resumen)
}
# Organizar las columnas
comparacion_americana <- comparacion_americana[, c(
  "estrategia",
  "ganancia_promedio",
  "probabilidad_ganar",
  "desviacion_ganancias",
  "rendimiento_promedio"
)]

print(comparacion_americana)

# 9. Comparación general de ambas ruletas
# Identificar cada tipo de ruleta
europea <- comparacion
americana <- comparacion_americana
europea$ruleta <- "Europea"
americana$ruleta <- "Americana"
# Unir las dos tablas
comparacion_final <- rbind(europea, americana)
# Organizar las columnas
comparacion_final <- comparacion_final[, c(
  "ruleta",
  "estrategia",
  "ganancia_promedio",
  "probabilidad_ganar",
  "desviacion_ganancias",
  "rendimiento_promedio"
)]

print(comparacion_final)


# 10. Efecto de la cantidad de giros
# Cantidades de giros que queremos comparar
cantidades_giros <- c(20, 100, 500)
# Crear tabla para guardar los resultados
comparacion_giros <- data.frame()
set.seed(2026)
# Repetir el experimento para cada cantidad de giros
for (n in cantidades_giros) {
  sesiones <- simular_multiples_sesiones(ruleta_europea, 1000, n, 50, "Combinada", "Negro")
  resumen <- analizar_sesiones(sesiones)
  # Identificar la cantidad de giros
  resumen$giros <- n
  # Guardar los resultados
  comparacion_giros <- rbind(comparacion_giros, resumen)
}

# Mostrar la comparación
print(comparacion_giros)


# 11. Efecto del monto apostado
# Montos que queremos comparar
montos <- c(10, 50, 100)
# Crear tabla para guardar los resultados
comparacion_montos <- data.frame()
# Repetir el experimento para cada monto
for (monto_actual in montos) {
  set.seed(2026)
  sesiones <- simular_multiples_sesiones(ruleta_europea, 1000, 100, monto_actual, "Combinada", "Negro")
  # Calcular los indicadores
  resumen <- analizar_sesiones(sesiones)
  # Identificar el monto apostado
  resumen$monto <- monto_actual
  # Guardar los resultados
  comparacion_montos <- rbind(comparacion_montos, resumen)
}

print(comparacion_montos)


# 12. Numero fijo vs numero aleatorio
#set.seed(2026)
# Configurar el experimento
n_sesiones <- 1000
n_giros <- 100
monto <- 50
# Crear vectores para guardar las ganancias
ganancias_fijo <- numeric(n_sesiones)
ganancias_aleatorio <- numeric(n_sesiones)
# Simular las sesiones
for (i in seq_len(n_sesiones)) {
  # Generar los resultados de la ruleta
  resultados <- simular_giros(ruleta_europea, n_giros)
  # Elegir un numero aleatorio en cada giro
  numeros_elegidos <- sample(ruleta_europea$numero, size = n_giros, replace = TRUE)
  # Jugador A: siempre apuesta al 17
  ganancias_fijo[i] <- sum(apostar_numero(resultados, monto, 17))
  # Jugador B: cambia de numero en cada giro
  ganancias_aleatorio[i] <- sum(apostar_numero(resultados, monto, numeros_elegidos))
}

# Comparar los resultados
comparacion_eleccion <- data.frame(
  modalidad = c("Fijo", "Aleatorio"),
  ganancia_promedio = c(mean(ganancias_fijo), mean(ganancias_aleatorio)),
  probabilidad_ganar = c(mean(ganancias_fijo > 0), mean(ganancias_aleatorio > 0)) * 100,
  desviacion = c(sd(ganancias_fijo), sd(ganancias_aleatorio)),
  rendimiento = c(mean(ganancias_fijo), mean(ganancias_aleatorio)) / (n_giros * monto) * 100
)

print(comparacion_eleccion)

# 13. Repetir la comparacion de elecciones

# Configurar el experimento
n_repeticiones <- 10
n_sesiones <- 10000
n_giros <- 100
monto <- 50

# Crear tabla de resultados
resultados_repeticiones <- data.frame()

# Establecer semilla una sola vez
set.seed(2026)

# Repetir el experimento completo
for (r in seq_len(n_repeticiones)) {
  
  ganancias_fijo <- numeric(n_sesiones)
  ganancias_aleatorio <- numeric(n_sesiones)
  
  # Simular las sesiones de cada repeticion
  for (i in seq_len(n_sesiones)) {
    
    resultados <- simular_giros(ruleta_europea, n_giros)
    
    numeros_elegidos <- sample(
      ruleta_europea$numero, n_giros, replace = TRUE
    )
    
    ganancias_fijo[i] <- sum(
      apostar_numero(resultados, monto, 17)
    )
    
    ganancias_aleatorio[i] <- sum(
      apostar_numero(resultados, monto, numeros_elegidos)
    )
  }
  
  # Calcular las estadisticas de cada repeticion
  resumen <- data.frame(
    repeticion = r,
    modalidad = c("Fijo", "Aleatorio"),
    ganancia_promedio = c(
      mean(ganancias_fijo),
      mean(ganancias_aleatorio)
    ),
    probabilidad_ganar = c(
      mean(ganancias_fijo > 0),
      mean(ganancias_aleatorio > 0)
    ) * 100,
    desviacion = c(
      sd(ganancias_fijo),
      sd(ganancias_aleatorio)
    ),
    rendimiento = c(
      mean(ganancias_fijo),
      mean(ganancias_aleatorio)
    ) / (n_giros * monto) * 100
  )
  
  # Guardar los resultados
  resultados_repeticiones <- rbind(
    resultados_repeticiones, resumen
  )
}

# Mostrar los resultados de las 10 repeticiones
print(resultados_repeticiones)




























