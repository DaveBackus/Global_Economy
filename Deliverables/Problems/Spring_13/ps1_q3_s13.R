# ------------------------------------------------------------------------------
#  Read in China's expenditure components of GDP \
#  Data downloaded from OECD National Accounts (automate?)
#  For Global Economy, Problem Set #1, Spring 2013
#  Written by:  Dave Backus, January 2013 
# ------------------------------------------------------------------------------
rm(list=ls())
dir = "C:/Users/dbackus/Documents/Classes/Global_Economy/Deliverables/Problems"
setwd(dir) 

# load packages for xls input 
library("xlsx")
#library("xts")

# load data 
oecd <- read.xlsx("ps1_q3_s13.xls", sheetName="Data_for_Q3", colClasses=c("numeric"))

# cool function from Espen to check column classes (watch for dreaded factors)
frameClasses <- function(x) {unlist(lapply(unclass(x),class))}
frameClasses(oecd)

# replace row numbers with variable names 
row.names(oecd) <- c("Y", "C", "G", "I", "NX", "X", "M", "SD", "NA")

# kill extra columns and transpose (kludgy) 
drops <- c("NA", "row.names")
data <- as.data.frame(t(oecd[,!(names(oecd) %in% drops)]))
date <- c(1979:2011)
data$date <- date 
data <- subset(data, date>1979.5) 

# compute ratios to Y=GDP 
iy <- data$I/data$Y 
sy <- 1 - (data$C+data$G)/data$Y
nxy <- data$NX/data$Y
sdy <- data$SD/data$Y
zero <- sy - iy - nxy - sdy 
date <- data$date 

plot(date,iy,type="l",cex=1.5, lwd=2, col="red",
     main="", xlab="", ylab="Ratio to GDP", 
     ylim=c(-0.05,0.55), 
     mar=c(2,4,2,2),   # better than default in most cases 
     mgp=c(2.5,1,0)  
     )
lines(date, sy, lwd=2, col="blue")
lines(date, nxy, lwd=2, col="magenta")
abline(0,0)
mtext("China", side=3, adj=0, line=1.0, cex=1.25)
text(1985, 0.28, "Saving", cex=1, adj=0)
text(1985, 0.44, "Investment", cex=1, adj=0)
text(1985, 0.07, "Net Exports", cex=1, adj=0)
#lines(date, sdy, lwd=2, lty=3, col="black")
#text(2000, -0.04, "Statistical discrepancy", cex=1, adj=0)

#dev.copy2eps(device=postscript, file="China_shares.eps",width=8,height=6)
dev.print(device=pdf, file="China_shares.pdf",width=8,height=6)

