# setwd("~/Documents/PROGRAMMING/Coursera/DS/assignments/EPA-airPollution")
# list.files()

# load libraries
library(dplyr) # for data manipulation
library(ggplot2) # data visualization

## read data
data <- readRDS("data/summarySCC_PM25.rds")
labels <- readRDS("data/Source_Classification_Code.rds")

color = c("#999999", "#E69F00", "#56B4E9", "#42f474")

# Question 3: Emission trend by type
plot3Data <- data %>% group_by(type, year) %>% 
    summarize(totalEmissions = sum(Emissions))

# Emission Graph by type
png('plot3.png')
ggplot(plot3Data, 
    aes(factor(year), totalEmissions/1000, fill=factor(year))) +           geom_bar(stat = "identity") + 
    facet_wrap(~type) +
    xlab("Year") + 
    ylab(expression('PM'[2.5]*' emission (thousand tons)')) +
    ggtitle(expression('PM'[2.5]*' emission trend by type of recording')) +
    guides(fill=guide_legend(title="year"))
dev.off()