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
        ## Convert the Date field to Date format
        ## convert the Time field to Time class
        x$Date <- strptime(paste(x$Date, x$Time, " "), "%d/%m/%Y %H:%M:%S")
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



## Plot2 creates file Plot2.png
png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "transparent")
plot(y$Date, y$Global_active_power, type='l', xlab="", ylab="Global Active Power (kilowatts)")
axis(side=1, at=1:3)
axis(side=2)
box()
dev.off()

