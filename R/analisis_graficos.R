# Cargar la librería (por si acaso)
library(ggplot2)
library(dplyr)

# Filtrar SOLO la estación NH0437 y graficar
promedios_mensuales %>%
  filter(id == "NH0437") %>%
  ggplot(aes(x = mes, y = temperatura_media)) +
  geom_line(color = "deepskyblue3", linewidth = 1.2) + # Le pongo un color y la hago más gruesa
  labs(title = "Promedio mensual de temperatura (Estación NH0437)",
       x = "Mes del año",
       y = "Temperatura media") +
  scale_x_continuous(breaks = seq(1, 12, by = 1)) + # Eje X de 1 a 12
  theme_minimal()

