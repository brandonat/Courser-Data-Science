## Plot 2

## Ojective
## --------------------------------------------------------------
## Have total emissions from PM2.5 decreased in the Baltimore City,
## Maryland (fips == "24510") from 1999 to 2008? Use the base plotting
## system to make a plot answering this question. 

## Note: data provided by course instructor, but can be reproduced
## using the source listed in README.md

## This first line will likely take a few seconds. Be patient!
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

## Baltimore City
bc <- nei[nei$fips == "24510", ]

year_total <- tapply(bc$Emissions, bc$year, sum, na.rm = TRUE)

## Plot
png(filename = "plot2.png")
barplot(year_total / 1e6, ylab = "Millions of Tons of PM2.5",
        main = "Total Emissions by Year\nBaltimore City, Maryland", col = "blue")
dev.off()
