rm(list = ls())

# Get location of current script
fileloc <- dirname(rstudioapi::getSourceEditorContext()$path)

# Set working directory to script location
setwd(fileloc)

rm(fileloc)

x <- rnorm(1)

# if only
if(x <= 0){
  y <- 10
}

# if - else
if (x <= 0){
  y <- 1 + 3i
} else {
  y <- -10
}

x <- 2.5

# if - else if - else
if (x <= 0){
  y <- 10
  } else if (x > 0 && x <=3){
      y <- 15
      } else {
        y <- 20
      }

rbinom(10, 1, 0.5)

# ifelse, vectorized
coin_toss <- ifelse(rbinom(10000000, 1, 0.5), "Heads", "Tails")
coin_toss

table(coin_toss)

# Negation
if (!(x > 10)){
  z <- 300
}

# for loops
x <- c(1,3,5,7,9,11)

for (i in x){
	print(i%%3)
}  

LETTERS
letters

length(LETTERS)

# Another example on for loops: join capital letters and corresponding indices:
vec1 <- character(length(LETTERS))
vec1

for (i in 1:length(LETTERS)){
  vec1[i] <- paste0(LETTERS[i], i)
}

vec1

# Nested for loop
# Create a 3D array, 5 by 10 by 15
# Each element is a product of dimension indices
array1 <- array(dim = c(5,10,15))
for (i in 1:dim(array1)[1]){
  for (j in 1:dim(array1)[2]){
    for (k in 1:dim(array1)[3]){
      array1[i,j,k] <- i*j*k
    }
  }
}

array1

# while loops
x <- 0

while (x <= 3) {
  z <- rnorm(1)
  x <- x + z
}

x <- 10
while(x > 0){
  print(x)
}

uname <- character()
while (length(uname) == 0){
  cat("Please enter your user name:")
  uname <- scan(what=character(),nmax=1,quiet=F)
  if(length(uname) != 0){
    cat("Hello", uname)
  }
}
  
# break: Find the largest integer that divides another integer
int1 <- 58463251456L
int2 <- int1
div_by <- 19537L

while (int1 > 0)  {
  if (int1%%div_by == 0)  {
    print(paste0("The largest integer between 0 and ", int2,
                 " divisible by ", div_by, " is ", int1, "."))
    break
  }
  int1 = int1 - 1
}

# next: Get all odd integers between 1 and 100 in a vector
vec_odd <- integer()

for (i in c(1:100)){
  if((i%%2 == 0)){ # || i%%4 == 0)){
    next  
  }
  vec_odd <- c(vec_odd,i)
}

vec_odd

# repeat
uname <- character()
repeat{
  cat("Enter your username:")
  uname <- scan(what=character(),nmax=1,quiet=TRUE)
  if(length(uname) != 0){
    print(paste0("Welcome ", uname, "!"))
    break
    }
  }

################
# apply family #
################

# apply
m1 <- matrix(1:100, nrow = 10)
m1

apply(m1, MARGIN = 1, mean)
apply(m1, MARGIN = 2, sum)
apply(m1, MARGIN = c(1,2), sqrt)

# lapply
object1 <- list(arr1 = array(rnorm(1000),dim = c(10,10,10)), 
                vect1 = rnorm(10), 
                mat1 = matrix(rnorm(100), nrow = 10))

lapply(object1, sum)

# sapply
sapply(object1, sum)

# vapply
as.complex(-10:10)
vapply(as.complex(-10:10), sqrt, 1i) # outputs complex numbers
vapply(1:10, log, 1) # outputs floating point numbers

# mapply
mapply(rep,5:1,1:5) # Equivalent to mapply(rep,x = 5:1,times = 1:5)

# rapply
res1 <- rapply(object1, mean)
rapply(object1, mean, how = "unlist")
rapply(object1, mean, how = "list")

object2 <- list(a1 = c(1:100), b1 = c(101:200), char1 = "Text")
rapply(object2, log , classes = "integer", how = "replace")
object2

# tapply
m1 <- matrix(1:9, 3, 3)
idx1 <- matrix(c(1,2,1,3,2,2,1,2,3), 3, 3)
tapply(m1, idx1, sum)

# figire out this
x <- 1:10
idx2 <- rep(c('A1', 'A2', 'A3'), length = 10)
idx2
idx3 <- rep(c('B1', 'B2' ,'B3', 'B4'), length = 10)
idx3
idx4 <- rep(c('C1','C2','C3','C4', 'C5'), length = 10)
idx5

tapply(x, list(idx2, idx3, idx4), mean, na.rm = TRUE)

zzz <- tapply(x, list(idx2, idx3), function(x) x*1)
zzz <- tapply(x, list(idx2, idx3), mean)
zzz

v1 <- tapply(x, idx2, function(x) x*1)
v2 <- tapply(x, idx3, function(x) x*1)
v3 <- tapply(x, idx4, function(x) x*1)
tapply(x, idx4, mean, na.rm = TRUE)

v1a <- v1$A1
v1b <- v2$B1
v1c <- v3$C1

all <- c(v1a,v1b,v1c)
mean(all)

# split
# Generate first a random integer vector of the same length of x
y <- sample(1:100, length(x))
y

f1 <- character(length(y))

# Create a factor variable: A for even, B for odd
for (i in 1:length(y)){
  if (y[i]%%2 == 0){
    f1[i] <- "A"
  } else {
    f1[i] <- "B"
  }
}

f1

sapply(split(y, f1), mean)

# sweep
mat1 <- matrix(1:12, nrow = 3)
mat1
sweep(mat1, 2, colMeans(mat1), "-") # remove column means from elements
sweep(mat1, 2, colSums(mat1), "/") # divide each element by the column sum

arr1 = array(1:18, dim = c(3,3,2))
sweep(arr1, 1, apply(arr1, 1, mean)) # sweeps out the row means from each element
sweep(arr1, 2, apply(arr1, 2, mean)) # sweeps out the column means

