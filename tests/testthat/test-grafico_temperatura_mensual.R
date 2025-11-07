library(testthat)
library(ggplot2)
library(tibble) # O data.frame

# Pega tu funcion aqui si no la estás cargando desde el paquete
# grafico_temperatura_mensual <- ... (tu funcion)


test_that("la estructura del grafico (clase y etiquetas) es correcta", {

  # 1. Datos de prueba (incluso con una sola estacion)
  datos_prueba_grafico <- data.frame(
    id = 'A',
    fecha = as.Date(c("2024-01-15", "2024-02-15")),
    temperatura_abrigo_150cm = c(10, 20)
  )

  # 2. Ejecutar la funcion
  # Usamos suppressWarnings() para ignorar avisos de colores, etc.
  g <- suppressWarnings(grafico_temperatura_mensual(datos_prueba_grafico))

  # 3. Expectativas Robustas (REEMPLAZA LAS ANTERIORES)

  # Expectativa 1: ¿La funcion devolvio un objeto "ggplot"?
  # Esta es la expectativa mas importante y te da la cobertura.
  expect_s3_class(g, "ggplot")

  # Expectativa 2: ¿Estan bien las etiquetas X e Y que SI controlamos?
  expect_equal(g$labels$x, "Mes del ano")
  expect_equal(g$labels$y, "Temperatura media")

  # Expectativa 3 (Opcional pero buena): ¿Puso bien el título por defecto?
  expect_equal(g$labels$title, "Temperatura")
})

test_that("la funcion usa el titulo y colores personalizados", {

  # Datos de prueba
  datos_prueba_grafico <- data.frame(
    id = c('A', 'B'),
    fecha = as.Date(c("2024-01-15", "2024-01-15")),
    temperatura_abrigo_150cm = c(10, 20)
  )

  # 1. Probar con titulo personalizado
  titulo_custom <- "Mi Titulo Especial"
  g_custom <- suppressWarnings(
    grafico_temperatura_mensual(datos_prueba_grafico, titulo = titulo_custom)
  )

  expect_s3_class(g_custom, "ggplot")
  expect_equal(g_custom$labels$title, titulo_custom)

  # 2. Probar con colores (solo que no tire error)
  # No testeamos el color final, solo que la funcion acepte el argumento.
  expect_no_error(
    suppressWarnings(
      grafico_temperatura_mensual(datos_prueba_grafico, colores = c("red", "blue"))
    )
  )
})
