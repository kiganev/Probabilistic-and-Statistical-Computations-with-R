# Clear workspace
rm(list = ls())

# Clear plots
check_dev <- dev.list()
if(!is.null(check_dev)){
  dev.off(dev.list()["RStudioGD"])  
}

# Get location of current script
fileloc <- dirname(rstudioapi::getSourceEditorContext()$path)

# Set working directory to script location
setwd(fileloc)

# Remove fileloc variable
rm(fileloc)

# Load the dataset and convert two of the variables to factors
stores <- read.csv2("stores.csv")
stores$treatment <- as.factor(stores$treatment)
stores$store <- as.factor(stores$store)

# Calculate the deviation of X's from their grand mean
stores$xcov <- stores$X - mean(stores$X)

# Attach the dataset
attach(stores)

# Plot the original data, colour by treatment
library(ggplot2)
ggplot(data=stores,aes(x=X,y=Y,col=treatment)) + 
  geom_point(size=I(6)) + 
  xlab("Sales in preceding period") + 
  ylab("Sales in promotion period") +
  theme_minimal()

# Figure 1 is created in LaTeX!
dev.copy2pdf(file = "fig2.pdf", width = 8, height = 6)

# Run the ANCOVA model
ancova1 <- lm(Y ~ treatment + xcov)
summary(ancova1)

# Just check this out - we could do it during lectures, too
# First estimate the mean, and then use a Y centered around it
# The mean is calculated in the slides, or can be taken from
# the restricted regression, see below
# zint <- 33.8
# lm(formula = I(Y - zint) ~ 0 + treatment + xcov)

# Plot the data using the grand mean, add regression lines
# We need this package to put some math symbols in the graph
library(latex2exp)

ggplot(data=stores,aes(x=xcov,y=Y,col=treatment)) + 
  geom_point(size=6) + geom_abline(aes(slope = ancova1$coefficients[4],intercept = ancova1$coefficients[1])) + 
  geom_abline(aes(slope = ancova1$coefficients[4],intercept = ancova1$coefficients[1]+ancova1$coefficients[2])) + 
  geom_abline(aes(slope = ancova1$coefficients[4],intercept = ancova1$coefficients[1]+ancova1$coefficients[3])) +
  xlab(TeX('$X - \\bar{X}_{\\cdot\\cdot}$')) + ylab(TeX('Y')) + 
  geom_vline(xintercept = 0, lty = 2) + 
  theme_minimal()

dev.copy2pdf(file = "fig3.pdf", width = 8, height = 6)

# Create a dataframe to hold fitted values and residuals by treatment
ancova1.df <- data.frame(Fitted = fitted(ancova1), 
                         Residuals = resid(ancova1), 
                         Treatment = treatment)

# Plot residuals vs treatments
ggplot(ancova1.df, 
       aes(x = Residuals, 
           y = Treatment, 
           color=treatment)) + 
  geom_point(size = 6) + 
  theme_minimal()

dev.copy2pdf(file = "fig4.pdf", width = 8, height = 6)

# Make normal plot of residuals
ggplot(data = ancova1.df, aes(sample = Residuals)) + 
  stat_qq_line(size = 1.2, color = "darkgreen") +
  stat_qq(size=6,color="red", alpha = 0.5) + 
  theme_minimal()

dev.copy2pdf(file = "fig5.pdf", width = 8, height = 6)

# Run the Jarque-Bera normality test
library(moments)
jarque.test(ancova1.df$Residuals)

# Run the restricted model
ancova1r <- lm(Y ~ xcov)
summary(ancova1r)

# Run ANOVA of the restricted model
rr <- anova(ancova1r)
rr

ur <- anova(ancova1)
ur

Fstat <- (rr$`Sum Sq`[2] - ur$`Sum Sq`[3])/ur$`Sum Sq`[3]/(rr$Df[2]/ur$Df[3] - 1)

p_value_Fstat <- 1 - pf(Fstat, 2, 11)

vcov(ancova1)

S <- sqrt(2*qf(0.95, 2, 11))

# Include interaction terms
ancova2 <- lm(Y ~ treatment*xcov)
summary(ancova2)
