library(sqldf)
#using this library to filter out only those dates required while reading itself.

#read the file extracting data for only the required days using sql query
data_sql <- read.csv2.sql("household_power_consumption.txt"
                          ,sql=" SELECT * FROM file where Date='1/2/2007' OR Date='2/2/2007'"
                          ,na.strings="?")

#Plot the histogram of the required field in red color with appropriate labels.
#this plotting is done for viewing from, plotted again later to dump to png.
hist(data_sql$Global_active_power,col="red"
     ,xlab="Global Active Power (kilowatts)"
     ,ylab="Frequency",main="Global Active Power")

#open png device handle for a png file within the same directory.
png(filename = "plot1.png",
    width = 480, height = 480, 
    bg = "white")

#Plot the same data again but this time it'll be dumped in the png
hist(data_sql$Global_active_power,col="red"
     ,xlab="Global Active Power (kilowatts)"
     ,ylab="Frequency",main="Global Active Power")

#Close the png
dev.off()