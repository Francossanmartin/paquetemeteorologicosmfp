# --- Archivo: tests/testthat/test-grafico_temperatura_mensual.R ---

# Necesitamos estas librerías para inspeccionar los gráficos
library(ggplot2)

context("Pruebas para grafico_temperatura_mensual")


# --- 1. PREPARACIÓN DE DATOS DE PRUEBA ---
# Creamos datos simples y predecibles
test_data <- data.frame(
  # Fechas en Enero y Febrero
  fecha = as.Date(c("2025-01-15", "2025-01-20", "2025-02-15", "2025-01-15")),
  id = c("A", "A", "A", "B"),
  temperatura_abrigo_150cm = c(10, 20, 30, 100)
)
# Promedios esperados:
# A, Mes 1 (Ene): mean(10, 20) = 15
# A, Mes 2 (Feb): mean(30) = 30
# B, Mes 1 (Ene): mean(100) = 100


test_that("la estructura del gráfico (clase y etiquetas) es correcta", {

  g <- grafico_temperatura_mensual(test_data)

  # 1.1) Es un objeto ggplot
  expect_s3_class(g, "ggplot")

  # 1.2) El título por defecto es "Temperatura"
  expect_equal(g$labels$title, "Temperatura")

  # 1.3) Las etiquetas (labels) de los ejes son correctas
  expect_equal(g$labels$x, "Mes del año")
  expect_equal(g$labels$y, "Temperatura media")
  expect_equal(g$labels$color, "Estación")
})


test_that("los cálculos internos (promedios) son correctos", {

  g <- grafico_temperatura_mensual(test_data)

  # "Construimos" el gráfico para inspeccionar sus datos internos
  built_g <- ggplot_build(g)
  plot_data <- built_g$data[[1]] # Datos de la capa 1 (geom_line)

  # 2.1) Comprobamos que hay 3 puntos de datos
  expect_equal(nrow(plot_data), 3)

  # 2.2) Comprobamos los valores 'y' (promedios) calculados,
  #      sin importar el grupo, ordenándolos.
  #      Esperamos (15, 30, 100)
  expect_equal(sort(plot_data$y), c(15, 30, 100))
})


test_that("argumentos 'titulo' y 'colores' (Camino 2) funcionan", {

  my_titulo <- "Mi Título de Prueba"
  my_colores <- c("red", "blue") # 2 colores para Estación A y B

  g_custom <- grafico_temperatura_mensual(
    test_data,
    colores = my_colores,
    titulo = my_titulo
  )

  # 3.1) Título personalizado
  expect_equal(g_custom$labels$title, my_titulo)

  # 3.2) Colores personalizados
  built_g_custom <- ggplot_build(g_custom)

  # Comprobamos los colores que se usaron en el gráfico
  expect_true(all(built_g_custom$data[[1]]$colour %in% my_colores))
})


test_that("ignora NAs y falla si faltan columnas", {

  # 4.1) Prueba de NA (na.rm = TRUE)
  test_data_na <- data.frame(
    fecha = as.Date(c("2025-01-15", "2025-01-20")),
    id = "A",
    temperatura_abrigo_150cm = c(10, NA) # <--- NA
  )

  g_na <- grafico_temperatura_mensual(test_data_na)
  built_g_na <- ggplot_build(g_na)

  # El promedio debe ser 10 (ignorando el NA), no NA
  expect_equal(built_g_na$data[[1]]$y, 10)

  # 4.2) Prueba de error (columnas faltantes)
  # Falla si falta 'fecha'
  expect_error(
    grafico_temperatura_mensual(data.frame(id = "A", temperatura_abrigo_150cm = 10))
  )
  # Falla si falta 'temperatura...'
  expect_error(
    grafico_temperatura_mensual(data.frame(fecha = as.Date("2025-01-01"), id = "A"))
  )
})
