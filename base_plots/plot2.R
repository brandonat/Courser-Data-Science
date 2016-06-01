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

## Create datetime variable
x$date_time <- lubridate::ymd_hms(paste(x$Date, x$Time))

## Plot 2
png("plot2.png", width = 480, height = 480)
plot(x = x$date_time, y = x$Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()
