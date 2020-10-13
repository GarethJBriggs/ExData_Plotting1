        library(lubridate)
        library(png)
        ## read household_power_consumption.txt for specified dates
        hpc_df <- read.table(file = "household_power_consumption.txt", header 
                = FALSE, sep = ";", skip = 66637, nrows = 2880,
                na.strings = "?", stringsAsFactors = FALSE,)
        header <- read.table(file = "household_power_consumption.txt", header =
                FALSE, stringsAsFactors = FALSE, nrows = 1, sep = ";")
        colnames(hpc_df) <- header
        ## subset out Global Intensity
        hpc_df <- hpc_df[, c(1:5, 7:9)]
        ## remove NA values
        good <- complete.cases(hpc_df)
        hpc_df <- hpc_df[good,]
        ## create Datetime column
        hpc_df$Datetime <- 0
        ## fill Date time column with values
        hpc_df$Datetime <- dmy_hms(paste(hpc_df$Date, hpc_df$Time))
        ## remove Date and Time columns
        hpc_df <- hpc_df[,3:9]
        ## set up the png
        png(filename = "plot4.png")
        ##set the parameters
        par(mfrow = c(2,2), mar = c(6,4,0,2))
        ## plot Global_active_power data
        with(hpc_df, plot(Datetime, Global_active_power, xlab = " ", ylab = 
                                  "Global Active Power" , type = "l" ))
        ## plot VOltage data
        with(hpc_df, plot(Datetime, Voltage, xlab = "datetime", 
                          ylab = "Voltage" , type = "l" ))
        ## plot the Sub_metering data
        with(hpc_df, plot(Datetime, Sub_metering_1, xlab = " ", ylab =  
                                  "Energy sub metering", type = "l" ))
        ## add Sub_meter_2 points
        with(hpc_df, points(Datetime, y = Sub_metering_2, type = "l",
                            col = "red"))
        ## add Sub_meter_3 points
        with(hpc_df, points(Datetime, y = Sub_metering_3, type = "l", 
                            col = "blue"))
        ## add legend
        legend("topright", col = c("black", "red", "blue"), lty = 1,
               legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
               bty = "n", cex = 0.90, lwd = 2)
        ## plot Global_Reactive_power data
        with(hpc_df, plot(Datetime, Global_reactive_power, xlab = "datetime", 
                          ylab = "Global_reactive_power" , type = "l" ))
        ## reset devices
        dev.off()