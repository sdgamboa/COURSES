## dia2.R
library(tibble)

# data frame --------------------------------------------------------------
x <- c(1, 2, 3, 4, 5, 6)
fct_vct <- factor(x)

int_vector <- c(1L, 2L, NA, 600L, -5L, 1e6L) ## integer
dbl_vector <- c(1, 2, NA, 600, -5, 1e6) ## double
chr_vector <- c(' ', 'palabra', 'una frase', NA, '200', 2.5) ## character
lgl_vector <- c(FALSE, TRUE, FALSE, TRUE, NA, FALSE) ## logical

list_vector <- list(
    int_vector, dbl_vector, chr_vector, lgl_vector
)

df <- data.frame(
    int_vector, dbl_vector, chr_vector, lgl_vector, fct_vct
)

rownames(df) <- paste0('row', 1:nrow(df))
rownames(df) <- NULL

# tibble ------------------------------------------------------------------

tbl <- tibble(int_vector, dbl_vector, chr_vector, lgl_vector, fct_vct)

# importar datos en forma de tabla ----------------------------------------
url <- 'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-07-28/penguins.csv'
penguins1 <- read.table(file = url, header = TRUE, sep = ',')
penguins2 <- read.csv(url)
mat_ <- as.matrix(penguins1)
# readr::read_tsv() # Version del tidtyverse

write.table(
    x = penguins1, file = 'data/penguins.tsv', sep = '\t', quote = FALSE
)
# readr::write_tsv(1) # version del tidyverse


# subsetting --------------------------------------------------------------

## indices
## numericos posicion
## nombres
## vectores logicos - longitud debe ser la misma 

## Vectores atomicos
int_vector[1]
names(int_vector) <- paste0('pos', 1:length(int_vector))
int_vector[c('pos4', 'pos1')]
int_vector[-1]

class(int_vector['pos1'])
class(int_vector[['pos1']])
# int_vector$pos1 ## marca error

lgl_vector_2 <- !is.na(int_vector) & int_vector == 600 ## deal with NAs
int_vector[lgl_vector_2]

## listas
names(list_vector) <- paste0('list', 1:length(list_vector))

## indices con un vector atomico
## nombres
## vectores logicos

class(list_vector['list1']) ## Trabajar uno de los elemetnos de la lista. No los valores.
class(list_vector[['list1']]) ## trabajar directo con los datos
list_vector$list ## Esto no marcar error, pero nos da un resultado que no queremos

list_vector[['list1']][1]

mat <- matrix(as.integer(fct_vct), nrow = 2)
rownames(mat) <- paste0('row', 1:nrow(mat))
colnames(mat) <- paste0('col', 1:ncol(mat))

mat[1:2, c(1,3)]

mat[c('row1', 'row2'), ]
mat[rowSums(mat) > 9, ]
mat[,]

a <- which(!is.na(df$chr_vector))
df[a,]

b <- which(vapply(df, is.character, logical(1)))
df[,b, drop = FALSE]
