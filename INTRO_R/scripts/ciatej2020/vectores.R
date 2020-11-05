

# Nov 5, 2020 -  Sesión 2

# Vectores atómicos -------------------------------------------------------

# Númerico
(int_vector <- c(1L, -10L, 0L, NA, 1000L, 5L))
dbl_vector <- c(2.6, 5.7, -5, NaN, NA, Inf)

# Caracter
chr_vector <- c("a", "palabra", "una frase", NA, "NA", 10L)

# Lógico
lgl_vector <- c(TRUE, FALSE, NA, T, F, TRUE)



# listas ------------------------------------------------------------------

list_vector <- list(int_vector, dbl_vector, chr_vector, lgl_vector)




# Names -------------------------------------------------------------------

named_vector <- c("int1" = 1, "int2" = 2, "int3" = 3)


names(named_vector) # checar

# inplace
names(named_vector) <- c("new1", "new2", "new3") # Asignar
names(named_vector) <- NULL # quitar los nombres

# Crear un vector
unnamed_vector <- unname(named_vector)
named_again_vector <- setNames(unnamed_vector, c("a", "b", "c"))


# nombrar listas
names(list_vector) <- c("l1", "l2", "l3", "l4")



# Matrices ----------------------------------------------------------------

x <- 1:9
col_names <- c("col1", "col2", "col3")
row_names <- c("row1", "row2", "row3")


mat <- matrix(data = x, nrow = 3, ncol = 3,
       byrow = FALSE,
       dimnames = list("row_names" = row_names, "col_names" = col_names))

dim(mat)
dimnames(mat)

ncol(mat)
nrow(mat)

t(mat)

# Factores ----------------------------------------------------------------

a <- c("a", "b", "b", "c", "d", "a")

fct_vector <- factor(a)


fct_vector <- factor(a, levels = c("d", "c", "b", "a"))



# Data frames -------------------------------------------------------------


df <- data.frame("int" = int_vector, "dbl" = dbl_vector,
           "chr" = chr_vector, "lgl" = lgl_vector,
           "fct" = fct_vector)

tbl <- tibble::tibble("int" = int_vector, "dbl" = dbl_vector,
  "chr" = chr_vector, "lgl" = lgl_vector,
  "fct" = fct_vector)


iris_tbl <- tibble::as_tibble(iris)


View(iris_tbl)


# Importar datos ----------------------------------------------------------

plants <- readxl::read_excel("datasets.xlsx", sheet = "PLANTS")

write_csv(plants, "new_dataset.csv")


plants$genome_size <- as.integer(plants$genome_size)
plants_no_na <- na.omit(plants)


# Propiedades -------------------------------------------------------------

# Longitud
length(df)

# Tipo
typeof(df)

is.integer(int_vector)
is.double(dbl_vector)

# Atributos
attributes(df)


# Misc --------------------------------------------------------------------

is.na(lgl_vector)
