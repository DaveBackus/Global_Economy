# ------------------------------------------------------------------------------
#  slides_indicators_FRED.R 
#  Global Economy course, functions to handle 
#     * Input from FRED (uses its XML API) 
#     * cross-correlation functions 
#     * business cycle scorecard (graphs)
#  Recommendation:  ignore the functions in Section 1 and start with Section 2
#  Written by:  Paul Backus (fredplot.R), with input from Espen Henriksen 
#  Adapted by:  Dave Backus 
# ------------------------------------------------------------------------------
rm(list=ls())

# set directory (needed only to direct where to print figures)
dir = "C:/Users/dbackus/Documents/Classes/Global_Economy/Deliverables/Problems"
setwd(dir) 

# load libraries/packages (these must be installed earlier)
library("XML")
library("xts")

# 1. FRED functions from Paul 
# ------------------------------------------------------------------------------
# Create a URL query string from key=value parameters
queryString <- function(...) {
  params <- list(...)
  paste(
    lapply(
      names(params),
      function(pname) {
        paste(pname, "=", URLencode(params[[pname]]), sep="")
      }
    ),
    collapse="&" # use collapse instead of sep to flatten list
  )
}

# Fetch raw XML data from the FRED web interface
# ... allows additional parameters; eg, frequency=m 
# Documentation at:  
#   http://api.stlouisfed.org/docs/fred/
#   http://api.stlouisfed.org/docs/fred/series_observations.html
callFredApi <- function(call_string, ...) {
  api_key <- "055ba538c874e5974ee22d786f27fdda" # courtesy of Kim Ruhl
  
  # Construct URL from call string and any parameters given in "..."
  # The finished URL should have the form:
  #   http://.../fred/some/resource?api_key=foo&param1=val1[&param2=val2...]
  # ie, the web address, followed by a ?, followed by a &-separated list
  #   of parameters
  # The api_key parameter is always required, and so is handled automatically.
  url <- paste(
    "http://api.stlouisfed.org/fred/", # base url
    call_string, # subdirectory--documented on fred website
    "?", # separator between web address and parameter list
    queryString(api_key=api_key, ...),
    sep=""
  )
  return(xmlTreeParse(url, useInternal=TRUE))
}

# Helper function to extract specific attributes from FRED's XML
collectAttrs <- function(xmldoc, tag, attr) {
  sapply(
    getNodeSet(xmldoc, paste("//", tag)),
    function(el) { xmlGetAttr(el, attr) }
  )
}

# Download the specified series and returns it as a vector, with the dates
# of each observation stored in the vector's names attribute
getFredData <- function(series_id, ...) {
  xmldoc <- callFredApi(
    call_string="series/observations",
    series_id=series_id,
    ...
  )
  
  dataseries <- as.numeric(collectAttrs(xmldoc, "observation", "value"))
  names(dataseries) <- collectAttrs(xmldoc, "observation", "date")
  return(dataseries)
}

# Download the metadata of a FRED series and returns a particular attribute
# A list of available attributes can be found at
#   http://api.stlouisfed.org/docs/fred/series.html
getFredMetadata <- function(series_id, attribute, ...) {
  xmldoc <- callFredApi(
    call_string="series",
    series_id=series_id,
    ...
  )
  attrs <- collectAttrs(xmldoc, "series", attribute)
  return(attrs)
}

# Return a multivariate time series of the variables specified in series_ids
getFredTable <- function(series_ids, ...) {
  data <- do.call(
    merge,
    lapply(
      series_ids, 
      function(series) { as.xts(getFredData(series, ...)) }
    )
  )
  colnames(data) <- series_ids
  return(data)
}

# cool function from Espen to check column classes (watch for dreaded factors)
frameClasses <- function(x) {unlist(lapply(unclass(x),class))}


#  2. Data input 
# ------------------------------------------------------------------------------
# this version needs to be changed if we want to use monthly data for a series
# that comes in some other frequency; eg, SP500 is daily 
fred.sym <- c("INDPRO", "PAYEMS", "HOUST", "RRSFS", "NAPM") 
fred.data <- getFredTable(fred.sym)

# yoy difference eveything and start in Jan 1990 
fred.data <- diff(log(fred.data),12)
fred.data <- fred.data["1990-01-01/"]  # slash means go to end: "n1/n2", "/n2", "n1/"


#  3. Cross-correlation functions (ccf's) 
# ------------------------------------------------------------------------------

# save pars 
old.pars <- par()

# not sure why, but ccf seems to need a data frame 
data <- data.frame(fred.data) 

# compute and plot a ccf 
par(mfcol=c(1))
ccf(data$PAYEMS,data$INDPRO, na.action=na.pass, lag.max=24,ylab="",xlab="Lag k relative to IP",main="Nonfarm Employment")

# do four at once, put in same plot 
# write function for this ....  
par(mfcol=c(2,2), mar=c(3,3,3,3)) 
ccf(data$PAYEMS,data$INDPRO, na.action=na.pass, lag.max=24, ylim=c(-1,1), ylab="",xlab="Lag k relative to IP", main="Nonfarm Employment")
abline(v=0, col='red', lty=1)
ccf(data$HOUST,data$INDPRO, na.action=na.pass, lag.max=24, ylim=c(-1,1), ylab="",xlab="Lag k relative to IP", main="Housing Starts")
abline(v=0, col='red', lty=1)
ccf(data$RRSFS,data$INDPRO, na.action=na.pass, lag.max=24, ylim=c(-1,1), ylab="", xlab="Lag k relative to IP",main="Retail Sales")
abline(v=0, col='red', lty=1)
ccf(data$NAPM,data$INDPRO, na.action=na.pass, lag.max=24, ylim=c(-1,1), ylab="", xlab="Lag k relative to IP", main="Purchasing Managers Index")
abline(v=0, col='red', lty=1)

# print as pdf 
dev.print(device=pdf, file="ccf_plot.pdf",width=8,height=6)


#  4. Business cycle scorecard 
# ------------------------------------------------------------------------------

# compute mean and standard deviation 
data.mean <- colMeans(data, na.rm=TRUE)
print(data.mean)
data.sdev <- sd(data, na.rm=TRUE)
print(data.sdev)

# correlations 
cor(data, use="pairwise.complete.obs")

# plot data with mean +/- standard deviation lines 
# should convert this to a function 

# this has some awkward kludges in it, one to handle NAs, the other because 
# the plot functions depend on the data type 
old.data <- data 
data <- na.omit(old.data)

par <- par(old.pars) 
par(mfcol=c(1,1))

nvar <- 1 
plot(as.Date(rownames(data), format="%Y-%m-%d"), data$INDPRO, type="l", xlab="", ylab="", main="Industrial Production")
abline(a=data.mean[nvar], b=0, col='red')
abline(a=data.mean[nvar]+data.sdev[nvar], b=0, col='red', lty=2)
abline(a=data.mean[nvar]-data.sdev[nvar], b=0, col='red', lty=2)
dev.print(device=pdf, file="scorecard_ip.pdf",width=8,height=6)

nvar <- 2 
plot(as.Date(rownames(data), format="%Y-%m-%d"), data$PAYEMS, type="l", xlab="", ylab="", main="Nonfarm Employment")
abline(a=data.mean[nvar], b=0, col='red')
abline(a=data.mean[nvar]+data.sdev[nvar], b=0, col='red', lty=2)
abline(a=data.mean[nvar]-data.sdev[nvar], b=0, col='red', lty=2)
dev.print(device=pdf, file="scorecard_emp.pdf",width=8,height=6)
