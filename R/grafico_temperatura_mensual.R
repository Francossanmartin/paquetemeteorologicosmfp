#' Grafica el promedio mensual de temperatura
#'
#' Genera un grafico de líneas de la temperatura media mensual
#' para una o más estaciones.
#'
#' @param datos Un data frame con datos de estaciones (ej: 'estaciones_unidas').
#'   Debe tener 'fecha', 'id' y 'temperatura_abrigo_150cm'.
#' @param colores Un vector de nombres de colores. Si es NULL (por defecto),
#'   se seleccionarán colores aleatorios.
#' @param titulo El título del gráfico. El valor por defecto es "Temperatura".
#'
#' @return Un objeto ggplot.
#' @export
#'

grafico_temperatura_mensual <- function(datos, colores = NULL, titulo = "Temperatura") {

  # 1. Procesar los datos
  promedios <- datos %>%
    dplyr::mutate(mes = lubridate::month(.data[["fecha"]])) %>%
    dplyr::group_by(.data[["id"]], .data[["mes"]]) %>%
    dplyr::summarise(
      temperatura_media = mean(.data[["temperatura_abrigo_150cm"]], na.rm = TRUE),
      .groups = 'drop'
    )

  # Contar cuantas estaciones (colores) necesitamos
  n_estaciones <- dplyr::n_distinct(promedios$id)

  # 2. Logica de colores (El Bonus)
  if (is.null(colores)) {
    # Si no se dan colores, elegir aleatorios de la lista de R
    colores_a_usar <- sample(grDevices::colors(), n_estaciones)
  } else {
    # Usar los colores dados por el usuario
    colores_a_usar <- colores
  }

  # 3. Crear el grafico
  g <- promedios %>%
    ggplot2::ggplot(ggplot2::aes(x = .data[["mes"]],
                                 y = .data[["temperatura_media"]],
                                 color = .data[["id"]],
                                 group = .data[["id"]])) +
    ggplot2::geom_line(linewidth = 1.2) +
    ggplot2::labs(
      title = titulo,
      x = "Mes del ano",
      y = "Temperatura media"
    ) +
    ggplot2::scale_x_continuous(breaks = seq(1, 12, by = 1)) +
    ggplot2::theme_minimal() +

    # 4. Aplicar los colores Y LA ETIQUETA
    ggplot2::scale_color_manual(
      values = colores_a_usar,
      name = "Estacion",
      guide = "legend"
    )

  return(g)
}
