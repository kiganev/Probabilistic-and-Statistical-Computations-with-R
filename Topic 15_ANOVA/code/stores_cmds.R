# Clear wortkspace
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

# Remove fileloc string
rm(fileloc)

avgbuy <- read.csv("three_stores.csv")
attach(avgbuy)
colMeans(avgbuy) # Means per store
mean(unlist(avgbuy)) # Grand mean for all stores

# Visualize means via boxplots
boxplot(avgbuy, col = c("red","green","blue"))

library(ggplot2)
library(reshape2)

avgbuy$id <- seq.int(nrow(avgbuy))

avgbuy1 <- melt(avgbuy, id = "id")

names(avgbuy1)[2:3] <- c("Store", "Purchase_value")

ggplot(data = avgbuy1, aes(x = Store)) + 
  geom_boxplot(aes(y = Purchase_value, fill = Store)) + 
  xlab("") + 
  ylab("") + 
  theme_minimal() +
  theme(legend.position = "bottom")

dev.copy2pdf(file = "fig1.pdf", width = 8, height = 6)

avgbuys <- stack(avgbuy[1:3])
names(avgbuys)

myanova <- aov(values ~ ind, data = avgbuys)
myanova
smr_anova <- summary(myanova)
smr_anova

189.19/14.27

1 - pf(13.25560813, 2, 15)

# Second example
mresponse <- c(rep(9,2), rep(11,2), rep(16,2))
gender <- rep(c("Male", "Female"), 3)
age <- c(rep("Young",2),rep("Middle",2), rep("Old",2))
data1 <- as.data.frame(cbind(mresponse, gender, age), stringsAsFactors = F)
data1$mresponse <- as.numeric(data1$mresponse)
data1

with(data1, {interaction.plot(gender, age, mresponse, 
                 type="b", 
                 col=c(1:3),
                 leg.bty="o", 
                 leg.bg="beige", 
                 lwd=2, 
                 pch=c(18,24,22),
                 xlab="Gender",
                 ylab="Age",
                 main="Interaction Plot")}
)

# Factor levels need to be reordered before creating the graph,
# so they appear in legend in natural order
data1$age <- factor(data1$age, levels = c("Young", "Middle", "Old"))

ggplot(data1,  aes(x = gender, y = mresponse, group = age, colour = age)) +
  geom_point(size = 6) + 
  geom_line(size = 2) +
  theme_minimal()

dev.copy2pdf(file = "fig2.pdf", width = 8, height = 6)

mresponse2 <- c(11,7,13,9,18,14)

data2 <- as.data.frame(cbind(mresponse2, gender, age), stringsAsFactors = F)

data2$mresponse2 <- as.numeric(data2$mresponse2)
data2$gender <- factor(data2$gender, levels = c("Male", "Female"))
data2$age <- factor(data2$age, levels = c("Young", "Middle", "Old"))

ggplot(data = data2, aes(x = age, y = mresponse2, group = gender, colour = gender)) +
  geom_point(size = 6) + geom_line(size = 2) + 
  theme_minimal()

dev.copy2pdf(file = "fig3.pdf", width = 8, height = 6)

ggplot(data = data2, aes(x = gender, y = mresponse2, group = age, colour = age)) +
  geom_point(size = 6) + geom_line(size = 2) +
  theme_minimal()

dev.copy2pdf(file = "fig4.pdf", width = 8, height = 6)



