#  Scorecard_FRED_Apr_13.R
#  Pictures for business cy cle scorecard 
#  "Business cycle indicators" class for Global Economy 
#  Data from FRED, input with functuions written by Paul Backus 
#  Written by:  Dave Backus, April 2013 
# ------------------------------------------------------------------------------
rm(list=ls())

# remember to change \ to /
dir = "C:/Users/dbackus/Documents/Classes/Global_Economy/Data/FRED"
setwd(dir) 

# must be installed:  install.packages("XML") etc
library("XML")    # for FRED input 
library("xts")    # time series package (also used for FRED)

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
# monthly data 
fred.sym.m <- c("INDPRO", "PAYEMS")  
fred.data <- getFredTable(fred.sym.m)

# difference and start in 1960 
fred.data <- diff(log(fred.data),12)
fred.data <- fred.data["1960-01-01/"]  # slash means go to end: "n1/n2", "/n2", "n1/"

oldpar <- par()
par(lwd=2, col="black")

score.fig <- function(IND) {
  pdf(file=paste("scorecard_",IND,".pdf",sep=""), width=8, height=6)

  x <- fred.data[,IND]
  xbar   <- mean(x) 
  sigmax <- apply(x,2,sd)  
#  sigmax <- sd(x) 
#  print(xbar) 
#  print(sigmax)
  
  plot.xts(x,  
     ylab="Growth Rate (YOY)", xlab="", main="", 
     type="l", 
     mar=c(2,3,2,2), mgp=c(2.5,1,0), 
  ) 
  mtext(IND, side=3, adj=0, line=0.5, cex=1.25) 
  abline(h=0, lwd=0.25) # axis 
  abline(h=xbar, lwd=2, col="red")
  abline(h=xbar+sigmax, lwd=2, col="red", lty=2)
  abline(h=xbar-sigmax, lwd=2, col="red", lty=2)
  dev.off()
}

score.fig("INDPRO")
score.fig("PAYEMS")

# OLD VERSION 
pdf(file="scorecard_INDPRO.pdf", width=8, height=6)
plot.xts(fred.data$INDPRO,  
     ylab="Growth Rate (YOY)", xlab="", main="", 
     type="l", 
     mar=c(2,3,2,2), mgp=c(2.5,1,0), 
) 
abline(h=0, lwd=0.25) # axis 
abline(h=xbar, lwd=2, col="red")
abline(h=xbar+sigma, lwd=2, col="red", lty=2)
abline(h=xbar-sigma, lwd=2, col="red", lty=2)
dev.off()

#dev.print(device=pdf, file="scorecard_ip.pdf", width=8, height=6)

