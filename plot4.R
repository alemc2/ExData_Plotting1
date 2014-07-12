library(sqldf)
#using this library to filter out only those dates required while reading itself.

#read the file extracting data for only the required days using sql query
data_sql <- read.csv2.sql("household_power_consumption.txt"
                          ,sql=" SELECT * FROM file where Date='1/2/2007' OR Date='2/2/2007'"
                          ,na.strings="?")

#add a new field which puts the data and time together and indicates a POSIX time
data_sql$DatenTime <- strptime(paste(data_sql$Date, data_sql$Time), 
                               "%d/%m/%Y %H:%M:%S")

#make it a 2,2 multiplot and arrange plotting columnwise
par(mfcol=c(2,2))

#Plot all the required points for display
#Plot the global active power vs the new DatenTime field for display 
#(subplot 1,1)
plot(data_sql$DatenTime, 
     data_sql$Global_active_power, 
     type="l", 
     xlab="", 
     ylab="Global Active Power (kilowatts)")

#Plot each sub metering power with different colors vs the new DatenTime field for display 
#(subplot 1,2)
plot(data_sql$DatenTime, 
     data_sql$Sub_metering_1, 
     type="l", 
     xlab="", 
     ylab="Energy sub metering")
lines(data_sql$DatenTime, data_sql$Sub_metering_2, col='red')
lines(data_sql$DatenTime, data_sql$Sub_metering_3, col='blue')
legend('topright', 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1),
       col = c('black', 'red', 'blue'),
       bty = "n")

#plot the voltages vs new DatenTime field for display
#(subplot 2,1)
plot(data_sql$DatenTime, data_sql$Voltage, ylab="Voltage", xlab="datetime", type="l")

#plot the global reactive power vs the new DatenTime field for display 
#(subplot 2,2)
plot(data_sql$DatenTime, data_sql$Global_reactive_power, ylab="Global_reactive_power",
     xlab="datetime", type="l")

#open png device handle for a png file within the same directory.
png(filename = "plot4.png",
    width = 480, height = 480, 
    bg = "white")

#make it a 2,2 multiplot and arrange plotting columnwise
par(mfcol=c(2,2))

#Plot the same data again but this time it'll be dumped in the png
#Plot the global active power vs the new DatenTime field for dumping 
#(subplot 1,1)
plot(data_sql$DatenTime, 
     data_sql$Global_active_power, 
     type="l", 
     xlab="", 
     ylab="Global Active Power (kilowatts)")

#Plot each sub metering power with different colors vs the new DatenTime field for dumping 
#(subplot 1,2)
plot(data_sql$DatenTime, 
     data_sql$Sub_metering_1, 
     type="l", 
     xlab="", 
     ylab="Energy sub metering")
lines(data_sql$DatenTime, data_sql$Sub_metering_2, col='red')
lines(data_sql$DatenTime, data_sql$Sub_metering_3, col='blue')
legend('topright', 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1),
       col = c('black', 'red', 'blue'),
       bty = "n")

#plot the voltages vs new DatenTime field for dumping
#(subplot 2,1)
plot(data_sql$DatenTime, data_sql$Voltage, ylab="Voltage", xlab="datetime", type="l")

#plot the global reactive power vs the new DatenTime field for dumping 
#(subplot 2,2)
plot(data_sql$DatenTime, data_sql$Global_reactive_power, ylab="Global_reactive_power",
     xlab="datetime", type="l")

#Close the png
dev.off()