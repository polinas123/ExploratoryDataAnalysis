source("read_data.R")

# read data into data tables
data <- readData()
emissions <- data[[1]]
css <- data[[2]]

# # calculate sum of emission for each year for Baltimore city - by type
ts <- emissions[fips=="24510", lapply(.SD,sum), by = list(year, type), .SDcols = "Emissions"]

setkey(ts, "type")

# plot with ggplot:
png(filename = "plot3.png")

dev.off()