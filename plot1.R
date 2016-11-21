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


png(filename="plot1.png", height=480, width=480)
hist(df1$Global_active_power,xlab="Global Active Power (Kilowatt)", ylab="Frequency",main="Global Active Power",col="red")
dev.off()

