## Plot 1

## install sqldf load library if necessary
if(!require(sqldf, quietly = TRUE)) install.packages("sqldf")
library(sqldf)


## change the working directory
workingDirChr <- "~/Documents/DataScience_JH/ExploratoryDataAnalysis/project1/ExData_Plotting1"
setwd(workingDirChr)

## download data file
fileUrlChr <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrlChr, destfile = "household_power_consumption.zip", method = "curl")
dateDownloadedDate <- date()
unzip("household_power_consumption.zip")

## read only the first 10 rows of data
top10rows <- read.table("household_power_consumption.txt", header = 
                                TRUE, sep = ";", nrows = 10)

## get the classes of the variables
classes <- sapply(top10rows, class)

## read only the 1 Feb 07 ad 2 Feb 07 data set into R
powerDataDf <- read.csv2.sql("household_power_consumption.txt", sql = 
                                     'select * from file where "Date" = 
                             "1/2/2007" or "Date" = "2/2/2007"',
                             colClasses = classes)

## create a vector with the Date and Time values
DateAndTime <- paste(powerDataDf$Date, powerDataDf$Time)

## convert the DateAndTime vector to a date class
convertedDate <- strptime(DateAndTime, "%d/%m/%Y %H:%M:%S")

## add the convertedDate vector to the dataframe
powerDataDf <- cbind(powerDataDf, convertedDate)

## make a histogram of Global Active Power (kilowatts) in red
hist(powerDataDf$Global_active_power, col = "red", xlab = "Global Active
      Power (kilowatts)", main = "Global Active Power")

## plot to .png
png(filename = "plot1.png", width = 480, height = 480)
hist(powerDataDf$Global_active_power, col = "red", xlab = 
             "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()




