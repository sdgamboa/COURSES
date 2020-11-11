


library(tidyverse)
library(palmerpenguins)


penguins_raw %>% 

summary(penguins_raw)

                  ) %>% 

summary(pen_tbl)
str(pen_tbl, vec.len = 1, give.attr = FALSE)


pen_tbl <- pen_tbl %>% 
         ) %>% 
    especie = Species, isla = Island,
    pico_lon_mm = `Culmen Length (mm)`,
    pico_pro_mm = `Culmen Depth (mm)`,
    aleta_lon_mm = `Flipper Length (mm)`,
    peso_g = `Body Mass (g)`,
    sexo = Sex, fecha = `Date Egg`
  )

summary(pen_tbl)
str(pen_tbl, vec.len = 1, give.attr = FALSE)


pen_tbl <- pen_tbl %>% 
  mutate(
    especie = especie %>% 
    sexo = case_when(sexo == "FEMALE" ~ "Hembra", 
                     sexo == "MALE" ~ "Macho") %>% 
      factor()
    )

summary(pen_tbl)
str(pen_tbl, vec.len = 1, give.attr = FALSE)


pen_tbl <- drop_na(pen_tbl)


pen_tbl %>% 
    conteo = n()
  ) %>% 

pen_count <- pen_tbl %>% 
  count(isla, especie, sexo, name = "conteo")

pen_count %>% 
  ggplot(aes(especie, conteo)) +
  geom_col(aes(fill = sexo), position = "dodge") +
  facet_wrap(~ isla)


pen_summary <- pen_tbl %>% 
    mediana = median (pico_lon_mm, na.rm = TRUE),
    desv_std = sd(pico_lon_mm, na.rm = TRUE),
    N = n()
  ) %>% 

pen_summary %>% 
  geom_errorbar(aes(ymin = media - desv_std, ymax = media + desv_std),
                width = 0.2) +
  facet_wrap(~especie)



blast <- readxl::read_excel("datasets.xlsx", sheet = "BLAST")
plants <- readxl::read_excel("datasets.xlsx", sheet = "PLANTS2")

str(blast, vec.len = 1)
str(plants, vec.len = 1)

blast_indexed <- blast %>% 
  mutate(
  ) %>% 

blast_indexed

blast_plants %>% 

blast_plants <- blast_plants %>%
  ungroup()

blast_plants %>% 

blast_plants <- left_join(blast_indexed, plants, by = c("index" = "sp"))

blast_plants %>% 
  count(group, species) %>% 
  ggplot(aes(fct_reorder(group, desc(n)), n)) +
  geom_boxplot() +
  geom_point()




str(diamonds, vec.len = 1)





diamonds$carat


count_uniques <- function(x) {
  output <- vector("integer", length(x))
  
  for (item in seq_along(x)) {
    output[[item]] <- length(unique(x[[item]]))
    names(output)[[item]] <- names(x)[[item]]
  }
  
  output
}


sapply(diamonds, function(x) length(unique(x))) 

map_int(diamonds, n_distinct)




plot_histogram <- function(data, x) {
    geom_histogram() +
    theme_classic()
}