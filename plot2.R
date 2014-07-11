# Our overall goal here is simply to examine how household energy usage varies over a 2-day period in February, 2007. The task is to reconstruct the following plots below,  using the base plotting system.:

# Plot2.png is the ourcome of this code, it displays a graphic representation of the Global Active Power over the 2 selected datesand scaled in Kilowatts

# The following descriptions of the 9 variables in the dataset are taken from the UCI web site:
#         
# Date: Date in format dd/mm/yyyy
# Time: time in format hh:mm:ss
# Global_active_power: household global minute-averaged active power (in kilowatt)
# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# Voltage: minute-averaged voltage (in volt)
# Global_intensity: household global minute-averaged current intensity (in ampere)
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.


## Set the Working Directory back to base
setwd("~/$R")
getwd()

#Create data Directory if does not exists
if (!file.exists("data")) {dir.create("data")}
setwd("./Data")
#Download raw data to data folder
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists("power.zip")){download.file(fileURL, destfile="power.zip")}
file <- "./household_power_consumption.txt"

# Unzipping the file inside the Data Filder
if (!file.exists(file)){unzip("./power.zip")}

# Loading the data file into the table, reading all 70K then subsetting table
reqDates <- c("1/2/2007", "2/2/2007")
data <- read.table(file, header = TRUE, sep = ";", nrows = 70000, quote = "", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), stringsAsFactors = FALSE, na.strings="?")
data <- (data[which(data$Date %in% reqDates ),])


# Setting un the time & date in the required format POSIXct is better
data$Date<- strptime(data$Date, "%d/%m/%Y")
data$Daytime <- paste(data$Date, data$Time)
data$Daytime <- as.POSIXct(data$Daytime)

# Start PNG device, generate graph right into plot1.png file, close device
png(filename = "plot2.png", width = 480, height = 480, units = "px", pointsize = 12, res = NA, family = "", restoreConsole = TRUE, type = c("windows", "cairo", "cairo-png"))
# Create the plot into the specified file: plot2.png
plot(data$Daytime, data$Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off() # Must close off dev in order to finish the copying

