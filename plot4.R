


library(data.table)


setwd("C:/Coursera/Week 1 Project")


## Download and unzip file into working directory

fileUrl = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
if (!file.exists('./household_power_consumption.zip')){
  download.file(fileUrl,'./household_power_consumption.zip', mode = 'wb')
  unzip("./household_power_consumption.zip", exdir = getwd())
}


##### Read in .txt file

myData <- read.table(paste0(getwd(),"/household_power_consumption.txt"), header=TRUE, sep=";", na.strings="?")


## Filter data to only include dates Feb 1, 2007 and Feb 2, 2007 and set the time variable
myData <- myData[myData$Date %in% c("1/2/2007","2/2/2007"),]
SetTime <-strptime(paste(myData$Date, myData$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
myData <- cbind(SetTime, myData)


## Create plot 4 and save to .png file

png(paste0(getwd(),"/plot4.png"))

## Create 4 plots

par(mfrow = c(2,2))

myLineColors <- c("black", "red", "blue")
myLabels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
plot(myData$SetTime, myData$Global_active_power, type="l", col="black", xlab="", ylab="Global Active Power")
plot(myData$SetTime, myData$Voltage, type="l", col="black", xlab="datetime", ylab="Voltage")
plot(myData$SetTime, myData$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(myData$SetTime, myData$Sub_metering_2, type="l", col="red")
lines(myData$SetTime, myData$Sub_metering_3, type="l", col="blue")
legend("topright", bty="n", legend=myLabels, lty=1, col=myLineColors)
plot(myData$SetTime, myData$Global_reactive_power, type="l", col="black", xlab="datetime", ylab="Global_reactive_power")

dev.off()



