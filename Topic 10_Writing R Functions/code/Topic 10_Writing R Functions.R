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

rm(fileloc)

env1 <- new.env()
env1[["v1"]] <- c(1,2,3)
env1$v1 <- c(1,2,3)

env1$v1

ls()
ls(envir = env1)

env1 <- as.list(env1)
env1 <- as.environment(env1)

env1$v1

# Functions
sd

body(rnorm)
formals(rnorm)
environment(mean)

body(sum)
environment(sin)

sin(5)

cyl_vol <- function(r,h){
  return(pi*r^2*h)
  }

cyl_vol(6,25)

root_cplx <- function(x, root = 2){
  x <- as.complex(x)
  x^(1/root)
}

root_cplx(-25,5)

root_cplx(-2,4) # or:
root_cplx(-2, root = 4) # or:
root_cplx(root = 4, -2)
root_cplx(4, -2)

x <- rnorm(100)
y <- rnorm(100)
plot(x,y, type = "p", col = "red")


mean(x)
sd(x)

standardize <- function(x, m = mean(x), s = sd(x)){
  if(sd(x) == 0){
    cat("The variable you are trying to standardize is a constant.")
  } else {
    (x - m) / s
  }
}

x <- rnorm(10000, mean = 3, sd = 5)
y <- standardize(x)
mean(y)
sd(y)

z <- rep(5, 1000)

w <- standardize(z)

ux <- unique(x)
which.max(tabulate(match(x, ux)))

Mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

Mode(x)
tabulate(match(var1, ux))

var1 <- c(1, 3, 4, 5, 5, 6, 7.5, 9, 9)

library(modeest)
mlv(var1, method = "mfv")

save(cyl_vol, file = "volume.R")
rm(cyl_vol)
load("volume.R")
