if (!require(data.table)){
        install.packages("data.table")
        require(data.table)
}

if (!require(ggplot2)){
        install.packages("ggplot2")
        require(ggplot2)
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

# # calculate sum of emission for each year for Baltimore city - by type
ts <- emissions[fips=="24510", lapply(.SD,sum), by = list(year, type), .SDcols = "Emissions"]

d <- as.data.frame(ts)

# plot with ggplot:
png(filename = "plot3.png")
qplot(year, Emissions, data = d, color = type) + geom_line()
dev.off()