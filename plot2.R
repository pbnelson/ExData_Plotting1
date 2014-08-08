#!/usr/bin/r

# plot2.R
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

# make plot to screen
system("rm plot2.png")  # remove existing plot
quartz(width=6, height=6)
plot(houseElecData$Time, houseElecData$Global_active_power, 
     main="", 
     xlab="", 
     ylab="Global Active Power (kilowatts)", 
     type="l")

# unfortunately, dev.copy doesn't honor the background color, so I have to use png()
# dev.copy(png, file = "plot2.png", width = 480, height = 480, bg="white")
dev.off()
png(file = "plot2.png", width = 480, height = 480, bg="white")
plot(houseElecData$Time, houseElecData$Global_active_power, 
     main="", 
     xlab="", 
     ylab="Global Active Power (kilowatts)", 
     type="l")

dev.off()

# open the chart, on a mac
# system('open plot2.png')