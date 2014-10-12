# Exploratory Data Analysis (Coursera)
# Course Project 1
# plot3.R file

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
data$datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

# Unnecessary sring, but otherwise you get weekdays in your language (which may be not "en_US")
Sys.setlocale("LC_TIME", "en_US")

## plot PNG 480x480
png(filename="plot3.png", width=480, height=480)
plot(x=data$datetime, y=data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col="black")
lines(x=data$datetime, y=data$Sub_metering_2, col="red")
lines(x=data$datetime, y=data$Sub_metering_3, col="blue")
legend("topright", legend=names(data)[7:9], col=c("black", "blue", "red"), lty=1)
dev.off()

