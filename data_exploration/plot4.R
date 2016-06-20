## Plot 4

## Ojective
## --------------------------------------------------------------
## Across the United States, how have emissions from coal 
## combustion-related sources changed from 1999-2008?

library(ggplot2)
library(dplyr)

## Note: data provided by course instructor, but can be reproduced
## using the source listed in README.md

## This first line will likely take a few seconds. Be patient!
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

## Identify coal combusion sources
coal <- scc$SCC[grepl("[Cc]oal", scc$Short.Name)]

df <- nei %>%
  filter(SCC %in% coal) %>%
  group_by(year) %>%
  summarise(total = sum(Emissions))

png(filename = "plot4.png")
ggplot(df, aes(x = factor(year), y = total / 1e6)) + 
  geom_bar(stat = "identity", fill = "blue", alpha = 0.75) + 
  labs(x = "Year", y = "Millions of Tons of PM2.5",
       title = "Total Emissions from Coal Combustion Sources") +
  theme_bw()
dev.off()
