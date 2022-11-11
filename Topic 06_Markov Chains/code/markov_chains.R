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

# Set locale
Sys.setlocale("LC_ALL","English")

# Package for matrix exponentiation
library(expm)

# Chiang and Wainwright, Ex. 4.7
# Initial distribution
init_dist <- matrix(c(0, 1200), nrow = 1)
init_dist

# Transition matrix
P <- matrix(c(0.9, 0.1, 0.7, 0.3), nrow = 2, byrow = T)
P

# One-step
init_dist %*% P

# Two-step
init_dist %*% (P %^% 2)

# Five-step
init_dist %*% (P %^% 5)

# Ten-step
init_dist %*% (P %^% 10)

# Steady-state
init_dist %*% (P %^% 10000)
P %^% 10000
