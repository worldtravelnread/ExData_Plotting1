## Plot 3

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
datetime <- strptime(DateAndTime, "%d/%m/%Y %H:%M:%S")

## add the datetime vector to the dataframe
powerDataDf <- cbind(powerDataDf, datetime)

## set up a panel with four plots
par(mfcol = c(2,2), mar = c(4, 4, 2, 1), oma = c(0, 0, 0, 0))

## make the plots
with(powerDataDf, {
        plot(datetime, Global_active_power, type = "l", 
                       xlab = "", ylab = "Global Active Power")
        plot(datetime, Sub_metering_1, type = "l", 
                       xlab = "", ylab = "Energy sub metering")
        points(datetime, Sub_metering_2, col = "red", type = "l")
        points(datetime, Sub_metering_3, col = "blue", type = "l")
        legend("topright", lty = "longdash", col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               cex = 0.5, bty = "n", text.width = strwidth("Sub_metering_3"))
        plot(datetime, Voltage, type = "l")
        plot(datetime, Global_reactive_power, type = "l")
        })


## plot to .png
png(filename = "plot4.png", width = 480, height = 480)
par(mfcol = c(2,2), mar = c(4, 4, 2, 1), oma = c(0, 0, 0, 0))
with(powerDataDf, {
        plot(datetime, Global_active_power, type = "l", 
             xlab = "", ylab = "Global Active Power")
        plot(datetime, Sub_metering_1, type = "l", 
             xlab = "", ylab = "Energy sub metering")
        points(datetime, Sub_metering_2, col = "red", type = "l")
        points(datetime, Sub_metering_3, col = "blue", type = "l")
        legend("topright", lty = "longdash", col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               cex = 0.5, bty = "n", text.width = strwidth("Sub_metering_3"))
        plot(datetime, Voltage, type = "l")
        plot(datetime, Global_reactive_power, type = "l")
})
dev.off()




