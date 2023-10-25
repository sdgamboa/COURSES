# setwd("~/Projects/COURSES/INTRO_R/scripts/ciatej2023")
library(purrr)
library(ggplot2)

## Definir una funcion
my_fun <- function(x, y = 3) {
    x * y
}

my_fun(3)

## if else
if (FALSE) "It's true" else "it's false"

##  for loops
x <- letters[1:10]
for (myVar in x) {
    print(myVar)
}

## for loops 
x <- letters[1:10]
output <- vector('character', length(x))
for (i in seq_along(x)) {
    output[[i]] <- paste0('this is letter ', x[i])
}
names(output) <- x

## lapply y vapply
lapply(X = x, FUN = print)
z <- vapply(X  =x , FUN = print, FUN.VALUE = character(1))

## map and map_*
l <- map(x, print)
v <- map_chr(x, print)


# Ejercicio ---------------------------------------------------------------

## Obtener list de los nombres de archivos
dirPath <- '/home/samuel/R/x86_64-pc-linux-gnu-library/4.3/palmerpenguins/extdata'
fnames <- list.files(path = dirPath, full.names = TRUE)
names(fnames) <- fnames

## Definir funcion para importar
importPenguins <- function(file_name) {
    
    cond1 <- grepl("\\.csv$", file_name)
    cond2 <- !grepl("_raw", file_name)
    
    if (cond1 && cond2) {
        output <- readr::read_csv(file_name)
    } else {
        output <- NULL
    }
    
    return(output)
}

## Usar for loop para importar
imported_files <- vector('list', length(fnames))
for (i in seq_along(imported_files)) {
    res <- importPenguins(fnames[i])
    names(imported_files)[i] <- fnames[i]
    if (!is.null(res))
        imported_files[[i]] <- res
}

imported_files <- purrr::discard(imported_files, is.null)

imported_files_2 <- fnames |> 
    map(importPenguins) |> 
    discard(is.null)

# Ejercicio 2 -------------------------------------------------------------
## tidyeval

x <- imported_files[[1]]

plot_histogram <- function(dat, col) {
    col_var <- enquo(col)
    dat |> 
        ggplot() +
        geom_histogram(aes(!!col_var))
}

plot_histogram(dat = x, col = bill_length_mm)

plot_histogram(dat = x, col = "bill_length_mm") ## Throws error.

x |> 
    ggplot() +
    geom_histogram(aes(bill_length_mm))






