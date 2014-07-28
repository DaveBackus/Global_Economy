# ------------------------------------------------------------------------------
#  PWT_71_calcs.R
#  Reads in Penn World Table, computes capital stocks, merges Barro-Lee 
#  education data, and outputs csv file
#  Added:  level and growth rate calculations for class 
#  PWT data:  http://pwt.econ.upenn.edu/php_site/pwt_index.php
#  List of variables:  http://pwt.econ.upenn.edu/php_site/pwt71/pwt71_form.php
#  Variable guide (some of these don't exist yet) 
#     country = name of country
#     isocode = 3-letter country code 
#     year
#     POP     = population in thousands 
#     XRAT    = exchange rate in lcu's per dollar
#     Currency_Unit = name
#     ppp     
#     tcgdp   = PPP adjusted GDP in current prices, millions of international dollars 
#     cgdp    = same by per capita 
#     cgdp2   = another GDP per capita number 
#     cda2    = absorption per capita, current prices 
#     cc      = consumption share at current prices 
#     cg      = government purchases share at current prices
#     ci      = investment share at current prices
#     p       = price of GDP, GK method 
#     p2      = price of GDP, avg of GEKS and CPDW 
#     pc      = price of consumption
#     pg      = price of government consumption
#     pi      = price of investment 
#     openc   = 
#     cgnp    = ratio of GNP to GDP 
#     y       = GDP per capita rel to US
#     y2      = ditto, diff method  
#     rgdpl   = GDP per capita, Laspeyres 
#     rgdpl2  = GDP per capita, based on absorption 
#     rgdpch  = GDP per capita, chain weighted 
#     kc      = consumption share at constant prices (Laspeyres)
#     kg      = government share 
#     ki      = investment share 
#     openk   =
#     rgdpeqa = GDP per adult equivalent, chain 
#     rgdpwok = GDP per worker, chain  
#     rgdpl2wok = GDP per worker, Laspeyres 
#     rgdpl2pe = 
#     rgdpl2te
#     rgdpl2th
#     rgdptt  = 
#  Barro-Lee data:  http://www.barrolee.com/
#  We use two files, one for education of population aged 15 and over, the other 
#  for aged 25 and over.  urls below.  In each one, we use variable yr_sch = 
#  average years of school for the relevant group.
#  Program written by:  Paul Backus, October 2012 
#  Capital stock procedure adapted from Gian Luca Clementi's Stata program
#  Ditto merging of Barro-Lee education data 
#  Additional comments by Dave Backus
# ------------------------------------------------------------------------------
# clear memory, set directory for output 
rm(list=ls())
# remember to change \ to /
dir = "c:/Users/dbackus/Documents/Classes/Global_Economy/Data/PWT"
setwd(dir)


# 1. Functions 
# ------------------------------------------------------------------------------

# Download zipped data file and unzip it in given subdir  
download_pwt_data <- function(directory) {
	zip_url = "http://pwt.econ.upenn.edu/Downloads/pwt71/pwt71_07262012version.zip"
	download.file(zip_url, basename(zip_url), method="auto")
	unzip(basename(zip_url), exdir=directory)
}

# ------------------------------------------------------------------------------
# Import complete PWT:  read csv data file into a data frame
import_pwt_data <- function(directory) {
	read.csv(paste(directory, "pwt71_w_country_names.csv", sep="/"))
}

# ------------------------------------------------------------------------------
# Create a table of countries and their iso codes from the first two columns
# col 1 = country name, col 2 = country code (3-letter abbrev)
country_index <- function(dataset) {
	unique(cbind(as.character(dataset$country), as.character(dataset$isocode)))
}

# ------------------------------------------------------------------------------
# From here you can use 'subset' to get specifc countries and variables.
# This code gives the same subset used in Espen's code (pwt_ky_ratios_db.R)
#subset(pwt_dataframe,
#	isocode %in% c("CHN", "JPN", "IND", "USA"), # countries (rows)
#	select=c("country", "isocode", "year", "rdpl", "ki") # variables (columns)
#)

# ------------------------------------------------------------------------------
# Compute capital for one or more countries
# Algorithm adapted from Clementi's Stata code, itself based on Hall-Jones 
# depreciation is 0.06, but if you use a number in the function call it'll use that instead 
capital <- function(cdata, depreciation=0.06) {
  # remove rows with missing observations
  cdata <- cdata[!is.na(cdata$rgdpch) & !is.na(cdata$POP) & !is.na(cdata$ki),]
  
  # compute investment
  investment <- cdata$rgdpch*(cdata$ki/100)*(cdata$POP*1000)  
  
  # compute growth rates
  growth_y <- with(cdata, (log(rgdpch[10]) - log(rgdpch[1]))/10)
  growth_pop <- with(cdata, (log(POP[10]) - log(POP[1]))/10)
  
  # compute initial capital (k0)
  # Similar to Hall and Jones (QJE, 1999, fn 5) 
  # http://www.stanford.edu/~chadj/HallJonesQJE.pdf		
  # NB:  HJ use growth rate of investment, we use growth of GDP  
  ki_bar <- mean(cdata$ki[1:10])
  init_inv <- cdata$rgdpch[1]*(ki_bar/100)*(cdata$POP[1]*1000)
  init_capital <- init_inv/(exp(growth_y + growth_pop) - 1 + depreciation)
  
  # compute capital series according to the recurrence relation
  capital <- Reduce(
    function(k,t) {
      c(k, (1-depreciation)*k[t-1] + investment[t-1])
    },
    2:length(investment),
    init_capital
  )
  
  # add some metadata to allow for easy merging
  series <- cbind(capital, cdata$year)
  colnames(series) <- c("capital","year")
  
  return(series)
}

# ------------------------------------------------------------------------------
# Add capital column to pwt dataframe 
# Much faster version based on merging country blocks 
add_capital_column <- function(dataset) {
  do.call(
    rbind,
    lapply(
      split(dataset, dataset$isocode),
      function(cdata) {
        merge(cdata, capital(cdata), by = "year", all.x=TRUE)
      }
    )
  )
}

# ------------------------------------------------------------------------------
# Barro-Lee functions:  read data, interpolate, and merge with PWT 
# Two files for education of different age groups 

# ------------------------------------------------------------------------------
# Download BL data 
download_bl_data <- function(directory) {
  csv_urls = c(
    "http://www.barrolee.com/data/BL_v1.2/BL(2010)_MF2599_v1.2.csv",
    "http://www.barrolee.com/data/BL_v1.2/BL(2010)_MF1599_v1.2.csv"
  )
  for (url in csv_urls) {
    download.file(url, paste(directory, basename(url), sep="/"), method="auto")
  }
}

# ------------------------------------------------------------------------------
# Read it -- times two 
import_bl15_data <- function(directory) {
  read.csv(paste(directory, "BL(2010)_MF1599_v1.2.csv", sep="/"))
}

import_bl25_data <- function(directory) {
  read.csv(paste(directory, "BL(2010)_MF2599_v1.2.csv", sep="/"))
}

# ------------------------------------------------------------------------------
# Fill in missing values by linear interpolation
# helper function for following 
interp_nas <- function(x) {
  pos=which(!is.na(x))
  if (length(pos) < 2) {
    warning("Not enough data to interpolate.")
    return(x)
  }
  for (i in 1:(length(pos) - 1)) {
    x[pos[i]:pos[i+1]] <- approx(
      c(x[pos[i]], x[pos[i+1]]),
      n=(pos[i+1] - pos[i] + 1)
    )$y
  }
  return(x)
}

# ------------------------------------------------------------------------------
# Adds the column labeled "yr_sch" to pwtdata and fills in missing values by
# linear interpolation 
add_education_column <- function(pwtdata, edudata, colname="yr_sch") {
  # subset to year, country code, and the column we want to merge
  edudata <- subset(edudata, select = c("year", colname, "WBcode"))
  
  # merge data frames
  combined <- merge(
    pwtdata,
    edudata,
    by.x = c("year", "isocode"),
    by.y = c("year", "WBcode"),
    all.x = TRUE # include all years in the result
  )
  
  # interpolate missing values
  combined <- do.call(
    rbind,
    lapply(
      split(combined, combined$isocode),
      function(cdata) {
        #print(cdata$yr_sch)
        cdata$yr_sch <- interp_nas(cdata$yr_sch)
        cdata
      }
    )
  )
  return(combined)
}


# 2. Execute:  PWT and Barro-Lee 
# ------------------------------------------------------------------------------

# get PWT data 
noquote("Downloading PWT data...")
data_dir = "data"
download_pwt_data(data_dir)
pwt <- import_pwt_data(data_dir)

# compute capital stocks and insert into dataframe 
noquote("Computing capital stocks...")
pwt <- add_capital_column(pwt)

# save as rdata file for easy access later
save(pwt, file="pwt.RData")

# get Barro-Lee education data 
noquote("Downloading Barro-Lee data...")
data_dir = "data"
download_bl_data(data_dir)

# load data and change variable name to avoid duplication 
bl15 <- import_bl15_data(data_dir)
bl25 <- import_bl25_data(data_dir)

# merge with PWT, change variables names to avoid conflict 
noquote("Merging Barro-Lee education with PWT...")
pwt <- add_education_column(pwt, bl15, colname="yr_sch")
nvar <- ncol(pwt)
colnames(pwt)[nvar] <- "ED15"
pwt <- add_education_column(pwt, bl25, colname="yr_sch")
nvar <- ncol(pwt)
colnames(pwt)[nvar] <- "ED25"

# save as rdata file for easy access later
save(pwt, file="pwtplus.RData")


# 3. Create variables and csv file for class    
# ------------------------------------------------------------------------------
# reload data (you can start program here)
rm(list=ls())
load("pwtplus.RData")

# drop the peripheral stuff
#col.names(pwt)
variables <- c("country", "isocode", "year", "POP", "rgdpch", "rgdpwok", "ki", "capital", "ED15", "ED25")
pwt <- pwt[variables]

# create variables of interest with understandable labels 
pwt$YPOP <- pwt$rgdpch
pwt$Y    <- pwt$YPOP*(pwt$POP*1000)
pwt$YL   <- pwt$rgdpwok 
pwt$LPOP <- pwt$YPOP/pwt$YL 
pwt$KY   <- pwt$capital/pwt$Y 
pwt$KL   <- pwt$KY*pwt$YL 
pwt$TFP  <- pwt$YL/pwt$KL^(1/3)
pwt$I <- pwt$rgdpch*(pwt$ki/100)*(pwt$POP*1000)

# check to see if reasonable 
mean(pwt$KY, na.rm=TRUE)

# variables to keep for spreadsheet 
variables <- c("country", "isocode", "year", "POP", "LPOP", "YPOP", "YL", "KL", "KY", "TFP", "ED15", "ED25", "I")
pwt_some <- pwt[variables]

# write csv file 
write.csv(pwt_some, file="pwt71.csv", row.names=FALSE)

# save as rdata file for easy access later
save(pwt, file="pwt_global71.RData")


# 4. Level and growth accounting 
# ------------------------------------------------------------------------------
# you can start the program from here once you've set up the databases 
rm(list=ls())
load("pwt_global71.RData")

# plots 
plot_YL <- function(pwt, country) {
  # select country 
  #data <- subset(pwt, isocode %in% country)
  data <- pwt[pwt$isocode == country,]
  # plot
  plot(data$year, data$YL/1000, 
  , type="l",cex=1.5, lwd=2, col="red",
  main="", xlab="", ylab="GDP per worker (000s of 2005 USD)", 
  #     ylim=c(10, 90),
  mar=c(2,4,2,2),   # better than default in most cases 
  mgp=c(2.5,1,0)  
  )
  mtext(country, side=3, adj=0, line=1.0, cex=1.25)

  dev.print(device=pdf, file=paste(country,"_YL.pdf",sep=""),width=8,height=6)
}

# level comparison (still in progress)
level_comp <- function(pwt, countries, years) {
  # subset data
  data <- subset(pwt, isocode %in% countries & year %in% years)
  # compute ratios 
  ratioYL <- data$YL[1]/data$YL[2]
  ratioKL <- data$KL[1]/data$KL[2]
  ratioA  <- data$TFP[1]/data$TFP[2]
  print(data$A[1]/data$A[2])
  # collect in matrix and return 
  country1 <- c(data$YL[1], data$KL[1], data$TFP[1])
  country2 <- c(data$YL[2], data$KL[2], data$TFP[2])
  ratio  <- c(ratioYL, ratioKL, ratioA)
  contri <- c(ratioYL, ratioKL^(1/3), ratioA)
  return(rbind(country1, country2, ratio, contri))
}

# growth accounting 
growth_acc <- function(pwt, code, years) {
  # subset data
  data <- subset(pwt, isocode %in% code & year %in% years)
  head(data)
  # compute growth rates 
  gYL <- (log(data$YL[2])-log(data$YL[1]))/(data$year[2]-data$year[1])
  gKL <- (log(data$KL[2])-log(data$KL[1]))/(data$year[2]-data$year[1])
  gA  <- (log(data$TFP[2])-log(data$TFP[1]))/(data$year[2]-data$year[1])
  # collect in matrix and return 
  date1 <- c(data$YL[1], data$KL[1], data$TFP[1])
  date2 <- c(data$YL[2], data$KL[2], data$TFP[2])
  growth <- c(gYL, gKL, gA)
  contri <- c(gYL, gKL/3, gA)
#  print(growth)
#  print(contri)
  return(rbind(date1, date2, growth, contri))
}


# plots 
plot_YL(pwt,c("USA"))
plot_YL(pwt,c("ARG"))
plot_YL(pwt,c("CHL"))
plot_YL(pwt,c("ZWE"))
plot_YL(pwt,c("KOR"))
plot_YL(pwt,c("JPN"))
plot_YL(pwt,c("CHN"))
plot_YL(pwt,c("IND"))
plot_YL(pwt,c("VEN"))
plot_YL(pwt,c("PAK"))


# level comparisions

print(level_comp(pwt, c("MEX", "USA"), c("2010"))) 

print(level_comp(pwt, c("CHN", "IND"), c("2010"))) 


# growth accounting 
countrycode <- 
years   <- c("1960", "2010")
myvars    <- c("isocode", "year", "YL", "KL", "TFP")

print(growth_acc(pwt, c("USA"), c("1950", "2010"))) 

print(growth_acc(pwt, c("ZWE"), c("1990", "2010"))) 
print(growth_acc(pwt, c("KOR"), c("1953", "2010"))) 

print(growth_acc(pwt, c("JPN"), c("1950", "1990"))) 
print(growth_acc(pwt, c("JPN"), c("1990", "2010"))) 

print(growth_acc(pwt, c("CHN"), c("1952", "1978"))) 
print(growth_acc(pwt, c("CHN"), c("1978", "2010"))) 

print(growth_acc(pwt, c("IND"), c("1950", "1980"))) 
print(growth_acc(pwt, c("IND"), c("1980", "2010"))) 


# figs for exams 

# India and Pakistan, midterm, spring 2013 
data <- pwt[pwt$isocode == "PAK",]
plot(data$year, data$YL/1000, 
     , type="l",cex=1.5, lwd=2, col="red",
     main="", xlab="", ylab="GDP per worker (000s of 2005 USD)", 
     ylim=c(1, 8),
     mar=c(2,4,2,2),   # better than default in most cases 
     mgp=c(2.5,1,0)  
)
data <- pwt[pwt$isocode == "IND",]
lines(data$year, data$YL/1000, type="l",cex=1.5, lwd=2, col="blue") 
text(x=1965, y=4, "Pakistan") 
text(x=1980, y=2, "India") 

dev.print(device=pdf, file="PAKIND_YL.pdf", width=8, height=6)
