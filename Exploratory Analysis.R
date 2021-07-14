##Proyecto

##########
##########
library(data.table)

##Opening and unziping dataset

getwd()
direccion="C:/Users/user/Downloads/exdata_data_household_power_consumption.zip"
unzip(direccion,exdir = "./power_consumption")



data= data.table::fread(input = "./power_consumption/household_power_consumption.txt"
                        , na.strings="?")
View(data)

##Plot 1


#We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative 
#is to read the data from just those dates rather than reading in the entire dataset and subsetting
#to those dates.

#Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.

#Your code file should include code for reading the data so that the plot can be fully reproduced.
#You must also include the code that creates the PNG file.


d_electric= data
names(d_electric)
str(d_electric)
View(d_electric)

#setting date with date format
d_electric[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

#setting filtter to include just specifics dates
d_electric=d_electric[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

#Format file
png("plot1.png", width=480, height=480)

#Histogram
hist(d_electric[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()

##Plot 2


data= data.table::fread(input = "./power_consumption/household_power_consumption.txt"
                        , na.strings="?")
d_electric= data

#setting date with date format
d_electric[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

#setting date and time with date format to build a new dateTime variable
d_electric[, dateTime := as.POSIXct(paste(Date, Time), tryformat = "%d/%m/%Y %H:%M:%S")]


#Filttering data
d_electric=d_electric[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

#Format and graph
png("plot2.png", width=480, height=480)

plot(x = d_electric[, dateTime]
     , y = d_electric[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()


##Plot 3

data= data.table::fread(input = "./power_consumption/household_power_consumption.txt"
                        , na.strings="?")
d_electric= data

#setting date with date format
d_electric[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

#setting date and time with date format to build a new dateTime variable
d_electric[, dateTime := as.POSIXct(paste(Date, Time), tryformat = "%d/%m/%Y %H:%M:%S")]

#Filttering data
d_electric=d_electric[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

#Format and graph
png("plot3.png", width=480, height=480)

plot(d_electric[, dateTime], d_electric[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(d_electric[, dateTime], d_electric[, Sub_metering_2],col="red")
lines(d_electric[, dateTime], d_electric[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1))

dev.off()


##Plot 4

data= data.table::fread(input = "./power_consumption/household_power_consumption.txt"
                        , na.strings="?")
d_electric= data

#setting date with date format
d_electric[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

#setting date and time with date format to build a new dateTime variable
d_electric[, dateTime := as.POSIXct(paste(Date, Time), tryformat = "%d/%m/%Y %H:%M:%S")]

#Filttering data
d_electric=d_electric[(Date >= "2007-02-01") & (Date <= "2007-02-02")]


#Format and graph

png("plot4.png", width=480, height=480)

#Graphs 
#####
#####


par(mfrow=c(2,2))

# Plot 1
plot(d_electric[, dateTime], d_electric[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(d_electric[, dateTime],d_electric[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# Plot 3
plot(d_electric[, dateTime], d_electric[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(d_electric[, dateTime], d_electric[, Sub_metering_2], col="red")
lines(d_electric[, dateTime], d_electric[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

# Plot 4
plot(d_electric[, dateTime], d_electric[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
