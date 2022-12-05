# Clear wortkspace
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

# Load packages
library(eurostat)
library(tidyverse)
library(xts)
library(openxlsx)

# Look for all datasets containing "GDP"
search1 <- search_eurostat("GDP", type = "dataset")

# Get data on quarterly GDP and its components
data_gdpq <- get_eurostat("namq_10_gdp", 
                          time_format = "date")

# Filter data on Bulgarian GDP and consumption only; 
# use values at 2010 prices, NSA
data_gdpq_bg <- data_gdpq %>%
  filter(geo == "BG", 
         unit == "CLV10_MEUR",
         s_adj == "NSA",
         na_item %in% c("B1GQ", "P3", "P5G",
                        "P6", "P7")) %>%
  select(time, values, na_item) %>%
  spread(na_item, values) %>%
  mutate(time = as.yearqtr(time))

# Create xts object
xts1 <- xts(data_gdpq_bg[,2:6],
            order.by = data_gdpq_bg$time)

# Make scatterplot
gg1 <- ggplot(xts1) + 
  geom_point(aes(x = log(B1GQ), y = log(P3)),
             size = 4, colour = "blue", alpha = 0.5) + 
  theme_bw()

gg1

# Run simple linear regression
lm1 <- lm(log(P3) ~ log(B1GQ), 
          data = xts1["2000-01/2020-12"])
xts1["2000-01/2020-12"]

class(lm1)
mode(lm1)

write.xlsx(xts1, "xts1.xlsx")

# See regression output
print(lm1)
summary(lm1)

lm1$coefficients # or:
coef(lm1)

# Plot data and regression line
plot(log(data_gdpq_bg$B1GQ),log(data_gdpq_bg$P3))

abline(lm1)

gg1 <- gg1 + 
  geom_abline(intercept = lm1$coef[1], 
              slope = lm1$coef[2],
              size = 1.2,
              colour = "red")
gg1

# Access fitted values
lm1$fitted # or
fitted(lm1)

# Merge fitted values to xts object
xts1$P3_fitted <- c(rep(NA,
                        length(xts1[,2])-length(lm1$fitted)-6),
                    exp(lm1$fitted), rep(NA, 6))

# Plot actual and fitted consumption
gg2 <- ggplot(xts1["2000/2020"], aes(x = Index)) + 
  scale_x_continuous() + 
  geom_line(aes(y = P3, color = "Consumption")) + 
  geom_line(aes(y = P3_fitted, color = "Fitted"), lty = 2) + 
  xlab("") + 
  ylab("") + 
  scale_color_manual("", values = c("red", "darkgreen")) +
  ggtitle("Actual and Fitted Consumption") + 
  theme_minimal() + 
  theme(legend.position = "bottom")
  
gg2

# Access residuals
lm1$residuals # or:
resid(lm1)

# Merge residual series to xts object
xts1$resids <- c(rep(NA, length(xts1[,2])-length(lm1$resid)-6),
                  lm1$resid, rep(NA, 6))

# Make a plot of residuals
gg3 <- ggplot(xts1["2000/2020"], aes(x = Index)) +
  scale_x_continuous() +
  geom_line(aes(y = resids), color = "red") + 
  xlab("") + 
  ylab("") + 
  ggtitle("Residuals") + 
  theme_minimal()

gg3

# Built-in diagnostic plots
plot(lm1)

# ANOVA
anova(lm1)

# Confidence intervals
confint(lm1, level = 0.95)

# Some other stuff
deviance(lm1)
logLik(lm1)
AIC(lm1)
BIC(lm1)

# log-likelihood
sum_sq_resid <- sum((lm1$residuals)^2)
logl1 <- -length(lm1$residuals)/2 * 
  (1 + log(2*pi) + log(sum_sq_resid/length(lm1$residuals)))

# SE of residuals
sqrt(deviance(lm1)/df.residual(lm1))
df.residual(lm1)

summary(lm1)

# R-squared
P3_smpl <- as.numeric(log(xts1$P3)["2000-01/2020-12"])

var(fitted(lm1))/var(P3_smpl)
cor(P3_smpl, fitted(lm1))**2
1 - var(resid(lm1))/var(P3_smpl)

smr_lm1 <- summary(lm1)
smr_lm1$r.squared

# Adj. R-squared
1 - (1 - var(fitted(lm1))/var(P3_smpl)) * (length(P3_smpl)-1)/df.residual(lm1)
smr_lm1$adj.r.squared

summary(lm1)

# Access coeffients, std. errors, etc.
coef(smr_lm1)[,2]
coef(smr_lm1)[2,3]

# t-stats
t1 <- coef(summary(lm1))[1,1]/coef(summary(lm1))[1,2]
t1

p1 <- 2*(1 - pt(t1, df = df.residual(lm1)))
p1

# Regression through the origin
lm1a <- lm(log(P3) ~ 0 + log(B1GQ), data = xts1["2000/2020"])
summary(lm1a)

# Regression on a constant
lm1b <- lm(log(P3) ~ 1, data = xts1["2000/2020"])
summary(lm1b)

# Predict
#------------

# Run a linear regression on a smaller sample (until 2017)
lm1c <- lm(log(P3) ~ log(B1GQ), data = xts1["2000-01/2017-12"])
summary(lm1c)

fc_lm1c <- exp(predict(lm1c, newdata = xts1["2018-01/2021-06"]))

xts1$fc_lm1c <- c(rep(NA, length(xts1$P3)-length(fc_lm1c)), fc_lm1c)

ggplot(xts1["2000/2021"], aes(x = Index)) + 
  scale_x_continuous() +
  geom_line(aes(y = P3, color = "Consumption"))  + 
  geom_line(aes(y = P3_fitted, color = "Fitted"), lty = 2)  + 
  geom_line(aes(y = fc_lm1c, color = "Forecast"), size = 1.2)  + 
  xlab("") + 
  ylab("") + 
  scale_color_manual("", values = c("red", "darkblue", "darkgreen")) +
  ggtitle("Actual, fitted, and forecast consumption") + 
  theme_minimal()

# Multivariate regression
lm2 <- lm(P7 ~ P3 + P5G + P6, data = xts1)
summary(lm2)

xts1$P7_fitted <- fitted(lm2)

ggplot(xts1["2000/2020"], aes(x = Index)) + 
  scale_x_continuous() +
  geom_line(aes(y = P7, color = "Imports"))  + 
  geom_line(aes(y = P7_fitted, color = "Fitted"), lty = 2)  + 
  xlab("") + 
  ylab("") + 
  scale_color_manual("", values = c("red", "darkblue")) +
  ggtitle("Actual and fitted imports") + 
  theme_minimal()

# Kolmogorov-Smirnov test
ks.test(xts1$resids, "pnorm", 
        mean = mean(xts1$resids, na.rm = T), 
        sd = sd(xts1$resids, na.rm = T))

ggplot(xts1["2000/2020"]) + 
  stat_ecdf(aes(x = resids), geom = "point") + 
  stat_function(fun = pnorm, 
                args = list(mean = mean(xts1$resids, na.rm = T), 
                            sd = sd(xts1$resids, na.rm = T)), 
                color = "red") + 
  xlab("") + 
  ylab("") +
  theme_minimal()

# Jarque-Bera Test
library(moments)
skewness(xts1$resids, na.rm = T)
kurtosis(xts1$resids, na.rm = T)

resids_vec <- as.vector(xts1$resids["2000/2020"])

jarque.test(resids_vec[!is.na(resids_vec)])

# Autocorrelation tests
Box.test(xts1$resids, lag = 2, type = "Box-Pierce", fitdf = 1)
Box.test(xts1$resids, lag = 2, type = "Ljung-Box", fitdf = 1)

library(lmtest)
dwtest(lm1)
bgtest(lm1, order = 4)

summary(lm1)

# Heteroskedasticity
bptest(lm1) # Breusch-Pagan
bptest(lm1, ~ log(B1GQ) + I(log(B1GQ)^2), data = xts1)

gqtest(lm1)
