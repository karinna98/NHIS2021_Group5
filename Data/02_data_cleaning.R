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

anyNA(nhis_clean) # examines 'nhis_clean' for any NA 

summary (nhis_clean)

nhis_clean <- nhis_clean %>% # selects 'nhis_clean' and create new version 
  mutate( # modify variables in data set
    EDUCP_A = case_when( # converting numerical variables to catergorical variables 
      EDUCP_A %in% 0:3 ~ "Less than High School",
      EDUCP_A == 4     ~ "High School Graduate",
      EDUCP_A %in% 5:7 ~ "Some College Education",
      EDUCP_A %in% 8:10 ~ "College Graduate or better",
      TRUE ~ NA_character_  # assigns NA to any where the numbers do not apply 
    ),
    EDUCP_A = factor( # converts variable into a factor 
      EDUCP_A,
      levels = c(
        "Less than High School",
        "High School Graduate",
        "Some College Education",
        "College Graduate or better"
      )
    )
  )

summary (nhis_clean) # provides a statistical summary of 'hint_clean' data 

view (nhis_clean) # view new clean data set 

write_csv(nhis_clean, "data/nhis_clean.csv") # saves new 'nhis_clean' to project data folder



