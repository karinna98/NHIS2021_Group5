library(readr) # opens 'readr'package

NHIS_Data_2021 <- read_csv("C:/Users/Karin/OneDrive/Spring 2026/PUBH 422/NHIS _Data_2021.csv") # downloads data 

library(tidyverse) # opens 'tidyverse'

library(ggplot2) # opens 'ggplot2'

View(NHIS_Data_2021) # view data

str(NHIS_Data_2021) # examine structure of data

summary (NHIS_Data_2021) # run statistical summary for all variables

head (NHIS_Data_2021) # print first 6 rows of data
