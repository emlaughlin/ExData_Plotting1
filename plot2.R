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

##Begin Plot 2
par(mfrow = c(1,1))
with(dfSubset, plot(DT, Global_active_power, 
                    ylab = "Global Active Power (kilowatts)",
                    pch = ".",
                    type = "n",
                    xlab = ""))
with(dfSubset, lines(DT, Global_active_power, type = "l"))

##Copy to PNG file
dev.copy(png, file = "plot2.png", width = 480, height = 480, units = "px")
dev.off()






