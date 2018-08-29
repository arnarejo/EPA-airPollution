# setwd("~/Documents/PROGRAMMING/Coursera/DS/assignments/EPA-airPollution")
# list.files()

# load libraries
library(dplyr) # for data manipulation
library(ggplot2) # data visualization

## read data
data <- readRDS("data/summarySCC_PM25.rds")
labels <- readRDS("data/Source_Classification_Code.rds")

color = c("#999999", "#E69F00", "#56B4E9", "#42f474")

# Question 2: Have total emissions from PM2.5 decreased in the Baltimore City
plot2Data <- data %>% filter(fips=="24510") %>% 
    group_by(year) %>% 
    summarize(totalEmissions = sum(Emissions))

# plot total pollutant trend across Baltimore
png('plot2.png')
barplot(plot2Data$totalEmissions, 
        names.arg = plot2Data$year, 
        main = expression('Baltimore city '*' PM'[2.5]*' emission trend from 1999 to 2008'),
        border="orange", 
        col=color, 
        xlab="year", 
        ylab=expression('PM'[2.5]*' emission (tons)'))
dev.off()