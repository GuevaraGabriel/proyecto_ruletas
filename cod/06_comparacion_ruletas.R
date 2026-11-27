# 06. Comparacion de las cuatro estrategias en ambas ruletas.
# Requiere los CSV creados por 01_crear_datos_ruletas.R.

library(dplyr)
library(tidyr)
library(ggplot2)
library(gridExtra)

source("cod/00_configuracion.R")
source("cod/02_reglas_apuestas.R")

# Verificar los parametros
stopifnot(
  n.personas >= 2,
  n.giros >= 1,
  is.finite(monto),
  monto > 0,
  max.personas >= n.personas,
  all(cantidades.giros >= 1)
)

# Carpeta de resultados
salida <- "res/06_comparacion_ruletas"
dir.create(salida, recursive = TRUE, showWarnings = FALSE)

# Cargar los datos de ambas ruletas
ruletas <- list(
  Americana = read.csv("data/ruleta_americana.csv"),
  Europea = read.csv("data/ruleta_europea.csv")
)

# Formato numerico para las tablas
formato <- function(x, digitos = 2) {
  formatC(
    x,
    format = "f",
    digits = digitos,
    big.mark = ".",
    decimal.mark = ","
  )
}

# Guardar los resultados de ambas ruletas
base <- list()

for (i in seq_along(ruletas)) {
  tipo <- names(ruletas)[i]
  numeros <- ruletas[[i]]$numero
  
  set.seed(semilla + i)
  
  # Calcular los pagos posibles por unidad apostada
  pagos <- cbind(
    Numero = apostar.numero(numeros, 1, 17),
    Docena = apostar.docena(numeros, 1, 1),
    Color = apostar.color(numeros, 1, "Negro"),
    Combinada = apostar.combinada(numeros, 1, "Negro")
  )
  
  # Convertir pagos a enteros para evitar errores decimales
  pagos.enteros <- round(pagos * escala)
  
  stopifnot(max(abs(pagos * escala - pagos.enteros)) < 1e-8)
  
  # Simular los giros de todas las personas
  indices <- matrix(sample.int(length(numeros), n.personas * n.giros, replace = TRUE),
                    nrow = n.personas)
  
  # Preparar las matrices de resultados
  ganancias.unidad <- matrix(
    0,
    nrow = n.personas,
    ncol = length(estrategias),
    dimnames = list(NULL, estrategias)
  )
  
  probabilidad.giro <- numeric(length(estrategias))
  
  # Calcular las ganancias de cada estrategia
  for (j in seq_along(estrategias)) {
    pagos.giros <- matrix(pagos.enteros[as.vector(indices), j], nrow = n.personas)
    
    ganancias.unidad[, j] <- rowSums(pagos.giros)
    
    probabilidad.giro[j] <- mean(pagos.giros > 0) * 100
  }
  
  # Convertir ganancias al monto real apostado
  ganancias.netas <- ganancias.unidad * monto / escala
  
  # Rendimiento teorico de cada estrategia
  teorico <- colMeans(pagos.enteros) / escala * 100
  
  # Resumen de resultados
  resumen <- tibble(
    ruleta = tipo,
    estrategia = estrategias,
    personas = n.personas,
    giros = n.giros,
    monto = monto,
    
    varianza.sesion = apply(ganancias.netas, 2, var),
    
    perdida.media.sesion = -colMeans(ganancias.netas),
    
    rendimiento = colMeans(ganancias.netas) /
      (n.giros * monto) * 100,
    
    probabilidad.giro.estimada = probabilidad.giro,
    
    probabilidad.giro.teorica = colMeans(pagos > 0) * 100,
    
    casos.favorables = colSums(pagos > 0),
    casillas = length(numeros),
    
    ganadores.sesion = colSums(ganancias.unidad > 0),
    
    probabilidad.ganancia.sesion =
      colMeans(ganancias.unidad > 0) * 100,
    
    rendimiento.teorico = unname(teorico)
  )
  
  # Guardar los datos necesarios para los scripts 07 y 08
  base[[tipo]] <- list(
    indices = indices,
    pagos.enteros = pagos.enteros,
    ganancias.unidad = ganancias.unidad,
    ganancias.netas = ganancias.netas,
    teorico = teorico
  )
  
  # Exportar la tabla de resultados a CSV
  write.csv(resumen, file.path(salida, paste0("tabla_", tolower(tipo), ".csv")), row.names = FALSE)
  
  # Preparar la tabla visual
  mostrar <- data.frame(
    etiquetas,
    formato(resumen$varianza.sesion, 0),
    formato(resumen$perdida.media.sesion),
    paste0(formato(resumen$probabilidad.giro.estimada), " %"),
    paste0(
      resumen$casos.favorables,
      "/",
      resumen$casillas,
      " = ",
      formato(resumen$probabilidad.giro.teorica),
      " %"
    )
  )
  
  names(mostrar) <- c(
    "Estrategia",
    "Varianza de la\nsesión (u. m.²)",
    "Pérdida media de\nla sesión (u. m.)",
    "P(ganar giro)\nestimada",
    "P(ganar giro)\nteórica"
  )
  
  tabla <- tableGrob(
    mostrar,
    rows = NULL,
    theme = ttheme_minimal(
      base_size = 11,
      core = list(bg_params = list(
        fill = c("#F3F6FA", "white"), col = NA
      )),
      colhead = list(fg_params = list(
        col = "#20344A", fontface = "bold"
      ))
    )
  )
  
  # Titulo
  titulo <- grid::textGrob(
    paste("Ruleta", tolower(tipo)),
    x = 0,
    hjust = 0,
    gp = grid::gpar(fontsize = 18, fontface = "bold")
  )
  
  # Nota explicativa
  nota <- grid::textGrob(
    paste0(
      formato(n.personas, 0),
      " personas; ",
      n.giros,
      " giros; ",
      formato(monto),
      " u. m. por giro.\n",
      "Pérdida negativa = ganancia media. ",
      "Ganar un giro exige un pago neto positivo.\n",
      "Fuente: elaboración propia mediante simulación."
    ),
    x = 0,
    hjust = 0,
    gp = grid::gpar(fontsize = 9, col = "#5D6B7A")
  )
  
  # Unir titulo, tabla y nota
  figura <- arrangeGrob(titulo,
                        tabla,
                        nota,
                        ncol = 1,
                        heights = c(0.5, 2, 0.8))
  
  grid::grid.newpage()
  grid::grid.draw(figura)
  
  # Guardar tabla como PNG y PDF
  for (extension in c("png", "pdf")) {
    ggsave(
      file.path(salida, paste0(
        "tabla_", tolower(tipo), ".", extension
      )),
      plot = figura,
      width = 11,
      height = 3.7,
      dpi = 300,
      bg = "white"
    )
  }
  
  print(resumen)
}

# Resultados individuales del escenario base
sesiones <- bind_rows(lapply(names(base), function(tipo) {
  as_tibble(base[[tipo]]$ganancias.netas) |>
    mutate(persona = row_number(), ruleta = tipo) |>
    pivot_longer(all_of(estrategias),
                 names_to = "estrategia",
                 values_to = "ganancia.neta")
}))

write.csv(sesiones, file.path(salida, "sesiones_base.csv"), row.names = FALSE)

# Guardar los datos compartidos con los scripts 07 y 08
saveRDS(
  list(
    parametros = list(
      n.personas = n.personas,
      n.giros = n.giros,
      monto = monto,
      semilla = semilla,
      escala = escala,
      max.personas = max.personas,
      cantidades.giros = cantidades.giros
    ),
    estrategias = estrategias,
    etiquetas = etiquetas,
    colores = colores,
    base = base
  ),
  file.path(salida, "base_ruletas.rds")
)






