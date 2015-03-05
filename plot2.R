plot2 <- function(){
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
    globalActivePower <- fullTable$Global_active_power[indices]
    time <- strptime(paste(fullTable$Date[indices], fullTable$Time[indices], sep=" "), "%d/%m/%Y %H:%M:%S")
    
    png(filename="plot2.png", width=480,height=480,units="px")
    plot(time,globalActivePower,xlab="", ylab="Global Active Power (kilowatts)", type='n')
    lines(time,globalActivePower)
    dev.off()
    
}