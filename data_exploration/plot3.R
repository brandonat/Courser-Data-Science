## Plot 2

## Ojective
## --------------------------------------------------------------
## Of the four types of sources indicated by the type
## (point, nonpoint, onroad, nonroad) variable, which of these four 
## sources have seen decreases in emissions from 1999-2008 for
## Baltimore City? Which have seen increases in emissions from 1999-2008?
## Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)

## Note: data provided by course instructor, but can be reproduced
## using the source listed in README.md

## This first line will likely take a few seconds. Be patient!
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

