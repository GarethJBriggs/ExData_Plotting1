        library(lubridate)
        ## generates a plot of Datetime vs Global Active Power
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
        ## set margin parameters
        par(mfrow = c(1,1), mar = c(3,4,0,2))
        ## plot data
        with(hpc_df, plot(Datetime, Global_active_power, xlab = " ", ylab = 
                "Global Active Power (kilowatts)" , type = "l" ))
        ##copy to PNG file
         dev.copy(png, file = "plot2.png")
        ## reset devices
        dev.off()