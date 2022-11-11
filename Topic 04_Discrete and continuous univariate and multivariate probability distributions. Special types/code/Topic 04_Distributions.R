rm(list = ls())

# Get location of current script
fileloc <- dirname(rstudioapi::getSourceEditorContext()$path)

# Set working directory to script location
setwd(fileloc)

rm(fileloc)

# Binomial RV
# Find the probability of getting heads two times 
# out of ten fair coin tosses
dbinom(2, 10, 0.5, log = FALSE)

# What is the probability of NOT getting a pass (60%)
# if you answer randomly at an exam in which there are
# 20 multiple-choice questions (the number of options is 4)?
pbinom(11, 20, 0.25, lower.tail = TRUE, log.p = FALSE)

# Find the number of correct answers so that 
# your test score is in the 75th percentile
qbinom(0.75, 20, 0.25, lower.tail = TRUE, log.p = FALSE)

# Generate 100 random numbers from the binomial distribution
# where $p = 0.6$ and $n = 20$
rbinom(100, 20, 0.6)

# Plot
plot(rbinom(100, 20, 0.6), type = "p")

# Histogram
hist(rbinom(100, 20, 0.6), breaks = 20)

# Geometric Random Variables
# What is the probability of tossing 5 times a fair coin and
# getting tails before we get heads on the sixth toss?
dgeom(5, 0.5, log=FALSE)

# What is the probability of tossing a coin between zero and 
# five times before getting heads?
pgeom(5, 0.5, lower.tail = TRUE, log.p = FALSE)

# Poisson RV
# 15 cars arrive at a gas station on average per hour. 
# What is the probability that 10 cars arrive during a chosen hour?
dpois(10, 15, log = FALSE)

# Calculate the probability of having 10 or less cars arrive:
ppois(10, 15, lower.tail = TRUE, log.p = FALSE)

# Uniform RV
# Calculate density at a given value
dunif(0.7, min = 0, max = 1, log = FALSE)

# Plot
plot(dunif, 0, 1, main = "The Uniform pdf")

# cdf
punif(0.7, min = 0, max = 1, lower.tail = TRUE, log.p = FALSE)

# Plot cdf
plot(punif, 0, 1, main = "Uniform cdf")

# Calculate median:
qunif(0.5, min = 0, max = 1, log = FALSE)

# Generate 10000 values of a uniformly distributed random variable:
runif(10000, min = 0, max = 1)

# Plot
plot(runif(10000, min = 0, max = 1),
     type = "l", col = "red", main = "Uniform RV")

# Histogram: 
hist(runif(10000, min = 0, max = 1), 
     breaks = 50, col = "red", main = "Uniform RV (histogram)")

# Exponential RV
dexp(2, 0.25) 

# Plot
x <- seq(0, 20, by = 0.01)
y <- dexp(x, 0.25)
plot(x, y, type = "l")

# Plot the cdf
y <- pexp(x, 0.25)
plot(x, y, type = "l")

# Let $x$ be the amount of time that a customer is processed 
# by a cashier at a department store. What is the probability 
# that a customer is processed between 3 and 4 minutes
# if on average a customer is processed 4 minutes?
pexp(4, 0.25) - pexp(3,0.25)

# Find the time for which half of the customers are being processed
qexp(0.5, 0.25)

# Gamma function
x <- seq(1, 10, by=.1)
y <- factorial(x)
plot(x, y, type = "l")

# Normal RV
# Density
dnorm(5, mean = 0, sd = 1, log = FALSE)	
dnorm(5)

# Plot pdf 
plot(dnorm,-3, 3, main = "Standard normal distribution")

x <- seq(-20, 20, by=0.1)
y <- dnorm(x, mean = 2, sd = 5)
plot(x, y, type = "l")

# Calculate cdf
pnorm(5, mean = 2, sd = 5, lower.tail = TRUE, log.p = FALSE)

# Find the probability that a value is within
# 1.96 standard deviations from the mean
pnorm(1.96, lower.tail = TRUE) - pnorm(-1.96, lower.tail = TRUE)

# Plot cdf
plot(pnorm, -5, 5, main = "Normal cdf")

# Quantiles
qnorm(0.25, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)

# Find the median of the standard normal distribution
qnorm(0.5)

# Find the lower and upper bounds of a 95\% confidence interval
c(qnorm(0.025),qnorm(0.975))

# Generate a normal random variable with 10000 values
rnorm(10000, mean = 2, sd = 5)

# Plot
plot(rnorm(10000, mean = 0, sd = 5), 
     type = "l", col = "blue", main = "Gaussian white noise")

# Histogram
hist(rnorm(100000000, mean = 2, sd = 5), breaks = 500, col = "orange")


# Chi-square RV
# pdf
dchisq(3, 5)

# Plot
x <- seq(-5, 50, by = 0.01)
y <- dchisq(x, 5)
plot(x, y, type="l")

# cdf
pchisq(3, 5)

# Plot cdf
x <- seq(0, 20, by = 0.01)
y <- pchisq(x, 5)
plot(x, y, type = "l")

# F-distribution
# pdf 
df(3, 2, 5)

# Plot pdf
x <- seq(0, 20, by = 0.01)
y <- df(x, 2, 5)
plot(x, y, type = "l")

# cdf
pf(3, 2, 5)

# Plot cdf
x <- seq(0, 20, by = 0.01)
y <- pf(x, 2, 5)
plot(x, y, type = "l")

# t-distribution
# pdf
dt(0, 15)

# Plot
x <- seq(-5, 5, by = 0.01)
y <-  dt(x, 150)
plot(x, y, type = "l")

# cdf
pt(0, 15)

# Add a normal density to the graph
z <- dnorm(x)
lines(x, z, col = "red")

