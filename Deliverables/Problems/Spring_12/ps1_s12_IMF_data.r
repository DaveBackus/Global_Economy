#  Read EIU and IMF data from spreadsheet and graph it 
#  For Global Economy, Problem Set #1, Spring 2012
#  Written by:  Dave Backus, February 2012 

rm(list=ls())
dir = "C:/Users/dbackus/Documents/Classes/Global_Economy/Deliverables/Problems"
setwd(dir) 

library("xlsx")
library("xts")

###########################################################################
# Version based on EIU data 
eiu.data <- read.xlsx("ps1_s12_answerkey.xlsx", sheetName="Question_3_EIU")

# replace row numbers with variable names (v = "stocks" = inventories)
row.names(eiu.data) <- c("y_ch", "c_ch", "g_ch", "i_ch", "v_ch", "x_ch", "m_ch", "y_in", "c_in", "g_in", "i_in", "v_in", "x_in", "m_in")

# kill extra columns and transpose 
drops <- c("Series.name", "Unit")
data <- as.data.frame(t(eiu.data[,!(names(eiu.data) %in% drops)]))
date <- c(1990:2010)
data$date <- date 

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

# India
iy_in <- (data$i_in+data$v_in)/data$y_in
sy_in <- 1 - (data$c_in+data$g_in)/data$y_in
nxy_in <- (data$x_in-data$m_in)/data$y_in
data$zero_in = sy_in - iy_in - nxy_in 

plot(date,iy_in,type="l",cex=1.5, lwd=2, col="red",
     main="", xlab="", ylab="Ratio to GDP", 
     ylim=c(-0.1,0.4), 
     mar=c(2,4,2,2),   # better than default in most cases 
     mgp=c(2.5,1,0)  
     )
lines(date, sy_in, lwd=2, col="blue")
lines(date, nxy_in, lwd=2, col="magenta")
abline(0,0)
text(1990, 0.17, "Saving", cex=1, adj=0)
text(1990, 0.29, "Investment", cex=1, adj=0)
text(1990,-0.05, "Net Exports", cex=1, adj=0)
mtext("India", side=3, adj=0, line=1.0, cex=1.25)

dev.copy2eps(device=postscript, file="India_shares.eps",width=8,height=6)
dev.print(device=pdf, file="India_shares.pdf",width=8,height=6)


###########################################################################
# Version based on IMF data 
imf.data <- read.xlsx("ps1_s12_answerkey.xlsx", sheetName="Question 3", rowIndex=NULL, colIndex=NULL)

# list variables
imf.data$Concept 

# replace row numbers with variable names 
row.names(imf.data) <- c("y_ch", "c_ch", "g_ch", "i_ch", "nx_ch", "y_in", "c_in", "g_in", "i_in", "x_in", "m_in")

# kill extra columns and transpose 
drops <- c("Country", "Concept", "Unit", "Facts", "Scale")
data <- as.data.frame(t(imf.data[,!(names(imf.data) %in% drops)]))
date <- c(1990:2010)
data$date <- date 

# China 
iy_ch <- data$i_ch/data$y_ch
sy_ch <- 1 - (data$c_ch+data$g_ch)/data$y_ch
nxy_ch <- data$nx_ch/data$y_ch
data$zero_ch <- sy_ch - iy_ch - nxy_ch

plot(date,iy_ch,type="l",cex=1.5, lwd=2, col="red",
     main="", xlab="", ylab="Ratio to GDP", 
     ylim=c(0,0.5), 
     mar=c(2,4,2,2),   # better than default in most cases 
     mgp=c(2.5,1,0)  
     )
lines(date, sy_ch, lwd=2, col="blue")
lines(date, nxy_ch, lwd=2, col="magenta")
text(1990, 0.45, "Saving", cex=1, adj=0)
text(1990, 0.20, "Investment", cex=1, adj=0)
text(1990, 0.05, "Net Exports", cex=1, adj=0)
mtext("China", side=3, adj=0, line=1.0, cex=1.25)

dev.copy2eps(device=postscript, file="China_shares.eps",width=8,height=6)
dev.print(device=pdf, file="China_shares.pdf",width=8,height=6)

# India
iy_in <- data$i_in/data$y_in
sy_in <- 1 - (data$c_in+data$g_in)/data$y_in
nxy_in <- (data$x_in-data$m_in)/data$y_in
data$zero_in = sy_in - iy_in - nxy_in 

plot(date,iy_in,type="l",cex=1.5, lwd=2, col="red",
     main="", xlab="", ylab="Ratio to GDP", 
     ylim=c(-0.1,0.4), 
     mar=c(2,4,2,2),   # better than default in most cases 
     mgp=c(2.5,1,0)  
     )
lines(date, sy_in, lwd=2, col="blue")
lines(date, nxy_in, lwd=2, col="magenta")
abline(0,0)
text(1990, 0.17, "Saving", cex=1, adj=0)
text(1990, 0.29, "Investment", cex=1, adj=0)
text(1990,-0.05, "Net Exports", cex=1, adj=0)
mtext("India", side=3, adj=0, line=1.0, cex=1.25)

dev.copy2eps(device=postscript, file="India_shares.eps",width=8,height=6)
dev.print(device=pdf, file="India_shares.pdf",width=8,height=6)


