readData = function(){
        # check dependencies
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
        
return(list(emissions, scc))
}

