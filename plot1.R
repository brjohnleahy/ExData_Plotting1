##########################
#  plot1()
# Inputs: 
#   None
# Outputs: 
#   480 by 480 pixel png file stored in the directory data.
#
# Description:
#   This function reads a zip file from a location on the internet, unzips the file, and then proceeds to
#     generate a histogram of the Global Active Power.
#########################
plot1 <- function(){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip";
    destZipFile <- "./data/powerconsumption.zip"
    
    #    # If folder doesn't exist, create it
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
    
    
    globalActivePower <- fullTable$Global_active_power[(fullTable$Date == "1/2/2007") |
                                                       (fullTable$Date == "2/2/2007")]
    
    #Generate png file with Histogram
    png(filename="plot1.png", width=480,height=480,units="px")
    hist(globalActivePower, col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
    dev.off()
    
}