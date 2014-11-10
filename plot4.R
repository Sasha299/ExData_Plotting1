## load the dataset
## set global variables 
        setglobalVariable <- function(){
                y<<-NULL
        }   
## retreive data and load into global variable
        getfile<- function(){
                temp <- tempfile()
                ## Create a temp file to hold the Zipped file
                download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
                ## Download the zipped file to temp
                temp<-unzip(temp,files="household_power_consumption.txt")
                ## unzip the temp file to household_power_consumption.txt
                x<-read.csv(temp, sep=";", na.strings="?")
                ## read temp identifying headers, colon separators, and question marks as NAs
                unlink(temp)
                ## disconnect from read file
                xy <- subset(x, Date == '1/2/2007'| Date=='2/2/2007')
                ## subset the data table - not a data frame. 
                xy$Date <-as.Date(xy$Date, "%d/%m/%Y")
                ## Convert the Date field to Date format
                xy$Time <- times(xy$Time)
                ## convert the Time field to Time class
                y<<-xy
        }

## check if global variable is null, if it is retrieve file
if(is.null(y)){
        setglobalVariable() 
        getfile()
        ##return(y)
}

## Plot1 creates file Plot1.png
png(filename = "plot41.png", width = 480, height = 480, units = "px", bg = "transparent")
        par(mfrow = c(2, 2))
        ## First Graph
        plot(y$Global_active_power, type='l', xlab="Gobal Active Power (kilowatts)", ylab="Frequency")
        ## Second graph
        plot(y$Voltage, type='l', axes=FALSE, xlab="datetime", ylab="Voltage")      
        ## Third Graph
        plot(y$Sub_metering_1, type='l', axes=TRUE, xlab="", ylab="Energy sub metering", col="black")
        lines(y$Sub_metering_2, col="red")
        lines(y$Sub_metering_3, col="blue")
        legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1)
        ## Fourth Graph
        plot(y$Global_reactive_power, type='l', axes=FALSE, xlab="datetime", ylab="Global_Reactive_Power")
        dev.off()