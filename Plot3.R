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

##Plot 3


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
png("plot3.png", width=480, height=480)

plot(d_electric[, dateTime], d_electric[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(d_electric[, dateTime], d_electric[, Sub_metering_2],col="red")
lines(d_electric[, dateTime], d_electric[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1))

dev.off()
