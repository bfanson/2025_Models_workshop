# Load required libraries
library(ggplot2)
library(dplyr)
library(patchwork)

# Set seed for reproducibility
set.seed(123)

# Define distributions and types
distributions <- list(
  Normal = list(data = rnorm(10000), type = "continuous"),
  Lognormal = list(data = rlnorm(10000, meanlog = 0, sdlog = 1), type = "continuous"),
  Gamma = list(data = rgamma(10000, shape = 2, scale = 2), type = "continuous"),
  Tweedie = list(data = rgamma(10000, shape = 1.5, scale = 1) + rpois(10000, lambda = 1), type = "continuous"),
  Beta = list(data = rbeta(10000, shape1 = 2, shape2 = 5), type = "continuous"),
  Uniform = list(data = runif(10000), type = "continuous"),
  Bernoulli = list(data = rbinom(10000, size = 1, prob = 0.3), type = "discrete"),
  Binomial = list(data = rbinom(10000, size = 10, prob = 0.5), type = "discrete"),
  Poisson = list(data = rpois(10000, lambda = 3), type = "discrete"),
  Exponential = list(data = rexp(10000, rate = 1), type = "continuous"),
  Negative_Binomial = list(data = rnbinom(10000, size = 10, prob = 0.5), type = "discrete"),
  Cauchy = list(data = rcauchy(10000), type = "continuous"),
  Half_Normal = list(data = abs(rnorm(10000)), type = "continuous")
)

# Create plots
plot_list <- lapply(names(distributions), function(name) {
  dist <- distributions[[name]]
  df <- data.frame(x = dist$data)
  
  if (dist$type == "continuous") {
    ggplot(df, aes(x)) +
      geom_density(color = "black", fill = "blue", alpha = 0.5) +
      labs(title = name) +
      theme_minimal(base_size = 14) +
      theme(
        plot.title = element_text(size = 16, face = "bold"),
        panel.grid = element_blank()
      )
  } else {
    df_count <- df %>% count(x)
    ggplot(df_count, aes(x = x, y = n)) +
      geom_col(fill = "blue", color = "black", alpha = 0.7) +
      labs(title = name) +
      theme_minimal(base_size = 14) +
      theme(
        plot.title = element_text(size = 16, face = "bold"),
        panel.grid = element_blank()
      )
  }
})

# Combine all plots
wrap_plots(plotlist = plot_list, ncol = 3)
