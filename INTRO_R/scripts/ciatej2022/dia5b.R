
library(purrr)
library(dplyr)

df <- ggplot2::diamonds

## For loop
output <- vector('list', ncol(df))
for (i in seq_along(output)) {
    output[[i]] <- length(unique(df[[i]]))
}
output_int <- as.integer(output)
names(output_int) <- colnames(df)

## lapply y vapply
out2 <- vapply(df, function(x) length(unique(x)), integer(1))
out3 <- lapply(df, \(x) length(unique(x)))

## map y map_*
out4 <- map_int(df, n_distinct)
out5 <- map(df, ~ n_distinc(.x))

