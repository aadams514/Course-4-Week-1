library(dplyr)
library(data.table)
library(lubridate)
library(tidyr)
##Download Data & Unzip
if(!file.exists("ExplorQ1Data")){dir.create("ExplorQ1Data")}

unzip(zipfile = "exdata_data_household_power_consumption", exdir = "ExplorQ1Data")

##Read Table
Q1<-read.table("household_power_consumption.txt", skip = 1, sep = ";")
##set names of columns
names(Q1)<-c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
##subset for dates specified.
subQ1<-subset(Q1,Q1$Date=="1/2/2007" | Q1$Date =="2/2/2007")

##reset input to be characters
subQ1$Global_active_power<-as.numeric(subQ1$Global_active_power)



subQ1$Date<-as.Date(subQ1$Date, format="%d/%m/%Y")

##make PNG
png("plot1.png", width = 480, height = 480)

##plot histogram
hist(subQ1$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

dev.off()
