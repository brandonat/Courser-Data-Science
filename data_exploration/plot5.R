## Plot 5

## Ojective
## --------------------------------------------------------------
## How have emissions from motor vehicle sources changed from
## 1999-2008 in Baltimore City?

library(ggplot2)
library(dplyr)

## Note: data provided by course instructor, but can be reproduced
## using the source listed in README.md

## This first line will likely take a few seconds. Be patient!
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

## Identify motor vehicle sources
vehicles <- scc$SCC[grepl("[Vv]ehicle", scc$Short.Name)]

df <- nei %>% 
  filter(fips == "24510" & SCC %in% vehicles) %>%
  group_by(year) %>%
  summarise(total = sum(Emissions))

png(filename = "plot5.png")
ggplot(df, aes(x = factor(year), y = total)) + 
  geom_bar(stat = "identity", fill = "blue", alpha = 0.75) + 
  labs(x = "Year", y = "Tons of PM2.5",
       title = "Total Emissions from Motor Vehicles\nBaltimore City, Maryland") +
  theme_bw()
dev.off()
