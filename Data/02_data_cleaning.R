nhis_subset <- NHIS_Data_2021[, c("AGEP_A", "WEIGHTLBTC_A", "HEIGHTTC_A",
                            "SEX_A", "HISPALLP_A", "EDUCP_A", "PHSTAT_A", "LSATIS4R_A")] # creates a subset of variables for analysis 

print (nhis_subset) # prints the subset
