library(readr)
library(lubridate)

setwd("c:/users/btaylor/desktop/base_plots/")

## Get power consumption data
temp <- "temp.zip"
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
utils::unzip(temp)

fname <- "household_power_consumption.txt"

## Read in data with datetime parsing
df <- readr::read_delim(fname, delim = ";",
                        col_type = cols(
                          Date = col_date(format = "%d/%m/%Y"),
                          Time = col_character()))

## Subset for two days in Feb. 2007
x <- df[df$Date >= as.Date("2007-02-01") & df$Date <= as.Date("2007-02-02"), ]

## Plot 4
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

plot(x = x$date_time, y = x$Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")

plot(x = x$date_time, y = x$Voltage, type = "l",
     ylab = "Voltage", xlab = "datetime")

plot(x = x$date_time, y = x$Sub_metering_1, type = "l",
     ylab = "Energy sub metering", xlab = "")
lines(x = x$date_time, y = x$Sub_metering_2, type = "l", col = "red")
lines(x = x$date_time, y = x$Sub_metering_3, type = "l", col = "blue")
legend(x = "topright", lty = c(1, 1, 1), col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(x = x$date_time, y = x$Global_reactive_power, type = "l",
     ylab = "Global_reactive_power", xlab = "datetime")

dev.off()
