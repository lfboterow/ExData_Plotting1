# Plots 4 charts
# plot4.png

#First step is download the .ZIP¨file from the web to avoid multiple reads and
# unzipped it in my local directory /r/data
#Sets data folder Reads file
setwd("./r/Exploratory data analysis")

data<-read.table("household_power_consumption.txt",sep=";",header=TRUE)
data2<-data.frame(data,stringsAsFactors=FALSE)

i<-sapply(data2,is.factor)
data2[i]<-lapply(data2[i],as.character)

# Subsets for date range 2007-02-01 and 2007-02-02 
# Converts Date to date format
#data2[,1]=as.Date(data2[,1],format="%d/%m/%Y")
data3<-subset(data2,data2[,1]=="1/2/2007"|data[,1]=="2/2/2007" )
data3$Datetime<-paste(data3$Date, data3$Time)

# Cleans rows with ? on Global_active_power 
data4<-subset(data3,data3[,3]!="?")
data4[,3:8]<-lapply(data4[,3:8],as.numeric)


# Joins Date and time into a new column
#data4$Date <- as.Date(data4$Date, format = "%Y-%m-%d")
#data4$Time <-strptime(data4$Time,format = "%H:%M:%S")
data4$DT2 <- as.POSIXct(data4$Datetime, format="%d/%m/%Y %H:%M:%S") 

# Creates Chart
par(mfcol = c(2, 2))

# Global Active Power
plot (data4$DT2,data4$Global_active_power ,type="n",ylab="Global Active Power",xlab="",main="",bg="white")
axis(1,at=1:3,lab=c("Thu","Fri","Sat"))
lines(x=data4$DT2,y=data4$Global_active_power,type="l")

# Energy Sub metering
plot (data4$DT2,data4$Sub_metering_1 ,type="n",ylab="Energy sub metering",xlab="",main="",bg="white")
axis(1,at=1:3,lab=c("Thu","Fri","Sat"))
lines(x=data4$DT2,y=data4$Sub_metering_1,type="l",col="black")
lines(x=data4$DT2,y=data4$Sub_metering_2,type="l",col="red")
lines(x=data4$DT2,y=data4$Sub_metering_3,type="l",col="blue")
legend("topright", pch = "___", col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), bty="n")

# Voltage vs DateTime   
plot (data4$DT2,data4$Voltage ,type="n",ylab="Voltage",xlab="",main="",bg="white")
axis(1,at=1:3,lab=c("Thu","Fri","Sat"))
lines(x=data4$DT2,y=data4$Voltage,type="l",lwd=1.5,lty=1)

# Global Reactive Power vs Datetime
plot (data4$DT2,data4$ Global_reactive_power ,type="n",ylab=" Global_reactive_power",xlab="",main="",bg="white")
axis(1,at=1:3,lab=c("Thu","Fri","Sat"))
lines(x=data4$DT2,y=data4$Global_reactive_power,type="l")




# Saves it as a PNG file of 480x480 pixels
# Some viewers will render a black background, it has been documented 
# on the web. # http://www.inside-r.org/r-doc/grDevices/jpeg
dev.copy(png,"plot4.png",width=480,height=480,units="px",bg="white")
dev.off()

