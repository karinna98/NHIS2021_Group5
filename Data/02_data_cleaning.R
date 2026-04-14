nhis_subset <- NHIS_Data_2021[, c("AGEP_A", "WEIGHTLBTC_A", "HEIGHTTC_A",
                            "SEX_A", "HISPALLP_A", "EDUCP_A", "PHSTAT_A", "LSATIS4R_A")] # creates a subset of variables for analysis 

print (nhis_subset) # prints the subset

# Removes all missing values in 'nhis_subset' data
nhis_clean <- nhis_subset %>%
  filter(
    !AGEP_A %in% c(97, 98, 99),
    !WEIGHTLBTC_A %in% c(996, 997, 998, 999),
    !HEIGHTTC_A %in% c(96, 97, 98, 99),
    !SEX_A %in% c(7, 9),
    !HISPALLP_A %in% c(97, 98, 99),
    !EDUCP_A %in% c(97, 98, 99),
    !PHSTAT_A %in% c(7, 8, 9),
    !LSATIS4R_A %in% c(7, 8, 9)
  )

dim (nhis_clean) # evaluates dimensions of 'nhis' clean data


