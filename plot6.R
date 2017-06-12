if (!require(data.table)){
        install.packages("data.table")
        require(data.table)
}

# downliad data
URL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url = URL, destfile = "NEI.zip")
# read files
data <- unzip(zipfile = "NEI.zip")
emissions <- readRDS(data[grep(x = data, "summarySCC_PM25.rds")])
scc <- readRDS(data[grep(x = data, "Source_Classification_Code.rds")])

emissions <- as.data.table(emissions)
scc <- as.data.table(scc)

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

d <- as.data.frame(cbind(Baltimore_city = ts1$Emissions, LA_county = ts2$Emissions))
d = cbind(melt(d), year = ts1$year)

# plot to PNG device
png(filename = "plot6.png")

# base:
# par(mfrow = c(2,1))
# plot(ts1, main = "Baltimore city", type = "l")
# plot(ts2, main = "LA county", type = "l")

qplot(year, value, data = d, facets = .~variable) + geom_line()

dev.off()