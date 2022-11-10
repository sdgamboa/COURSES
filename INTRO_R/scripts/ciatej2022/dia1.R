
## Expresion a ser evaluada
10 * 2
print("a")

## Asignacion
x <- 10 * 2 # Alt + -

## Funcion sin args
ls()

## Funcion con args
rm(x) ## variable
print(10 * 2)  ## Expresion
print('s') ## vector


## Argumentos por posicion
seq(1, 10, 2)

## Argumentos por nombre
seq(to = 10, by = 2, from = 1)


## Conectar outputs
head(seq(1,20))

output_1 <- seq(1, 20) |> ## Ctrl + Shift + M
    head()

## Cargar paquetes
library(MASS)
detach('package:MASS')


# Vectores atomicos -------------------------------------------------------
int_vector <- c(1L, 2L, NA, 600L, -5L, 1e6L) ## integer
dbl_vector <- c(1, 2, NA, 600, -5, 1e6) ## double
chr_vector <- c(' ', 'palabra', 'una frase', NA, '200', 2.5) ## character
lgl_vector <- c(FALSE, TRUE, FALSE, TRUE, NA, FALSE) ## logical

# listas -----------------------------------------------------------------
list_vector <- list(
    int_vector, dbl_vector, chr_vector, lgl_vector
)

# Named vectors -----------------------------------------------------------

## named atomic vector
names(int_vector) <- letters[1:6]

## named list vector
names(list_vector) <- c('vct1', 'vct2', 'vct3', 'vct4')
list_vector2 <- list(int_vector)
names(list_vector2) <- 'test'


# Matrices ----------------------------------------------------------------
m <- matrix(
    data = int_vector, nrow = 2, ncol = 3, byrow = TRUE 
)
rownames(m) <- paste0('row', 1:nrow(m))
colnames(m) <- paste0('col', 1:ncol(m))
t(m)



