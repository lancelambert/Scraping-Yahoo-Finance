# Scraping-Yahoo-Finance
This script is for scraping daily stock data from Yahoo Finance in R. The script uses the rvest and BatchGetSymbols libraries. The example pulls data for stocks in the NYSE and NASDAQ, however, you can adjust this by adding or deleting stock ticker symbols.
 
Please note the stock’s ticker symbol is the unique identifier that is necessary to pull in its daily results. The script pulls daily stock results for every day within the specified range. 

Daily stock results are cached in the BGS_Cache folder.  
 
