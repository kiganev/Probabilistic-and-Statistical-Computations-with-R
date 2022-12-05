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
rm(fileloc, check_dev)

x <- 1000*runif(50)
y <- 2 + 0.8*x + rnorm(50, mean = 0, sd = 75)

plot(x,y)

df1 <- as.data.frame(cbind(x,y))

colnames(df1) <- c("inc", "cons")

plot(df1$inc, df1$cons)

attach(df1)

plot(inc, cons)

plot(inc, cons, 
     xlab = "Aggregate income", 
     ylab = "Aggregate consumption",
     main = "Some macroeconomic aggregates")

plot(inc, cons,
     xlab = "Aggregate income", 
     ylab = "Aggregate consumption",
     main = "Some macroeconomic aggregates", 
     xlim = c(0,2000), 
     ylim = c(0, 2000))

plot(df1$inc, df1$cons, 
     xlab = "Aggregate income",
     ylab = "Aggregate consumption",
     main = "Some macroeconomic aggregates",
     pch = 23, cex = 1, bg = "yellow", col = "red")

saved_par <- par()

par(
  bg = "lightgray", # background of chart
  bty = "l", # box type around chart
  cex = 1.5, # magnification of symbols
  cex.axis = 0.4, # magnification of axis symbols relative to cex
  cex.lab = 0.5, # magnification of labels relative to cex
  cex.main = 0.67, # magnification of main title relative to cex
  col = "darkorange", # colour of symbols
  col.axis = "blue", # colour of axes symbols
  col.lab = "blue", # colour of axis labels
  col.main = "darkgreen",
  family = "serif",
  fig = saved_par$fig,
  fin = saved_par$fin,
  mar = c(4,4,2,2),
  oma = saved_par$oma,
  omi = saved_par$omi,
  pch = 20 # symbol for plotting
)

plot(inc, cons, 
     xlab = "Aggregate income", 
     ylab = "Aggregate consumption",
     main = "Some macroeconomic aggregates")

par(saved_par)

f1 <- factor(sample(c(1:3),length(x),replace = T))
df1$country <- f1

plot(inc, cons, 
     xlab = "Aggregate income", 
     ylab = "Aggregate consumption",
     main = "Some macroeconomic aggregates",
     col = df1$country, pch = 20, cex = 2)

plot(inc, cons, type = "l")

plot(inc, type = "l", lty = 0,
     ylab = "BGN", main = "Income and consumption",
     ylim = c(-200, 1000))
lines(inc, type = "l", lty = "solid", 
      lwd = 2, col = "red")
lines(cons, type = "l", lty = 6, 
      lwd = 2, col = "blue")
legend(35,970, c("Income","Consumption"), 
       lty=c(1,6), lwd=c(2,2), col=c("red","blue"))

fun1 <- function(x){
	3*x^3 + 2*x^2 - 7*x + 11
	}

curve(fun1, -10, 10, lwd = 2, col = "red")
abline(h = 0, lty = 2)
abline(v = 0, lty = 2)

fun2 <- function(x){
  1000*cos(x)
}

curve(fun2, -10, 10, add = T, lwd = 2, col = "blue")

# Pie charts
pie_data <- c(19,24,28,17,35)
pie_labels <- c("Apples", "Pears", "Cherries", "Oranges", "Bananas")

pie(pie_data, pie_labels, col = rainbow(length(pie_data)),
    main = "Fruit consumption")

library(plotrix)
pie3D(pie_data, labels = pie_labels, explode = 0.1,
      radius = 0.8,
      main = "Fruit consumption in 3D", 
      labelcex = 1, labelcol = "blue")

# Bar plots
barplot(inc, border = "darkgreen",
        col = "orange", xlab = "Index", ylab = "BGN", 
        main = "Income levels")

barplot(inc, horiz = T, border = "darkgreen",
        col = "orange", ylab = "Index", xlab = "BGN", 
        main = "Income levels")

bar_data1 <- sample(30:50, 3)
bar_data2 <- sample(30:40, 3)

barplot(cbind(bar_data1,bar_data2), 
        col = c("darkred", "darkorange", "yellow"),
        names.arg = c("My variable", "Your variable"))

barplot(cbind(bar_data1,bar_data2), 
        col = c("darkred", "darkorange", "yellow"),
        names.arg = c("My variable", "Your variable"), 
        beside = T)

# Histograms
z <- rnorm(500)
hist(z, border = "darkblue", 
     col = "orange", breaks = 23, freq = T)
hist(z, border = "darkblue", 
     col = "darkgreen", density = 40, 
     breaks = 20, freq = F)

# Box plots
boxplot(inc, col = "#D85625") # uses an HTML colour

avgbuy <- read.csv("three_stores.csv")
boxplot(avgbuy, col = c("red","green","blue"))

# Pairs plots
data() # Gives you the list of all built-in datasets

iris_df <- as.data.frame(iris)

pairs(iris_df[,1:4], col = iris_df[,5])

# 3D
dome <- function(x,y){
  -(x^2 + y^2)
}
x <- seq(from=-3, to = 3, by=0.1)
y <- seq(from=-3, to = 3, by=0.1)
z <- outer(x,y,dome)
persp(x,y,z,col="blue",theta=70,phi=-20)

# Multiple
par(mfrow = c(2,2))
plot(rnorm(100), type = "p")
plot(rnorm(100), type = "l")
plot(rnorm(100), type = "s")
plot(rnorm(100), type = "b")

pos_m <- matrix(c(1,1,2,3), nrow = 2)
layout(pos_m)
plot(rnorm(100), type = "p")
plot(rnorm(100), type = "l")
plot(rnorm(100), type = "s")

par(mfrow = c(1,1))

plot(rnorm(100))

# Export and save
png("linegr1.png", height=600, width=800)
plot(rnorm(100), type = "l")
dev.off()

plot(rnorm(1000), type = "l", col = "red", 
     main = "Gaussian white noise")
dev.copy2pdf(file = "wn.pdf", height=6, width=8)
dev.copy2eps(file = "wn.eps", height=6, width=8)

###########
# lattice #
###########
library(lattice)
xyplot(cons ~ inc, data = df1)
df1$index <- c(1:length(df1$cons))
xyplot(cons ~ index, data = df1, 
       type="o", lty = 2, pch=24,
       main="Consumption")
barchart(cons ~ index, 
         horizontal = FALSE, 
         data = df1, 
         main="Consumption", 
         col = "darkred")

rnd1 <- rnorm(1000)
bwplot(rnd1, col = "red", fill = "green")

histogram(rnd1, col = "orange")
densityplot(rnd1, lwd = 3)

rnd1[758]
rnd1[758] <- 55

qqmath(rnd1)

###########
# ggplot2 #
###########
library(ggplot2)
qplot(cons, inc, data = df1, 
      main = "Consumption vs. income")
idx5 <- c(1:length(df1$cons))
qplot(x = idx5, y = cons, 
      geom = "line", 
      data = df1, main = "Consumption", xlab = "Index")

dev.copy2pdf(file = "zz.pdf", height=6, width=8)

gg_graph1 <- ggplot(data = df1)
gg_graph1
gg_graph1 <- gg_graph1 + 
  geom_point(aes(x = inc, y = cons), 
             size = 6, 
             colour = "red",
             alpha = 0.2)
gg_graph1

dev.copy2pdf(file = "inc_cons.pdf", height=6, width=8)

gg_hist <- ggplot(iris_df)
gg_hist
gg_hist <- gg_hist + 
  geom_histogram(aes(x = Petal.Length, color=Species,
                     fill=Species), alpha=0.2)
gg_hist

gg_dens <- ggplot(iris_df)
gg_dens
gg_dens <- gg_dens + 
  geom_density(aes(x = Petal.Length, color=Species, fill=Species),
               alpha=I(0.5))
gg_dens

dev.copy2pdf(file = "density_iris.pdf", height=6, width=8)

gg_box <- ggplot(iris_df)
gg_box <- gg_box + 
  geom_boxplot(aes(x = Species, y = Petal.Length, fill=Species),
               alpha=I(0.5))
gg_box

gg_points <- ggplot(df1)
gg_points <- gg_points + 
  geom_point(aes(x = inc, y = cons, color = country, fill=country),
                                    size = I(6), alpha=I(0.5))
gg_points <- gg_points + 
  scale_x_continuous(name="Household income (EUR)") + 
  scale_y_continuous(name="Household consumption (EUR)") 

gg_points

gg_points <- gg_points +  
  scale_colour_manual(values = c("orange","darkblue", "darkgreen")) 

gg_points

gg_points <- gg_points + 
  stat_smooth(aes(x = inc, y = cons), 
              method=lm, formula = y ~ poly(x,2), level=0.95)

gg_points

gg_facets <- ggplot(df1)
gg_facets <- gg_facets + 
  geom_point(aes(x=inc, y=cons), colour = "red", size = I(3))
gg_facets
gg_facets <- gg_facets + 
  facet_wrap(~ country, nrow=3)
gg_facets

gg_dens
gg_dens + theme_bw()
gg_dens + theme_dark()
gg_dens + theme_get()
gg_dens + theme_classic()
gg_dens + theme_gray()
gg_dens + theme_light()
gg_dens + theme_linedraw()
gg_dens + theme_minimal()
gg_dens + theme_replace()
gg_dens + theme_void()

gg2 <- ggplot(iris_df)
gg2
gg2 <- gg2 + 
  geom_point(aes(x = Sepal.Width, y = Sepal.Length)) +
        geom_text(aes(x = Sepal.Width, y = Sepal.Length, 
                      label = Species, color = Species))
gg2

gg2 <- gg2 + 
  geom_point(aes(x = Sepal.Width, y = Sepal.Length)) +
  geom_label(aes(x = Sepal.Width, y = Sepal.Length, 
                 label = Species, color = Species))

gg2

gg3 <- ggplot(df1)
gg3 <- gg3 + 
  geom_point(aes(x = inc, y = cons), size = 6, colour = "red")
gg3
gg3 <- gg3 + 
  annotate("text", x = 130, y = 700, 
           label = "A text annotation", size = 6, color = "blue")
gg3

gg3 <- gg3 + 
  annotate("rect", xmin = 100, xmax =  300, 
           ymin = 0, ymax = 300, alpha = 0.2)
gg3

gg3 <- gg3 + 
  annotate("segment",
           x = 600, xend =  900, y = 800, yend = 0, 
           color = "darkgreen")
gg3



