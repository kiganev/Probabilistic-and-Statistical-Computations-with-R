rm(list = ls())

# Get location of current script
fileloc <- dirname(rstudioapi::getSourceEditorContext()$path)

# Set working directory to script location
setwd(fileloc)

# Remove fileloc string
rm(fileloc)

# Set locale
Sys.setlocale("LC_ALL","English")

# Create a matrix
A <- matrix(1:12, nrow = 3)
A

# Another one
B <- matrix(13:24, nrow = 3)

# Addition and subtraction
C <- A + B
C
D <- A - B	
D

# Transposition
E <- t(A)
A
E


# Scalar multiplication
F <- 5 * A
A
F

# Matrix multiplication:
G <- A %*% E
G

crossprod(A, B)

# Diagonal matrix:
D <- diag(c(1,2,3))
D
I <- diag(7)
I

library(psych)
tr(I)

# Determinant
det(G)
G

W <- matrix(c(7, 15, 6, 8, 9, 12, 6, 10, 3), 
            nrow = 3, byrow =  T)
det(W)

# Inverse
A <- matrix(rnorm(9), nrow = 3)
A
solve(A)

# Solve systems n x n
A <- matrix(c(1.5, 7.1, 2.2, 3.3, 9.5, 6.8, 1.9, 5.4, 8.2), nrow = 3)
A
det(A)
b <- c(1.8, 2.1, 3.0)
b
x <- solve(A, b)
x

b1 <- c(0,0,0)
x <- solve(A, b1)
x

# Dot product
a <- c(1,2,3)
b <- c(2,3,9)

dotp <- t(a) %*% b	
dotp

library(Matrix)
E
rankMatrix(E)

# Eigenvalues and eigenvectors
A1 <- matrix(c(6,5,3,8), nrow = 2)
A1

eigen(A1)$values
eigen(A1)$vectors

A <- matrix(c(0,1/2,0,0,0,1/3,6,0,0), nrow = 3)
A
eigval <- eigen(A)$values
eigvect <- eigen(A)$vectors

eigval
eigvect




z <- -6*eigvect/eigvect[1,1]
z

Y <- matrix(1:4, nrow = 2)
eigen(Y)$values

(5 - sqrt(33))/2

# Diagonalization
A <- matrix(1:9, nrow = 3)
A
P <- eigen(A)$vectors
P
LAMBDA <- diag(eigen(A)$values)
LAMBDA

P %*% LAMBDA %*% solve(P)

