#' Datos meteorológicos unificados de 5 estaciones.
#'
#' Un data frame (tibble) que contiene los datos combinados de las
#' estaciones NH0046, NH0098, NH0437, NH0472 y NH0910.
#'
#' @format Un tibble con 95,681 filas y 35 variables.
#' @source Script de procesamiento en `data-raw/preparar_datos.R`
"estaciones_unidas"

#' Promedios mensuales de temperatura por estación.
#'
#' Un data frame (tibble) que contiene la temperatura media mensual
#' (`temperatura_media`) para cada estación (`id`).
#'
#' @format Un tibble con 60 filas (12 meses * 5 estaciones) y 3 variables:
#' \describe{
#'   \item{id}{ID de la estación}
#'   \item{mes}{Número del mes (1-12)}
#'   \item{temperatura_media}{Temperatura media de abrigo a 150cm}
#' }
#' @source Script de procesamiento en `data-raw/preparar_datos.R`
"promedios_mensuales"
