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

png(file="Plot3.png", width = 480, height = 480, units = "px")
plot(sd$Sub_metering_1,type="n", xaxt="n",xlab="", ylab="Energy sub metering")
lines(sd$Sub_metering_2,col="red")
lines(sd$Sub_metering_1)
lines(sd$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"))
axis(1, at=1:3, labels=c("Thu","Fri","Sat"))
dev.off()
print("Done.")

}


