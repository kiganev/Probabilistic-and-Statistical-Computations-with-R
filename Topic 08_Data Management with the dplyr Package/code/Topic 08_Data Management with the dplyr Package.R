# Clear wortkspace
rm(list = ls())

# Clear plots
dev.off(dev.list()["RStudioGD"])

# Get location of current script
fileloc <- dirname(rstudioapi::getSourceEditorContext()$path)

# Set working directory to script location
setwd(fileloc)

# Remove fileloc variable
rm(fileloc)

# Set locale to English
Sys.setlocale("LC_ALL","English")

library(tidyverse)

data1 <- read_csv("Demographic_Statistics_By_Zip_Code.csv")
data1

class(data1)

df1 <- as.data.frame(matrix(1:9, nrow = 3))

tb1 <- as_tibble(df1)
tb1

# Flights from NY City
install.packages("nycflights13")
library(nycflights13)
print(flights)
data(flights)

# Filtering
july27 <- filter(flights, month == 7, day == 27)
class(july27)

july7or27 <- filter(flights, (day == 7 | day == 27) & month == 7)	

not_in_jan <- filter(flights, month != 1)

not_in_winter <- filter(flights, !(month %in% c(1,2,12)))

# Sorting (arranging)
sort1 <- arrange(flights, dep_delay, carrier)

sort1a <- arrange(flights, carrier, dep_delay)

sort2 <- arrange(filter(flights, month == 1, day == 1), desc(dep_delay))	

# Variable selection
new_tbl1 <- select(flights, year, month, day, flight)

new_tbl2 <- select(flights, year:day, flight)

new_tbl3 <- select(flights, -c(hour, minute))

new_tbl4 <- select(flights, starts_with("flig")) # Selects all variables starting with this character string

# Rename
flights1 <- rename(flights, airline = carrier)

flights2 <- select(flights, time_hour, everything())

# New variable
flights <- 	mutate(flights, travel_time = arr_time - dep_time)

by_airline <- group_by(flights, carrier)
summary1 <- summarize(by_airline, delay = mean(dep_delay, na.rm = TRUE))

avg_delay <- flights %>% 
  group_by(carrier) %>%
  summarize(avg_delay = mean(dep_delay, na.rm = TRUE))

avg_delay  

%>% 