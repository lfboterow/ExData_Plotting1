# Plots for Individual household electric power consumption Data Set
# plot1.png

#First step is download the .ZIP¨file from the web to avoid multiple reads and
# unzipped it in my local directory /r/data
#Sets data folder Reads file
setwd("./r/Exploratory data analysis")

data<-read.table("household_power_consumption.txt",sep=";",header=TRUE)
data2<-data.frame(data,stringsAsFactors=FALSE)
# Converts Date to date format
#data2[,1]=as.Date(data2[,1],format="%d/%m/%Y")

i<-sapply(data2,is.factor)
data2[i]<-lapply(data2[i],as.character)

# Subsets for date range 2007-02-01 and 2007-02-02 
data3<-subset(data2,data2[,1]=="1/2/2007"|data[,1]=="2/2/2007" )

# Cleans rows with ? on Global_active_power 
data4<-subset(data3,data2[,3]!="?")
data4[,3:8]<-lapply(data4[,3:8],as.numeric)

# Creates histogram
hist(table(data4$Global_active_power),xlab="Global Active Power (kilowatts)",main="Global Active Power",col="red",bg="white")

# Saves it as a PNG file of 480x480 pixels
# Some viewers will render a black background, it has been documented 
# on the web. # http://www.inside-r.org/r-doc/grDevices/jpeg
dev.copy(png,"plot1.png",width=480,height=480,units="px",bg="transparent")
dev.off()

