# FRED_indicators.r
# This R script downloads and plots datasets from the St. Louis Fed's Federal
# Reserve Economic Data (FRED) database.
# The code is organized into 3 sections:
#   1. Global variables that you can edit to set the script's basic parameters
#   2. Function definitions containing the bulk of the implementation
#   3. A few lines of code to actually trigger the execution of those functions
# Based on code by Espen Henriksen
# Reorganized, extended, and documented by Paul Backus

# A Note on Indentation Style:
# Many of the function calls in this code are formatted like this:
#   some_function(
#   	foo,
#   	bar,
#   	baz
#   )
# rather than the usual
#   some_function(foo, bar, baz)
# in order to avoid excessively long lines and make nested function calls
# easier to follow.

# If you don't have these packages, type install.packages("name") 
require("XML")
require("xts")

#################################
## SECTION 1: GLOBAL VARIABLES ##
#################################

# Vector listing the series to be plotted
# Edit this with the indicators you want before you run the script!
#
# You can browse the available series by category at 
#   http://research.stlouisfed.org/fred2/
# There is also a partial list on Wikipedia:
#   https://en.wikipedia.org/wiki/Federal_Reserve_Economic_Data#FRED_economic_indicators_.28partial_list.29
fred_symbols = c(
	"PAYEMS",
	"INDPRO",
	"PCEC96",
	"RRSFS",
	"NAPM",
	"HOUST"
)

# The directory where the plots will be saved
# This is computer-specific! 
output_directory = "~/code/R/data"

##########################
## SECTION 2: FUNCTIONS ##
##########################

# Fetches raw XML data from the FRED web interface
# Full documentation can be found online at 
#   http://api.stlouisfed.org/docs/fred/
callFredAPI <- function(call_string, params) {
	api_key<-"055ba538c874e5974ee22d786f27fdda"

	# Construct the URL from the call string and parameter list ("params")
	# The finished URL should have the form:
	#   http://.../fred/some/directory?api_key=foo&param1=bar[&param2=baz...]
	# ie, the web address, followed by a ?, followed by a &-separated list
	#   of parameters
	# The api_key parameter is always required, and so is handled automatically.
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

# Bare-bones code to make plots and save them to pdf files
# This is the fallback if no other plot routine is provided
defaultPlotRoutine = function(table, colname) { 
	plot(table[,colname], main="")
	title(main=colname)
	dev.print(device=pdf, paste(colname, "pdf", sep=".")) 
}

# Generic function to plot the columns of a table (matrix, data.frame, xts...)
# You can pass in your own function with custom plotting commands to add 
# text, labels, etc. to the plot
# Otherwise, the default plot routine defined above is used
# 
# This function is not specific to FRED; it will work with any matrix-like
# table structure in R (though it does assume the existence of colnames).
plotColumns <- function(table, plotRoutine=defaultPlotRoutine) {
	sapply(
		colnames(table),
		function(colname) { 
			plotRoutine(table, colname)
		}
	)
	invisible() # no return value
}

# A more sophisticated plotting routine with FRED-specific code
# This function encapsulates all the fiddly formatting details
fredPlotRoutine <- function(table, series_id) {
	plot(table[,series_id], main="")
	title(
		# use series title as the main title for the graph
		main=getFredMetadata(series_id, "title"),
		# put units on the y-axis
		ylab=getFredMetadata(series_id, "units")
	)
	# Source attribution in small type along the bottom
	mtext(
		paste(
			"Source: FRED, Federal Reserve Economic Data, from the Federal Reserve Bank of St. Louis; series", 
			series_id
		),
		side=1, # bottom
		adj=0, # align left
		padj=1, # align bottom
		line=3, # don't overlap the x-axis
		cex=0.7 # font size
	)
	# Write to pdf
	dev.print(device=pdf, paste(series_id, "pdf", sep="."))
	# Write to eps
	dev.print(device=postscript, paste(series_id, "eps", sep="."))
}

##########################
## SECTION 3: EXECUTION ##
##########################

# Now that we've defined all these functions, we can write out what we
# actually want to *do* in just a few lines

# Store the current working directory in a variable and switch to
# the output directory given at the top of the script
# oldwd <- getwd()
# setwd(output_directory)

# This command downloads and plots each variable listed in fred_symbols,
# at the top of the script.
plotColumns(getFredTable(fred_symbols), plotRoutine=fredPlotRoutine)

# Go back to the directory we were in before
setwd(oldwd)
