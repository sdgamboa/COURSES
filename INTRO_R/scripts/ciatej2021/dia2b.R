
## Estructuras en R

x <- 10 * 2

## Propiedades
length(x)
attributes(x) # class
class(x)
dim(x)

# Vectores atómicos -------------------------------------------------------

# numeric o double
vctr_dbl <- c(1, 2, 3, 4.2, 5.5, 6)
length(vctr_dbl)
typeof(vctr_dbl)

# integer
vctr_int <- c(1L, 2L, 3L, 0L, -1L, 3L)
length(vctr_int)
typeof(vctr_int)

# character
vctr_chr <- c("k", 'x', "", "una frase", "palabra", "2.5")
length(vctr_chr)
typeof(vctr_chr)

# logical
vctr_lgl <- c(TRUE, FALSE, T, F, TRUE, FALSE)
length(vctr_lgl)
typeof(vctr_lgl)


x = vctr_dbl > 2

## Coerción
lgl_chr <- as.logical(c(TRUE, FALSE, "TRUE", "NO DISP"))
typeof(lgl_chr)

sum(is.na(lgl_chr))

vctr_1 <- c("x")
## Listas y dataframes
## Misma longitud
my_list <- list(
    vctr_1,
    vctr_chr,
    vctr_dbl,
    vctr_int,
    vctr_lgl
)


df1 = as.data.frame(my_list)

df2 = tibble::as_tibble(my_list, .name_repair = "unique")
length(df1)
dim(df1)
class(df1)
class(df2)

## Cargar un set de datos de R
## diferentes tipos de columnas
## filtrado de alguna de las columns (e.g., > 2)

data(iris)

typeof(iris)
class(iris)
dim(iris)

lapply(iris, class)

iris$Species <- as.character(iris$Species)
iris$Species <- as.factor(iris$Species)

iris |> View()


mat <- matrix(vctr_dbl, nrow = 2)

dim(mat)
class(mat)


# Nombres -----------------------------------------------------------------

vctr_nm <- c(a = 1, b = 2, c = 3)
my_list <- list(
    a = vctr_1,
    b = vctr_chr,
    c = vctr_dbl,
    d = vctr_int,
    e =  vctr_lgl
)
my_list[["a"]]


names(df1)
attributes(df1)
colnames(df1) <- paste0("c", 1:5)
rownames(df1) <- paste0("r", 1:6)

df1["r1", c("c2", "c3")]

