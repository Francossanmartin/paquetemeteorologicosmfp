# Cargar librerías necesarias para el test
library(testthat)
library(dplyr)
library(tibble)

# --- YA NO ESTÁ LA DEFINICIÓN DE LA FUNCIÓN ---
# El paquete la cargará automáticamente.


# --- Definición del Test ---

test_that("la función calcula correctamente las estadísticas resumen", {

  # 1. Datos de Prueba
  # Creamos un data.frame con dos estaciones ('A' y 'B')
  # y valores NA para probar el argumento na.rm = TRUE.
  datos_prueba <- data.frame(
    id = c('A', 'A', 'A', 'A', 'B', 'B', 'B'),
    temperatura_abrigo_150cm = c(10, 20, 30, NA, 5, 5, 11)
  )

  # 2. Resultado Esperado
  # Calculamos manualmente los valores que esperamos obtener.
  # Estación 'A': mean(10,20,30)=20, sd(10,20,30)=10, max=30, min=10
  # Estación 'B': mean(5,5,11)=7, sd(5,5,11)=3.464..., max=11, min=5
  resultado_esperado <- tibble::tibble(
    id = c('A', 'B'),
    media = c(20.0, 7.0),
    desvio = c(10.0, stats::sd(c(5, 5, 11))), # Usamos stats::sd() para precisión
    maxima = c(30.0, 11.0),
    minima = c(10.0, 5.0)
  )

  # 3. Ejecutar la Función
  # AHORA SÍ LLAMA A LA FUNCIÓN REAL DEL PAQUETE
  resultado_obtenido <- tabla_resumen_temperatura(datos_prueba)

  # 4. Comprobar (Assert)
  # expect_equal() comprueba que los dos tibbles sean idénticos.
  # Si lo son, el test pasa (0 fails).
  expect_equal(resultado_obtenido, resultado_esperado)

  # Opcional: Probar un caso con NaN o solo NAs
  datos_solo_na <- data.frame(
    id = c('C'),
    temperatura_abrigo_150cm = c(NA_real_)
  )

  resultado_esperado_na <- tibble::tibble(
    id = 'C',
    media = NaN, # mean(NA, na.rm=TRUE) -> NaN
    desvio = NA_real_, # sd(NA, na.rm=TRUE) -> NA
    maxima = -Inf, # max(NA, na.rm=TRUE) -> -Inf (con warning)
    minima = Inf  # min(NA, na.rm=TRUE) -> Inf (con warning)
  )

  # Suprimimos los warnings que genera max(NA, na.rm=TRUE)
  resultado_obtenido_na <- suppressWarnings(tabla_resumen_temperatura(datos_solo_na))

  expect_equal(resultado_obtenido_na, resultado_esperado_na)
})
