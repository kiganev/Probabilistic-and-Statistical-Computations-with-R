rm(list = ls())

# Get location of current script
fileloc <- dirname(rstudioapi::getSourceEditorContext()$path)

# Set working directory to script location
setwd(fileloc)

# Remove fileloc string
rm(fileloc)

# Set locale
Sys.setlocale("LC_ALL","English")

library(tidyverse)

# Normal distribution with mean 5 and variance 9
# Mean: 5
nobs <- 100000
mean1 <- 5
sd1 <- 3
idx1 <- c(1:nobs)

vec_draws <- numeric()
vec_avgs <- numeric()
for (i in 1:nobs){
  draw <- rnorm(1, mean = mean1, sd = sd1)
  vec_draws[i] <- draw
  vec_avgs[i] <- mean(vec_draws)
}

df1 <- as.data.frame(cbind(idx1, vec_avgs, 
                           mean1 = rep(mean1, nobs)))

ggplot(df1, aes(x = idx1)) + 
  geom_line(aes(y = mean1, col = "Theoretical mean")) + 
  geom_line(aes(y = vec_avgs, col = "Empirical mean")) + 
  scale_color_manual("", values = c("blue", "red")) +
  xlab("Number of draws") + 
  ylab("") + 
  theme_bw() + 
  theme(legend.position = "bottom")

