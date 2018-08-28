# setwd("~/Documents/PROGRAMMING/Coursera/DS/assignments/EPA-airPollution")
list.files()

# load libraries
library(dplyr)

## read data
data <- readRDS("data/summarySCC_PM25.rds")
labels <- readRDS("data/Source_Classification_Code.rds")

# Question 1: Check total emissions trend across USA from 1999 to 2008
countryTotal <- data %>% group_by(year) %>% summarize(totalEmissions = sum(Emissions))

# plot total pollutant trend across USA
barplot(countryTotal$totalEmissions/1000000, 
        names.arg = countryTotal$year, 
        main="Graph 1",
        border="orange", 
        col="lightgreen", 
        xlab="year", 
        ylab="mn tons")

# Question 2: Have total emissions from PM2.5 decreased in the Baltimore City
BaltimoreTotal <- data %>% filter(fips=="24510") %>% 
    group_by(year) %>% 
    summarize(totalEmissions = sum(Emissions))

# plot total pollutant trend across Baltimore
barplot(BaltimoreTotal$totalEmissions, 
        names.arg = countryTotal$year, 
        main = "graph 2",
        border="grey", 
        col="orange", 
        xlab="year", 
        ylab="tons")


# Question 3: Emission trend by type
totalByType <- data %>% group_by(type, year) %>% 
    summarize(totalEmissions = sum(Emissions))

# Emission Graph by type
# need to format and add labels
ggplot(totalByType, 
    aes(factor(year), totalEmissions/1000, fill=factor(year))) +           geom_bar(stat = "identity") + 
    facet_wrap(~type) +
    xlab("Year") + 
    ylab("Total Pollution") +
    ggtitle("Annual pollution trend by type")

# Question 4: emissions from coal combustion-related sources changed from 1999–2008
comb <- grepl("comb", labels$Short.Name, ignore.case=TRUE)
coal <- grepl("coal", labels$Short.Name, ignore.case=TRUE)
Codes <- labels[(comb & coal), ]$SCC
filteredData <- data[data$SCC %in% Codes,]

# summarize data by year
coalData <- filteredData %>% group_by(year) %>% 
    summarize(totalEmissions = sum(Emissions))

# plot data
barplot(coalData$totalEmissions/1000, 
        names.arg = coalData$year, 
        main = "Total Coal Emissions",
        border="grey", 
        col="orange", 
        xlab="year", 
        ylab="k tons")

# Question 5: emissions from motor vehicle sources changed from 1999–2008 in Baltimore City
motor <- grepl("motor", labels$Short.Name, ignore.case=TRUE)
Codes <- labels[motor, ]$SCC
motorData <- data[data$SCC %in% Codes,]

# filtere data for Baltimore city and summarize by year
BaltimoreMotorData <- motorData %>% filter(fips=="24510") %>% 
    group_by(year) %>% 
    summarize(totalEmissions = sum(Emissions))

# plot data
barplot(BaltimoreMotorData$totalEmissions, 
        names.arg = countryTotal$year, 
        main = "graph 2",
        border="grey", 
        col="orange", 
        xlab="year", 
        ylab="tons")

# Question 6: Baltimore vs LA emission trend for motor vehicles
motor <- grepl("motor", labels$Short.Name, ignore.case=TRUE)
Codes <- labels[motor, ]$SCC
motorData <- data[data$SCC %in% Codes,]

# filtere data for Baltimore city|LA and summarize by year
BmVsLaData <- motorData %>% filter(fips == "24510" | fips=="06037") %>% 
    group_by(year, fips) %>% 
    summarize(totalEmissions = sum(Emissions))
# plot Baltimore vs La

ggplot(BmVsLaData, 
       aes(factor(year), totalEmissions/1000, fill=factor(year))) +           geom_bar(stat = "identity") + 
    facet_wrap(~fips) +
    xlab("Year") + 
    ylab("Total Pollution") +
    ggtitle("Motor Pollution Baltimore Vs LA")