# ------------------------------------------------------------------------------
#  Read in India's expenditure components of GDP and plot shares
#  Data downloaded from EIU CountryData (can we automate?)
#  For Global Economy, Problem Set #1, Fall 2013
#  Written by:  Dave Backus, September 2013 
# ------------------------------------------------------------------------------
rm(list=ls())
dir = "C:/Users/dbackus/Documents/Classes/Global_Economy/Deliverables/Problems"
setwd(dir) 

# load packages for xls input 
library("xlsx")
#library("xts")

# load data 
input <- read.xlsx("ps1_q3_f13.xls", sheetName="data", colClasses=c("numeric"))

# cool function from Espen to check column classes (watch for dreaded factors)
frameClasses <- function(x) {unlist(lapply(unclass(x),class))}
frameClasses(input)

# get data (kludgy) 
data <- as.data.frame(t(input[2:8,3:26]))
colnames(data) <- c("Y", "C", "G", "I", "S", "X", "M")
data$date <- c(1990:2013)

# compute ratios to Y=GDP 
data$iy <- (data$I+data$S)/data$Y 
data$sy <- 1 - (data$C+data$G)/data$Y
data$nxy <- (data$X-data$M)/data$Y

# plot saving, investment, and net exports 
plot(data$date, data$iy, type="l", cex=1.5, lwd=2, col="red",
     main="", xlab="", ylab="Ratio to GDP", 
     ylim=c(-0.1,0.4), 
     mar=c(2,4,2,2),   # better than default in most cases 
     mgp=c(2.5,1,0)  
     )
lines(data$date, data$sy, lwd=2, col="blue")
lines(data$date, data$nxy, lwd=2, col="magenta")
abline(0,0)
mtext("India", side=3, adj=0, line=1.0, cex=1.25)
text(1995, 0.18, "Saving", cex=1, adj=0)
text(1995, 0.30, "Investment", cex=1, adj=0)
text(1995, -0.05, "Net Exports", cex=1, adj=0)
#lines(date, sdy, lwd=2, lty=3, col="black")
#text(2000, -0.04, "Statistical discrepancy", cex=1, adj=0)

#dev.copy2eps(device=postscript, file="China_shares.eps",width=8,height=6)
dev.print(device=pdf, file="India_shares.pdf",width=8,height=6)

