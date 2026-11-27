# 08. Probabilidad de terminar con ganancia al aumentar los giros.
# Ejecutar despues de 06_comparacion_ruletas.R.

library(dplyr)
library(ggplot2)

# Cargar los resultados del script 06
archivo <- "res/06_comparacion_ruletas/base_ruletas.rds"

if (!file.exists(archivo)) {
  stop("Primero ejecuta cod/06_comparacion_ruletas.R")
}

proyecto <- readRDS(archivo)

p <- proyecto$parametros
estrategias <- proyecto$estrategias
cantidades.giros <- p$cantidades.giros

# Crear la carpeta de resultados
salida <- "res/08_prob_ganancia"
dir.create(salida, recursive = TRUE, showWarnings = FALSE)

resultados <- list()
individuales <- list()

# Analizar ambas ruletas
for (i in seq_along(proyecto$base)) {
  tipo <- names(proyecto$base)[i]
  modelo <- proyecto$base[[i]]
  
  set.seed(p$semilla + 20000 + i)
  
  # Comenzar con las ganancias del escenario base
  acumuladas <- modelo$ganancias.unidad
  ultimo.giro <- p$n.giros
  
  # Evaluar las diferentes cantidades de giros
  for (n in cantidades.giros) {
    if (n <= p$n.giros) {
      # Recuperar los primeros n giros del escenario base
      indices <- as.vector(modelo$indices[, seq_len(n), drop = FALSE])
      
      unidades <- sapply(seq_along(estrategias), function(j) {
        rowSums(matrix(modelo$pagos.enteros[indices, j], nrow = p$n.personas))
      })
      
      colnames(unidades) <- estrategias
      
    } else {
      # Simular solamente los giros adicionales
      conteos <- t(rmultinom(
        p$n.personas,
        size = n - ultimo.giro,
        prob = rep(1, nrow(modelo$pagos.enteros))
      ))
      
      # Sumar las nuevas ganancias
      acumuladas <- acumuladas +
        conteos %*% modelo$pagos.enteros
      
      unidades <- acumuladas
      ultimo.giro <- n
    }
    
    # Convertir las ganancias al monto real
    ganancias <- unidades * p$monto / p$escala
    
    # Contar personas que terminaron con ganancia
    ganadores <- colSums(unidades > 0)
    
    clave <- paste(tipo, n, sep = "_")
    
    # Resumen por estrategia y cantidad de giros
    resultados[[clave]] <- tibble(
      ruleta = tipo,
      estrategia = estrategias,
      personas = p$n.personas,
      giros = n,
      monto = p$monto,
      
      ganadores = ganadores,
      perdedores = colSums(unidades < 0),
      empates = colSums(unidades == 0),
      
      probabilidad.ganancia =
        ganadores / p$n.personas * 100,
      
      perdida.media = -colMeans(ganancias),
      
      rendimiento = colMeans(ganancias) /
        (n * p$monto) * 100
    )
    
    # Guardar las ganancias individuales de cada persona
    individuales[[clave]] <- bind_rows(lapply(seq_along(estrategias), function(j) {
      tibble(
        ruleta = tipo,
        estrategia = estrategias[j],
        giros = n,
        persona = seq_len(p$n.personas),
        ganancia.neta = ganancias[, j]
      )
    }))
  }
}

# Unir los resultados de ambas ruletas
datos <- bind_rows(resultados)

# Exportar los resultados generales
write.csv(datos,
          file.path(salida, "probabilidad_ganancia.csv"),
          row.names = FALSE)

# Exportar los resultados individuales
write.csv(bind_rows(individuales),
          file.path(salida, "sesiones_por_giros.csv"),
          row.names = FALSE)

# Formato de numeros y porcentajes
numero <- scales::label_number(big.mark = ".", decimal.mark = ",")

porcentaje <- scales::label_number(suffix = " %", decimal.mark = ",")

# Mantener la misma escala vertical en ambas ruletas
limite.y <- min(100, max(60, ceiling(max(
  datos$probabilidad.ganancia
) / 10) * 10))

# Crear un grafico para cada ruleta
for (tipo in names(proyecto$base)) {
  d <- filter(datos, ruleta == tipo)
  
  grafico <- ggplot(d, aes(x = giros, y = probabilidad.ganancia, color = estrategia)) +
    geom_vline(
      xintercept = p$n.giros,
      color = "#ADB6C2",
      linetype = "dotted"
    ) +
    geom_line(linewidth = 0.8) +
    geom_point(size = 2.3) +
    scale_color_manual(
      values = proyecto$colores,
      breaks = estrategias,
      labels = proyecto$etiquetas,
      name = NULL
    ) +
    scale_x_log10(breaks = sort(unique(
      c(
        min(cantidades.giros),
        p$n.giros,
        500,
        2000,
        10000,
        max(cantidades.giros)
      )
    )), labels = numero) +
    scale_y_continuous(
      limits = c(0, limite.y),
      breaks = seq(0, limite.y, 10),
      labels = porcentaje
    ) +
    labs(
      title = paste0(
        "Ruleta ",
        tolower(tipo),
        ": probabilidad de terminar con ganancia"
      ),
      subtitle = paste0(
        numero(p$n.personas),
        " personas por estrategia; ",
        numero(p$monto),
        " u. m. por giro; ganancia final mayor que cero."
      ),
      x = "Cantidad de giros por persona (escala logarítmica)",
      y = "Personas que terminan con ganancia (%)",
      caption = paste0(
        "Mismas personas al aumentar los giros, sin límite de fondos. ",
        "Un 0 % observado no implica imposibilidad.\n",
        "Fuente: elaboración propia mediante simulación."
      )
    ) +
    theme_minimal(base_size = 12) +
    theme(
      legend.position = "bottom",
      panel.grid.minor = element_blank(),
      plot.title = element_text(face = "bold", color = "#20344A"),
      plot.caption = element_text(hjust = 0),
      plot.margin = margin(12, 16, 12, 12)
    )
  
  print(grafico)
  
  # Guardar los graficos como PNG y PDF
  for (extension in c("png", "pdf")) {
    ggsave(
      file.path(salida, paste0(
        "probabilidad_", tolower(tipo), ".", extension
      )),
      plot = grafico,
      width = 11,
      height = 6.5,
      dpi = 300,
      bg = "white"
    )
  }
}

# =============================================================================
# gráfico de del reporte final

grafico.reporte.08 <- ggplot(
  datos,
  aes(x = giros, y = probabilidad.ganancia, color = estrategia)
) +
  geom_vline(
    xintercept = p$n.giros,
    color = "gray60",
    linetype = "dotted",
    linewidth = 0.6
  ) +
  geom_line(linewidth = 0.9) +
  geom_point(size = 2) +
  facet_wrap(~ruleta, ncol = 2) +
  scale_color_manual(
    values = proyecto$colores,
    breaks = estrategias,
    labels = proyecto$etiquetas,
    name = "Estrategia"
  ) +
  scale_x_log10(labels = numero) +
  scale_y_continuous(
    limits = c(0, limite.y),
    breaks = seq(0, limite.y, 10),
    labels = porcentaje
  ) +
  labs(
    title = "Probabilidad de terminar una sesión con ganancia neta positiva",
    subtitle = paste0(
      numero(p$n.personas),
      " personas por estrategia; ",
      numero(p$monto),
      " u. m. por giro"
    ),
    x = "Cantidad de giros por persona (escala logarítmica)",
    y = "Probabilidad de ganancia (%)",
    caption = "La línea vertical indica la cantidad de giros del escenario base."
  ) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position = "bottom",
    panel.grid.minor = element_blank(),
    strip.text = element_text(face = "bold"),
    plot.title = element_text(face = "bold"),
    plot.caption = element_text(hjust = 0)
  )

print(grafico.reporte.08)

ggsave(
  file.path(salida, "probabilidad_reporte.png"),
  plot = grafico.reporte.08,
  width = 10,
  height = 5.8,
  dpi = 300,
  bg = "white"
)

ggsave(
  file.path(salida, "probabilidad_reporte.pdf"),
  plot = grafico.reporte.08,
  width = 10,
  height = 5.8,
  bg = "white"
)





