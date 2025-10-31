#' Descarga y lee los datos de una estación meteorológica
#'
#' Verifica si un archivo de estación existe localmente. Si no,
#' lo descarga desde el repositorio de GitHub. Finalmente,
#' lee y devuelve los datos.
#'
#' @param id_estacion El ID de la estación (ej: "NH0437").
#' @param ruta_guardado La ruta completa donde guardar el .csv (ej: "data-raw/NH0437.csv").
#'        (Nota: la función creará el directorio si no existe).
#'
#' @return Un data frame (tibble) con los datos de la estación.
#' @export
#'
#' @importFrom readr read_csv
#' @importFrom utils download.file
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
