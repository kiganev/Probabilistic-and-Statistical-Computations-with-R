rm(list = ls())

# Get location of current script
fileloc <- dirname(rstudioapi::getSourceEditorContext()$path)

# Set working directory to script location
setwd(fileloc)

rm(fileloc)

df1 <- as.data.frame(matrix(rnorm(100000000), ncol = 100000))

library(lubridate)

means1 <- numeric(ncol(df1))

start1 <- now()
for(i in 1:ncol(df1)){
    means1[i] <- mean(df1[,i])
}
end1 <- now()

ex_time1 <- end1 - start1
ex_time1

means2 <- numeric(ncol(df1))
start2 <- now()
means2 <- sapply(df1, mean)
end2 <- now()

ex_time2 <- end2 - start2
ex_time2

cat(paste("Ratio of execution times:", as.numeric(ex_time1)/as.numeric(ex_time2)))
ex_time1 - ex_time2
