# setwd("~/Documents/PROGRAMMING/Coursera/DS/assignments/EPA-airPollution")
# list.files()

# load libraries
library(dplyr) # for data manipulation
library(ggplot2) # data visualization

## read data
data <- readRDS("data/summarySCC_PM25.rds")
labels <- readRDS("data/Source_Classification_Code.rds")

color = c("#999999", "#E69F00", "#56B4E9", "#42f474")

# Question 6: Baltimore vs LA emission trend for motor vehicles
motor <- grepl("motor", labels$Short.Name, ignore.case=TRUE)
Codes <- labels[motor, ]$SCC
motorData <- data[data$SCC %in% Codes,]

# filtere data for Baltimore city|LA and summarize by year
plot6Data <- motorData %>% filter(fips == "24510" | fips=="06037") %>% 
    group_by(year, fips) %>% 
    summarize(totalEmissions = sum(Emissions))
plot6Data$fips <- as.factor(plot6Data$fips)
levels(plot6Data$fips) <- c("Los Angeles", "Baltimore")

# plot Baltimore vs La
png('plot6.png')
ggplot(plot6Data, 
       aes(factor(year), totalEmissions, fill=factor(year))) +           geom_bar(stat = "identity") + 
    facet_wrap(~fips) +
    xlab("Year") + 
    ylab(expression('PM'[2.5]*' emission (tons)')) +
    ggtitle("Motor Pollution in Baltimore vs Los Angeles") +
    guides(fill=guide_legend(title="year"))
dev.off()