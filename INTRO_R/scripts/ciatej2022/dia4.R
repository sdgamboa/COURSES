## dia 4

library(tidyverse)
library(palmerpenguins)

x <- rep(1:3, 100)
x %>%
    head() %>%
    unique() %>%
    as.character()


# pivot_longer ------------------------------------------------------------
## Cambiar datos a formato largo
data <- readxl::read_xlsx('datasets.xlsx', sheet = 1)

data_long <- data %>% 
    pivot_longer(
        cols = starts_with('2'), names_to = 'Year', values_to = 'Yield'
    )
data_long$Year <- factor(data_long$Year)

## Tidydata esta lista para ser graficada con las funciones de ggplot2:
data_long %>% 
    ggplot(aes(Year, Yield)) +
    geom_line(aes(color = Area, group = Area)) + 
    labs(title = "Top 10 Maize Producers") +
    scale_color_discrete(name = "Countries") +
    theme_bw()

# pivot_wider -------------------------------------------------------------
## Convertir datos del formato tidy (version larga) a uno 'untidy'
## Por ejemplo, las matrices
data_wide <- data_long %>% 
    pivot_wider(
        names_from = 'Year', values_from = 'Yield'
    )

row_names <- data_wide$Area[2:nrow(data_wide)]
m <- as.matrix(data_wide[2:nrow(data_wide),2:ncol(data_wide)])
colnames(m) <- col_names
rownames(m) <- row_names

## ?tibble::column_to_rownames
## El codigo es mas limpio y claro utilizando las funciones del tidyverse
## Comparar con las lineas de arriba
m2 <- data_wide %>% 
    tibble::column_to_rownames('Area') %>% 
    as.matrix()

# Separate ----------------------------------------------------------------
## Separar una variable (columna) en dos
plants <- readxl::read_xlsx('datasets.xlsx', sheet = 2)

plants_separated <- plants %>% 
    separate(
        col = 'species', into = c('genus', 'species'), remove = TRUE,
        sep = ' '
    )

# unite -------------------------------------------------------------------
## Unir dos variables (columnas)
plants_united <- plants_separated %>% 
    unite(
        col = 'genus2', sep = ' ', remove = TRUE, genus, species
    )

# dplyr -------------------------------------------------------------------

## filter y select
select_columns <- c("Sample Number", "Species", "Island",
                    "Date Egg", "Culmen Length (mm)",
                    "Culmen Depth (mm)", "Flipper Length (mm)",
                    "Body Mass (g)", "Sex")

## usando base 3
penguins1 <- penguins_raw[!is.na(penguins_raw$Sex),  select_columns]

## usando el tidyverse
penguins2 <- penguins_raw %>% 
    filter(
        !is.na(Sex),
    ) %>% 
    select(all_of(select_columns))


## Renombrar columnas
penguins3 <- penguins2 %>% 
    rename(
        Sample = `Sample Number`, Date = `Date Egg`,
        Culm_len = "Culmen Length (mm)", Culm_dep = "Culmen Depth (mm)",
        Flip_len = "Flipper Length (mm)", Mass = "Body Mass (g)"
)

## colnames(penguins2) <- c('Sample Number', ...)

top_6 <- penguins3 %>% 
    arrange(desc(Sample)) %>%
    head()
## Investigar como resolver los 'ties' cuando las filas son ordenadas

pen <- penguins_raw %>% 
    separate(
        col = 'Species', into = c('Com_name', 'Sci_name'), sep = ' \\('
    ) %>% 
    mutate(
        Sci_name = sub('\\)$', '', Sci_name), # str_remove(rex, var)
        Sci_name = sub(' ', '_', Sci_name),
        Com_name = sub(' .*$', '', Com_name)
    )

## group_by y summarise
penguins_summary <- penguins %>%
    group_by(island, species, sex) %>%
    summarise(
        mean = mean(bill_length_mm, na.rm = TRUE),
        sd = sd(bill_length_mm, na.rm = TRUE),
        n = n() ## equivalente a usar count
    ) %>%
    ungroup()
