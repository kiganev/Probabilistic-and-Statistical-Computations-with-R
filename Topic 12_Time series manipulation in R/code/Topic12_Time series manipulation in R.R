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

# Set locale
Sys.setlocale("LC_ALL","English")

# Load packages
library(eurostat)
library(tidyverse)

# Look for all datasets containing "GDP"
search1 <- search_eurostat("GDP", type = "dataset")

# Get data on quarterly GDP and its components
data_gdpq <- get_eurostat("namq_10_gdp", time_format = "date")

# Filter data on Bulgarian GDP and consumption only; 
# use values at 2010 prices, NSA
data_gdpq_bg <- data_gdpq %>%
  filter(geo == "BG", 
         unit == "CLV10_MEUR",
         s_adj == "NSA",
         na_item %in% c("B1GQ", "P3")) %>%
  select(time, values, na_item) %>%
  spread(na_item, values)

# Create names for the time series from the 
# names of the variables in the data frame
names_ts <- character()

for(i in names(data_gdpq_bg)[2:3]){
  names_ts[i] <- paste0(i, ".ts")
}

names_ts

# Assign variables from dataframe to each name
for(i in 1:length(names_ts)){
  assign(names_ts[i],ts(data_gdpq_bg[[i+1]], start = c(1995,1), 
                        frequency = 4))
}

# Properties of ts objects
B1GQ.ts
P3.ts

class(B1GQ.ts)
mode(B1GQ.ts)

start(B1GQ.ts)
end(B1GQ.ts)
frequency(B1GQ.ts)

deltat(B1GQ.ts)

# Subsetting ts objects 
B1GQ_smpl.ts <- window(B1GQ.ts, start = c(2010, 1), end = c(2019, 2))
B1GQ_smpl.ts
class(B1GQ_smpl.ts)

# Create ts from data frame
mts1 <- ts(data_gdpq_bg[,2:3], start = c(1995, 1), frequency = 4)
mts1

class(mts1)

# Combine individual ts
ts_comb1 <- cbind(B1GQ.ts, P3.ts)
ts_comb2 <- ts.union(B1GQ.ts, P3.ts)

class(ts_comb1)
class(ts_comb2)

ts_comb1

# Lags
B1GQ_lag1.ts <- stats::lag(B1GQ.ts,-1)
B1GQ_lag1.ts
start(B1GQ_lag1.ts)

# Get the series and its first lag together
mts2 <- ts.union(B1GQ.ts, B1GQ_lag1.ts)
mts2

# Get the common sample data for two or more series
mts3 <- ts.intersect(B1GQ.ts, B1GQ_lag1.ts)
mts3

# Difference
diff(B1GQ.ts)
diff(B1GQ.ts, differences = 2)
diff(B1GQ.ts, lag = 4)
diff(B1GQ.ts, lag = 4)/stats::lag(B1GQ.ts, -4)

# zoo and xts
library(zoo)

m1 <- matrix(rnorm(480), nrow = 120)
colnames(m1) <- c("var1", "var2", "var3", "var4")
m1

idx1 <- seq(from = as.Date("2001-01-01"), 
            length.out = nrow(m1), by = "months")
idx1

zoo1 <- zoo(m1, order.by = idx1)
zoo1

index(zoo1)
coredata(zoo1)

start(zoo1)
end(zoo1)

summary(zoo1)
str(zoo1)

head(zoo1)
tail(zoo1)

zoo2 <- window(zoo1, start = as.Date("2005-11-11"), 
               end = as.Date("2006-08-15"))
zoo2
is.zoo(zoo2)

zoo1[,1]
zoo1$var1
zoo1[2,3]
zoo1$var3[2]

stats::lag(zoo1, -1)
diff(zoo1, differences = 1)

zoo4 <- merge(zoo1, zoo2)
zoo4

zoo3 <- cbind(zoo1$var2, zoo1$var1, stats::lag(zoo1$var1, -1))
zoo3
zoo3 <- merge(zoo1$var2, zoo1$var1, stats::lag(zoo1$var1, -1))
zoo3

write.csv(data_gdpq_bg, "data_gdpq_bg.csv", row.names = F)

data_gdpq_bg.zoo <- read.zoo("data_gdpq_bg.csv", 
                      index.column = 1, 
                      FUN = as.Date,
                      sep = ",",
                      header = T)

data_gdpq_bg.zoo

write.zoo(data_gdpq_bg.zoo, "data_gdpq_bg.zoo.csv",
          index.name = "Time period", sep = ",")

# Convert zoo to ts
ts_conv <- as.data.frame(data_gdpq_bg.zoo)
ts_conv
class(ts_conv)
ts_conv <- ts(ts_conv, start = c(1995,1), frequency = 4)
ts_conv

# Convert ts to zoo
zoo_conv <- as.zoo(ts_comb1)
zoo_conv
index(zoo_conv)
class(zoo_conv)

# The xts package
library(xts)
xts1 <- xts(data_gdpq_bg[,2:3], 
            order.by = data_gdpq_bg$time,
            descr = "first xts object")
class(xts1)

xts1["2010"] # select all quarters of 2010
xts1["2010-01"] # select Q1 2010
xts1["2010-01/2010-06"] # select Q1-Q2 2010

library(lubridate)
nowtime <- now()
idx2 <- nowtime + days(0:364)
idx2
last(idx2)
rnorm_data <- rnorm(length(idx2))
xts2 <- xts(rnorm_data, order.by = idx2)
colnames(xts2)[1] <- "data"
head(xts2)

apply.monthly(xts2, mean)
apply.quarterly(xts2, sd)
apply.yearly(xts2, sum)

start(xts2)
end(xts2)

ndays(xts2)
nmonths(xts2)
nyears(xts2)

endp1 <- endpoints(xts2,'weeks')
period.apply(xts2, INDEX=endp1, mean)
endp2 <- endpoints(xts2,'months')
period.max(xts2, INDEX=endp2)

