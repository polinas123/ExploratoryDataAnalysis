source("read_data.R")

# read data into data tables
data <- readData()
emissions <- data[[1]]
css <- data[[2]]

# get SCC codes for coal related emissions
motor.loc = grep(x = scc$Short.Name, "Motor")
vehicle.loc = grep(x = scc$Short.Name, "Veh")
scc.index = scc[unique(c(motor.loc, vehicle.loc)), "SCC"]

# calculate sum of emission for each year in Baltimore city
setkey(emissions, "SCC")
ts <- emissions[fips == "24510",][.(scc.index), lapply(.SD,sum), by = "year", .SDcols = "Emissions"]

setkey(ts, "year")

# plot to PNG device
png(filename = "plot5.png")
plot(ts, main = "total PM2.5 emission from motor vehicles in Baltimore city", type = "l")
dev.off()