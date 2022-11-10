## dia 5

library(readxl)
library(dplyr)

# joins -------------------------------------------------------------------

## Importar resultados de BLAST
blast_res <- read_xlsx(path = 'datasets.xlsx', sheet = 'BLAST') %>% 
    rename(sequence = subject) %>% 
    mutate(
        sp = sub('^(....).*$', '\\1', sequence),
        sp = sub('_$', '', sp)
    ) %>% 
    relocate(sp)

## Importar datos de las especies
plant_data <- read_xlsx(path = 'datasets.xlsx', sheet = 'PLANTS2')

## Unir los dos datasets con las claves en la columna 'sp'
data <- left_join(
    x = blast_res, y = plant_data, by = 'sp'
)





