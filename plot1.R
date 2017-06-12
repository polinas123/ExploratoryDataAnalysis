source("read_data.R")

# read data into data tables
data <- readData()
emissions <- data[[1]]
css <- data[[2]]

# calculate sum of emission for each year
ts <- emissions[, lapply(.SD,sum), by = "year", .SDcols = "Emissions"]

# plot to PNG device
png(filename = "plot1.png")
plot(ts, main = "total PM2.5 emission from all sources", type = "l")
dev.off()