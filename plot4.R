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
##subset dates
subQ1<-subset(Q1,Q1$Date=="1/2/2007" | Q1$Date =="2/2/2007")

##reclassify columns
subQ1$Date<-as.Date(subQ1$Date, format="%d/%m/%Y")
subQ1$Global_active_power<-as.numeric(subQ1$Global_active_power)
subQ1Q1$Global_reactive_power<-as.numeric(subQ1Q1$Global_reactive_power)
subQ1Q1$Voltage<-as.numeric(subQ1Q1$Voltage)
subQ1Q1$Global_intensity<-as.numeric(subQ1Q1$Global_intensity)
subQ1Q1$Sub_metering_1<-as.numeric(subQ1Q1$Sub_metering_1)
subQ1Q1$Sub_metering_2<-as.numeric(subQ1Q1$Sub_metering_2)
subQ1Q1$Sub_metering_3<-as.numeric(subQ1Q1$Sub_metering_3)


##display date and time in year, month, day, and hour, min, sec format
subQ1<-unite(subQ1, "Date_Time", Date:Time, remove = FALSE)
subQ1$Date_Time<-ymd_hms(subQ1$Date_Time)

##display date and time in year, month, day, and hour, min, sec format

subQ1$Date_Time<-ymd_hms(subQ1$Date_Time)

##make PNG

png("plot4.png", width = 480, height = 480)

##plot graph

par(mfrow=c(2,2))
subQ1<-unite(subQ1, "Date_Time", Date:Time, remove = FALSE)
subQ1$Date_Time<-ymd_hms(subQ1$Date_Time)
with(subQ1, plot(Date_Time, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
with(subQ1, plot(Date_Time, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))
plot(subQ1$Date_Time, subQ1$Sub_metering_1, col = "gray", type = "l", xlab = "", ylab = "Energy Sub Metering")
lines(subQ1$Date_Time, subQ1$Sub_metering_2, col = "red", type = "l")
lines(subQ1$Date_Time, subQ1$Sub_metering_3, col = "blue", type = "l")
legend("topright", lty=c(1,1,1), cex = .4,col=c("gray","red", "blue"),legend=c("Sub Metering 1","Sub Mertering 2", "Sub Metering 3"))
with(subQ1, plot(Date_Time, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))

dev.off()
