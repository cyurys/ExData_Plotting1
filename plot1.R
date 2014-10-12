# Exploratory Data Analysis (Coursera)
# Course Project 1
# plot1.R file

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileZip <- "household_power_consumption.zip"
file <- "household_power_consumption.txt"
dates <- c(as.Date("2007-02-01"), as.Date("2007-02-02"))

## download and unzip file if needed
if (!file.exists(file)) {
	download.file(fileUrl, destfile=fileZip)
	unzip(fileZip)
}
## load (read.table works slow)
data <- read.table(file, header=TRUE, sep=";", stringsAsFactors=FALSE)

## subset to dates
data <- data[which(as.Date(data$Date, "%d/%m/%Y") %in% dates), ]

## plot PNG 480x480
png(filename="plot1.png", width=480, height=480)
hist(as.numeric(data$Global_active_power), main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()

