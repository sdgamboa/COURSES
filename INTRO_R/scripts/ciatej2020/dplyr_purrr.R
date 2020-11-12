# Sesión 4, 12 de noviembre, 2020

# Ctrl + Shift + F10 = Reiniciar sesión en R
# Ctrl + Shift + M = pipe ( %>% )
# Atl + - = <- 

# Cargar paquetes ---------------------------------------------------------

library(tidyverse)
library(palmerpenguins)

# Revisar datos -----------------------------------------------------------

# Revisar structura con str()
penguins_raw %>% 
  str(vec.len = 1, # mostrar solo el primer valor por vector
      give.attr = FALSE) # no mostrar los atributos

# Un resumen con summary()
summary(penguins_raw)

# Converitr todas las columnas con vectores tipo caracter como factor
# Podemos usar la función map_if del paquete purrr (programacion funcional)

pen_tbl <- map_if(penguins_raw, # Dataset
                  is.character, # Predicado (condición)
                  as.factor # Función (acción a realizar)
                  ) %>% 
  as_tibble() # Convertir a tibble
# Nota: El resultado de map siempre es una lista, por eso hay que convertir de nuevo a tibble.

# Revisar de nuevo con summary() y str()
summary(pen_tbl)
str(pen_tbl, vec.len = 1, give.attr = FALSE)

# Filtrar y seleccionar ---------------------------------------------------

# 1. Filtrar la variable "Clutch Completion"; dejar solo los "Yes."
# 2. Incluir únicamente las variables "especie", "pico_lon_mm", "pico_pro_mm",
#    "aleta_lon_mm", "peso_g", "sexo."
pen_tbl <- pen_tbl %>% 
  filter(`Clutch Completion` == "Yes", # Filtrar observaciones (filas)
         ) %>% 
  select( # Seleccionar variables (columnas)
    especie = Species, isla = Island,
    pico_lon_mm = `Culmen Length (mm)`,
    pico_pro_mm = `Culmen Depth (mm)`,
    aleta_lon_mm = `Flipper Length (mm)`,
    peso_g = `Body Mass (g)`,
    sexo = Sex, fecha = `Date Egg`,
    -Comments # podemos excluir columnas con negativos.
  )

# Tidyselect

# Subsetting

# df[vector (FILTRAR FILAS)  ,  vector (SELECCIONA COLUMNAS)  ]
# subset()

# Revisar de nuevo con summary() y str()
summary(pen_tbl)
str(pen_tbl, vec.len = 1, give.attr = FALSE)

# Modificar con mutate ----------------------------------------------------

pen_tbl <- pen_tbl %>% 
  mutate(
    fecha = factor(format(fecha, format = "%Y")), # Extraer año y convertir a factor
    especie = especie %>% 
      as.character() %>% # Convertir a caracter
      str_remove(" .*$") %>% # Eliminar todo desde el primer espacio (paquete stringr)
      factor(), # convertir nuevamente a factor
    sexo = case_when(sexo == "FEMALE" ~ "Hembra", 
                     sexo == "MALE" ~ "Macho") %>% 
      factor()
    )

# Revisar de nuevo con summary() y str()
summary(pen_tbl)
str(pen_tbl, vec.len = 1, give.attr = FALSE)

# Eliminar NAs con drop_na() -----------------------------------------------

pen_tbl <- drop_na(pen_tbl) # na.omit()

# Resúmenes agrupados con group_by, summarise, count ----------------------

# Conteos agrupados con group_by() %>% summarise() %>% ungroup()
pen_tbl %>% 
  group_by(isla, especie, sexo) %>% # Agrupar
  summarise( # resumir
    conteo = n()
  ) %>% 
  ungroup() # desagrupar

# Más corto (no requiere agrupar/desagrupar):
pen_count <- pen_tbl %>% 
  count(isla, especie, sexo, name = "conteo")

# Un gráfico de los conteos con geom_col
pen_count %>% 
  ggplot(aes(especie, conteo)) +
  geom_col(aes(fill = sexo), position = "dodge") +
  facet_wrap(~ isla)

# fill (barras apiladas, proporción), stack (barras apiladas)


# Algunas medidas de dispersión
pen_summary <- pen_tbl %>% 
  group_by(isla, especie, sexo) %>% # agrupar
  summarise( # resumir
    media = mean(pico_lon_mm, na.rm = TRUE), # estar pendientes de NAs
    mediana = median(pico_lon_mm, na.rm = TRUE),
    desv_std = sd(pico_lon_mm, na.rm = TRUE),
    N = n()
  ) %>% 
  ungroup() # desagrupar

# Un gráfico
pen_summary %>% 
  ggplot(aes(isla, media, fill = sexo)) + # fill debe ser indicado en ggplot()
  geom_col(position = "dodge") + #dodge
  geom_errorbar(aes(ymin = media - desv_std, 
                    ymax = media + desv_std),
                position = position_dodge(0.9), #dodge
                width = 0.2) +
  facet_wrap(~especie)


# Unir datasets con join --------------------------------------------------

# Importar datos
blast <- readxl::read_excel("datasets.xlsx", sheet = "BLAST")
plants <- readxl::read_excel("datasets.xlsx", sheet = "PLANTS2")

# Revisar datos con str()
str(blast, vec.len = 1)
str(plants, vec.len = 1)

# Necesitamos crear índices
blast_indexed <- blast %>% 
  mutate(
    index = str_extract(subject, "^....") %>% # estraer primeros 4 caracteres
      str_remove("_$") # eliminar "_" al final de la línea
  ) %>% 
  select(index, everything()) # everything(), función de tidyselect

blast_indexed

# En el caso de blast, si tiene duplicados mejor quitarlos
blast_indexed %>% 
  count(subject) %>%  # Contar las secuencias subjetc (resultado de blast)
  arrange(desc(n)) # Ordenar de mayor a menor por la columna n

# Remover duplicados con slice_max()
blast_indexed <- blast_indexed %>%
  group_by(subject) %>% # Agrupar por subject
  slice_max(identity) %>%  # Remover duplicados de acuerdo a identity; dejar mayor valor
  ungroup()

# Checamos de nuevo duplicados
blast_indexed %>% 
  count(subject) %>%  # Contar las secuencias subjetc (resultado de blast)
  arrange(desc(n)) # Ordenar de mayor a menor por la columna n

# unir con left_join
blast_plants <- left_join(blast_indexed, plants, by = c("index" = "sp"))

# Crear gráfico
blast_plants %>% 
  count(group, species) %>% 
  ggplot(aes(fct_reorder(group, desc(n)), n)) +
  geom_boxplot() +
  geom_point()


# programación funcional --------------------------------------------------

# Cómo definir una función
my_fun <- function(x, y = 2) {
  z = x * y
  z
}

# if statement
if ( FALSE ) { 
  "It's true."
  } else {
    "It's false"
}

# for loop
for ( i in 1:9) {
  print(i)
}




# Explorar diamonds
str(diamonds, vec.len = 1)


# Obtener varores únicos por cada variable

unique(diamonds) # No funciona como quisiéramos


### Opción 1: Contar valores únicos por cada variable
diamonds$carat %>% unique() %>% length()

### Opción 2: Crear un una función con un for loop

count_uniques <- function(x) {
  # 1. Crear un output vacío
  output <- vector("integer", length(x))
  
  # 2. Iterar con for loop
  for (item in seq_along(x)) {
    output[[item]] <- length(unique(x[[item]]))
    names(output)[[item]] <- names(x)[[item]]
  }
  
  # 3. Imprimir output en pantalla
  output
}

### Opción 3: Usar programación funcional

# sapply de apply
# Acepta funciones
sapply(diamonds, function(x) length(unique(x)))
sapply(diamonds, n_distinct)

# map_int de purrr
# Aceptar funcione en forma de fórmula
map_int(diamonds, ~length(unique(.x)))
map_int(diamonds, n_distinct)



## funciónes en purrr con condición

show_unique_values <- function(data) {
  output <- vector("list", length(data))
  for (i in seq_along(data)) {
    if(is.factor(data[[i]]) | is.character(data[[i]]) ) {
      output[[i]] <- as.character(unique(data[[i]]))
      names(output)[i] <- names(data[i])
    } else {
      output[[i]] <- NULL
    }
  }
  output[!is.na(names(output))]
}

diamonds %>% 
  keep(~is.factor(.x) | is.character(.x)) %>% 
  map(unique)



# tidyeval ----------------------------------------------------------------

# usar funciones de ggplot dentro de funciones personalizadas
plot_histogram <- function(data, x) {
  x_var <- enquo(x) # Encerrar en 'enquo()'
  ggplot(data, aes(!!x_var)) + # utilizar !! antes de usar la variable
    geom_histogram() +
    # labs(y = "Frequency", x = get_label(!!x_var)) +
    theme_classic()
}

p1 <- plot_histogram(penguins, bill_length_mm)
p2 <- plot_histogram(penguins, bill_depth_mm)
p3 <- plot_histogram(penguins, flipper_length_mm)
p4 <- plot_histogram(penguins, body_mass_g)

ggpubr::ggarrange(p1, p2, p3, p4,
                  labels = c("A)", "B)", "C)", "D)"),
                  hjust = 0)
