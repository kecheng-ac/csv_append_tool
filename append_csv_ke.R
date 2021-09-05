rm(list = ls())

library(tidyverse)
library(readxl)
library(writexl)
library(readr)

## 1.read functions
append_csv_ke <- function(dir_in, dir_out){
  files <- list.files(dir_in, pattern = "csv", full.names = TRUE)
  # 1. Appending files using map_dfr
  # (return df after applying function, in this case read.csv, and row binding)
  df <- map_dfr(files, read.csv, encoding = "UTF-8-BOM", check.names=FALSE)
  # 2. Appending files using pipe and bind_rows
  # (automatically match columns with the same name and append df) 
  # files %>%
  #   lapply(read.csv)%>%
  #   bind_rows -> df 
  # 3. Replacing NA with blank and output CSV
  df <<-  df %>% replace(is.na(df), "")
  write_excel_csv(df, dir_out, col_names = TRUE, na = "")
}
help(read.csv)
## 2.set var. for functions
dir_in <- "Maomao/July/"
dir_out <- "Maomao/output/append.csv"

# Avoid conflict over the name "df" resulting in
# <<- operator attempts to overwrite the contents of the df function
df <- NULL 

## 3.implement functions
append_csv_ke(dir_in, dir_out)

glimpse(df)
dim(df)
head(df)
tail(df)
rm(df)

## 4.additional stuff 
#    test functions
test_files <- files[1:10]
df_test <- map_dfr(test_files, read.csv)

#    detect encoding of the files
guess_encoding(files[1], n_max = 3000)
test <- read.csv(files[1], encoding = "UTF-8") 
test
