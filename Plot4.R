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

##Plot 4


d_electric= data
names(d_electric)
str(d_electric)
View(d_electric)


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

