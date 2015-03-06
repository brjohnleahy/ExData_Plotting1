##########################
#  plot4()
# Inputs: 
#   None
# Outputs: 
#   480 by 480 pixel png file stored in the directory data.
#
# Description:
#   This function reads a zip file from a location on the internet, unzips the file, and then proceeds to
#     generate 4 plots.
#########################
plot4 <- function(){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip";
    destZipFile <- "./data/powerconsumption.zip"
    
    # If folder doesn't exist, create it
    if(!file.exists("data")){
        fle.create("data")
    }
    
    # If file exists DON'T REDOWNLOAD, this cuts down on debugging time.
    if(!file.exists(destZipFile)){
        download.file(fileUrl,destfile=destZipFile)
    }
    
    #Unzip file and store destination file
    destFile <-unzip(destZipFile)
    
    # If the file doesn't exist there is something seriously wrong
    if(!file.exists(destFile)){
        stop("Error in download or unzip of target file")
    }
    
    # Generate Table from unzipped file
    fullTable <- read.table(destFile,
                            header=TRUE,sep=";",
                            na.strings="?",
                            colClasses = c("character", "character", rep("numeric",7)))
    
    indices <- (fullTable$Date == "1/2/2007") | (fullTable$Date == "2/2/2007")
    subMetering1 <- fullTable$Sub_metering_1[indices]
    subMetering2 <- fullTable$Sub_metering_2[indices]
    subMetering3 <- fullTable$Sub_metering_3[indices]
    globalActivePower <- fullTable$Global_active_power[indices]
    globalReactivePower <- fullTable$Global_reactive_power[indices]
    voltage <- fullTable$Voltage[indices]
    time <- strptime(paste(fullTable$Date[indices], fullTable$Time[indices], sep=" "), "%d/%m/%Y %H:%M:%S")
    
    # Create png file with graphs
    png(filename="plot4.png", width=480,height=480,units="px")
    par(mfrow=c(2,2))
    
    ##Figure Top Left
    plot(time,globalActivePower,xlab="", ylab="Global Active Power", type='n')
    lines(time,globalActivePower)
    
    ##Figure Top Right
    plot(time,voltage,xlab="datetime",ylab="Voltage",type="n")
    lines(time,voltage)
    
    ##Figure Bottom Left
    plot(time,subMetering1,xlab="", ylab="Energy sub metering", type='n')
    lines(time,subMetering1, col="black")
    lines(time,subMetering2, col="red")
    lines(time,subMetering3, col="blue")
    legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lwd=1, bty="n")
    
    ##Figure Bottom Right
    plot(time,globalReactivePower,xlab="datetime", ylab="Global_reactive_power", type='n')
    lines(time,globalReactivePower)
    
    dev.off()
}
