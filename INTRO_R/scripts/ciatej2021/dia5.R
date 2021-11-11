


# For loops ---------------------------------------------------------------

library(tidyverse)
library(palmerpenguins)
data(diamonds)

## Contar los valores únicos por columna

## con todo lo demás
## Alocar el espacio para el resultado
output <- vector(mode = "integer", length = length(diamonds))

## Contar los valores únicos por columna
for (col in seq_along(output)) {
    output[[col]] <- length(unique(diamonds[[col]]))
    names(output)[col] <- colnames(diamonds)[col]
}

## purrr
map_dbl(diamonds, n_distinct) # data frames y con listas

## lapply o vapply
vapply(diamonds, n_distinct, integer(1))


# Filter and select ------------------------------------------------------

penguins_raw

penguins2 <- penguins_raw %>%
    filter(!is.na(Sex)) %>%
    select("Sample Number", "Species", "Island", "Date Egg",
        matches("(\\(mm\\))|\\(g\\)"), "Sex") #tidyselect
penguins2 %>% head(3)


penguins2 <- penguins2 %>% rename(
    Sample = "Sample Number", Date = "Date Egg",
    Culm_len = "Culmen Length (mm)", Culm_dep = "Culmen Depth (mm)",
    Flip_len = "Flipper Length (mm)", Mass = "Body Mass (g)")
names(penguins2)

penguins2 %>% arrange(des(Sample)) %>% head(3)

penguins3 <- penguins2 %>%
    separate(Species, c("Common_name", "Species"),
        sep = " \\(", remove = TRUE) %>%
    mutate(
        Common_name = str_remove(Common_name, "(P|p)enguin"),
        Species = str_remove(Species, "\\)$"),
        Sex = ifelse(Sex == "FEMALE", "F", "M"),
        Year = as.numeric(format(Date,'%Y'))
    ) %>%
    select("Sample", "Common_name", "Species", "Island", "Year",
        everything(), -Date)
penguins3 %>% head(5)


penguins_summary <- penguins3 %>%
    group_by(Island, Common_name, Sex) %>%
    summarise(
        mean = mean(Culm_len, na.rm = TRUE),
        sd = sd(Culm_len, na.rm = TRUE),
        n = n()
    ) %>%
    ungroup() # No olvidar ungroup()
penguins_summary %>% head(5)


penguins_summary %>%
    ggplot(aes(Common_name, mean, fill = Sex)) +
    geom_col(position = "dodge") +
    geom_errorbar(aes(ymin = mean - sd, ymax = mean + sd),
        width = 0.2, position = position_dodge(0.9)) +
    facet_wrap(~Island) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 14),
        axis.title = element_text(size = 18),
        strip.text = element_text(size = 14))

blast_output <- readxl::read_excel("datasets/datasets.xlsx", sheet = "BLAST")
species_data <- readxl::read_excel("datasets/datasets.xlsx", sheet = "PLANTS2")


blast_output <- blast_output %>%
    group_by(subject) %>%
    slice_max(identity) %>%
    ungroup()
head(blast_output, 3)

blast_output <- blast_output %>%
    mutate(id = str_extract(subject, "^....") %>% str_remove("_$")) %>%
    select(id, everything())

joined_data <- left_join(blast_output, species_data,
    by = c("id" = "sp"))
joined_data

