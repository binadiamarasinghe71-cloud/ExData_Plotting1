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

# Create plot2.png
png(filename = "plot2.png", width = 480, height = 480)

plot(data_sub$Datetime, data_sub$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

dev.off()