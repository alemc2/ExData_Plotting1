library(sqldf)
#using this library to filter out only those dates required while reading itself.

#read the file extracting data for only the required days using sql query
data_sql <- read.csv2.sql("household_power_consumption.txt"
                          ,sql=" SELECT * FROM file where Date='1/2/2007' OR Date='2/2/2007'"
                          ,na.strings="?")

#add a new field which puts the data and time together and indicates a POSIX time
data_sql$DatenTime <- strptime(paste(data_sql$Date, data_sql$Time), 
                               "%d/%m/%Y %H:%M:%S")

#Plot each sub metering power with different colors vs the new DatenTime field for display
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
       col = c('black', 'red', 'blue'))

#open png device handle for a png file within the same directory.
png(filename = "plot3.png",
    width = 480, height = 480, 
    bg = "white")

#Plot the same data again but this time it'll be dumped in the png
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
       col = c('black', 'red', 'blue'))

#Close the png
dev.off()