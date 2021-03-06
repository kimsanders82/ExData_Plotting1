


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


## Create Global Active Power plot 2 and save to .png file

png(paste0(getwd(),"/plot2.png"))

plot(myData$SetTime, myData$Global_active_power, type = "l", col="black", xlab = "", ylab="Global Active Power (kilowatts)")

dev.off()



