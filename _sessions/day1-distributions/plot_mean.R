# Load required libraries
library(ggplot2)
library(gganimate)
library(dplyr)

# Set seed for reproducibility
set.seed(123)

# Generate data for increasing sample sizes
sample_sizes <- c(2,5,10,30,100,1000,10000)
true_mean <- 0
true_sd <- 1

# Create a data frame with sample means and confidence intervals
data <- lapply(sample_sizes, function(n) {
  sample <- rnorm(n, mean = true_mean, sd = true_sd)
  sample_mean <- true_mean # mean(sample)
  se <- true_sd / sqrt(n)
  ci_lower <- true_mean - 1.96 * se
  ci_upper <- true_mean + 1.96 * se
  data.frame(
    sample_size = n,
    mean = sample_mean,
    se=se,
    ci_lower = ci_lower,
    ci_upper = ci_upper
  )
}) %>% bind_rows()

# Plot with gganimate
ggplot(data, aes(factor(sample_size), mean, ymin=ci_lower, ymax=ci_upper)) + geom_pointrange() +
  labs( x='Sample size', y='Mean + 95%CI' )

