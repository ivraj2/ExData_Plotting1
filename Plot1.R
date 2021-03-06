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
  
  #Construct the plot
  png(file="Plot1.png", width = 480, height = 480, units = "px")
  hist(sd$Global_active_power, col="red", main="Global Active Power", ylim=c(0,1200), xlab="Global Active Power (kilowats)")
  dev.off()
  print("Done.")
  
}



