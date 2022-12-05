# Clear workspace
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

# Current date of system
Sys.Date()

datevar1 <- as.Date("2016-10-08")
datevar1
class(datevar1)

as.integer(datevar1)
as.integer(Sys.Date())

datevar2 <- as.Date("2016/10/08")
datevar2

Sys.getlocale()
Sys.setlocale(category = "LC_ALL", 
              locale = "English_United States.1252")

as.Date("07/31/2016", format = "%m/%d/%Y")
as.Date("December 26, 2011", format = "%B %d, %Y")
as.Date("26mar2011", format = "%d%b%Y")

as.Date("4th of November, 2019", format = "%dth of %B, %Y")

as.Date(32874, origin = as.Date("1899-12-30"))

library(readxl)

data1 <- read_excel("Book2.xlsx", sheet = 1)

data1$hhh <- as.Date(data1$hhh, origin = "1899-12-30")

data1

as.Date(42658, origin = "1899-12-30")

as.numeric(datevar1)

Sys.Date() - as.Date("1991-11-29")
difftime(Sys.Date(), as.Date("1991-11-29"), units = "weeks")

tseq1 <- seq(as.Date("2016-10-10"), by = "days", length = 20)
tseq1
class(tseq1)

tseq2 <- seq(from = as.Date("2016-10-10"), 
             to = as.Date("2017-10-10"), by = "3 weeks")
tseq2

# chron package
library(chron)
dates1 <- dates(c("03/21/2002", "04/26/12", "01/11/14", 
                  "01/28/1915", "02/10/2016"))
dates1

class(dates1)

dates1[5] - dates1[4]

times1 <- times(c("20:05:21", "19:29:59", "11:13:31", 
                  "10:29:14", "06:48:02"))
times1

datestimes1 <- chron(dates = dates1, times = times1)
datestimes1

class(datestimes1)
datestimes1

datestimes1[2] + 3.5

datestimes1[3] - datestimes1[2]

# POSIXct
Sys.time()

pos1 <- "2016-10-15"
pos2 <- "2016/10/16"
posdate1 <- as.POSIXct(pos1)
posdate2 <- as.POSIXct(pos2)
c(posdate1,posdate2)

pos3 <- "2016-10-15 15:45:37"
posdate3 <- as.POSIXct(pos3)
posdate3

class(posdate3)

date0 <- as.POSIXct("10-12-2016", format = "%d-%m-%Y", 
                    tz = "EET")
date0

class(date0)

tick_data <- read.csv("tick_data.csv", 
                      stringsAsFactors = FALSE)
tick_data$DATE <- as.Date(tick_data$DATE, format = "%m.%d.%Y")
tick_data$datetime <- paste(tick_data$DATE, tick_data$TIME,
                            sep = " ")
tick_data$datetime <- as.POSIXct(tick_data$datetime)
tick_data <- subset(tick_data, select = c(5,3:4))

library(lubridate)
datetime0 <- dmy_hms("15-09-2016 13:45:01")
datetime0

class(datetime0)

nowtime <- now()
nowtime
with_tz(nowtime, tzone = "UTC")
force_tz(nowtime, tzone = "UTC")
now()

month(nowtime)
day(nowtime)
hour(nowtime)
am(nowtime)
pm(nowtime)
month(nowtime, label = TRUE)
month(nowtime, label = TRUE, abbr = FALSE)

wday(nowtime, label = TRUE)
wday(nowtime, label = TRUE, abbr = FALSE)

yesttime <- nowtime - days(1)
yesttime
int1 <- interval(nowtime, yesttime)
int1
class(int1)
mode(int1)

years(1) + hours(2) + minutes(15)
dyears(1)
as.numeric(dyears(1))/60/60/24

dmy(31012016) + years(1)
dmy(31012016) + dyears(1)

