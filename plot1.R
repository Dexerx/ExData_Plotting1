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

hist(subset$Global_active_power, xlab="Global Active Power (Kilowatts)", col="Orange", main="Global Active Power")
dev.copy(png,file="plot1.png",width=480,height=480)
dev.off()
