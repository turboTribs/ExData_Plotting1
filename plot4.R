library (ggplot2)
library(dplyr)
library(tidyr)




energyFile <- "./household_power_consumption.txt";

df <- read.table(energyFile,header=TRUE, sep=";",quote="\"'",na.strings="?");

## convert date + time to Date and Time data type
df$DateTime_ct <- as.POSIXct(paste( df$Date,df$Time, sep = " "),"%d/%m/%Y %H:%M:%S")

## convert Date string type to Date()
df$Date1 <-  as.Date(df$Date, "%d/%m/%Y", tz = "")

###df %>% mutate( date1= as.Date(Date, "%d/%m/%Y", tz = ""), DateTime = strptime(paste( Date,Time, sep = " "),"%d/%m/%Y %H:%M:%S") )  %>% filter(date1 >= as.Date("2007-02-01","%Y-%m-%d") & date1 <= as.Date("2007-02-02","%Y-%m-%d") ) -> df1

df %>% filter(Date1 >= as.Date("2007-02-01","%Y-%m-%d") & Date1 <= as.Date("2007-02-02","%Y-%m-%d") ) -> df1

## Add Week Days for graph#2
df1$WeekDay <- weekdays(df1$Date1)

## POSIXlt DateTime
df1$DateTime <- strptime(paste( df1$Date,df1$Time, sep = " "),"%d/%m/%Y %H:%M:%S")



##4

## plot by column

par(mfcol = c(2, 2)) 

#row1
   plot(df1$DateTime,df1$Global_active_power,ylab="Global Active Power (Kilowatt)", main="Global Active Power",col="red", type = "l")

##row 2
plot(df1$DateTime,df1$Sub_metering_1,xlab= "", ylab="Energy SubMetering", main="Global Active Power",col="red", type = "l")
lines(df1$DateTime,df1$Sub_metering_2,col="blue")
lines(df1$DateTime,df1$Sub_metering_3,col="green")

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue", "green"))

## row 3

plot(df1$DateTime, df1$Voltage, type="l", xlab="datetime", ylab="Voltage")

## row 4

plot(df1$DateTime, df1$Global_reactive_power , type="l", xlab="datetime", ylab="Global_reactive_power")


dev.copy(png,file = "plot4.png", height=480, width=480)
dev.off()
