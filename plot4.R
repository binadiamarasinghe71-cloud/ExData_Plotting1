# Download and unzip data if not present
txt_file <- "household_power_consumption.txt"
if (!file.exists(txt_file)) {
  dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(dataset_url, "household_power_consumption.zip")
  unzip("household_power_consumption.zip")
}

# Read and subset data
data <- read.table(txt_file, header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)
data_sub <- data[data$Date %in% c("1/2/2007", "2/2/2007"), ]
data_sub$Datetime <- as.POSIXct(paste(data_sub$Date, data_sub$Time), format = "%d/%m/%Y %H:%M:%S")

# Create plot4.png
png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))

# Top-left plot: Global Active Power
plot(data_sub$Datetime, data_sub$Global_active_power,
     type = "l", xlab = "", ylab = "Global Active Power")

# Top-right plot: Voltage
plot(data_sub$Datetime, data_sub$Voltage,
     type = "l", xlab = "datetime", ylab = "Voltage")

# Bottom-left plot: Energy Sub-Metering
plot(data_sub$Datetime, data_sub$Sub_metering_1, type = "l", col = "black",
     xlab = "", ylab = "Energy sub metering")
lines(data_sub$Datetime, data_sub$Sub_metering_2, col = "red")
lines(data_sub$Datetime, data_sub$Sub_metering_3, col = "blue")
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1,
       bty = "n")

# Bottom-right plot: Global Reactive Power
plot(data_sub$Datetime, data_sub$Global_reactive_power,
     type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()