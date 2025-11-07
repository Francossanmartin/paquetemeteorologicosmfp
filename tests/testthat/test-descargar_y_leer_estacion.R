# --- Archivo: tests/testthat/test-descargar_y_leer_estacion.R ---

# Usamos context() para agrupar los tests de esta función

test_that("la función descarga, lee y luego lee localmente", {

  # --- PREPARACIÓN ---
  # Saltamos este test si no hay internet o si estamos en CRAN
  skip_on_cran()
  skip_if_offline(host = "raw.githubusercontent.com")

  # Usamos un archivo temporal para no crear basura en el proyecto
  # fileext = .csv es importante para que readr sepa qué es
  ruta_temporal_csv <- tempfile(fileext = ".csv")

  # Nos aseguramos de que el archivo no exista antes de empezar
  if (file.exists(ruta_temporal_csv)) {
    file.remove(ruta_temporal_csv)
  }

  # Usaremos un ID de estación que sabemos que existe
  id_valido <- "NH0046"

  # --- PRUEBA CAMINO 1: Descarga (el archivo NO existe) ---

  # 1.1) Verificamos que imprima el mensaje de descarga
  expect_message(
    datos_descargados <- descargar_y_leer_estacion(
      id_estacion = id_valido,
      ruta_guardado = ruta_temporal_csv
    ),
    "Archivo no encontrado. Descargando desde:"
  )

  # 1.2) Verificamos que el archivo ahora SÍ existe
  expect_true(file.exists(ruta_temporal_csv))

  # 1.3) Verificamos que los datos devueltos son correctos
  expect_s3_class(datos_descargados, "data.frame") # Es un data frame
  expect_gt(nrow(datos_descargados), 0)            # Tiene filas


  # --- PRUEBA CAMINO 2: Lectura Local (el archivo SÍ existe) ---

  # 2.1) Verificamos que imprima el mensaje de lectura local
  expect_message(
    datos_leidos_local <- descargar_y_leer_estacion(
      id_estacion = id_valido,
      ruta_guardado = ruta_temporal_csv
    ),
    "Archivo encontrado localmente:"
  )

  # 2.2) Verificamos que los datos leídos localmente son idénticos
  expect_identical(datos_descargados, datos_leidos_local)


  # --- LIMPIEZA ---
  # Borramos el archivo temporal que creamos
  file.remove(ruta_temporal_csv)
})

test_that("la función falla correctamente con un ID inválido", {

  # --- PREPARACIÓN ---
  skip_on_cran()
  skip_if_offline(host = "raw.githubusercontent.com")

  ruta_temporal_csv <- tempfile(fileext = ".csv")
  id_invalido <- "ESTACION_FALSA_123"

  # --- PRUEBA CAMINO 3: Error ---
  # La función `download.file` fallará (dando un warning)
  # y luego `readr::read_csv` fallará (dando un error)
  # porque el archivo descargado estará vacío o corrupto.

  # Esperamos que la función se detenga con un warning
  expect_error(
    descargar_y_leer_estacion(id = "ESTACION_FALSA_1S3",
                              ruta_guardado = tempfile(fileext = ".csv"))
  )
  # --- LIMPIEZA ---
  if (file.exists(ruta_temporal_csv)) {
    file.remove(ruta_temporal_csv)
  }
})
