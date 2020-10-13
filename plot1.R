        library(lubridate)
        ## read household_power_consumption.txt for specified dates
        hpc_df <- read.table(file = "household_power_consumption.txt", header 
                = FALSE, sep = ";", skip = 66637, nrows = 2880,
                na.strings = "?", stringsAsFactors = FALSE,)
        header <- read.table(file = "household_power_consumption.txt", header 
                = FALSE, stringsAsFactors = FALSE, nrows = 1, sep = ";")
        colnames(hpc_df) <- header
        ## subset out Global Intensity
        hpc_df <- hpc_df[, c(1:5, 7:9)]
        ## remove NA values
        good <- complete.cases(hpc_df)
        ## create Datetime column
        hpc_df$Datetime <- 0
        ## fill Date time column with values
        hpc_df$Datetime <- dmy_hms(paste(hpc_df$Date, hpc_df$Time))
        ## remove Date and Time columns
        hpc_df <- hpc_df[,3:9]
        ## set margins via parameters
        par(mfrow = c(1,1), mar = c(4,4,4,1)) 
        ## plot histogram
        hist(hpc_df$Global_active_power, col = "red", xlab = 
                 "Global Active Power (kilowatts)", ylab = "Frequency",
                main = "Global Active Power") 
        ##write to PNG
        dev.copy(png, file = "plot1.png")
        ## reset devices
        dev.off()
        