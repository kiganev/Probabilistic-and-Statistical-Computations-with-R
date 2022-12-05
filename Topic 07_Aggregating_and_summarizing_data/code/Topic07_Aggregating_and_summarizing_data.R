# Clear workspace
rm(list = ls())

# Get location of current script
fileloc <- dirname(rstudioapi::getSourceEditorContext()$path)

# Set working directory to script location
setwd(fileloc)

rm(fileloc)

# Read data
residential <- read.csv2("residential.csv", header = TRUE,
                         skip = 4, blank.lines.skip = TRUE,
                         na.strings = "-")

str(residential)

summary(residential)

names(residential)

z <- c(1,2,3, NA, 5)

max(z)

max(z, na.rm = T)
min(z, na.rm = T)

length(z)
na.omit(z)
mode(na.omit(z))
length(na.omit(z))

z1 <- c(1:100)

mean(z1)
mean(z, na.rm = T)

var(z1, na.rm = T)
sd(z1, na.rm = T)

z2 <- c(1,2,3,4)
mean(z2)
var(z2)

mad(z1)

quantile(z1)

quantile(z, probs = c(0.33, 0.66, 0.99),
         na.rm = T, names = T)

s1 <- c(1:10)
cumsum(s1)

cumprod(s1)
plot(cumprod(s1), type = "l")

m1 <- matrix(1:24, nrow = 4)
m1

mean(m1)
max(m1)

mean(m1[3,])
mean(m1[,2])

coin <- sample(c("H", "T"), 100000000, replace = TRUE)
table2 <- table(coin)
table2

gender <- sample(c("Male", "Female"), 210, replace = TRUE)
hair_col <- sample(c("Black", "Brown", "Blond"), 210, replace = TRUE)

data1 <- as.data.frame(cbind(gender, hair_col))
table1 <- table(data1$gender, data1$hair_col)
table1

seq(120,160, by = 0.5)

degree <- sample(c("BSc", "MSc", "PhD"), 20, 
                 replace = TRUE)
productivity <- sample(c("high", "medium", "low"), 
                       20, replace = TRUE)
salary <- sample(seq(120,160, by = 0.5), 
                 20, replace = TRUE)

df1 <- as.data.frame(cbind(degree, productivity, salary))
df1$salary <- as.numeric(as.character(df1$salary))

table(df1)
ftable(df1)

table1

ft1 <- ftable(df1)

library(openxlsx)
write.xlsx(ft1, "ft1.xlsx")

table1
prop.table(table1)
prop.table(table1, margin = 1)
prop.table(table1, margin = 2)

salary2 <- sample(seq(2500,3500, by = 0.01), 20, replace = TRUE)

df2 <- as.data.frame(cbind(productivity, salary2))

df2$salary2 <- as.numeric(df2$salary2)

prop.table(table(df2))


