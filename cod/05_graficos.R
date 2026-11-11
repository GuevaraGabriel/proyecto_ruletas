# Simulación de estrategias de ruleta
# BORRADOR, CAMBIO EN EL OBJETIVO DE ANALISIS

# 1. Cargar librería
library(ggplot2)

# 2. Cargar resultados de las simulaciones
comparacion_estrategias <- read.csv("res/comparacion_estrategias.csv")

# ==============================================================================

# 3. Gráfico de probabilidad de terminar ganando
grafico_probabilidad <- ggplot(comparacion_estrategias,
                               aes(x = estrategia, y = probabilidad_ganar, fill = ruleta)) +
  geom_col(position = "dodge") +
  labs(title = "Probabilidad de terminar con ganancias",
       x = "Estrategia de apuesta",
       y = "Sesiones ganadoras (%)",
       fill = "Tipo de ruleta") +
  theme_minimal(base_size = 12)

# Mostrar el gráfico
print(grafico_probabilidad)

# ==============================================================================

# 4. Guardar el gráfico
ggsave(
  filename = "res/grafico_probabilidad.png",
  plot = grafico_probabilidad,
  width = 9,
  height = 5,
  dpi = 300
)

# Cargar resultados del experimento de giros
comparacion_giros <- read.csv("res/comparacion_giros.csv")

# ==============================================================================

# 5. Gráfico del efecto de la cantidad de giros
grafico_giros <- ggplot(comparacion_giros,
                        aes(x = giros, y = probabilidad_ganar, color = ruleta)) +
  geom_line(linewidth = 1) +
  geom_point(size = 3) +
  scale_x_continuous(breaks = c(20, 100, 500)) +
  labs(
    title = "Efecto de la cantidad de giros",
    subtitle = "Porcentaje de sesiones que terminan con ganancias",
    x = "Cantidad de giros por sesion",
    y = "Sesiones ganadoras (%)",
    color = "Tipo de ruleta"
  ) +
  theme_minimal(base_size = 12)

# Mostrar el grafico
print(grafico_giros)

# Guardar el grafico
ggsave(
  filename = "res/grafico_giros.png",
  plot = grafico_giros,
  width = 9,
  height = 5,
  dpi = 300
)

# ==============================================================================

# 6. Grafico de rendimiento simulado vs teorico

# Crear tabla con los rendimientos teoricos
rendimientos_teoricos <- data.frame(ruleta = c("Europea", "Americana"),
                                    teorico = c(-100 / 37, -200 / 38))

# Construir el grafico
grafico_rendimiento <- ggplot(comparacion_estrategias,
                              aes(x = estrategia, y = rendimiento_promedio)) +
  geom_point(size = 3, color = "#009EAD") +
  geom_hline(
    data = rendimientos_teoricos,
    aes(yintercept = teorico),
    linetype = "dashed",
    color = "#E76F67"
  ) +
  facet_wrap( ~ ruleta) +
  labs(
    title = "Rendimiento simulado frente al teorico",
    subtitle = "1.000 sesiones de 100 giros por estrategia",
    x = "Estrategia de apuesta",
    y = "Rendimiento promedio (%)"
  ) +
  theme_minimal(base_size = 12)

# Mostrar el gráfico
print(grafico_rendimiento)

# Guardar el gráfico
ggsave(
  filename = "res/grafico_rendimiento.png",
  plot = grafico_rendimiento,
  width = 9,
  height = 5,
  dpi = 300
)

# ==============================================================================

# 7. Gráfico de variabilidad de las estrategias

grafico_variabilidad <- ggplot(comparacion_estrategias,
                               aes(x = estrategia, y = desviacion_ganancias, fill = ruleta)) +
  geom_col(position = "dodge") +
  labs(
    title = "Variabilidad de las ganancias por estrategia",
    subtitle = "1.000 sesiones de 100 giros, con apuestas de $50",
    x = "Estrategia de apuesta",
    y = "Desviacion estandar ($)",
    fill = "Tipo de ruleta"
  ) +
  theme_minimal(base_size = 12)

# Mostrar el gráfico
print(grafico_variabilidad)

# Guardar el gráfico
ggsave(
  filename = "res/grafico_variabilidad.png",
  plot = grafico_variabilidad,
  width = 9,
  height = 5,
  dpi = 300
)

# ==============================================================================

# 9. Evolucion de ganancias durante una sesion

# Crear tabla para guardar las trayectorias
trayectorias <- data.frame()

# Simular una sesion por estrategia
for (i in seq_along(estrategias)) {
  # Utilizar los mismos giros en cada estrategia
  set.seed(2026)
  
  sesion <- simular_sesion(ruleta_europea, 100, 50, estrategias[i], elecciones[[i]])
  
  # Identificar la estrategia
  sesion$estrategia <- estrategias[i]
  
  # Guardar los resultados
  trayectorias <- rbind(trayectorias, sesion)
}

# Exportar los datos
write.csv(trayectorias, "res/trayectorias.csv", row.names = FALSE)

# Mostrar los resultados
print(trayectorias)

# ==============================================================================

# 8. Grafico de evolucion de ganancias

# Cargar los datos de las trayectorias
trayectorias <- read.csv("res/trayectorias.csv")

# Crear el grafico
grafico_evolucion <- ggplot(trayectorias, aes(x = giro, y = acumulada)) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  geom_line(color = "#009EAD", linewidth = 0.8) +
  facet_wrap( ~ estrategia, scales = "free_y") +
  labs(
    title = "Evolucion de ganancias por estrategia",
    subtitle = "Ruleta europea: 100 giros con apuestas de $50",
    x = "Numero de giro",
    y = "Ganancia neta acumulada ($)"
  ) +
  theme_minimal(base_size = 12)

# Mostrar el grafico
print(grafico_evolucion)

# Guardar el grafico
ggsave(
  filename = "res/grafico_evolucion.png",
  plot = grafico_evolucion,
  width = 9,
  height = 6,
  dpi = 300
)

