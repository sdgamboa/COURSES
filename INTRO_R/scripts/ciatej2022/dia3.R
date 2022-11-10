## dia 3

library(ggplot2)
library(palmerpenguins)
library(dplyr)

## Comportamientos de la funcion plot en R
data('iris')

plot(x = iris$Sepal.Length, y = iris$Speal.Width)
plot(x = iris$Species, y = iris$Sepal.Length)
plot(iris)

plot(x = iris$Sepal.Length)
hist(x = iris$Sepal.Length)

attach(iris)
png(filename = 'iris.png')
plot(Sepal.Length, Sepal.Width, pch = 3, cex = 2, col = "blue",
     xlab = "Sepal length", ylab = "Sepal width",
     main = "Added linear regression")
abline(lm(Sepal.Width ~ Sepal.Length), col = "red")
dev.off()
detach(iris)

# Graficos con ggplot2 (tidyverse) ----------------------------------------

p <- iris |> 
    ggplot(
        mapping = aes(x = Sepal.Length, y = Sepal.Width)
    ) +
    geom_point(
        mapping = aes(color = Species)
    )

## Uso de los geoms y los stats
data('penguins')
penguins |> 
    ggplot(aes(species)) +
    geom_bar()

pen_counts <- penguins |> 
    count(species) ## dplyr
    
p2 <- pen_counts |> 
    ggplot(aes(x = species, y = n)) +
    geom_col(aes(fill = species), alpha = 0.7) + ## stat = 'identity'
    scale_y_continuous(limits = c(-10, 200, breaks = seq(-10, 200, 20))) +
    facet_wrap(~species, scales = 'free_x') +
    theme_minimal() +
    theme(
        axis.title = element_text(face = 'bold')
    )

ggsave(filename = 'test2.pdf', plot = p2)

# Cambiar orden con factores ----------------------------------------------


penguin_filename <- paste0("https://raw.githubusercontent.com/",
                           "rfordatascience/tidytuesday/master/data/",
                           "2020/2020-07-28/penguins.csv")
penguins <- readr::read_csv(penguin_filename)
ggplot(na.omit(penguins), aes(bill_length_mm, bill_depth_mm)) +
    geom_point(aes(color = sex, size = body_mass_g), alpha = 0.6) +
    facet_grid(species ~ island) +
    theme_bw()

## Usar factores para cambiar el orden de los datos
ordered_species <- c("Gentoo", "Adelie", "Chinstrap")
ordered_islands <- c("Torgersen", "Biscoe", "Dream")
penguins$species <- factor(penguins$species, levels = ordered_species)
penguins$island <- factor(penguins$island, levels = ordered_islands)
penguins



plants <- readxl::read_excel("datasets.xlsx", sheet = 'PLANTS')
ggplot(plants, aes(species, genome_size, fill = group)) +
    geom_col() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))


plants$species <- forcats::fct_inorder(plants$species)
plants$group <- forcats::fct_inorder(plants$group)
group_colors <- unique(plants$group_color)
ggplot(plants, aes(species, genome_size, fill = group)) +
    geom_col() +
    scale_fill_manual(values = group_colors) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))







