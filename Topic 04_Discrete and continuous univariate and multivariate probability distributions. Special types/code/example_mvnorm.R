# Clear workspace
rm(list = ls())

# Clear plots
dev.off(dev.list()["RStudioGD"])

# Get location of current script
fileloc <- dirname(rstudioapi::getSourceEditorContext()$path)

# Set working directory to script location
setwd(fileloc)

# Remove fileloc variable
rm(fileloc)

# Set locale to English
Sys.setlocale("LC_ALL","English")

library(mvtnorm)
library(ggplot2)

sigmamat <- matrix(c(1, 0.6, 0.6, 1), nrow = 2)
sigmamat

# Density
dmvnorm(x = c(1,2), mean = c(0.05, -0.05), sigma = sigmamat)

# Cumulative
pmvnorm(lower = -Inf, upper = c(1,2), mean = c(0.05, -0.05), sigma = sigmamat)

# Random number generation
rvec1 <- rmvnorm(n = 10000, mean = c(0.05, -0.05), sigma = sigmamat)
rvec1 <- as.data.frame(rvec1)


# Same but if the two variables are uncorrelated
sigmamat2 <- matrix(c(1, 0, 0, 1), nrow = 2)
sigmamat2

rvec2 <- rmvnorm(n = 10000, mean = c(0.05, -0.05), sigma = sigmamat2)
rvec2 <- as.data.frame(rvec2)

# Plot
ggplot(rvec1, aes(x = V1, y = V2)) + 
  geom_point(col = "red", size = 2, alpha = 0.3) + 
  theme_bw()

dev.copy2pdf(file = "fig1.pdf", width = 6, height = 6)

ggplot(rvec2, aes(x = V1, y = V2)) + 
  geom_point(col = "red", size = 2, alpha = 0.3) + 
  theme_bw()

dev.copy2pdf(file = "fig2.pdf", width = 6, height = 6)
