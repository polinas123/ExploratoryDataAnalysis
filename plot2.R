source("read_data.R")

# read data into data tables
data <- readData()
emissions <- data[[1]]
css <- data[[2]]

# calculate sum of emission for each year for Baltimore city
ts <- emissions[fips=="24510", lapply(.SD,sum), by = "year", .SDcols = "Emissions"]

# plot to PNG device
png(filename = "plot2.png")
plot(ts, main = "total PM2.5 emission from all sources - Baltimore city", type = "l")
dev.off()