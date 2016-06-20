## Plot 6

## Ojective
## --------------------------------------------------------------
## Compare emissions from motor vehicle sources in Baltimore City
## with emissions from motor vehicle sources in Los Angeles County, 
## California (fips == "06037"). Which city has seen greater changes
## over time in motor vehicle emissions?

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
  filter(fips %in% c("24510", "06037") & SCC %in% vehicles) %>%
  group_by(year, fips) %>%
  summarise(total = sum(Emissions)) %>%
  mutate(location = ifelse(fips == "24510",
    "Baltimore City", "Los Angeles County"))

png(filename = "plot6.png")
ggplot(df, aes(x = factor(year), y = total)) + 
  geom_bar(stat = "identity", fill = "blue", alpha = 0.75) + 
  facet_wrap(~location) +
  labs(x = "Year", y = "Tons of PM2.5",
    title = "Total Emissions from Motor Vehicles") +
  theme_bw()
dev.off()




Emissions from coal combustion-related sources