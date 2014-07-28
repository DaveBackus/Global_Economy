#  slides_EPWT_s12.r 
#  Read EPWT, graph Y/L, do level and growth accounting 
#  For Global Economy, growth accounting slides, Spring 2012
#  Written by:  Dave Backus, February 2012 
#  Abandoned:  not clear these numbers are any good 

# prelims 
rm(list=ls())
dir = "C:/Users/dbackus/Documents/Classes/Global_Economy/Data/PWT"
setwd(dir) 

library("xlsx")
library("xts")

# read EPWT (slightly cleaned version)
# NB:  read.xlsx2 much faster 
#epwt <- read.xlsx2("ExtendedPWT_6305_db.xlsx", sheetName="Sheet1", startRow=52)
epwt <- read.csv("ExtendedPWT_6305_db.csv")

keep <- c("Id")
epwt.sub <- subset(epwt, select=keep)

# get variables of interest 
epwt.sub$Year <- as.numeric(epwt$Year) 
epwt.sub$N <- as.numeric(epwt$N)/10^6
epwt.sub$Pop <- as.numeric(epwt$Pop)/10^3
epwt.sub$X <- as.numeric(epwt$X)/10^3 
epwt.sub$K <- as.numeric(epwt$K)/10^3

# compute some more 
epwt.sub$YPop <- epwt.sub$X/epwt.sub$Pop
epwt.sub$YL <- epwt.sub$X/epwt.sub$N 
epwt.sub$KL <- epwt.sub$K/epwt.sub$N
epwt.sub$KY <- epwt.sub$K/epwt.sub$X
epwt.sub$A  <- epwt.sub$YL/epwt.sub$KL^(1/3) 

# now pick a country 
country <- "USA"

epwt.country <- epwt.sub[epwt.sub$Id == country,]

# OLD STUFF (ignore) 

# China 
iy_ch <- (data$i_ch+data$v_ch)/data$y_ch
sy_ch <- 1 - (data$c_ch+data$g_ch)/data$y_ch
nxy_ch <- (data$x_ch-data$m_ch)/data$y_ch
data$zero_ch <- sy_ch - iy_ch - nxy_ch

plot(date,iy_ch,type="l",cex=1.5, lwd=2, col="red",
     main="", xlab="", ylab="Ratio to GDP", 
     ylim=c(0,0.5), 
     mar=c(2,4,2,2),   # better than default in most cases 
     mgp=c(2.5,1,0)  
     )
lines(date, sy_ch, lwd=2, col="blue")
lines(date, nxy_ch, lwd=2, col="magenta")
abline(0,0)
text(1990, 0.45, "Saving", cex=1, adj=0)
text(1990, 0.30, "Investment", cex=1, adj=0)
text(1990, 0.07, "Net Exports", cex=1, adj=0)
mtext("China", side=3, adj=0, line=1.0, cex=1.25)

dev.copy2eps(device=postscript, file="China_shares.eps",width=8,height=6)
dev.print(device=pdf, file="China_shares.pdf",width=8,height=6)

