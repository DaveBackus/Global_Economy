#  Read FRED data from spreadsheet and compute ccf's 
#  For Global Economy, Problem Set #3, Q2 and Q3, Spring 2012
#  Written by:  Dave Backus, April 2012 
rm(list=ls())
dir = "C:/Users/dbackus/Documents/Classes/Global_Economy/Deliverables/Problems"
setwd(dir) 

library("xlsx")
#library("xts")

###########################################################################
# input FRED data  
data <- read.xlsx("ps3_s12_FRED_data.xls", sheetName="edited")

attributes(data)
# cool function from Espen to check column classes (watch for dreaded factors)
frameClasses <- function(x) {unlist(lapply(unclass(x),class))}
frameClasses(data)

#par(mfrow=c(1,1))
#ccf(data$PAYEMS,data$INDPRO, lag.max=24,ylab="",xlab="Lag k relative to IP",main="Nonfarm Employment")

# Data from 1990 onwards
data90 <- data[data$Date >= as.Date("1990-01-01"),]

# not used 
# fred.xts <- as.xts(data[,-1], order.by=data[,1])

###########################################################################
# stats 

data.mean <- mean(data90, na.rm=TRUE)
data.sdev <- sd(data90, na.rm=TRUE)
cor(data90[,-1], use="pairwise.complete.obs")


###########################################################################
# cross-correlation functions  

par(mfrow=c(2,2)) #  set up 2 by 2 set of ccf's

ccf(data$PAYEMS,data$INDPRO, lag.max=24,ylab="",xlab="Lag k relative to IP",main="Nonfarm Employment")
ccf(data$HOUST,data$INDPRO, lag.max=24,ylab="",xlab="Lag k relative to IP",main="Housing Starts")
ccf(data$RRSFS,data$INDPRO, na.action=na.pass, lag.max=24,ylab="",xlab="Lag k relative to IP",main="Retail Sales")
ccf(data$SP500,data$INDPRO, lag.max=24,ylab="",xlab="Lag k relative to IP",main="S&P 500")

dev.copy2eps(device=postscript, file="ps3_q2_ccfs.eps",width=8,height=6)
dev.print(device=pdf, file="ps3_q2_ccfs.pdf",width=8,height=6)

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
