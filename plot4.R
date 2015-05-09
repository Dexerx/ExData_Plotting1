library(utils)

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,destfile="./householdconsumption.zip")
unzip("./householdconsumption.zip")
data <- read.table("./household_power_consumption.txt", sep=";", na.string="?",header=TRUE)

subset1 <- subset(data, Date=="1/2/2007")
subset2 <- subset(data, Date=="2/2/2007")

subset <- rbind(subset1,subset2)

subset$Date=as.Date(subset$Date, "%d/%m/%Y")


rm(subset1)
rm(subset2)
rm(data)

subset$NewDate = strptime(paste(as.character(subset$Date),as.character(subset$Time)),format="%Y-%m-%d %H:%M:%S")

legend <- names(subset[,7:9])
par(mfrow=c(2,2))

plot(subset$NewDate,subset$Global_active_power,type="l",ylab="Global Active Power",xlab="")

plot(subset$NewDate,subset$Voltage,type="l",ylab="Voltage",xlab="datetime")

plot(subset$NewDate,subset$Sub_metering_1,ylim=c(0,40),type="l",ylab="Energy Submetering",xlab="",)
par(new=T)
plot(subset$NewDate,subset$Sub_metering_2,ylim=c(0,40),col="red",type="l",ylab="",xlab="")
par(new=T)
plot(subset$NewDate,subset$Sub_metering_3,ylim=c(0,40),col="blue",type="l",ylab="",xlab="")
legend("topright",legend,lty=1,col=c("black","red","blue"),cex=.8,inset=.24)

plot(subset$NewDate,subset$Global_reactive_power,type="l",ylab=names(subset)[4],xlab="datetime")

dev.copy(png, file="plot4.png",width=480,height=480)

dev.off()

