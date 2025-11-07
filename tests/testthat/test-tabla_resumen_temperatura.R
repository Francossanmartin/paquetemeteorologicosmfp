# --- Archivo: tests/testthat/test-tabla_resumen_temperatura.R ---

context("Pruebas para tabla_resumen_temperatura")

test_that("calculos y agrupamiento son correctos", {

  # --- 1. PREPARACIÓN ---
  # Creamos datos de prueba con 2 estaciones
  test_data <- data.frame(
    id = c("Estacion_A", "Estacion_A", "Estacion_B", "Estacion_B", "Estacion_B"),
    temperatura_abrigo_150cm = c(10, 20, 100, 110, 120)
  )

  # --- 2. EJECUCIÓN ---
  resumen <- tabla_resumen_temperatura(test_data)

  # --- 3. COMPROBACIÓN ---

  # 3.1) Estructura general
  expect_s3_class(resumen, "data.frame")
  expect_equal(nrow(resumen), 2) # Dos filas, una por estación
  expect_named(resumen, c("id", "media", "desvio", "maxima", "minima"))

  # 3.2) Cálculos Estacion_A
  res_A <- resumen[resumen$id == "Estacion_A", ]
  expect_equal(res_A$media, 15)   # (10+20)/2
  expect_equal(res_A$maxima, 20)
  expect_equal(res_A$minima, 10)
  expect_equal(res_A$desvio, sd(c(10, 20))) # sd de 10 y 20

  # 3.3) Cálculos Estacion_B
  res_B <- resumen[resumen$id == "Estacion_B", ]
  expect_equal(res_B$media, 110) # (100+110+120)/3
  expect_equal(res_B$maxima, 120)
  expect_equal(res_B$minima, 100)
  expect_equal(res_B$desvio, sd(c(100, 110, 120)))
})


test_that("maneja NAs correctamente (prueba de na.rm = TRUE)", {

  # Creamos datos con NA
  test_data_na <- data.frame(
    id = c("Estacion_C", "Estacion_C", "Estacion_C"),
    temperatura_abrigo_150cm = c(10, 20, NA) # <--- NA AQUI
  )

  resumen_na <- tabla_resumen_temperatura(test_data_na)

  # Los cálculos deben ignorar el NA
  expect_equal(nrow(resumen_na), 1)
  expect_equal(resumen_na$media, 15) # Debe ser (10+20)/2, no NA
  expect_equal(resumen_na$maxima, 20)
  expect_equal(resumen_na$minima, 10)
  expect_equal(resumen_na$desvio, sd(c(10, 20)))
})


test_that("maneja casos especiales (ej: sd de un solo valor)", {

  # Datos con una sola observación para una estación
  test_data_solo <- data.frame(
    id = "Estacion_D",
    temperatura_abrigo_150cm = 100
  )

  resumen_solo <- tabla_resumen_temperatura(test_data_solo)

  # sd() de un solo número debe devolver NA
  expect_equal(nrow(resumen_solo), 1)
  expect_equal(resumen_solo$media, 100)
  expect_true(is.na(resumen_solo$desvio)) # <--- Comprobación clave
})


test_that("falla con input incorrecto (columnas faltantes)", {

  # Falla si falta la columna 'temperatura_abrigo_150cm'
  expect_error(
    tabla_resumen_temperatura(data.frame(id = "A"))
  )

  # Falla si falta la columna 'id'
  expect_error(
    tabla_resumen_temperatura(data.frame(temperatura_abrigo_150cm = 10))
  )
})
