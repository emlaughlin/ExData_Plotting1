##This section downloads, unzips, and reads the data

install.packages("downloader")
library(downloader)
download("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
         dest="dataset.zip", mode="wb")
unzip("dataset.zip", exdir = "./")

dfHPC <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?", 
                 stringsAsFactors = FALSE)

##This section formats date column and subsets by date
dfHPC$Date <- as.Date(dfHPC$Date, "%d/%m/%Y")
Date1 <- as.Date("2007-02-01")
Date2 <- as.Date("2007-02-02")
dfSubset <- dfHPC[dfHPC$Date %in% Date1:Date2, ]

##This section creates a new column that is properly formatted date/time for later use
z <- paste(dfSubset$Date, dfSubset$Time)
dfSubset$DT <- strptime(z, "%Y-%m-%d %H:%M:%S")

##Begin Plot 3
par(mfrow = c(1,1))
with(dfSubset, plot(DT, Sub_metering_1, 
                    ylab = "Energy sub metering",
                    type = "n",
                    xlab = ""))
with(dfSubset, lines(DT, Sub_metering_1, type = "l"))
with(dfSubset, lines(DT, Sub_metering_2, type = "l", col = "red"))
with(dfSubset, lines(DT, Sub_metering_3, type = "l", col = "blue"))
with(dfSubset, legend("topright", 
                      legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
                      col = c("black", "red", "blue"), 
                      lty = 1))
dev.copy(png, file = "plot3.png", width = 480, height = 480, units = "px")
dev.off()






