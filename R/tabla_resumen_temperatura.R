#' Crea una tabla resumen de temperatura
#'
#' Calcula la media, desvío estándar, máxima y mínima
#' temperatura_abrigo_150cm para cada estación en un data frame.
#'
#' @param datos Un data frame que contenga 'id' y 'temperatura_abrigo_150cm'.
#'
#' @return Un data frame (tibble) resumido por estación.
#' @export
#'
#' @importFrom magrittr %>%
#'
#' @examples
#' datos_ejemplo <- data.frame(
#'   id = c("A", "A", "B", "B"),
#'   temperatura_abrigo_150cm = c(20, 22, 18, 19)
#' )
#' tabla_resumen_temperatura(datos_ejemplo)

tabla_resumen_temperatura <- function(datos) {

  # Usamos .data[[]] para evitar notas de R CMD check
  resumen <- datos %>%
    dplyr::group_by(.data[["id"]]) %>%
    dplyr::summarise(
      media = mean(.data[["temperatura_abrigo_150cm"]], na.rm = TRUE),
      desvio = stats::sd(.data[["temperatura_abrigo_150cm"]], na.rm = TRUE),
      maxima = max(.data[["temperatura_abrigo_150cm"]], na.rm = TRUE),
      minima = min(.data[["temperatura_abrigo_150cm"]], na.rm = TRUE),
      .groups = 'drop'
    )

  return(resumen)
}
