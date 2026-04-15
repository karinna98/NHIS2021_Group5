# Load clean dataset

nhis_clean <- read.csv("Data/nhis_clean.csv")

# Check that key variables do not contain missing-value codes

table(nhis_clean$PHSTAT_A)

table(nhis_clean$LSATIS4R_A)

# Load package for plotting

library(ggplot2)

# Create scatter plot of height and weight, colored by sex and faceted by education
ggplot(nhis_clean, aes(x = HEIGHTTC_A, y = WEIGHTLBTC_A, color = factor(SEX_A))) +
  geom_point(alpha = 0.6) +
  facet_wrap(~ EDUCP_A) +
  labs(
    title = "Height vs Weight by Sex and Education",
    x = "Height (inches)",
    y = "Weight (pounds)",
    color = "Sex"
  ) +
  theme_minimal()

# Load psych package for correlation matrix
library(psych)

# Create correlation matrix for age, height, and weight
pairs.panels(
  nhis_clean[, c("AGEP_A", "WEIGHTLBTC_A", "HEIGHTTC_A")]
)


# The scatter plot of height and weight shows a positive relationship, meaning that taller people usually weigh more.The correlation matrix shows the same idea. There is a moderate positive correlation (between height and weight, which means they are related




# Day 4: Multivariate Analysis

# Load clean dataset
nhis_clean <- read.csv("Data/nhis_clean.csv")

# Scatter plot: Height vs Weight
library(ggplot2)

ggplot(nhis_clean, aes(x = HEIGHTTC_A, y = WEIGHTLBTC_A, color = factor(SEX_A))) +
  geom_point(alpha = 0.6) +
  facet_wrap(~ EDUCP_A) +
  labs(
    title = "Height vs Weight by Sex and Education",
    x = "Height (inches)",
    y = "Weight (pounds)",
    color = "Sex"
  ) +
  theme_minimal()

# Correlation matrix
library(psych)

pairs.panels(
  nhis_clean[, c("AGEP_A", "WEIGHTLBTC_A", "HEIGHTTC_A")]
)





