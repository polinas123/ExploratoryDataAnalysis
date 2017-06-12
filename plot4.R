source("read_data.R")

# read data into data tables
data <- readData()
emissions <- data[[1]]
css <- data[[2]]

# get SCC codes for coal related emissions
coal.loc = grep(x = scc$Short.Name, "Coal")
scc.index = scc[coal.loc, "SCC"]

# calculate sum of emission for each year
setkey(emissions, "SCC")
ts <- emissions[.(scc.index), lapply(.SD,sum), by = "year", .SDcols = "Emissions"]

# plot to PNG device
png(filename = "plot4.png")
plot(ts, main = "total PM2.5 emission from coal combustion related sources", type = "l")
dev.off()
