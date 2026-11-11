# 07. Convergencia del rendimiento al aumentar las personas.
# Ejecutar despues de 06_comparacion_ruletas.R.

library(dplyr)
library(tidyr)
library(ggplot2)

# Cargar los resultados del script 06
archivo <- "res/06_comparacion_ruletas/base_ruletas.rds"

if (!file.exists(archivo)) {
  stop("Primero ejecuta cod/06_comparacion_ruletas.R")
}

proyecto <- readRDS(archivo)

p <- proyecto$parametros
estrategias <- proyecto$estrategias

# Crear la carpeta de resultados
salida <- "res/07_rendimiento_teorico"
dir.create(salida, recursive = TRUE, showWarnings = FALSE)

# Cantidades de personas que vamos a comparar
min_personas <- min(100, p$n_personas)

puntos <- sort(unique(c(
  round(10^seq(
    log10(min_personas), log10(p$max_personas), length.out = 120
  )), p$n_personas, p$max_personas
)))

resultados <- list()

# Analizar cada ruleta
for (i in seq_along(proyecto$base)) {
  tipo <- names(proyecto$base)[i]
  modelo <- proyecto$base[[i]]
  
  set.seed(p$semilla + 10000 + i)
  
  # Reutilizar las personas del escenario base
  ganancias <- modelo$ganancias_netas
  
  # Cantidad de personas adicionales
  extra <- p$max_personas - p$n_personas
  
  if (extra > 0) {
    # Simular los resultados de las personas adicionales
    conteos <- t(rmultinom(extra, size = p$n_giros, prob = rep(1, nrow(
      modelo$pagos_enteros
    ))))
    
    # Calcular las ganancias de las nuevas personas
    nuevas <- (conteos %*% modelo$pagos_enteros) *
      p$monto / p$escala
    
    ganancias <- rbind(ganancias, nuevas)
  }
  
  # Sumar las ganancias de forma acumulada
  acumuladas <- apply(ganancias, 2, cumsum)
  
  # Calcular el rendimiento acumulado
  rendimiento <- sweep(acumuladas[puntos, , drop = FALSE], 1, puntos * p$n_giros * p$monto, "/") * 100
  
  # Organizar los resultados
  resultados[[tipo]] <- as_tibble(rendimiento) |>
    mutate(personas = puntos) |>
    pivot_longer(all_of(estrategias),
                 names_to = "estrategia",
                 values_to = "rendimiento") |>
    mutate(
      ruleta = tipo,
      giros = p$n_giros,
      monto = p$monto,
      teorico = unname(modelo$teorico[estrategia]),
      error_puntos_porcentuales = rendimiento - teorico
    )
}

# Unir los resultados de ambas ruletas
datos <- bind_rows(resultados)

# Guardar los datos en CSV
write.csv(datos,
          file.path(salida, "convergencia_rendimiento.csv"),
          row.names = FALSE)

# Formato de los numeros y porcentajes
numero <- scales::label_number(big.mark = ".", decimal.mark = ",")

porcentaje <- scales::label_number(accuracy = 0.01,
                                   suffix = " %",
                                   decimal.mark = ",")

# Utilizar la misma escala vertical para ambas ruletas
limites <- range(c(datos$rendimiento, datos$teorico, 0))
margen <- max(diff(limites) * 0.05, 0.1)

# Crear un grafico para cada ruleta
for (tipo in names(proyecto$base)) {
  d <- filter(datos, ruleta == tipo)
  referencia <- distinct(d, teorico)
  
  grafico <- ggplot(d, aes(x = personas, y = rendimiento, color = estrategia)) +
    geom_vline(
      xintercept = p$n_personas,
      color = "#ADB6C2",
      linetype = "dotted"
    ) +
    geom_line(linewidth = 0.8) +
    geom_hline(
      data = referencia,
      aes(yintercept = teorico, linetype = "Rendimiento teórico"),
      color = "#263447",
      linewidth = 0.7
    ) +
    scale_color_manual(
      values = proyecto$colores,
      breaks = estrategias,
      labels = proyecto$etiquetas,
      name = NULL
    ) +
    scale_linetype_manual(values = c("Rendimiento teórico" = "dashed"),
                          name = NULL) +
    scale_x_log10(breaks = sort(unique(
      c(min_personas, 1000, 10000, p$max_personas)
    )), labels = numero) +
    scale_y_continuous(labels = porcentaje, limits = limites + c(-margen, margen)) +
    labs(
      title = paste0("Ruleta ", tolower(tipo), ": convergencia del rendimiento"),
      subtitle = paste0(
        p$n_giros,
        " giros por persona; ",
        numero(p$monto),
        " u. m. por giro. Teórico: ",
        porcentaje(referencia$teorico)
      ),
      x = "Cantidad de personas simuladas (escala logarítmica)",
      y = "Ganancia neta / total apostado (%)",
      caption = paste0(
        "Promedio acumulado. Línea vertical: escenario base de ",
        numero(p$n_personas),
        " personas.\n",
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
  
  # Guardar cada grafico en PNG y PDF
  for (extension in c("png", "pdf")) {
    ggsave(
      file.path(salida, paste0(
        "convergencia_", tolower(tipo), ".", extension
      )),
      plot = grafico,
      width = 11,
      height = 6.5,
      dpi = 300,
      bg = "white"
    )
  }
}
