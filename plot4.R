#!/usr/bin/r

# plot4.R
#
# Assignment for https://class.coursera.org/exdata-005

# set working directory
setwd("/Users/peter.nelson/Documents/Coursera/jhds-04-exdata/week1/ExData_Plotting1")

# segment data by 2007-02-01 to 2007-02-02 only
system('head -1                ../data/household_power_consumption.txt  > ../data/household_power_consumption_subset.csv')
system('egrep "^[1-2]/2/2007;" ../data/household_power_consumption.txt >> ../data/household_power_consumption_subset.csv')

# load data
houseElecData <- read.table("../data/household_power_consumption_subset.csv", sep=";", header=TRUE)

# convert date column from string to datetype
houseElecData$Date <- as.Date(houseElecData$Date, format="%d/%m/%Y")

# convert time column from string to timetype
houseElecData$Time <- strptime(paste(houseElecData$Date, houseElecData$Time), format="%Y-%m-%d %H:%M:%S")

# view data
# View(houseElecData)

# confirm no ? in data
# sum(houseElecData$Global_active_power=="?")
# sum(houseElecData$Global_reactive_power=="?")
# sum(houseElecData$Global_intensity=="?")
# sum(houseElecData$Sub_metering_1=="?")
# sum(houseElecData$Sub_metering_2=="?")
# sum(houseElecData$Sub_metering_3=="?")



# my own plotting function
makePlot <- function() {
    
    # set up four-square
    par(mfcol=c(2,2), mar=c(4,4,4,2))
    
    # plot 4a
    plot(houseElecData$Time, houseElecData$Global_active_power, 
         main="", 
         xlab="", 
         ylab="Global Active Power", 
         type="l")
    
    # plot 4b
    plot(houseElecData$Time, houseElecData$Sub_metering_1, 
         main="", 
         xlab="", 
         ylab="Energy Sub Metering", 
         type="n")
    points(houseElecData$Time, houseElecData$Sub_metering_1, col="black", type="l")
    points(houseElecData$Time, houseElecData$Sub_metering_2, col="red"  , type="l")
    points(houseElecData$Time, houseElecData$Sub_metering_3, col="blue" , type="l")
    legend(x="topright", 
           c("Sub_metering_1","Sub_metering_1","Sub_metering_1"), 
           col=c("black","red","blue"), 
           lty=1,
           bty="n",
           cex=0.80)
    
    # plot 4c
    plot(houseElecData$Time, houseElecData$Voltage, 
         xlab="datetime", 
         ylab="Voltage", 
         type="l")

    # plot 4d
    plot(houseElecData$Time, houseElecData$Global_reactive_power, 
         xlab="datetime", 
         ylab="Global_reactive_power", 
         type="l")
}

# make plot to screen

system("rm plot4.png")  # remove existing plot
quartz(width=6, height=6)
makePlot()
# unfortunately, dev.copy doesn't honor the background color, so I have to use png()
# dev.copy(png, file = "plot4.png", width = 480, height = 480, bg="white")
dev.off()
png(file = "plot4.png", width = 480, height = 480, bg="white")
makePlot()
dev.off()

# open the chart, on a mac
# system('open plot4.png')
