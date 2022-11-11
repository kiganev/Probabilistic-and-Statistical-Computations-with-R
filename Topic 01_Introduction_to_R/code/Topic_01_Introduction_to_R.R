# Clear workspace
rm(list = ls())

# Clear plots
check_dev <- dev.list()
if(!is.null(check_dev)){
  dev.off(dev.list()["RStudioGD"])  
}

# Get working directory
getwd()

# Get location of current script
fileloc <- dirname(rstudioapi::getSourceEditorContext()$path)

# Set working directory to script location
setwd(fileloc)

# List contents (files) of current working directory
dir()

rm(fileloc)

# Assignment
x1 <- 10 # numeric
x2 <- 5L # integer
x3 <- 6 + 2i # complex
y <- FALSE # logical
na <- NA # logical
z <- "Hello World!" # character

z1 <- rnorm(625)
z2 <- matrix(z1, nrow = 25)
z2
attributes(z2)

# Mode and class
mode(z2)
class(z2)

# Logical type check
is.numeric(z2)

# Coercion
as.numeric(FALSE) # Try also with TRUE
as.character(102)
as.integer(105.88)
as.complex(3.14)
as.numeric("458")
as.numeric("Cinema")
as.numeric("This is text.")
as.logical("NA")
as.numeric("NA")
as.numeric("FALSE")

# List workspace elements
ls()

# Change some options
options(digits = 4)

# Vectors
x1 <- c(1, 2, 3, 4)
x2 <- seq(from = 1, to=100, by=1)
x3 <- seq(from = 2, to = 3, by = 0.01)
y <- c("One", "Two", 3)
z <- c(TRUE, FALSE, T, F)

# Logical check whether something is a vector
is.vector(x3)
is.vector(150)
is.vector("text")

x3

# Automatic coercion in vectors
y1 <- c(1.02, 3 + 0.5i) # Check out the next line, too
y2 <- c(1.02, 3 + 0.5i, "text")

# Naming vectors
lunch_costs <- c(3.30, 5.91, 2.75)  
names(lunch_costs) <- c("Soup", "Main course", "Dessert")
print(lunch_costs)
str(lunch_costs)
attributes(lunch_costs)

# Empty vectors
em1 <- vector("numeric")
em2 <- vector("character")
em3 <- vector("logical")

nem1 <- vector("numeric", length = 20)
nem1

em1a <- numeric()
em2a <- character()
em3a <- logical()

# Calculations with vectors
v1 <- c(1,2,3)
v2 <- c(4,5,6)
v1 + 3.5
v1 * 2
v1 / 3
v1 - v2
v1 * v2
v1 ^ v2

# Recycling
v3 <- c(7,8,9,10)
v4 <- v1 + v3
v5 <- v1 * v3

# If you need to find the sum of all elements in a vector:
total_lunch <- sum(lunch_costs)
total_lunch

# Compare with another vector:
lunch_costs_alt <- c(3.10, 6.25, 2.90)
lunch_costs > lunch_costs_alt

# Vector subsets:
lunch_costs[2]
lunch_costs["Main course"]
lunch_costs[c(1,3)]
lunch_costs[-2]
lunch_costs[c("Soup","Dessert")]
lunch_costs[c(TRUE, FALSE, TRUE)]
lunch_costs[1:2]

# Factors
hair_col <- c("black", "brown", "black", "blond", "red", "brown", "black")
hair_col_f <- factor(hair_col)
hair_col_f

temp <- c("freezing", "warm", "hot", "cold", "warm", "freezing")
temp_f <- factor(temp,
                 ordered = TRUE, 
                 levels = c("freezing", "cold", "warm", "hot"))
temp_f
temp_f[2] < temp_f[4] # Comparison possible
temp_f <- factor(temp, ordered = TRUE, 
                 levels = c("freezing", "cold", "warm", "hot"),
                 labels = c("very cold", "cold", "warm", "hot")) # labels changed here
temp_f

# Create matrix
emat1 <- matrix(numeric()) # Empty matrix
emat1

m1 <- matrix(1:12, nrow = 3) # or,
m1 <- matrix(1:12, ncol = 4) 
m1
m2 <- matrix(1:12, ncol = 4, byrow = TRUE)
m2
m3 <- cbind(lunch_costs, lunch_costs_alt)
m3

colnames(m3) <- c("Costs, restaurant 1", "Costs, restaurant 2")
rownames(m3) <- c("Soup", "Main course", "Dessert")
m3

sum(m3)

m3a <- rbind(m3, colSums(m3))
m3a
rownames(m3a)[4] <- "Total"
m3a

# Subsets of matrices
m3a[,1]
m3a[2,]
m3a[c(1,3),1]
m3a[4,2]
m3a["Soup", "Costs, restaurant 2"]
m3a[c(T, F, F, F), c(T,F)]

m1

# Math with matrices
m1 + 5
m1 * 3
m1 %% 3
m1^2

m1 + m2 
m1 / m2
m1 %% m2
m1^m2

m1
m2

# True matrix algebra
t(m1)
t(m1) %*% m2
crossprod(m1,m2)

m4 <- matrix(1:4, nrow = 2)

m4

solve(m4)

eig <- eigen(m4)
eig$val
eig$vec

# Arrays
array1 <- array(1:343, dim = c(7,7,7))
array1

array1[2,3,4]

# Lists
list1 <- list(TRUE, "France", 21)
list1

names(list1) <- c("Active", "Country", "Age")
list1

list2 <- list(Appearances = c(T,F,T,T,T), Attributes = list1)
list2

list3 <- list2[1]
list3
is.list(list3)

vec1 <- list2[[1]]
vec1
is.vector(vec1)

vec2 <- list2$Appearances
vec2
is.vector(vec2)

list2[[1]][1]
list2$Appearances[1]

list2["Attributes"]
list1[c(FALSE,TRUE,FALSE)]

teams <- c("Real Madrid", "Barcelona", "Valencia")
list2$clubs <- teams
list2
str(list2)

# Data frames
m4df <- matrix(1:9, nrow = 3)
m4df
df1 <- as.data.frame(m4df)
df1

names(df1)[1] <- "Price"

names(df1) <- c("One", "Two", "Three")
df1
str(df1)

df1$Four <- c(10,11,12)
df1

totals0 <- as.character(c(6,15,24,33))
names(totals0) <- c("One", "Two", "Three", "Four")

totals1 <- list(6,15,24,"33")

aaa <- rbind(df1, totals0)

bbb <- rbind(df1, totals1)


totals <- data.frame(matrix(c(6,15,24,33), nrow = 1, ncol = 4))
totals

names(totals) <- c("One", "Two", "Three", "Four")
df2 <- rbind(df1, totals)
df2

