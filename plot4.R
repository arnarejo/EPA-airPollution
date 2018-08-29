# setwd("~/Documents/PROGRAMMING/Coursera/DS/assignments/EPA-airPollution")
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

# Question 4: emissions from coal combustion-related sources changed from 1999–2008
comb <- grepl("comb", labels$Short.Name, ignore.case=TRUE)
coal <- grepl("coal", labels$Short.Name, ignore.case=TRUE)
Codes <- labels[(comb & coal), ]$SCC
filteredData <- data[data$SCC %in% Codes,]

# summarize data by year
plot4Data <- filteredData %>% group_by(year) %>% 
    summarize(totalEmissions = sum(Emissions))

# plot data
png('plot4.png')
barplot(plot4Data$totalEmissions/1000, 
        names.arg = plot4Data$year, 
        main = expression('PM'[2.5]*' emission from coal trend from 1999 to 2008'),
        border="grey", 
        col=color, 
        xlab="year", 
        ylab=expression('PM'[2.5]*' emission (thousand tons)'))
dev.off()