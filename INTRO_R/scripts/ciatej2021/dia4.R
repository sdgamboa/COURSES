
library(ggplot2)
library(dplyr)
library(tidyr)
library(palmerpenguins)

## Componentes del gráfico en ggplot2:
# mapping
# aesthetics
# geom
iris <- as_tibble(iris)
iris %>% 
    ## Mapping y aesthetics
    ggplot(mapping = aes(x = Petal.Length , y = Petal.Width)) +
    ## Geom
    geom_point(mapping = aes(color = Species))

p <- iris %>% 
    ggplot(aes(Petal.Length, Petal.Width))
p <- p + geom_point(aes(color = Species))
p

ggsave(filename = "plot_iris.pdf", plot = p)


## Forma de salvar gráfico número dos
## Para base R o cualquier otro tipo de gráfico
pdf(file = "plot2.pdf")
p
dev.off()


# Ejemplo 2 todos los componentes de ggplot2 ------------------------------

p <- diamonds %>% 
    ggplot(aes(cut, fill = cut))
p <- p + geom_bar()
p <- p + scale_y_continuous(labels = function(x) format(x, scientific = TRUE))
p <- p + scale_fill_viridis_d(option = "C")
p <- p + guides(fill = guide_legend(override.aes = list(size = 15)))
p <- p + labs(x = "Corte", y = "Cantidad", title = "Tipos de Cortes de Diamantes")
p <- p + coord_flip()
p <- p + facet_wrap(~ clarity, nrow = 2)
p <- p + theme_bw()
p <- p + theme( # despues del tema general
    axis.text.x = element_text(size = 12, angle = 45, hjust = 1)
)

df <- diamonds
df$cut <- as.character(df$cut)
df$cut <- factor(
    x = df$cut, levels = c("Ideal", "Premium", "Good", "Very Good", "Fair")
    )

p <- df %>% 
    ggplot(aes(cut, fill = cut))
p <- p + geom_bar()

# Manipular datos con dplyr -----------------------------------------------

diamonds_counts <- diamonds %>% 
    dplyr::group_by(cut) %>% 
    dplyr::summarise(counts = n()) %>% 
    dplyr::ungroup()

diamonds_counts <- diamonds %>% 
    dplyr::count(cut, name = "counts")
diamonds_counts$cut <- as.character(diamonds_counts$cut)

diamonds_counts %>% 
    ggplot(aes(forcats::fct_reorder(cut, -counts), counts)) +
    labs(x = "Corte", y = "Conteo") +
    geom_col(fill = "firebrick4") +
    theme_bw()


# tidyr -------------------------------------------------------------------

## Cambiar datos a formato tidy
dat <- readxl::read_xlsx("datasets.xlsx", sheet = 1)

dat_long <- dat %>% 
    pivot_longer(cols = `2009`:`2018`, 
        names_to = "Year", 
        values_to = "Yield")

## Revertir
dat_wider <- dat_long %>% 
    pivot_wider(names_from = "Year", values_from = "Yield")


## Separar y unir con separate() y unite()

plants <- readxl::read_xlsx("datasets.xlsx", sheet = 2)

species <- plants %>% 
    separate(col = "species", into = c("genus", "species"))

plants2 <- species %>% 
    unite(col = "Species2", sep = " ", genus, species)

