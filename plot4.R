# get col names and classes
power.consumption.100 <- read.table("data/household_power_consumption.txt", 
                                    header = TRUE, 
                                    sep = ";", 
                                    stringsAsFactors = FALSE, 
                                    nrows = 100)
col.names <- colnames(power.consumption.100)
col.classes <- sapply(power.consumption.100, class)
# read in data for 1/2/2007 and 2/2/2007
power.consumption <- read.table(pipe('grep "^[1-2]/2/2007" "data/household_power_consumption.txt"'), 
                                header = FALSE, 
                                sep = ";",
                                na.strings = c("?"), 
                                col.names = col.names, 
                                colClasses = col.classes)
# convert date and time to single date variable
power.consumption$DateTime <- strptime(paste(power.consumption$Date, 
                                             power.consumption$Time), 
                                       format = "%d/%m/%Y %H:%M:%S")
# plot graph
png(file = "plot4.png")
par(mfcol = c(2, 2))
# plot 2
with(power.consumption, 
     plot(DateTime, 
          Global_active_power, 
          type = "l", 
          xlab = NA, 
          ylab = "Global Active Power (kilowatts)"))
# plot 3
with(power.consumption, 
     plot(DateTime, 
          Sub_metering_1, 
          type = "n", 
          xlab = NA, 
          ylab = "Energy sub metering"))
lines(power.consumption$DateTime, power.consumption$Sub_metering_1)
lines(power.consumption$DateTime, power.consumption$Sub_metering_2, col = "red")
lines(power.consumption$DateTime, power.consumption$Sub_metering_3, col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1, 1, 1), 
       col = c("black", "red", "blue"))
# voltage vs datetime
with(power.consumption, 
     plot(DateTime, 
          Voltage, 
          type = "l",
          xlab = "datetime"))
# global reactive power vs datetime
with(power.consumption, 
     plot(DateTime, 
          Global_reactive_power, 
          type = "l",
          xlab = "datetime"))
dev.off()
