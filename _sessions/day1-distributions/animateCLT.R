library(ggplot2)
library(gganimate)
library(dplyr)
library(tidyr)

frames <- 1:40

# Binomial
binom_data <- lapply(frames, function(n) {
  x <- rbinom(1000, size = n, prob = 0.1)
  tibble(
    x = x,
    dist = "Binomial",
    frame = n
  )
}) |> bind_rows()

# Poisson
pois_data <- lapply(frames, function(lambda) {
  x <- rpois(1000, lambda)
  tibble(
    x = x,
    dist = "Poisson",
    frame = lambda
  )
}) |> bind_rows()

# Beta
beta_data <- lapply(frames, function(a) {
  x <- rbeta(1000, shape1 = a, shape2 = a)
  tibble(
    x = x,
    dist = "Beta",
    frame = a
  )
}) |> bind_rows()

# Combine all
all_data <- bind_rows(binom_data, pois_data) #, beta_data)
#all_data <- binom_data 


p <- ggplot(all_data, aes(x = x)) +
  geom_histogram(aes(y = ..density..), binwidth = 1, fill = "steelblue", color = "white") +
 # scale_x_continuous( breaks=1:max(all_data$frame) ) +
  geom_text( aes(x=Inf, y=Inf, label=glue::glue('N={frame}') ), 
             size=7,vjust=2, hjust=5, check_overlap=T ) +
  facet_wrap(~dist, scales = "free") +
  labs(title = "Distribution Convergence to Normal: Frame {current_frame}",
       x = "x", y = "Density") +
  transition_manual(frame) + theme(strip.text=element_text(size=16) )

# p <- ggplot(all_data %>% filter(dist!='Beta') , aes(x = x)) +
#   geom_histogram(aes(y = ..density..), bins = 20, fill = "steelblue", color = "white") +
#   facet_wrap(~dist, scales = "free") +
#   labs(title = "Distribution Convergence to Normal: Frame {current_frame}",
#        x = "x", y = "Density") +
#   transition_manual(frame)

# Render animation
animate(p, nframes = max(frames), fps = 2, width = 1000, height = 600,end_pause = 10)
#anim_save("distribution_histograms.gif", animation = last_animation())


