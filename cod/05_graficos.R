# Simulación de estrategias de ruleta

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









