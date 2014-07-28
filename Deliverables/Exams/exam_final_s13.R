# ------------------------------------------------------------------------------
#  Global Economy, Final Exam, Spring 2013 
#  Read FRED data from spreadsheet and compute ccf's 
#  Written by:  Dave Backus, with functions from Paul  
# ------------------------------------------------------------------------------
rm(list=ls())
dir = "C:/Users/dbackus/Documents/Classes/Global_Economy/Deliverables/Exams"
setwd(dir) 

#library("xlsx")
library("xts")
library("XML")

# 1. FRED functions from Paul 
# ------------------------------------------------------------------------------

# FRED functions from Paul 
callFredAPI <- function(call_string, params) {
  api_key <- "055ba538c874e5974ee22d786f27fdda"  
  url <- paste(
    "http://api.stlouisfed.org/fred/", # base url
    call_string, # subdirectory--documented on fred website
    "?", # separator between web address and parameter list
    paste(
      paste("api_key=", api_key, sep=""),
      paste(
        sapply(
          names(params),
          function(pname) {
            paste(pname, "=", params[[pname]], sep="")
          }
        ),
        collapse="&" # use collapse instead of sep to flatten list
      ),
      sep="&"
    ),
    sep=""
  )
  return(xmlTreeParse(url, useInternal=TRUE))
}

# Helper function to extract specific attributes from FRED's XML
collectAttrs <- function(doc, tag, attr) {
  sapply(
    getNodeSet(doc, paste("//", tag)),
    function(el) { xmlGetAttr(el, attr) }
  )
}

# Downloads the specified series and returns it as a vector, with the dates
# of each observation stored in the vector's names attribute
getFredData <- function(series_id) {
  doc <- callFredAPI("series/observations", list(series_id=series_id))
  dataseries <- as.numeric(collectAttrs(doc, "observation", "value"))
  names(dataseries) <- collectAttrs(doc, "observation", "date")
  return(dataseries)
}

# Downloads the metadata of a FRED series and returns a particular attribute
# A list of available attributes can be found at
#   http://api.stlouisfed.org/docs/fred/series.html
getFredMetadata <- function(series_id, attribute) {
  doc <- callFredAPI("series", list(series_id=series_id))
  attrs <- collectAttrs(doc, "series", attribute)
  return(attrs)
}

# Returns a multivariate time series of the variables specified in series_ids
getFredTable <- function(series_ids) {
  data <- do.call(
    merge,
    lapply(
      series_ids, 
      function(series) { as.xts(getFredData(series)) }
    )
  )
  colnames(data) <- series_ids
  return(data)
}

# cool function from Espen to check column classes (watch for dreaded factors)
frameClasses <- function(x) {unlist(lapply(unclass(x),class))}

#  2. Data input 
# ------------------------------------------------------------------------------
#fred.sym <- c("ALTSALES", "GASREGM", "PAYEMS")
fred.sym <- c("PAYEMS")
data <- getFredTable(fred.sym)

# Stop here 

# first difference and start in 1990 
data <- data["1991-01-01/"]  # slash means go to end: "n1/n2", "/n2", "n1/"
data <- diff(log(data),12)


###########################################################################
# stats 

data.mean <- colMeans(data90, na.rm=TRUE)
#data.mean <- mean(data90, na.rm=TRUE)
data.sdev <- sd(data90, na.rm=TRUE)
cor(data90, use="pairwise.complete.obs")


###########################################################################
# cross-correlation functions  
# doesn't work...  
#data < data.frame(data90)
par(mfcol=c(2,1), mar=c(3,3)) #  set up 2 by 2 set of ccf's

ccf(data$PAYEMS,data$ALTSALES, lag.max=24,ylab="",xlab="Lag k relative to auto sales",main="Employment")
ccf(data$GASREGM,data$ALTSALES, lag.max=24,ylab="",xlab="Lag k relative to autosales",main="Gas prices")

dev.print(device=pdf, file="exam_final_s13.pdf",width=8,height=6)

###########################################################################
# plots 

par(mfrow=c(2,2))
nvar <- 2 
plot(data90$Date, data90$INDPRO, xlab="", ylab="", main="Industrial Production")
abline(a=data.mean[nvar], b=0, col='red')
abline(a=data.mean[nvar]+data.sdev[nvar], b=0, col='red', lty=2)
abline(a=data.mean[nvar]-data.sdev[nvar], b=0, col='red', lty=2)

nvar <- 3 
plot(data90$Date, data90$PAYEMS, xlab="", ylab="", main="Nonfarm Employment")
abline(a=data.mean[nvar], b=0, col='red')
abline(a=data.mean[nvar], b=0, col='red')
abline(a=data.mean[nvar]+data.sdev[nvar], b=0, col='red', lty=2)
abline(a=data.mean[nvar]-data.sdev[nvar], b=0, col='red', lty=2)

nvar <- 4 
plot(data90$Date, data90$HOUST, xlab="", ylab="", main="Housing Starts")
abline(a=data.mean[nvar], b=0, col='red')
abline(a=data.mean[nvar], b=0, col='red')
abline(a=data.mean[nvar]+data.sdev[nvar], b=0, col='red', lty=2)
abline(a=data.mean[nvar]-data.sdev[nvar], b=0, col='red', lty=2)

nvar <- 5 
plot(data90$Date, data90$HOUST, xlab="", ylab="", main="S&P 500 Index")
abline(a=data.mean[nvar], b=0, col='red')
abline(a=data.mean[nvar], b=0, col='red')
abline(a=data.mean[nvar]+data.sdev[nvar], b=0, col='red', lty=2)
abline(a=data.mean[nvar]-data.sdev[nvar], b=0, col='red', lty=2)

dev.copy2eps(device=postscript, file="ps3_q3_scorecard.eps",width=8,height=6)
dev.print(device=pdf, file="ps3_q3_scorecard.pdf",width=8,height=6)
