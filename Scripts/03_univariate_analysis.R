#Day 3: Univariate & Bivariate Analysis & Visualization
#Task 1: Univariate Analysis

# -----------------------------
# Load libraries
# -----------------------------
library(tidyverse)

# -----------------------------
# Load cleaned dataset
# -----------------------------
nhis_clean <- read.csv("data/nhis_clean.csv")

# -----------------------------
# RECODE VARIABLES (CODEBOOK FIX)
# -----------------------------
nhis_clean <- nhis_clean %>%
  mutate(
    
    # Sex
    SEX_A = factor(SEX_A,
                   levels = c(1,2),
                   labels = c("Male","Female")),
    
    # Race / Ethnicity
    HISPALLP_A = factor(HISPALLP_A,
                        levels = c(1,2,3,4,5,6,7),
                        labels = c("Hispanic",
                                   "NH White",
                                   "NH Black",
                                   "NH Asian",
                                   "NH AIAN",
                                   "NH AIAN + Other",
                                   "Other")),
    
    # Education (corrected grouping)
    EDUCP_A = case_when(
      EDUCP_A %in% 0:3 ~ "Less than High School",
      EDUCP_A == 4 ~ "High School Graduate",
      EDUCP_A %in% 5:7 ~ "Some College",
      EDUCP_A >= 8 ~ "College Graduate or Higher",
      TRUE ~ NA_character_
    ),
    
    EDUCP_A = factor(EDUCP_A),
    
    # Health status
    PHSTAT_A = factor(PHSTAT_A,
                      levels = 1:5,
                      labels = c("Excellent","Very Good","Good","Fair","Poor")),
    
    # Life satisfaction
    LSATIS4R_A = factor(LSATIS4R_A,
                        levels = 1:4,
                        labels = c("Very Satisfied","Satisfied","Dissatisfied","Very Dissatisfied"))
  )

# -----------------------------
# QUANTITATIVE VARIABLES
# -----------------------------
quant_vars <- c("AGEP_A", "WEIGHTLBTC_A", "HEIGHTTC_A")

for (var in quant_vars) {
  
  cat("\n=============================\n")
  cat("Variable:", var, "\n")
  cat("=============================\n")
  
  data_var <- nhis_clean[[var]]
  data_var <- as.numeric(data_var)
  data_var <- data_var[is.finite(data_var)]
  
  # Skip empty variables
  if (length(data_var) == 0) next
  
  # Summary statistics
  print(summary(data_var))
  cat("Mean:", mean(data_var), "\n")
  cat("Median:", median(data_var), "\n")
  cat("SD:", sd(data_var), "\n")
  
  # Base R Histogram
  hist(data_var,
       main = paste("Histogram of", var),
       xlab = var)
  
  # ggplot Histogram
  ggplot(data.frame(x = data_var), aes(x = x)) +
    geom_histogram(bins = 30) +
    labs(title = paste("Histogram of", var), x = var, y = "Count")
  
  # Base R Boxplot
  boxplot(data_var,
          main = paste("Boxplot of", var),
          ylab = var)
  
  # ggplot Boxplot
  ggplot(data.frame(y = data_var), aes(y = y)) +
    geom_boxplot() +
    labs(title = paste("Boxplot of", var), y = var)
}

# -----------------------------
# QUALITATIVE VARIABLES
# -----------------------------
qual_vars <- c("SEX_A", "HISPALLP_A", "EDUCP_A", "PHSTAT_A", "LSATIS4R_A")

for (var in qual_vars) {
  
  cat("\n=============================\n")
  cat("Variable:", var, "\n")
  cat("=============================\n")
  
  # Frequency table (now labeled properly)
  print(table(nhis_clean[[var]], useNA = "ifany"))
  
  # Base R Bar Plot
  barplot(table(nhis_clean[[var]]),
          main = paste("Bar Plot of", var),
          las = 2)
  
  # ggplot Bar Plot
  ggplot(nhis_clean, aes(x = .data[[var]])) +
    geom_bar() +
    labs(title = paste("Bar Plot of", var),
         x = var,
         y = "Count") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
}

#Interpretation: 
#The dataset includes 26,037 adults with an average age of 52.6 years. 
#Weight (mean = 176.8 lbs) shows moderate variation, while height 
#(mean = 66.7 inches) is relatively stable.The sample is slightly 
#female-dominant and mainly Non-Hispanic White. Most respondents report 
#good or very good health and high life satisfaction. However, the education 
#variable shows no variation (all “College Graduate or Higher”), suggesting a 
#possible coding or cleaning issue that should be reviewed.
