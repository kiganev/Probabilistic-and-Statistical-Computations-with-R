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

rm(fileloc, check_dev)

# Read data
routes.df <- read.table("routes.txt", sep = ",",
                        header = FALSE)

# Name variables
names(routes.df) <- c("Airline", "Airline_ID", "Source airport", "Source_airport_ID",
                      "Destination_airport", "Destination_airport_ID", "Codeshare",
                      "Stops", "Equipment")

random_data <- read.csv2("Book1.csv")

# Write text file
write.table(routes.df, "routes.tsv", sep = "\t")

write.csv2(routes.df, "routes.csv")

# Load foreign library 
library(foreign)

# Read SAS xport file
sas1 <- read.xport("ALQ_F.XPT")

# Read Weka arff file:
weka1 <- read.arff("cpu.with.vendor.arff")

# Read Stata files:
stata1 <- read.dta("phillips.dta")

stata2 <- read.dta("odd1.dta")

library(haven)

stata2 <- read_dta("odd1.dta")

# Read SPSS
spss1 <- read.spss("MathAssess-SpssFormat.sav", to.data.frame = TRUE)

# Write files with foreign
write.arff(routes.df, "routes.arff")
names(routes.df)[3] <- "Source_Airport" # write_dta() does not like spaces in variable names
routes.df$Codeshare <- NA
write.dta(routes.df, "routes.dta") # will likely produce an error so

write.dta(random_data, "random_data.dta")

# With haven
write_dta(routes.df, "routes.dta")
write.foreign(sas1, "stata2.csv",
              "stata2.do", 
              package = "Stata") # SAS and SPSS are also possible

# Read and write xlsx
library(openxlsx)
xlsx1 <- read.xlsx("benefits.xlsx", sheet = "benefits")

library(readxl)
xlsx2 <- read_excel("benefits.xlsx", sheet = "benefits", 
                    range = "A1:S1849")

write.xlsx(sas1,"sas1.xlsx", overwrite = T)

library(writexl)
write_xlsx(sas1, "sas2.xlsx")

# Read EViews wf1 files
library(hexView)
eviews1 <- readEViews("consump.wf1")

# SQLite
library(RSQLite)

drv <- dbDriver("SQLite")

dbpath <- "./chinook.db"

mydb <- dbConnect(drv, dbpath)

dbListTables(mydb)

dbListFields(mydb, "artists")

artists <- dbReadTable(mydb, "artists")

db_data <- dbGetQuery(mydb, "SELECT	trackid, tracks.name AS Track,
                      albums.title AS Album, artists.name AS Artist
                      FROM tracks
                      INNER JOIN albums ON albums.albumid = tracks.albumid
                      INNER JOIN artists ON artists.artistid = albums.artistid
                      WHERE artists.artistid = 22;")

# MySQL - online database
library(RMySQL)
drv2 <- dbDriver("MySQL")

mydb2 <- dbConnect(drv2, dbname = "ensembl_compara_51", 
                   user="anonymous", password="", 
                   host = "ensembldb.ensembl.org")
class(mydb2)

dbListTables(mydb2)

dbListFields(mydb2, "genome_db")

genome <- dbReadTable(mydb2, "genome_db")

# ODBC
library(RODBC)
odbc1 <- odbcConnect("sampledb", believeNRows = FALSE, 
                     rows_at_time = 1)

sqlTables(odbc1)

odbc_data <- sqlFetch(odbc1, "albums")

odbc_data2 <- sqlQuery(odbc1, paste("SELECT	trackid, tracks.name AS Track,
                      albums.title AS Album, artists.name AS Artist
                      FROM tracks
                      INNER JOIN albums ON albums.albumid = tracks.albumid
                      INNER JOIN artists ON artists.artistid = albums.artistid
                      WHERE artists.artistid = 22;"))

