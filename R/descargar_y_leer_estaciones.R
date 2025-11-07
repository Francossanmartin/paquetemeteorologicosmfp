#' Descargar y leer datos de una estación
#'
#' @description
#' Descarga un archivo CSV de una estación específica desde un repositorio
#' de GitHub y lo lee en un data frame (tibble).
#'
#' Si el archivo ya existe en la 'ruta_guardado', lo lee directamente.
#'
#' @param id_estacion El ID de la estación (ej: "NH0046").
#' @param ruta_guardado La ruta local completa donde guardar/leer el archivo
#'   (ej: "data-raw/NH0046.csv").
#'
#' @return Un data frame (tibble) con los datos de la estación.
#' @export
#'
#' @importFrom utils download.file
#' @importFrom readr read_csv cols
#'
#' @examples
#' # Este ejemplo usa un archivo temporal para no guardar nada permanentemente
#' # \donttest{
#' #   temp_file <- tempfile(fileext = ".csv")
#' #   datos_ejemplo <- descargar_y_leer_estacion("NH0046", temp_file)
#' #   print(datos_ejemplo)
#' # }
descargar_y_leer_estacion <- function(id_estacion, ruta_guardado) {

  # 1. Construir la URL de descarga
  base_url <- "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/"
  nombre_archivo <- paste0(id_estacion, ".csv")
  url_completa <- paste0(base_url, nombre_archivo)

  # 2. Verificar si el archivo ya existe
  if (!file.exists(ruta_guardado)) {
    message("Archivo no encontrado. Descargando desde: ", url_completa)

    # Asegurarse de que el directorio (ej: "data-raw/") exista
    dir.create(dirname(ruta_guardado), showWarnings = FALSE, recursive = TRUE)

    # Descargar el archivo
    utils::download.file(url_completa, destfile = ruta_guardado)

  } else {
    message("Archivo encontrado localmente: ", ruta_guardado)
  }

  # 3. Leer y devolver el archivo
  datos <- readr::read_csv(ruta_guardado, col_types = readr::cols())
  return(datos)
}
