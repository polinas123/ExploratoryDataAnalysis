source("read_data.R")

# read data into data tables
data <- readData()
emissions <- data[[1]]
css <- data[[2]]

# get SCC codes for coal related emissions
motor.loc = grep(x = scc$Short.Name, "Motor")
vehicle.loc = grep(x = scc$Short.Name, "Veh")
scc.index = scc[unique(c(motor.loc, vehicle.loc)), "SCC"]

# calculate sum of emission for each year in Baltimore city and LA county
setkey(emissions, "SCC")
ts1 <- emissions[fips == "24510",][.(scc.index), lapply(.SD,sum), by = "year", .SDcols = "Emissions"]
ts2 <- emissions[fips == "06037",][.(scc.index), lapply(.SD,sum), by = "year", .SDcols = "Emissions"]

setkey(ts1, "year")
setkey(ts2, "year")

# plot to PNG device
png(filename = "plot6.png")
par(mfrow = c(2,1))
plot(ts1, main = "Baltimore city", type = "l")
plot(ts2, main = "LA county", type = "l")
dev.off()