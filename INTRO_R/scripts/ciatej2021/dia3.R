library(magrittr)

# Importar datos ----------------------------------------------------------

## Importar datos tsv "crudos"
fc_tbl_url <- "https://raw.githubusercontent.com/sdgamboa/misc_datasets/master/L0_vs_L20.tsv"
fc_tbl <- read.table(file = supp_tbl_url, header = TRUE, sep = "\t")

## Importar archivo de excel
supp_tbl_url <- "https://static-content.springer.com/esm/art%3A10.1038%2Fs41598-018-32904-2/MediaObjects/41598_2018_32904_MOESM3_ESM.xlsx"
fc_tbl_file <- tempfile()
download.file(url = supp_tbl_url, destfile = fc_tbl_file)
sheet <- "Supplementary Table S2"
supp_tbl <- readxl::read_xlsx(
    path = fc_tbl_file, sheet = sheet, range = "A5:AQ27774"
)


# Subsetting --------------------------------------------------------------

vctr_num <- 1:10
names(vctr_num) <- paste0("e", 1:10)

## Usando vector numérico
## Cualquier longitud
vctr_num[1:3] ## Por rango
vctr_num[c(3, 9)] ## por posición

## Por nombre (vector de caracter)
## Elemento tiene que estar entre los nombres
select_chr <- c("e2", "e9")
vctr_num[select_chr]

## Con un vector lógico (misma longitud que el vector)
vct_lgl <- vctr_num > 5
vctr_num[vct_lgl]

## En una matrix (dos dimensiontes)

mat <- matrix(1:9, ncol = 3)
colnames(mat) <- paste0("c", 1:3)
rownames(mat) <- paste0("r", 1:3)

row_dim <- 1:2
col_dim <- 2:3
mat[row_dim, col_dim]

## Seleccionar los significativos (FDR < 0.001)
sig <- 0.001
filter_sig <- fc_tbl[["FDR"]] < sig
fc_tbl_sig <- fc_tbl[filter_sig, ]

## Seleccionar FC >= 2
fc <- 2
up_fc <- fc_tbl$logFC > log(fc) ## Regulados hacia arriba
fc_tbl_up <- fc_tbl[up_fc, ]

## regulados hacia arriba y además sean significativos
sig_up <- fc_tbl[["FDR"]] < sig & fc_tbl$logFC > log(fc)
fc_tbl_sig_up <- fc_tbl[sig_up, ]

## Subsetting usando dos dimensiones
genes <- fc_tbl_sig[,"Genes"]

# subsetting de la matrix -------------------------------------------------
mat <- supp_tbl[ , c(1, 26:length(supp_tbl))]


tpm_mat <- as.matrix(mat[,-1])
rownames(tpm_mat) <- mat[[1]]


new_names <- sub("^.+_", "", rownames(tpm_mat)) %>% ## pipe de magrittr
    sub("\\.", "_", .)

new_names <- sub("^.+_", "", rownames(tpm_mat)) |> ## pipe "nativo" de base R
    {\(.x) sub("\\.", "_", .x)}()

rownames(tpm_mat) <- new_names


heatmap(tpm_mat[genes,])



