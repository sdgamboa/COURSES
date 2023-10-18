
library(palmerpenguins)
library(ggplot2)

## Set wd --> Session menu
(x <- c(a = 1, b = 2, c = 3, d = 5, e = 5))

# subsetting vectores atomicos --------------------------------------------
## character
## integer
## double
## logical

## integer
x[length(x)] ## los elmentos comeinzan en el indice 1

## vector logico
x[x >= 3] ## misma longitud
x[x >= 3] <- 0

## Usar un vector con positiones no contiguas
x[c(1, 3)]

## Usando vector de caracter
x['a'] ## preserva nombre
x[['a']] ## quita nombre
x['a'] == x[['a']] 

(m <- matrix(1:12, ncol = 3, byrow = TRUE))
colnames(m) <- paste0('col', 1:3)
rownames(m) <- paste0('row', 1:4)

## row x col
m[1, 3]
m['row3', 'col2']
m[m > 2] <- 0

## usar drop = FALSE para preservar la clase de matrix cuando se seleciona
## una fila o columna
## aplica para los data.frames
class(m[, 'col1']) ## numeric
class(m[, 'col1', drop = FALSE]) ## matrix

l <- list(1:5, letters[1:5], month.abb[1:5])
names(l) <- c('num', 'let', 'mes')

l[1] == 2
l[[1]] == 2

l$mes == l[['mes']]


class(penguins)
typeof(penquins)

df <- as.data.frame(penguins)
class(penguins)
typeof(df)
df[df[['species']] == 'Gentoo', ] |>
    head()  
p <- penguins
p[!is.na(p$bill_length_mm),]

# Plots -------------------------------------------------------------------

dat <- penguins
dplyr::glimpse(dat)
    
## Grafico de dispersion
(
    p <- dat |>   
        ggplot() + 
        geom_point(aes(bill_length_mm, bill_depth_mm))
)
    







