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

# Question 5: emissions from motor vehicle sources changed from 1999–2008 in Baltimore City
motor <- grepl("motor", labels$Short.Name, ignore.case=TRUE)
Codes <- labels[motor, ]$SCC
motorData <- data[data$SCC %in% Codes,]

# filtere data for Baltimore city and summarize by year
plot5Data <- motorData %>% filter(fips=="24510") %>% 
    group_by(year) %>% 
    summarize(totalEmissions = sum(Emissions))

# plot data
png('plot5.png')
barplot(plot5Data$totalEmissions, 
        names.arg = plot5Data$year, 
        main = expression('Motor pollution in Baltimore City PM'[2.5]*' from 1999 to 2008'),
        border="grey", 
        col=color, 
        xlab="year", 
        ylab=expression('PM'[2.5]*' emission (thousand tons)'))
dev.off()