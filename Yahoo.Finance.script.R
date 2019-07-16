library(BatchGetSymbols)
library(dplyr)
library(xml2)
library(rvest)

#This code will create a data frame which includes daily stock results for specified tickers
#This looks at NYSE and Nasdaq tickers, but you can add or delete whatever tickers you'd like
#The final results include daily "price.open", "price.high", "price.low", "price.close", "volume", "price.adjusted", "ref.date", "ret.adjusted.prices", and "ret.closing.prices" 


#STEP 1
#Let's start by tracking down tickers for stocks listed on the New York Stock Exchange (NYSE) and Nasdaq
#Ticker data comes from these links:
# https://www.nasdaq.com/screening/companies-by-industry.aspx?exchange=NASDAQ
# https://www.nasdaq.com/screening/companies-by-industry.aspx?exchange=NYSE

#STEP 2 
#Load ticker data into R
NYSE <- read.csv('~/Documents/r-journalism/StockPrices/NYSE_Tickers.csv')
NASDAQ <- read.csv('~/Documents/r-journalism/StockPrices/NASDAQ_Tickers.csv')

#STEP 3
#Merge the ticker data for NYSE and Nasdaq stocks
NYSE_NASDAQ <- merge(NYSE, NASDAQ, all=TRUE)

#STEP 4 
#Create these three values so we're ready to scrape data from Yahoo
#For first.date you can either put a numerical value of the number of days you'd like to go back. Or put the date, for example, first.date <- '2016-01-01'
#For last.date if you leave it blank, it will default to the most recent date. Or you can put an actual date, for example, last.date <- '2018-01-01'
#NYSE_NASDAQ is the data frame with all the tickers we're pulling data for 
#"Symbol" is the column with the tickers 
first.date <- Sys.Date()-5
last.date <- Sys.Date()
tickers <- NYSE_NASDAQ$Symbol

#STEP 5 
#Now we're ready for scraping! 
#Make sure you've loaded the BatchGetSymbols library 
#This step can take over an hour 
#Ticker results will be stored in BGS_Cache 
stockpull <- BatchGetSymbols(tickers =  tickers,
                             first.date = first.date,
                             last.date = last.date)

#STEP 6
#Now let's put this scraped data into its own data frame 
StockResults <- (stockpull$df.tickers)
#This creates a data frame for the additional data we've scraped
otherdata <- (stockpull$df.control)

#Step 7
#Save StockResults
write.table(StockResults, file="StockResults_Raw.csv", row.names=F, sep=",")
