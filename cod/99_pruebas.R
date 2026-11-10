# Pruebas del proyecto de ruletas

# Cargar las funciones del proyecto
source("cod/03_simulaciones.R")

# Prueba de rentabilidad de una sesión

set.seed(2026)

monto <- 50
sesion_prueba <- simular_sesion(ruleta_europea, 100, monto, "Combinada", "Negro")
ganancia_neta <- sum(sesion_prueba$ganancia)
total_apostado <- nrow(sesion_prueba) * monto
rendimiento <- (ganancia_neta / total_apostado) * 100

print(ganancia_neta)
print(total_apostado)
print(rendimiento)

# Prueba de la función resumen
resumen_prueba <- resumir_sesion(sesion_prueba, monto)
print(resumen_prueba)



