## load the dataset
## set global variables 
setglobalVariable <- function(){
        y<<-NULL
       
}   
    
readFile<- function(fname){
        x<-read.csv(fname, sep=";", na.strings="?", colClasses=c(rep("character", 2), rep("numeric",7)))
        x <- subset(x, Date == "1/2/2007"| Date=="2/2/2007")
        ##xy<-x
        ## subset the data table - not a data frame. 
        ## x$Date <-as.Date(x$Date, "%d/%m/%Y")
        ## Convert the Date field to Date format
        ## x$Time <- hms(x$Time)
        ## convert the Time field to Time class
        x$Date <- strptime(paste(x$Date, x$Time, " "),"%d/%m/%Y %H:%M:%S")
        y<<-x
}
## retreive data and load into global variable
getfile<- function(){
        if(file.exists("household_power_consumption.csv")){
                readFile("household_power_consumption.csv")
                              
        } else {
                temp <- tempfile()
                ## Create a temp file to hold the Zipped file
                download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
                ## Download the zipped file to temp
                temp<-unzip(temp,files="household_power_consumption.csv")
                ## unzip the temp file to household_power_consumption.csv
                readFile(temp)
                ## read temp identifying headers, colon separators, and question marks as NAs
                unlink(temp)
                readFile("household_power_consumption.csv")
        }
        
}

## check if global variable is null, if it is retrieve file
if(exists("y", mode = "any")){
        if(is.null(y)){ 
                getfile()
        }
} else {
        setglobalVariable() 
        getfile()
        ##return(y)
}



## Plot1 creates file Plot1.png
png(filename = "plot3.png", width = 480, height = 480, units = "px", bg = "transparent")
plot(y$Date, y$Sub_metering_1, type='l', axes=TRUE, xlab="", ylab="Energy sub metering", col="black")
lines(y$Date, y$Sub_metering_2, col="red")
lines(y$Date, y$Sub_metering_3, col="blue")
legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1)
dev.off()
