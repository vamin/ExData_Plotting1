# get col names and classes
power.consumption.100 <- read.table("data/household_power_consumption.txt", 
                                    header = TRUE, 
                                    sep = ";", 
                                    stringsAsFactors = FALSE, 
                                    nrows = 100)
col.names <- colnames(power.consumption.100)
classes <- sapply(power.consumption.100, class)
# read in data for 1/2/2007 and 2/2/2007
power.consumption <- read.table(pipe('grep "^[1-2]/2/2007" "data/household_power_consumption.txt"'), 
                                header = TRUE, 
                                sep = ";",
                                na.strings = c("?"), 
                                col.names = col.names, 
                                colClasses = classes)
# plot graph
png(file = "plot1.png")
hist(power.consumption$Global_active_power, 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", 
     col="red")
dev.off()