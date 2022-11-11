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

library(tidyverse)

# Generate a population to sample from
Pop <- as.data.frame(rchisq(10000000, 5))
colnames(Pop) <- "Pop"

true_mean <- mean(Pop$Pop)
true_var <- var(Pop$Pop)

# Plot histogram
ggplot(Pop, aes(x = Pop)) + 
  geom_histogram(bins = 100,
                 col = "red",
                 fill = "red",
                 alpha = 0.5) + 
  theme_bw()

# Sample size
n <- 10000

# Number of samples
m <- 10000

df1 <- as.data.frame(c(1:n))
colnames(df1) <- "idx"

# Generate samples
for(i in 1:m){
  df1[[paste0("Smpl",i)]] <- sample(Pop$Pop, n)
}

smpl_sums <- colSums(df1[,2:ncol(df1)])

Z_n <- (smpl_sums - n * true_mean) / (sqrt(true_var) * sqrt(n))

Z_n <- as.data.frame(Z_n)

ggplot(Z_n, aes(x = Z_n)) + 
  geom_histogram(bins = 200,
                 col = "red", 
                 fill = "red",
                 alpha = 0.5) + 
  theme_bw()

mean(Z_n$Z_n)
sd(Z_n$Z_n)^2
