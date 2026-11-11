# Simulación de estrategias de ruleta y códigos finales

# 1. Cargar las funciones del proyecto
source("cod/03_simulaciones.R")

# 2. Configurar los experimentos

# Semilla para reproducir los resultados
set.seed(2026)

# Cantidad de sesiones
n_sesiones <- 1000

# Cantidades de giros y montos
cantidades_giros <- c(20, 100, 500)
montos <- c(10, 50, 100)

# Estrategias y elecciones
estrategias <- c("Numero", "Docena", "Color", "Combinada")
elecciones <- list(17, 1, "Negro", "Negro")

# Tipos de ruleta
ruletas <- list(Europea = ruleta_europea, Americana = ruleta_americana)

# ==============================================================================

# 3. Comparar las estrategias en ambas ruletas

# Crear tabla para guardar los resultados
comparacion_estrategias <- data.frame()

# Recorrer las dos ruletas
for (tipo_ruleta in names(ruletas)) {
  # Recorrer las cuatro estrategias
  for (i in seq_along(estrategias)) {
    # Utilizar la misma semilla para cada estrategia
    set.seed(2026)
    
    # Simular las sesiones
    sesiones <- simular_multiples_sesiones(ruletas[[tipo_ruleta]], n_sesiones, 100, 50, estrategias[i], elecciones[[i]])
    
    # Calcular los indicadores
    resumen <- analizar_sesiones(sesiones)
    
    # Identificar la ruleta y la estrategia
    resumen$ruleta <- tipo_ruleta
    resumen$estrategia <- estrategias[i]
    
    # Guardar los resultados
    comparacion_estrategias <- rbind(comparacion_estrategias, resumen)
  }
}

# Organizar las columnas
comparacion_estrategias <- comparacion_estrategias[, c(
  "ruleta",
  "estrategia",
  "ganancia_promedio",
  "probabilidad_ganar",
  "desviacion_ganancias",
  "rendimiento_promedio"
)]

# 4. Guardar los resultados en CSV
write.csv(comparacion_estrategias,
          "res/comparacion_estrategias.csv",
          row.names = FALSE)

# Mostrar los resultados
print(comparacion_estrategias)

# ==============================================================================

# 5. Efecto de la cantidad de giros

# Crear tabla para guardar los resultados
comparacion_giros <- data.frame()

# Establecer semilla para reproducir el experimento
set.seed(2026)

# Recorrer las dos ruletas
for (tipo_ruleta in names(ruletas)) {
  # Recorrer las cantidades de giros
  for (n in cantidades_giros) {
    # Simular las sesiones
    sesiones <- simular_multiples_sesiones(ruletas[[tipo_ruleta]], n_sesiones, n, 50, "Combinada", "Negro")
    
    # Calcular los indicadores
    resumen <- analizar_sesiones(sesiones)
    
    # Identificar el escenario
    resumen$ruleta <- tipo_ruleta
    resumen$giros <- n
    
    # Guardar los resultados
    comparacion_giros <- rbind(comparacion_giros, resumen)
  }
}

# Organizar las columnas
comparacion_giros <- comparacion_giros[, c(
  "ruleta",
  "giros",
  "ganancia_promedio",
  "probabilidad_ganar",
  "desviacion_ganancias",
  "rendimiento_promedio"
)]

# 6. Exportar resultados
write.csv(comparacion_giros, "res/comparacion_giros.csv", row.names = FALSE)

print(comparacion_giros)













