# Exploratory Data Analysis (Coursera)
# Course Project 1
# plot2.R file

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
png(filename="plot4.png", width=480, height=480)
# plot 2x2
par(mfrow=c(2,2))
with (data, {
	# plot at position (1, 1)
	plot(x=datetime, y=Global_active_power, type="l", xlab="", ylab="Global Active Power")
	# plot at position (1, 2)
	plot(x=datetime, y=Voltage, type="l", xlab="datetime")
	# plot at position (2, 1)
	plot(x=datetime, y=Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col="black")
	lines(x=datetime, y=Sub_metering_2, col="red")
	lines(x=datetime, y=Sub_metering_3, col="blue")
	legend("topright", legend=names(data)[7:9], col=c("black", "blue", "red"), lty=1, bty="n")
	# plot at position (2, 2)
	plot(x=datetime, y=Global_reactive_power, type="l", xlab="datetime")
})
dev.off()

