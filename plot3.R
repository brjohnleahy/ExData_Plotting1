plot3 <- function(){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip";
    destZipFile <- "./data/powerconsumption.zip"
    
    # If folder doesn't exist, create it
    if(!file.exists("data")){
        fle.create("data")
    }
    if(!file.exists(destZipFile)){
        download.file(fileUrl,destfile=destZipFile)
    }
    
    
    destFile <-unzip(destZipFile)
    
    if(!file.exists(destFile)){
        stop("Error in download or unzip of target file")
    }
    
    fullTable <- read.table(destFile,
                            header=TRUE,sep=";",
                            na.strings="?",
                            colClasses = c("character", "character", rep("numeric",7)))
    
    indices <- (fullTable$Date == "1/2/2007") | (fullTable$Date == "2/2/2007")
    subMetering1 <- fullTable$Sub_metering_1[indices]
    subMetering2 <- fullTable$Sub_metering_2[indices]
    subMetering3 <- fullTable$Sub_metering_3[indices]
    time <- strptime(paste(fullTable$Date[indices], fullTable$Time[indices], sep=" "), "%d/%m/%Y %H:%M:%S")
    
    png(filename="plot3.png", width=480,height=480,units="px")
    plot(time,subMetering1,xlab="", ylab="Energy sub metering", type='n')
    lines(time,subMetering1, col="black")
    lines(time,subMetering2, col="red")
    lines(time,subMetering3, col="blue")
    legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lwd=1)
    dev.off()
}
