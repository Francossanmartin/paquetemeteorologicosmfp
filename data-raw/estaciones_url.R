# 1. Cargar la librería necesaria
library(readr)

# 2. Definir las URLs de los archivos
urls <- c("https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/metadatos_completos.csv",
          "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0472.csv",
          "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0910.csv",
          "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0046.csv",
          "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0098.csv",
          "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0437.csv")

# 3. Definir dónde guardar los archivos
#    (Usamos "datos/" como pedía tu ejercicio original)
file_names <- c("datos/metadatos_completos.csv",
                "datos/estacion_NH0472.csv",
                "datos/estacion_NH0910.csv",
                "datos/estacion_NH0046.csv",
                "datos/estacion_NH0098.csv",
                "datos/estacion_NH0437.csv")

# 4. Crear la carpeta "datos" (si no existe)
dir.create("datos", showWarnings = FALSE)

# 5. Descargar los archivos (ESTE ERA EL PASO QUE FALTABA)
print("Iniciando descarga de archivos...")
for (i in seq_along(urls)) {
  download.file(urls[i], file_names[i], mode = "wb")
}
# 6. Leer los archivos descargados
#    (Esto ahora SÍ va a funcionar)
print("Cargando archivos en R...")
metadatos <- read_csv("datos/metadatos_completos.csv")
estacion_NH0472 <- read_csv("datos/estacion_NH0472.csv")
estacion_NH0910 <- read_csv("datos/estacion_NH0910.csv")
estacion_NH0046 <- read_csv("datos/estacion_NH0046.csv")
estacion_NH0098 <- read_csv("datos/estacion_NH0098.csv")
estacion_NH0437 <- read_csv("datos/estacion_NH0437.csv")

