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
