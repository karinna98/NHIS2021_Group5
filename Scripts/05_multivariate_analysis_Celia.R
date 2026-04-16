# Day 4: Multivariate Analysis

# Load clean dataset
nhis_clean <- read.csv("Data/nhis_clean.csv")

# Scatter plot: Height vs Weight
library(ggplot2)

ggplot(nhis_clean, aes(x = HEIGHTTC_A, y = WEIGHTLBTC_A, color = factor(SEX_A,
                                                                        levels = c(1, 2),
                                                                        labels = c("Male", "Female")))) +
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