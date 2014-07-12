library(sqldf)
#using this library to filter out only those dates required while reading itself.

#read the file extracting data for only the required days using sql query
data_sql <- read.csv2.sql("household_power_consumption.txt"
                          ,sql=" SELECT * FROM file where Date='1/2/2007' OR Date='2/2/2007'"
                          ,na.strings="?")

#add a new field which puts the data and time together and indicates a POSIX time
data_sql$DatenTime <- strptime(paste(data_sql$Date, data_sql$Time), 
                          "%d/%m/%Y %H:%M:%S")

#Plot the global active power vs the new DatenTime field for display
plot(data_sql$DatenTime, 
     data_sql$Global_active_power, 
     type="l", 
     xlab="", 
     ylab="Global Active Power (kilowatts)")

#open png device handle for a png file within the same directory.
png(filename = "plot2.png",
    width = 480, height = 480, 
    bg = "white")

#Plot the same data again but this time it'll be dumped in the png
plot(data_sql$DatenTime, 
     data_sql$Global_active_power, 
     type="l", 
     xlab="", 
     ylab="Global Active Power (kilowatts)")

#Close the png
dev.off()