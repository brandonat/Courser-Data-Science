## Plot 1

## Ojective
## --------------------------------------------------------------
## Have total emissions from PM2.5 decreased in the United States 
## from 1999 to 2008? Using the base plotting system, make a plot 
## showing the total PM2.5 emission from all sources for each of
## the years 1999, 2002, 2005, and 2008.

## Note: data provided by course instructor, but can be reproduced
## using the source listed in README.md

## This first line will likely take a few seconds. Be patient!
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

year_total <- tapply(nei$Emissions, nei$year, sum, na.rm = TRUE)

## Plot
png(filename = "plot1.png")
barplot(year_total / 1e6, ylab = "Millions of Tons of PM2.5",
        main = "Total Emissions by Year", col = "blue")
dev.off()


