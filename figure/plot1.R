# set your own working directory
setwd("C:/research/john hopkins R/Principles of Analytic Graphics/week 1")

# download and unzip the file
if(!file.exists("exdata-data-household_power_consumption.zip")) {
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}

# load data
# install.packages("data.table")
library(data.table)
power.data <- read.table(file, header=T, sep=";")
head(power.data)

# change the format of date
power.data$Date <- as.Date(power.data$Date, format="%d/%m/%Y")

# extract the data collected on "2007-02-01" or "2007-02-02"
df <- power.data[(power.data$Date=="2007-02-01") | (power.data$Date=="2007-02-02"),]

# convert variables to appropriate types
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
df$Voltage <- as.numeric(as.character(df$Voltage))
df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))

# plot 1
plot1 <- function() {
  hist(df$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)")
  dev.copy(png, file="plot1.png", width=480, height=480)
  dev.off()
  cat("Plot1.png has been saved in", getwd())
}
plot1()
