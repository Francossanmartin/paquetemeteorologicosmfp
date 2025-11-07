
# paquetemeteorologicosmfp


# paquetemeteorologicosmfp <img src="man/logo/logo.png" align="right" width="150"/>


## Autores

El paquete fue creado por 
[Franco San Martin](https://github.com/Francossanmartin) y
[Gregorio Fernandez](https://github.com/Gregoriofernandezperrier)

## Objetivo

El objetivo del paquete es trabajar con datos meteorologicos, En base a esos datos hacer un analisis y sacar conclusiones.
El paquete es de prueba, no esta pensado para ser utilizado.

## Instalación

Puede instalar la version de paquetemeteorologicosmfp desde
[GitHub](https://github.com/) con:

``` r
# install.packages("pak")
# pak::pak("Francossanmartin/paquetemeteorologicosmfp")
```

## Funciones

1.  **`descargar_y_leer_estaciones()`**:descarga los datos de una estación meteorológica desde un repositorio en línea, los guarda localmente y devuelve un data frame listo para analizar.
  
2.  **`tabla_resumen_temperatura`** : Genera una tabla resumen con la temperatura máxima, mínima y promedio por estación, facilitando la comparación de valores térmicos.
  
3.  **`grafico_temperatura_mensual`**: Crea un gráfico de líneas con la temperatura promedio mensual por estación, con opciones de personalización en título y colores.


### Ejemplos de uso

Así es como debería usarse nuestro paquete:

``` r
library(paquetemeteorologicosmfp)
```

``` r
NH0046 <- descargar_y_leer_estacion("NH0046", "data-raw/NH0046.csv")
```

``` r
tabla_resumen_temperatura(NH0046)
```

``` r
grafico_temperatura_mensual(NH0046, colores = "steelblue", titulo = "Temperatura promedio mensual - NH0046")
```

## Contribuciones

Las contribuciones al paquete son bienvenidas. Si querés sumar mejoras, corregir errores o proponer nuevas funciones, seguí estos pasos:

1.Creá una rama para tu aporte
Antes de realizar cambios, generá una nueva rama para mantener el historial limpio:

 `git checkout -b nombre-de-la-rama`


2.Hacé un fork y cloná el repositorio
Realizá un fork de este repositorio en tu cuenta de GitHub y clonalo en tu entorno local para trabajar en los cambios.

3.Implementá tus cambios y abrí un Pull Request
Una vez que termines tus modificaciones, subilas a tu repositorio y abrí un Pull Request hacia la rama principal del proyecto.
Asegurate de incluir una descripción clara del objetivo del cambio y, si es posible, ejemplos o pruebas que faciliten la revisión.

Agradecemos tu colaboración 
Te recomendamos revisar el Código de Conducta
 antes de contribuir, para mantener un entorno positivo y respetuoso dentro de la comunidad del paquete.

