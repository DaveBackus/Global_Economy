#  slides_PWT_s12.r 
#  Read PWT (Clementi version), graph Y/L, do level and growth accounting 
#  For Global Economy, growth accounting slides, Spring 2012
#  Written by:  Dave Backus, February 2012 

# 1. Basic inputs 

# prelims 
rm(list=ls())
dir = "C:/Users/dbackus/Documents/Classes/Global_Economy/Data/PWT"
setwd(dir) 

#library("xlsx")
#library("xts")

# read PWT (Clementi version, December 2011) 
pwt <- read.csv("pwt70_GlobalEconomy.csv")
colnames(pwt)
sapply(pwt, class)

# change class as in 
# http://stackoverflow.com/questions/3796266/change-the-class-of-many-columns-in-a-data-frame
# id <- c(1,3:ncol(stats))) 
# stats[,id] <- as.numeric(as.character(unlist(stats[,id])))
pwt$output_per_capita <- as.numeric(pwt$output_per_capita)
pwt$capital_per_worker <- as.numeric(pwt$capital_per_worker)

# adjust units and compute tfp 
pwt$output_per_capita <- pwt$output_per_capita/1000
pwt$output_per_worker <- pwt$output_per_worker/1000
pwt$capital_per_worker <- pwt$capital_per_worker/1000
pwt$tfp <- pwt$output_per_worker/pwt$capital_per_worker^(1/3) 

# 2. Country-specific figs and calculations 

# now pick a country 
country <- "IND"
dates <- c(1950, 1980, 2007) 
pwt.sub <- pwt[pwt$code == country,]

# look at specific dates and variables
vars <- c( "year", "output_per_worker", "capital_per_worker", "tfp") 
pwt.some <- pwt.sub[pwt.sub$year %in% dates, vars]
head(pwt.some)
        
# growth calcs 

# draw pix 
plot(pwt.sub$year,pwt.sub$output_per_worker, type="l",cex=1.5, lwd=2, col="red",
     main="", xlab="", ylab="GDP per worker (000s of 2005 USD)", 
#     ylim=c(10, 90),
     mar=c(2,4,2,2),   # better than default in most cases 
     mgp=c(2.5,1,0)  
     )
#lines(pwt.sub$year,pwt.sub$output_per_capita, lwd=2, col="blue")
#abline(0,0)
#text(1980, 15, "GDP per capita", cex=1, adj=0)
mtext(country, side=3, adj=0, line=1.0, cex=1.25)

dev.copy2eps(device=postscript, file=paste(country,"_YL.eps",sep=""),width=8,height=6)
dev.print(device=pdf, file=paste(country,"_YL.pdf",sep=""),width=8,height=6)

