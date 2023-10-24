# setwd("~/Projects/COURSES/INTRO_R/scripts/ciatej2023")


library(tidyr)
library(palmerpenguins)
library(readxl)
library(dplyr)
library(ggplot2)

## Cambiar de formato no tidy a tidy
fpath <- c('/home/samuel/Projects/COURSES/INTRO_R/datasets.xlsx')
dat <- read_xlsx(fpath, sheet = 1)
dat_tidy <- tidyr::pivot_longer(
    data = dat, cols = 2:last_col(), names_to = 'Year', values_to = 'Tons'
)
## Cambiar de formato tidy a no tidy
dat_wide <- tidyr::pivot_wider(
    data = dat_tidy, names_from = 'Year', values_from = 'Tons'
)

d1 <- penguins_raw |> 
    ## Separar nombres cientificos del numbre comun
    separate( 
        col = 'Species', into = c('common', 'scientific'), sep = ' \\(',
        remove = TRUE
    ) 
    
## unite
# d1 |>
#     unite(col = 'newcol', sep = '---', common, scientific)

## Manipulacion de los datos con dplyr
d2 <- d1 |> 
    ## modificar o crear columnas
    dplyr::mutate(
        common = sub(' [P|p]enguin$', '', common),
        scientific = sub('\\)$', "", scientific),
        `Date Egg` = sub('-.*$', '', `Date Egg`)
    ) 

## filtrar filas
d3 <- d2 |> 
    dplyr::filter(`Clutch Completion` == 'Yes')

## Seleccionar columnas
var1 <- c(
    'studyName', 'Sample Number', 'Region', 'Island', 'Stage', 'Individual ID',
    'Clutch Completion', 'Delta 15 N (o/oo)', 'Delta 13 C (o/oo)', 'Comments'
)

d4 <- d3 |> 
    dplyr::select(-all_of(var1))

## cambinar nombres
d5 <- d4 |> 
    rename(
        bill_length_mm = `Culmen Length (mm)`
    )

## count
penguins |> 
    dplyr::count(species, sex)

## summarise
df <- penguins |> 
    group_by(species, sex) |> 
    summarise(
        n = dplyr::n(),
        bill_length_mean = mean(bill_length_mm)
    ) |> 
    ungroup() |> 
    filter(!is.na(sex))


## factores para ordenar nuestros datos



df |> 
    ggplot() +
    geom_col(
        aes(species, n, fill = sex)
    )


df |> 
    ggplot() +
    geom_col(
        aes(reorder(species, -n), n, fill = sex)
    )

## forcats
df |> 
    mutate(
        species = factor(species, levels = c('Chinstrap', 'Adelie', 'Gentoo'))
    ) |> 
    ggplot() +
    geom_col(
        aes(species, n, fill = sex)
    )

