setwd("~/Documents/PROGRAMMING/Coursera/DS/assignments/EPA-airPollution")
# list.files()

# load libraries
library(dplyr) # for data manipulation
library(ggplot2) # data visualization

## read data
data <- readRDS("data/summarySCC_PM25.rds")
labels <- readRDS("data/Source_Classification_Code.rds")

color = c("#999999", "#E69F00", "#56B4E9", "#42f474")
# Question 1: Check total emissions trend across USA from 1999 to 2008
plot1Data <- data %>% group_by(year) %>% summarize(totalEmissions = sum(Emissions))

# plot total pollutant trend across USA
png('plot1.png')
barplot(plot1Data$totalEmissions/1000, 
        names.arg = plot1Data$year, 
        main=expression('USA '*' PM'[2.5]*' emission trend from 1999 to 2008'),
        col=color, 
        xlab="year", 
        ylab=expression('PM'[2.5]*' emission (thousand tons)') )
dev.off()
