# --- Cargar las librerías necesarias ---
library(dplyr)
library(lubridate)
library(ggplot2)

# --- PASO 1: Crear 'estaciones_unidas' ---
# (Este es el paso que faltaba asignar)
# Unimos todos los data frames de estaciones en uno solo.
# ¡La clave es la flecha "<-" al principio!
estaciones_unidas <- bind_rows(
  estacion_NH0046,
  estacion_NH0098,
  estacion_NH0437,
  estacion_NH0472,
  estacion_NH0910
)

# --- PASO 2: Crear 'promedios_mensuales' ---
# (Este era el segundo paso faltante)
# Ahora tomamos 'estaciones_unidas' y calculamos los promedios.
# Asumo que tus columnas se llaman 'fecha' y 'temperatura_abrigo_150cm'
promedios_mensuales <- estaciones_unidas %>%

  # Creamos una columna 'mes' extrayendo el mes de la 'fecha'
  mutate(mes = month(fecha)) %>%

  # Agrupamos por estación (id) y mes
  group_by(id, mes) %>%

  # Calculamos la temperatura media
  summarise(
    temperatura_media = mean(temperatura_abrigo_150cm, na.rm = TRUE),
    .groups = 'drop'
  )

# ---- VERIFICACIÓN 2 ----
# (Después de correr este bloque, 'promedios_mensuales'
# DEBE aparecer en tu "Environment".)


# --- PASO 3: Graficar (Tu código original) ---
# Ahora este código SÍ encontrará 'promedios_mensuales'
promedios_mensuales %>%
  filter(id == "NH0437") %>%
  ggplot(aes(x = mes, y = temperatura_media)) +
  geom_line(color = "deepskyblue3", linewidth = 1.2) +
  labs(title = "Promedio mensual de temperatura (Estación NH0437)",
       x = "Mes del año",
       y = "Temperatura media") +
  scale_x_continuous(breaks = seq(1, 12, by = 1)) +
  theme_minimal()
