library(dplyr)
library(tidyr)
library(readr)

# calculo metricas solicitadas
resumen_estaciones <- estaciones_unidas %>%
  group_by(id) %>%
  summarise(
    media = mean(temperatura_abrigo_150cm, na.rm = TRUE),
    desvio = sd(temperatura_abrigo_150cm, na.rm = TRUE),
    maxima = max(temperatura_abrigo_150cm, na.rm = TRUE),
    minima = min(temperatura_abrigo_150cm, na.rm = TRUE),
    .groups = 'drop' # Buena práctica
  )

print(resumen_estaciones)

# alagamos la tabla

resumen_largo <- resumen_estaciones %>%
  pivot_longer(
    cols = c(maxima, minima),       # Las columnas que queremos apilar
    names_to = "metrica_extrema",   # Nueva columna para los nombres
    values_to = "valor_extremo"     # Nueva columna para los valores
  )

print(resumen_largo)

# Ensanchamos usando el 'resumen_largo'
resumen_ancho <- resumen_largo %>%

  select(id, media, desvio) %>%
  distinct() %>%

  pivot_longer(
    cols = c(media, desvio),
    names_to = "metrica",
    values_to = "valor"
  ) %>%

  pivot_wider(
    names_from = id,
    values_from = valor
  )

print(resumen_ancho)

# Leemos los datos
url_metadatos <- "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/metadatos_completos.csv"
metadatos <- read_csv(url_metadatos)

glimpse(metadatos)

# Unimos 'metadatos' A 'estaciones_unidas'
datos_completos <- left_join(estaciones_unidas, metadatos, by = "id")

glimpse(datos_completos)
