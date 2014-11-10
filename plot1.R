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
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "transparent")
hist(y$Global_active_power, xlab="Gobal Active Power (kilowatts)", ylab="Frequency", main="Global Active Power", col="red")
dev.off()