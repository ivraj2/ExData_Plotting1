# Required libraries 
require(dplyr)


# Check input data. If dataset is not found, report the problem and exit, otherwise continue. 
source_file <- "household_power_consumption.txt"
if(!file.exists(source_file)){
  print(paste("Missing source file: ",source_file))
  return()
}else{ # Source data seems to be be there, so continue processing.
  
  # set up a generic date parsing function
  setClass("myDate")
  setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )
  print("Reading data...")
  solar_data <- read.csv2("household_power_consumption.txt",sep=";",colClasses=c("myDate","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),dec=".",na.strings="?")
  sd <- filter(solar_data,Date>=as.Date("2007-02-01")&Date<as.Date("2007-02-03"))
  solar_data <- NULL #Free up memory
  xlbls <- c(0,nrow(sd)/2,nrow(sd))
  
  png(file="Plot4.png", width = 480, height = 480, units = "px")
  par(mfrow=c(2,2))
  plot(sd$Global_active_power, xlab="Voltage",  type="n", xaxt="n", ylab="Global Active Power (kilowats)")
  lines(sd$Global_active_power)
  axis(1, at=xlbls, labels=c("Thu","Fri","Sat"))
  
  plot(sd$Voltage, xlab="datetime",  type="n", xaxt="n", ylab="Voltage")
  lines(sd$Voltage)
  axis(1, at=xlbls, labels=c("Thu","Fri","Sat"))
  
  plot(sd$Sub_metering_1,type="n", xaxt="n",xlab="", ylab="Energy sub metering")
  lines(sd$Sub_metering_2,col="red")
  lines(sd$Sub_metering_1)
  lines(sd$Sub_metering_3,col="blue")
  legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"),bty = "n")
  axis(1, at=xlbls, labels=c("Thu","Fri","Sat"))
  
  
  plot(sd$Global_reactive_power, xlab="datetime",  type="n", xaxt="n", ylab="Global_reactive_power")
  lines(sd$Global_reactive_power)
  axis(1, at=xlbls, labels=c("Thu","Fri","Sat"))
  dev.off()
  print("Done.")
  
 
  
}