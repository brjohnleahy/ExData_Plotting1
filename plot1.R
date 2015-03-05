plot1 <- function(){
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
    
    
    globalActivePower <- fullTable$Global_active_power[(fullTable$Date == "1/2/2007") |
                                                       (fullTable$Date == "2/2/2007")]
    
    png(filename="plot1.png", width=480,height=480,units="px")
    hist(globalActivePower, col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
    dev.off()
    
}