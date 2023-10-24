## Vectores atomicos

int_vct <- c(0L, NA, -1L, 1L, 7L, 9L)
typeof(int_vct)

dbl_vct <- c(0, 1, -1, 1, 2.3, 4.5)
typeof(dbl_vct)

chr_vct <- c('a', 'palabera', 'una frase', NA, 'NA', 'sd')

lgl_vct <- c(TRUE, FALSE, NA, TRUE, FALSE, FALSE)
typeof(lgl_vct)


## Checar typo de un objeto
class(lgl_vct)

l <- list(int_vct, dbl_vct, chr_vct, lgl_vct)
str(l)

## Propiedades

## tipo/clase
typeof(l)
class(l)

## longitud
length(l)

## attributes
names(l) <- c('int', 'dbl', 'chr', 'lgl')
names(l) <- NULL


## nrow() ncol()
dim(lgl_vct) <- c(3, 2)
class(lgl_vct)

matrix(data = lgl_vct, nrow = 3)

m1 <- lgl_vct
dim(m1) <- c(nrow = 3,  ncol = 2)
matrix(lgl_vct, ncol = 3, nrow = 2)

as.data.frame(l)

l1 <- list(
    x = c('a', 'b', 'c', 'd'),
    y = c(1, 2, 3),
    z = 3
)
as.data.frame(l1)

df <- as.data.frame(l)
colnames(df) <- paste0('col', 1:4)
rownames(df) <- paste0('row', 1:6)

