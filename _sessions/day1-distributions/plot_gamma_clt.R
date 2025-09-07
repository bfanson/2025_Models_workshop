
sample_sizes <- c(1,5, 30, 100, 500)
num_samples <- 1000

# Function to generate sample means
generate_sample_means <- function(n, shape, scale, num_samples) {
  replicate(num_samples, mean(rgamma(n, shape=2, scale=2)))
}

# Create a data frame to hold results
results <- data.frame()

for (n in sample_sizes) {
  means <- generate_sample_means(n, shape, scale, num_samples)
  temp <- data.frame(sample_mean = means, sample_size = as.factor(n))
  results <- rbind(results, temp)
}

# Plot the sampling distributions
ggplot(results, aes(x = sample_mean)) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "skyblue", color = "black") +
  geom_density(color = "red", size = 1) +
  facet_wrap(~ sample_size, scales = "free", nrow = 1) +
  labs(title = "Sampling Distribution of the Mean from Gamma Distribution",
       x = "Sample Mean", y = "Density") 
