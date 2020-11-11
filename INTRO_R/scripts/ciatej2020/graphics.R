
# Sesión 10 de noviembre, 2020

# Cargar paquetes ---------------------------------------------------------

library(tidyverse)
library(palmerpenguins)

# Explorar y modificar datos ----------------------------------------------

# Revisar estructura de datos con str()
# el opreador %>% sirve para pasar el resultado de una función directamente
# como argumento para otra función
penguins %>% 
  str()

# Convertir year de numérico a factor (subassignment)
penguins$year <- factor(penguins$year)

# Obetener resumen de datos
summary(penguins)

# ggplot2 -----------------------------------------------------------------

# Crear gráfico de dispersión con ggplot2

# Si encierras tu código entre paréntesis mientras haces una asignación,
# pasan dos cosas:
# 1. Se realiza la asignación ( ej. p <- <código_para_gráfico>).
# 2. Se imprime en pantalla (ej. un plot).

(
p <- penguins %>%
  drop_na() %>% # Eliminar filas con NAs
  # Llamado de función ggplot:
  # Se indica el mapeo de las variables (ej. x, y, color, size)
  ggplot(mapping = aes(x =  bill_length_mm,
                y = bill_depth_mm,
                color = sex, 
                size = body_mass_g)) +
  # Figura geométrica (geom_*):
  geom_point(alpha = 0.5) + # alpha controla la transparencia
  # Título del plot
  ggtitle("My plot") +
  # Cambiar colores de la variable "sex" manualmente
  scale_color_manual(values = c("red", "blue")) +
  # Dividir el plot en un "grid" de acuerdo a las variables
  # "island" y "species"
  facet_grid(island ~ species) +
  # Tema con fondo blanco predeterminado
  theme_bw()
)

# Después de haber guardado el gŕafico en un objeto (p), podemos
# seguir añadiendo elementos (o modificando) el gráfico:

# Cambiar labels de los ejes x y y
p <- p +
  labs(x = "Length (mm)", y = "Depth (mm)")

# Exportar gráfico --------------------------------------------------------

### 1. Método "convencional" con base R

png(filename = "test_ggplot.png") # paso 1 pdf(), svg()
p                                 # paso 2
dev.off()                         # paso 3

### 2. Método con ggplot
ggsave("test_ggplot.pdf", p, height = 3)

### 3. También se puede exportar la figura desde el panel de plots


# Modificar orden de factors ----------------------------------------------

# Cargar datos
plants <- readxl::read_excel("datasets.xlsx", sheet = "PLANTS")

# Revisar estructura
plants %>% 
  str()

# Utilizar mutate (dplyr) para transformar datos
plants <- plants %>% 
  mutate(
    # Conservar el orden de aparición de los elementos de una variable
    # con la función fct_inorder() del paquete forcats
    species = fct_inorder(species),
    group = fct_inorder(group),
    genome_size = genome_size * 10 # Multiplicar columna por 10
  )

# Obtener los valores únicos de una variable en orden de aparición
# (no se requiere ni se realiza un sort previo)
my_color <- unique(plants$group_color)

# Creación de gráfico con el mismo orden de aparición que en los datos
plants %>% 
  ggplot(aes(species, genome_size)) +
  geom_bar(aes(fill = group), stat = "identity") +
  # el vector my_color fue creado en el código anterior
  scale_fill_manual(values = my_color) +
  theme_bw() +
  theme(# Ajustar la alineación del texto en el eje x:
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

# Creación de gráfico con orden decreciente (eje x)
# Para lograrlo se uiliza la función reorder en el mapeo de aes():
# fct_reorder(species, desc(genome_size))
plants %>% 
  ggplot(aes(fct_reorder(species, desc(genome_size)), genome_size)) +
  geom_bar(aes(fill = group), stat = "identity") +
  scale_fill_manual(values = my_color) +
  theme_bw() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

# tidyr -------------------------------------------------------------------

# Cambiar la forma de nuestros datos a tidydata
maiz <- readxl::read_excel("datasets.xlsx", sheet = 1)

# 1. convertir a formato largo - pivot_longer
maiz_tidy <- maiz %>% 
  gather(key = "Year",
         value = "Production",
        `2009`:`2018`)

# 2. Convertir a formato ancho - pivot_wider
maiz_tidy %>% 
  spread(key = Year,
         value = Production)

# 3. Separar
plant_separated <- plants %>% 
  separate(species, 
           into = c("genera", "sp"),
           remove = FALSE,
           sep = " ")

# 3. Unir
plant_separated %>% 
  unite(new_species, 
        genera, sp,
        sep = " ")

# Los resultados se pueden ver con """ %>% View()"""
