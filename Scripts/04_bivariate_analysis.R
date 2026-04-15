#Day 3: Univariate & Bivariate Analysis & Visualization
#Task 2: Bivariate Analysis

# -----------------------------
# Load libraries
# -----------------------------
library(tidyverse)

# Load dataset
nhis_clean <- read.csv("data/nhis_clean.csv")

# -----------------------------
# Ensure correct factor labels (from codebook)
# -----------------------------
nhis_clean <- nhis_clean %>%
  mutate(
    
    SEX_A = factor(SEX_A,
                   levels = c(1,2),
                   labels = c("Male","Female")),
    
    EDUCP_A = case_when(
      EDUCP_A %in% 0:3 ~ "Less than High School",
      EDUCP_A == 4 ~ "High School Graduate",
      EDUCP_A %in% 5:7 ~ "Some College",
      EDUCP_A >= 8 ~ "College Graduate+",
      TRUE ~ NA_character_
    ),
    EDUCP_A = factor(EDUCP_A),
    
    PHSTAT_A = factor(PHSTAT_A,
                      levels = 1:5,
                      labels = c("Excellent","Very Good","Good","Fair","Poor")),
    
    LSATIS4R_A = factor(LSATIS4R_A,
                        levels = 1:4,
                        labels = c("Very Satisfied","Satisfied","Dissatisfied","Very Dissatisfied"))
  )

# =========================================================
# 1. QUANTITATIVE vs QUALITATIVE (AGEP_A vs SEX_A, EDUCP_A)
# =========================================================

# --- Base R: Boxplot AGE by SEX ---
plot(nhis_clean$SEX_A, nhis_clean$AGEP_A,
     main = "Age by Sex (Base R)",
     xlab = "Sex",
     ylab = "Age")

# --- ggplot: Boxplot AGE by SEX ---
ggplot(nhis_clean, aes(x = SEX_A, y = AGEP_A)) +
  geom_boxplot() +
  labs(title = "Age by Sex", x = "Sex", y = "Age")

# --- Base R: Boxplot AGE by EDUCATION ---
plot(nhis_clean$EDUCP_A, nhis_clean$AGEP_A,
     main = "Age by Education (Base R)",
     xlab = "Education",
     ylab = "Age")

# --- ggplot: Boxplot AGE by EDUCATION ---
ggplot(nhis_clean, aes(x = EDUCP_A, y = AGEP_A)) +
  geom_boxplot() +
  labs(title = "Age by Education", x = "Education", y = "Age") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# =========================================================
# 2. QUALITATIVE vs QUALITATIVE
# PHSTAT_A vs LSATIS4R_A
# =========================================================

ggplot(nhis_clean, aes(x = PHSTAT_A, fill = LSATIS4R_A)) +
  geom_bar(position = "dodge") +
  labs(title = "Health Status vs Life Satisfaction",
       x = "General Health",
       y = "Count",
       fill = "Life Satisfaction") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# =========================================================
# 3. QUANTITATIVE vs QUANTITATIVE
# HEIGHT vs WEIGHT
# =========================================================

# Base R scatter plot
plot(nhis_clean$HEIGHTTC_A, nhis_clean$WEIGHTLBTC_A,
     main = "Height vs Weight (Base R)",
     xlab = "Height (inches)",
     ylab = "Weight (lbs)")

# ggplot scatter plot
ggplot(nhis_clean, aes(x = HEIGHTTC_A, y = WEIGHTLBTC_A)) +
  geom_point(alpha = 0.6) +
  labs(title = "Height vs Weight",
       x = "Height (inches)",
       y = "Weight (lbs)") +
  theme_minimal()

# Correlation
correlation <- cor(nhis_clean$HEIGHTTC_A,
                   nhis_clean$WEIGHTLBTC_A,
                   use = "complete.obs")

cat("Correlation between Height and Weight:", correlation, "\n")

#Interpretation
#There are moderate associations between health status and life satisfaction, 
#and a moderate positive correlation (r = 0.50) between height and weight, 
#while age differences by sex and education are relatively small.

