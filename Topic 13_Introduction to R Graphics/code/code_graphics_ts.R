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

library(quantmod)

# Get gold price in EUR
getMetals("gold", from = "2007-01-01", to = Sys.Date(),
          base.currency="EUR")

# Get Google and Tesla stock price from Yahoo Finance
getSymbols("GOOG",src="yahoo")
getSymbols("TSLA",src="yahoo")

plot(XAUEUR$XAU.EUR, col = "red", main = "Gold price in EUR")

library(lattice)
xts1 <- GOOG[,1:2] 

xyplot(xts1, type=c("l","g"), 
       xlab="", main="Google Price")

xts2 <- merge(xts1[,1],diff.xts(log(xts1[,1])))
colnames(xts2)[2] <- "return"

xyplot(xts2, type=c("l","g"), 
       strip = strip.custom(factor.levels = c("Gold Price, USD","Percentage change")),
       main="Gold Price")

savepar <- trellis.par.get()
trellis.par.set(strip.background = list(col="#0080ff"))
xyplot(xts2, type=c("l","g"),
       strip = strip.custom(factor.levels = c("Gold Price, USD","Percentage change")),
       par.strip.text = list(col="white", font = 2),
       main="Gold Price")

dev.copy2pdf(file = "lattice_ts.pdf", width = 8, height = 6)

trellis.par.set(savepar)

library(ggplot2)

gg1 <- ggplot(data = xts2) + 
  geom_line(aes(x = Index, y = GOOG.Open), colour = "#0080ff") + 
  theme_bw() +
  ggtitle("Google open price, USD") + 
  theme(plot.title = element_text(face="bold", 
                                  colour = "red",
                                  size = 10)) +
  xlab("") +
  ylab("")
gg1

gg2 <- ggplot(xts2) +
  geom_line(aes(x = Index, y = return), colour = "#0080ff") + 
  theme_bw() +
  ggtitle("Return, %") + 
  theme(plot.title = element_text(face="bold", 
                                  colour = "red",
                                  size = 10)) +
  xlab("") +
  ylab("")
gg2

library(gridExtra)
grid.arrange(gg1, gg2, ncol=1)

dev.copy2pdf(file = "ggplot_ts.pdf", width = 8, height = 6)

# Plot two xts series together
ggplot(GOOG["2011/"], aes(x = Index)) + 
  geom_line(aes(y = GOOG.Open, col = "Google open price")) + 
  geom_line(aes(y = TSLA["2011/"]$TSLA.Open, 
                col = "Tesla open price")) + 
  scale_color_manual("", values = c("darkred", "darkblue")) + 
  xlab("") + 
  ylab("") + 
  theme_bw() + 
  theme(legend.position = "bottom") + 
  ggtitle("Stock prices, USD") +
  annotate("rect", 
           xmin = as.Date("2015-01-01"),
           xmax = as.Date("2015-12-31"),
           ymin = 0,
           ymax = max(GOOG$GOOG.Open),
           fill = "orange", alpha = I(0.2))

dev.copy2pdf(file = "ggplot_ts3.pdf", width = 10.7, height = 6)
