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
png(file = "plot2.png")
with(power.consumption, 
     plot(DateTime, 
          Global_active_power, 
          type = "l", 
          xlab = NA, 
          ylab = "Global Active Power (kilowatts)"))
dev.off()
