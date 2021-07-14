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

##Plot 2


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
png("plot2.png", width=480, height=480)

plot(x = d_electric[, dateTime]
     , y = d_electric[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()
