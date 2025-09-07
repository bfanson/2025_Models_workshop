# Load required libraries
library(ggplot2)
library(dplyr)
library(patchwork)

# Set seed for reproducibility
set.seed(123)

# Define distributions and types
mu <- c(25,65,75,125)
sd <- c(5,10,25,15)
n=10000
ds <- map_df( 1:length(mu), ~data.frame( id=paste0('Species ',.x), mu=mu[.x],sd=sd[.x], y=rnorm(n,mu[.x],sd[.x]) ) ) 

ggplot(ds,aes(y)) + geom_density( fill='blue') 
ggplot(ds,aes(y)) +  geom_density( aes(fill=id, group=id), alpha=0.6,bw=5) +
  ggthemes::scale_fill_economist('Species') + cowplot::theme_map()

ggplot(ds,aes(y)) +  geom_density( aes(fill=id, group=id), alpha=0.6,bw=5) +
  ggthemes::scale_fill_economist('Species') + facet_wrap(~id)

library(gganimate)
ggplot(ds,aes(y)) + geom_density( fill='blue')


