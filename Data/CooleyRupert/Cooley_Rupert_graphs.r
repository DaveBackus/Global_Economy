#   File: graphs.r - R program
#   Cooley-Rupert graphs for Snapshot blog 
#   Purpose: Upload cycles data, graph data, export graphs to pdf.  
#   Author: Zach Bethune
#   Date last edited: 9.21.2011

########################################## Parameters & Functions #############################################

#working.dir <- "/Users/zacharybethune/Dropbox/UCSB - Economic Forecast Project/Peter_project"

system("open /Applications/Utilities/X11.app")

hpfilter <- function(x,lambda){ 
eye <- diag(length(x)) 
result <- solve(eye+lambda*crossprod(diff(eye,lag=1,d=2)),x) 
return(result) 
}

#Create new folder and name it the current date
system(paste("rmdir",Sys.Date()))
system(paste("mkdir",Sys.Date()))

#Change working directory to the newly created folder
setwd(paste("~/Dropbox/rupert/",Sys.Date(),sep=""))


################################### Aggregate Series - NIPA ########################################
# Makes shadow text
shadowtext <- function(x, y=NULL, labels, col='white', bg='black',
	theta= seq(pi/4, 2*pi, length.out=8), r=0.1, ... ) {
	
	xy <- xy.coords(x,y)
	xo <- r*strwidth('A')
	yo <- r*strheight('A')

	for (i in theta) {
		text( xy$x + cos(i)*xo, xy$y + sin(i)*yo, labels, col=bg, ... )
	}
	text(xy$x, xy$y, labels, col=col, ... )
}

#Read GDP Data
#Nominal
gdp <- read.fwf("http://research.stlouisfed.org/fred2/data/GDP.txt",skip=13,widths=c(10,9),header=FALSE, col.names=c("date","nominal"))

gdp$nominal <- ts(gdp$nominal, start=c(1947,1), deltat=1/4)

#Real
gdp$real <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/GDPC1.txt",skip=13,widths=c(10,9),header=FALSE, col.names=c("date","real"))[,2], start=c(1947,1), deltat=1/4)

gdpreal <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/GDPC1.txt",skip=13,widths=c(10,9),header=FALSE, col.names=c("date","real"))[,2], start=c(1947,1), deltat=1/4)

#Consumption Expenditures
gdp$rcons <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/PCECC96.txt",skip=13,widths=c(10,8),header=FALSE, col.names=c("date","rcons"))[,2], start=c(1947,1), deltat=1/4)

data <- read.csv("http://www.bea.gov/national/nipaweb/csv/NIPATable.csv?TableName=63&FirstYear=1947&LastYear=2020&Freq=Qtr",skip=5,sep=",")

data <- data[,-c(1,2)]

#Goods
gdp$goods <- ts(t(data[2,]), start=c(1947,1), deltat=1/4)
colnames(gdp$goods) <- "goods"

#Durables
gdp$durables <- ts(t(data[3,]), start=c(1947,1), deltat=1/4)
colnames(gdp$durables) <- "durables"

#Nondurables
gdp$nondurables <- ts(t(data[8,]), start=c(1947,1), deltat=1/4)
colnames(gdp$nondurables) <- "nondurables"

#Services
gdp$services <- ts(t(data[13,]), start=c(1947,1), deltat=1/4)
colnames(gdp$services) <- "services"

#Housing Services as apart of PCE
gdp$housingservices <- ts(t(data[15,]), start=c(1947,1), deltat=1/4)
colnames(gdp$services) <- "housingservices"

#Investment
gdp$rgdpi <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/GPDIC96.txt",skip=13,widths=c(10,10),header=FALSE, col.names=c("date","rgdpi"))[,2], start=c(1947,1), deltat=1/4)

#Residential Fixed Investment
data <- read.csv("http://www.bea.gov/national/nipaweb/csv/NIPATable.csv?TableName=143&FirstYear=1947&LastYear=2020&Freq=Qtr",skip=5,sep=",") 

data <- data[,-c(1,2)]

gdp$nprfi <- ts(t(data[17,]), start=c(1947,1), deltat=1/4)
colnames(gdp$nprfi) <- "nprfi"

#Nonredsidential Fixed Investment
gdp$npnfi <- ts(t(data[2,]), start=c(1947,1), deltat=1/4)
colnames(gdp$npnfi) <- "npnfi"

#Nonresidential - Equipment and Software
gdp$software <- ts(t(data[9,]), start=c(1947,1), deltat=1/4)
colnames(gdp$software) <- "software"


#Government Expenditures & Gross Investment
gdp$gov <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/GCEC96.txt",skip=13,widths=c(10,10),header=FALSE, col.names=c("date","gov"))[,2], start=c(1947,1), deltat=1/4)

#Exports
gdp$exports <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/EXPGSC1.txt",skip=13,widths=c(10,8),header=FALSE, col.names=c("date","exports"))[,2], start=c(1947,1), deltat=1/4)

#Imports
gdp$imports <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/IMPGSC1.txt",skip=13,widths=c(10,8),header=FALSE, col.names=c("date","imports"))[,2], start=c(1947,1), deltat=1/4)

#Compute change from previous peak
attach(gdp, pos=2)
n <- dim(gdp)[2]
for(i in 3:n){
  name <- paste(colnames(gdp)[i],"73",sep=".")
  assn <- as.numeric(window(get(colnames(gdp)[i]),start=c(1973,4),end=c(1978,4)))
  assign(name, ts((assn/assn[1] -1)*100, start=1))

  name <- paste(colnames(gdp)[i],"81",sep=".")
  assn <- as.numeric(window(get(colnames(gdp)[i]),start=c(1981,3),end=c(1986,3)))
  assign(name, ts((assn/assn[1] -1)*100, start=1))

  name <- paste(colnames(gdp)[i],"90",sep=".")
  assn <- as.numeric(window(get(colnames(gdp)[i]),start=c(1990,3),end=c(1995,3)))
  assign(name, ts((assn/assn[1] -1)*100, start=1))

  name <- paste(colnames(gdp)[i],"01",sep=".")
  assn <- as.numeric(window(get(colnames(gdp)[i]),start=c(2001,1),end=c(2006,1)))
  assign(name, ts((assn/assn[1] -1)*100, start=1))

  name <- paste(colnames(gdp)[i],"07",sep=".")
  assn <- as.numeric(window(get(colnames(gdp)[i]),start=c(2007,4),end=NULL))
  assign(name, ts((assn/assn[1] -1)*100, start=1))
}
detach(gdp, pos=2)

#Calculate HP Filtered GDP
rgdp.trend <- hpfilter(log(gdp$real), 1600)
rgdp.trend <- ts(rgdp.trend, start=c(1947,1), deltat=1/4)

rgdp.cyc <- log(gdp$real)-rgdp.trend

#Graph Series
x11()
#Real GDP
#pdf(file = "rgdp.pdf", family = "Times", pointsize = 12)
plot(real.73,
     main="Real Gross Domestic Product",
     ylab="",
     xlab="Quarters from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(real.73, real.81, real.90, real.01, real.07)-1,max(real.73, real.81, real.90, real.01, real.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,35,4)))
abline(h=0)  
lines(real.73,col="darkgreen",lwd=2)
lines(real.81,col="orange3",lwd=2)
lines(real.90,col="red",lwd=2)
lines(real.01,col="orangered4",lwd=2)
lines(real.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: U.S. Bureau of Economic Analysis",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("rgdp-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("rgdp-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("rgdp-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

###############################################################
#Cyclical Component of Real GDP
#pdf("rgdp-cyc.pdf", family="Times", pointsize=12)
plot(window(rgdp.cyc, start=c(1970,1), end=NULL),
     main="Cyclical Component of Real Gross Domestic Product",
     ylab="Percentage Deviation from Trend",
     xlab="Year",
     col="black",
     type="l",
     lwd=1,
     bty="l",
     ylim=c(min(rgdp.cyc)-.01, max(rgdp.cyc)+.01))
abline(h=0)  
lines(window(rgdp.cyc,start=c(1973,4), end=c(1975,1)),col="darkgreen",lwd=4)
lines(window(rgdp.cyc,start=c(1981,3), end=c(1982,4)),col="orange3",lwd=4)
lines(window(rgdp.cyc,start=c(1990,3), end=c(1991,1)),col="red",lwd=4)
lines(window(rgdp.cyc,start=c(2001,1), end=c(2001,4)),col="orangered4",lwd=4)
lines(window(rgdp.cyc,start=c(2007,4), end=c(2009,2)),col="mediumblue",lwd=4)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: U.S. Bureau of Economic Analysis",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("bottomleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("rgdpcyc-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("rgdpcyc-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("rgdpcyc-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

###############################################################
#Trend Component & Level of Real GDP#
#pdf("rgdp-level.pdf", family="Times", pointsize=12)
plot(window(log(gdp$real), start=c(1970,1), end=NULL),
     main="Trend Component of Log Real Gross Domestic Product",
     ylab="",
     xlab="Year",
     col="black",
     type="l",
     lwd=1,
     bty="l")
abline(h=0)  
lines(window(log(gdp$real),start=c(1973,4), end=c(1975,1)),col="darkgreen",lwd=2)
lines(window(log(gdp$real),start=c(1981,3), end=c(1982,4)),col="orange3",lwd=2)
lines(window(log(gdp$real),start=c(1990,3), end=c(1991,1)),col="red",lwd=2)
lines(window(log(gdp$real),start=c(2001,1), end=c(2001,4)),col="orangered4",lwd=2)
lines(window(log(gdp$real),start=c(2007,4), end=c(2009,2)),col="mediumblue",lwd=2)
lines(rgdp.trend, col="red", lwd=1, lty=2)
mtext("Seasonally Adjusted",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: U.S. Bureau of Economic Analysis",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("rgdp-level-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("rgdp-level-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=18, height = 7, width = 10)
dev.print(png, file=paste("rgdp-level-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

###############################################################
#Consumption
#pdf(file = "cons.pdf", family = "Times", pointsize = 12)
plot(rcons.73,
     main="Real Personal Consumption Expenditures",
     ylab="",
     xlab="Quarters from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(rcons.73, rcons.81, rcons.90, rcons.01, rcons.07)-1,max(rcons.73, rcons.81, rcons.90, rcons.01, rcons.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,30,4)))
abline(h=0)  
lines(rcons.73,col="darkgreen",lwd=2)
lines(rcons.81,col="orange3",lwd=2)
lines(rcons.90,col="red",lwd=2)
lines(rcons.01,col="orangered4",lwd=2)
lines(rcons.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("U.S. Bureau of Economic Analysis",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("cons-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("cons-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("cons-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

################################
#Real Personal Consumption: Goods
#pdf(file = "goods.pdf", family = "Times", pointsize = 12)
plot(goods.73,
     main="Real Personal Consumption Expenditures - Goods",
     ylab="",
     xlab="Quarters from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(goods.73, goods.81, goods.90, goods.01, goods.07)-1,max(goods.73, goods.81, goods.90, goods.01, goods.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,30,4)))
abline(h=0)  
lines(goods.73,col="darkgreen",lwd=2)
lines(goods.81,col="orange3",lwd=2)
lines(goods.90,col="red",lwd=2)
lines(goods.01,col="orangered4",lwd=2)
lines(goods.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("U.S. Bureau of Economic Analysis",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("goods-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("goods-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("goods-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

################################################
#Real Personal Consumption Expenditures: Durables
#pdf(file = "durables.pdf", family = "Times", pointsize = 12)
plot(durables.73,
     main="Real Personal Consumption Expenditures - Durables",
     ylab="",
     xlab="Quarters from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(durables.73, durables.81, durables.90, durables.01, durables.07)-1,max(durables.73, durables.81, durables.90, durables.01, durables.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,30,4)))
abline(h=0)  
lines(durables.73,col="darkgreen",lwd=2)
lines(durables.81,col="orange3",lwd=2)
lines(durables.90,col="red",lwd=2)
lines(durables.01,col="orangered4",lwd=2)
lines(durables.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("U.S. Bureau of Economic Analysis",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("durables-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("durables-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("durables-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################
#Real Personal Consumption Expenditures: Nondurables
#pdf(file = "nondurables.pdf", family = "Times", pointsize = 12)
plot(nondurables.73,
     main="Real Personal Consumption Expenditures - Nondurables",
     ylab="",
     xlab="Quarters from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(nondurables.73, nondurables.81, nondurables.90, nondurables.01, nondurables.07)-1,max(nondurables.73, nondurables.81, nondurables.90, nondurables.01, nondurables.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,30,4)))
abline(h=0)  
lines(nondurables.73,col="darkgreen",lwd=2)
lines(nondurables.81,col="orange3",lwd=2)
lines(nondurables.90,col="red",lwd=2)
lines(nondurables.01,col="orangered4",lwd=2)
lines(nondurables.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("U.S. Bureau of Economic Analysis",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("nondurables-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("nondurables-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("nondurables-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#################################################
#Real Personal Consumption Expenditures: Services
#pdf(file = "services.pdf", family = "Times", pointsize = 12)
plot(services.73,
     main="Real Personal Consumption Expenditures - Services",
     ylab="",
     xlab="Quarters from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(services.73, services.81, services.90, services.01, services.07)-1,max(services.73, services.81, services.90, services.01, services.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,30,4)))
abline(h=0)  
lines(services.73,col="darkgreen",lwd=2)
lines(services.81,col="orange3",lwd=2)
lines(services.90,col="red",lwd=2)
lines(services.01,col="orangered4",lwd=2)
lines(services.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("U.S. Bureau of Economic Analysis",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("services-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("services-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("services-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#################################################
#Real Personal Consumption Expenditures: Services - Housing and Utilities
#plot(housingservices.73,
#     main="Real Personal Consumption Expenditures - Housing and Utility Services",
#     ylab="",
#     xlab="Quarters from previous peak",
#     col="white",
#     type="l",
#     lwd=2,
#     axes=FALSE,
#     yaxs="i",
#     xaxs="i",
#     tck=1,
#     bty="l",
#     family="Times",
#     ylim=c(min(housingservices.73, housingservices.81, housingservices.90, housingservices.01, housingservices.07)-1,max(housingservices.73, housingservices.81, housingservices.90, housingservices.01, housingservices.07)+1))
#axis(2,
#     tick=TRUE,
#     tck=1,
#     lwd.ticks=.1,
#     col.ticks="grey")
#axis(1,
#     tick=TRUE,
#     las=1,
#     at=c(seq(0,30,4)))
#abline(h=0)  
#lines(housingservices.73,col="darkgreen",lwd=2)
#lines(housingservices.81,col="orange3",lwd=2)
#lines(housingservices.90,col="red",lwd=2)
#lines(housingservices.01,col="orangered4",lwd=2)
#lines(housingservices.07,col="mediumblue",lwd=4)
#mtext("Percentage change from previous peak, Seasonally Adjusted",
#      side = 3,
#      line=0.5,
#      cex = 1)
#mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
#      side = 4,
#      line= 0,
#      cex = .8,
#      adj = 0)
#mtext("U.S. Bureau of Economic Analysis",
#      side = 4,
#      line= 1,
#      cex = .8,
#      adj = 0)
#box()
#legend("topleft",
#      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
#       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
#       lwd=c(2,2,2,2,2),
#       lty=c(1,1,1,1,1),
#       inset=.02,
#       cex=.75,
#       bg="gray87")
#dev.copy2pdf(file=paste("housingservices-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
#dev.copy2pdf(file=paste("housingservices-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
#dev.print(png, file=paste("housingservices-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#################################################################
#Private Domestic Investment
#pdf(file = "inv.pdf", family = "Times", pointsize = 12)
plot(rgdpi.73,
     main="Real Gross Private Domestic Investment",
     ylab="",
     xlab="Quarters from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(rgdpi.73, rgdpi.81, rgdpi.90, rgdpi.01, rgdpi.07)-1,max(rgdpi.73, rgdpi.81, rgdpi.90, rgdpi.01, rgdpi.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,30,4)))
abline(h=0)  
lines(rgdpi.73,col="darkgreen",lwd=2)
lines(rgdpi.81,col="orange3",lwd=2)
lines(rgdpi.90,col="red",lwd=2)
lines(rgdpi.01,col="orangered4",lwd=2)
lines(rgdpi.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("U.S. Bureau of Economic Analysis",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("inv-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("inv-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("inv-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Residential
#pdf(file = "rfi.pdf", family = "Times", pointsize = 12)
plot(nprfi.73,
     main="Real Private Residential Fixed Investment",
     ylab="",
     xlab="Quarters from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(nprfi.73, nprfi.81, nprfi.90, nprfi.01, nprfi.07)-1,max(nprfi.73, nprfi.81, nprfi.90, nprfi.01, nprfi.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,30,4)))
abline(h=0)  
lines(nprfi.73,col="darkgreen",lwd=2)
lines(nprfi.81,col="orange3",lwd=2)
lines(nprfi.90,col="red",lwd=2)
lines(nprfi.01,col="orangered4",lwd=2)
lines(nprfi.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("U.S. Bureau of Economic Analysis",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("rfi-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("rfi-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("rfi-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Nonresidential
#pdf(file = "nfi.pdf", family = "Times", pointsize = 12)
plot(npnfi.73,
     main="Real Private Nonresidential Fixed Investment",
     ylab="",
     xlab="Quarters from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(npnfi.73, npnfi.81, npnfi.90, npnfi.01, npnfi.07)-1,max(npnfi.73, npnfi.81, npnfi.90, npnfi.01, npnfi.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,30,4)))
abline(h=0)  
lines(npnfi.73,col="darkgreen",lwd=2)
lines(npnfi.81,col="orange3",lwd=2)
lines(npnfi.90,col="red",lwd=2)
lines(npnfi.01,col="orangered4",lwd=2)
lines(npnfi.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("U.S. Bureau of Economic Analysis",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("nfi-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("nfi-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("nfi-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Nonresidential - Equipment and Software
plot(software.73,
     main="Real Private Investment in Equipment and Software",
     ylab="",
     xlab="Quarters from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(software.73, software.81, software.90, software.01, software.07)-1,max(software.73, software.81, software.90, software.01, software.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,30,4)))
abline(h=0)  
lines(software.73,col="darkgreen",lwd=2)
lines(software.81,col="orange3",lwd=2)
lines(software.90,col="red",lwd=2)
lines(software.01,col="orangered4",lwd=2)
lines(software.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Nonresidential, Seasonally Adjusted",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("U.S. Bureau of Economic Analysis",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("software-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("software-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("software-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Real Govnerment Expenditures & Gross Investment
#pdf(file = "gov.pdf", family = "Times", pointsize = 12)
plot(gov.73,
     main="Real Government Consumption Expenditures & Gross Investment",
     ylab="",
     xlab="Quarters from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(gov.73, gov.81, gov.90, gov.01, gov.07)-1,max(gov.73, gov.81, gov.90, gov.01, gov.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,30,4)))
abline(h=0)  
lines(gov.73,col="darkgreen",lwd=2)
lines(gov.81,col="orange3",lwd=2)
lines(gov.90,col="red",lwd=2)
lines(gov.01,col="orangered4",lwd=2)
lines(gov.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("U.S. Bureau of Economic Analysis",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("gov-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("gov-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("gov-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Real Exports of Goods & Services
#pdf(file = "exports.pdf", family = "Times", pointsize = 12)
plot(exports.73,
     main="Real Exports of Goods & Services",
     ylab="",
     xlab="Quarters from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(exports.73, exports.81, exports.90, exports.01, exports.07)-1,max(exports.73, exports.81, exports.90, exports.01, exports.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,30,4)))
abline(h=0)  
lines(exports.73,col="darkgreen",lwd=2)
lines(exports.81,col="orange3",lwd=2)
lines(exports.90,col="red",lwd=2)
lines(exports.01,col="orangered4",lwd=2)
lines(exports.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("U.S. Bureau of Economic Analysis",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("exports-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("exports-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("exports-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Real Imports of Goods & Services
#pdf(file = "imports.pdf", family = "Times", pointsize = 12)
plot(imports.73,
     main="Real Imports of Goods & Services",
     ylab="",
     xlab="Quarters from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(imports.73, imports.81, imports.90, imports.01, imports.07)-1,max(imports.73, imports.81, imports.90, imports.01, imports.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,30,4)))
abline(h=0)  
lines(imports.73,col="darkgreen",lwd=2)
lines(imports.81,col="orange3",lwd=2)
lines(imports.90,col="red",lwd=2)
lines(imports.01,col="orangered4",lwd=2)
lines(imports.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("U.S. Bureau of Economic Analysis",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("imports-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("imports-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("imports-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

dev.off()


################################# Credit Market #######################################
#Get Data
#Total Consumer Credit Oustanding:
cc <- read.fwf("http://research.stlouisfed.org/fred2/data/TOTALSL.txt",skip=14,widths=c(10,8),header=FALSE, col.names=c("date","value"))

#Households & Non-profit Organizations Net Worth
networth <- ts(read.csv("http://www.federalreserve.gov/datadownload/Output.aspx?rel=Z1&series=09965856e2dead27fb02a6931f6e3e39&lastObs=&from=03/01/1945&to=12/31/2020&filetype=csv&label=include&layout=seriescolumn", skip=30, sep=",", header=FALSE)[,43], start=c(1951,4), deltat=1/4)

#Households' Assets -  Real Estate at Market Value
realestate <- ts(read.csv("http://www.federalreserve.gov/datadownload/Output.aspx?rel=Z1&series=09965856e2dead27fb02a6931f6e3e39&lastObs=&from=03/01/1945&to=12/31/2020&filetype=csv&label=include&layout=seriescolumn", skip=30, sep=",", header=FALSE)[,4], start=c(1951,4), deltat=1/4)

#Households Debt Oustanding: STOCK
hhdebt <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/CMDEBT.txt",skip=12,widths=c(12,10),header=FALSE, col.names=c("date","value"))[,2], start=c(1949,4), deltat=1/4)

#Households Total Borrowing: FLOW
hhborrow <- ts(read.csv("http://www.federalreserve.gov/datadownload/Output.aspx?rel=Z1&series=88184524e71f816af03f01907f12939e&lastObs=&from=03/01/1945&to=12/31/2020&filetype=csv&label=include&layout=seriescolumn", skip=26, sep=",", header=FALSE)[,4], start=c(1951,4), deltat=1/4)

#Business Corporate Debt Outstanding: STOCK
bcdebt <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/BCNSDODNS.txt",skip=15,widths=c(10,9),header=FALSE, col.names=c("date","value"))[,2], start=c(1949,4),deltat=1/4)

#Business Corporate Debt Borrowing: FLOW
bcborrow <- ts(read.csv("http://www.federalreserve.gov/datadownload/Output.aspx?rel=Z1&series=bafcc7826fb6ad18c908261487c7546a&lastObs=&from=03/01/1945&to=12/31/2020&filetype=csv&label=include&layout=seriescolumn", skip=26, sep=",", header=FALSE)[,7], start=c(1951,4), deltat=1/4)

#Bank Credit

#Publically Held Federal Debt
fd.pub <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/FYGFDPUN.txt",skip=12,widths=c(10,9),header=FALSE, col.names=c("date","value"))[,2], start=c(1970,1), deltat=1/4)

#Foriegn Held Federal Debt
fd.for <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/FDHBFIN.txt",skip=12,widths=c(10,8),header=FALSE, col.names=c("date","value"))[,2], start=c(1970,1), deltat=1/4)

fd.for <- fd.for*1000

#Total Public Federal Debt
fd <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/GFDEBTN.txt",skip=28,widths=c(10,10),header=FALSE, col.names=c("date","value"))[,2], start=c(1970,1), deltat=1/4)

#Nominal GDP
GDP <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/GDP.txt",skip=13,widths=c(10,9),header=FALSE, col.names=c("date","value"))[,2], start=c(1947,1), deltat=1/4)


#Restrict range of dates to lowest common denominator with gdp
bcdebt <- window(bcdebt, start=c(1970,1), end=NULL)
bcborrow <- window(bcborrow, start=c(1970,1), end=NULL)
networth <- window(networth, start=c(1970,1), end=NULL)
hhdebt <- window(hhdebt, start=c(1970,1), end=NULL)
hhborrow <- window(hhborrow, start=c(1970,1), end=NULL)
fd.pub <- window(fd.pub, start=c(1970,1), end=NULL)
fd <- window(fd, start=c(1970,1), end=NULL)
GDP <- window(GDP, start=c(1970,1), end=NULL)

#Convert consumer credit into quarterly observations (mean across 3 months on quarter)
q.cc <- matrix(0,length(GDP),1)

for(i in 1:length(GDP)){
  q.cc[i] <- (cc$value[(i*3)-2]+cc$value[(i*3)-1]+cc$value[(i*3)])/3
}

#Check if dates match
if(is.na(q.cc[length(q.cc)])){
  q.cc <- q.cc[1:length(q.cc)-1]
  gdp <- gdp[1:length(gdp)-1,]
}

#Compute ratios to GDP
ccgdp <- (q.cc/GDP)*100
networth <- (networth/GDP)*100
hhgdp <- (hhdebt/GDP)*100
bcgdp <- (bcdebt/GDP)*100
fdpub <- (fd.pub/GDP)*100

#Compute publically and foriegn held federal debt as ratios to total federal debt
fdfor <- fd.for/fd.pub


#Compute change from previous peak 
ccgdp.73 <- as.numeric(window(ccgdp, start=c(1973,4),end=c(1978,4)))
ccgdp.81 <- as.numeric(window(ccgdp, start=c(1981,3),end=c(1986,3)))
ccgdp.90 <- as.numeric(window(ccgdp, start=c(1990,3),end=c(1995,3)))
ccgdp.01 <- as.numeric(window(ccgdp, start=c(2001,1),end=c(2006,1)))
ccgdp.07 <- as.numeric(window(ccgdp, start=c(2007,4),end=NULL))

ccgdp.73 <- ts((ccgdp.73/ccgdp.73[1] - 1)*100,start=1)
ccgdp.81 <- ts((ccgdp.81/ccgdp.81[1] - 1)*100, start=1)
ccgdp.90 <- ts((ccgdp.90/ccgdp.90[1] - 1)*100, start=1)
ccgdp.01 <- ts((ccgdp.01/ccgdp.01[1] - 1)*100, start=1)
ccgdp.07 <- ts((ccgdp.07/ccgdp.07[1] - 1)*100, start=1)

bcgdp.73 <- as.numeric(window(bcgdp, start=c(1973,4),end=c(1978,4)))
bcgdp.81 <- as.numeric(window(bcgdp, start=c(1981,3),end=c(1986,3)))
bcgdp.90 <- as.numeric(window(bcgdp, start=c(1990,3),end=c(1995,3)))
bcgdp.01 <- as.numeric(window(bcgdp, start=c(2001,1),end=c(2006,1)))
bcgdp.07 <- as.numeric(window(bcgdp, start=c(2007,4),end=NULL))

bcgdp.73 <- ts((bcgdp.73/bcgdp.73[1] - 1)*100,start=1)
bcgdp.81 <- ts((bcgdp.81/bcgdp.81[1] - 1)*100, start=1)
bcgdp.90 <- ts((bcgdp.90/bcgdp.90[1] - 1)*100, start=1)
bcgdp.01 <- ts((bcgdp.01/bcgdp.01[1] - 1)*100, start=1)
bcgdp.07 <- ts((bcgdp.07/bcgdp.07[1] - 1)*100, start=1)

borrow.73 <- as.numeric(window(bcborrow, start=c(1973,4),end=c(1978,4)))
borrow.81 <- as.numeric(window(bcborrow, start=c(1981,3),end=c(1986,3)))
borrow.90 <- as.numeric(window(bcborrow, start=c(1990,3),end=c(1995,3)))
borrow.01 <- as.numeric(window(bcborrow, start=c(2001,1),end=c(2006,1)))
borrow.07 <- as.numeric(window(bcborrow, start=c(2007,4),end=NULL))

borrow.73 <- ts((borrow.73/borrow.73[1] - 1)*100,start=1)
borrow.81 <- ts((borrow.81/borrow.81[1] - 1)*100, start=1)
borrow.90 <- ts((borrow.90/borrow.90[1] - 1)*100, start=1)
borrow.01 <- ts((borrow.01/borrow.01[1] - 1)*100, start=1)
borrow.07 <- ts((borrow.07/borrow.07[1] - 1)*100, start=1)

networth.73 <- as.numeric(window(networth, start=c(1973,4),end=c(1978,4)))
networth.81 <- as.numeric(window(networth, start=c(1981,3),end=c(1986,3)))
networth.90 <- as.numeric(window(networth, start=c(1990,3),end=c(1995,3)))
networth.01 <- as.numeric(window(networth, start=c(2001,1),end=c(2006,1)))
networth.07 <- as.numeric(window(networth, start=c(2007,4),end=NULL))

networth.73 <- ts((networth.73/networth.73[1] - 1)*100,start=1)
networth.81 <- ts((networth.81/networth.81[1] - 1)*100, start=1)
networth.90 <- ts((networth.90/networth.90[1] - 1)*100, start=1)
networth.01 <- ts((networth.01/networth.01[1] - 1)*100, start=1)
networth.07 <- ts((networth.07/networth.07[1] - 1)*100, start=1)

realestate.73 <- as.numeric(window(realestate, start=c(1973,4),end=c(1978,4)))
realestate.81 <- as.numeric(window(realestate, start=c(1981,3),end=c(1986,3)))
realestate.90 <- as.numeric(window(realestate, start=c(1990,3),end=c(1995,3)))
realestate.01 <- as.numeric(window(realestate, start=c(2001,1),end=c(2006,1)))
realestate.07 <- as.numeric(window(realestate, start=c(2007,4),end=NULL))

realestate.73 <- ts((realestate.73/realestate.73[1] - 1)*100,start=1)
realestate.81 <- ts((realestate.81/realestate.81[1] - 1)*100, start=1)
realestate.90 <- ts((realestate.90/realestate.90[1] - 1)*100, start=1)
realestate.01 <- ts((realestate.01/realestate.01[1] - 1)*100, start=1)
realestate.07 <- ts((realestate.07/realestate.07[1] - 1)*100, start=1)

hhgdp.73 <- as.numeric(window(hhgdp, start=c(1973,4),end=c(1978,4)))
hhgdp.81 <- as.numeric(window(hhgdp, start=c(1981,3),end=c(1986,3)))
hhgdp.90 <- as.numeric(window(hhgdp, start=c(1990,3),end=c(1995,3)))
hhgdp.01 <- as.numeric(window(hhgdp, start=c(2001,1),end=c(2006,1)))
hhgdp.07 <- as.numeric(window(hhgdp, start=c(2007,4),end=NULL))

hhgdp.73 <- ts((hhgdp.73/hhgdp.73[1] - 1)*100,start=1)
hhgdp.81 <- ts((hhgdp.81/hhgdp.81[1] - 1)*100, start=1)
hhgdp.90 <- ts((hhgdp.90/hhgdp.90[1] - 1)*100, start=1)
hhgdp.01 <- ts((hhgdp.01/hhgdp.01[1] - 1)*100, start=1)
hhgdp.07 <- ts((hhgdp.07/hhgdp.07[1] - 1)*100, start=1)

hhborrow.73 <- as.numeric(window(hhborrow, start=c(1973,4),end=c(1978,4)))
hhborrow.81 <- as.numeric(window(hhborrow, start=c(1981,3),end=c(1986,3)))
hhborrow.90 <- as.numeric(window(hhborrow, start=c(1990,3),end=c(1995,3)))
hhborrow.01 <- as.numeric(window(hhborrow, start=c(2001,1),end=c(2006,1)))
hhborrow.07 <- as.numeric(window(hhborrow, start=c(2007,4),end=NULL))

hhborrow.73 <- ts((hhborrow.73/hhborrow.73[1] - 1)*100,start=1)
hhborrow.81 <- ts((hhborrow.81/hhborrow.81[1] - 1)*100, start=1)
hhborrow.90 <- ts((hhborrow.90/hhborrow.90[1] - 1)*100, start=1)
hhborrow.01 <- ts((hhborrow.01/hhborrow.01[1] - 1)*100, start=1)
hhborrow.07 <- ts((hhborrow.07/hhborrow.07[1] - 1)*100, start=1)

fdpub.73 <- as.numeric(window(fdpub, start=c(1973,4),end=c(1978,4)))
fdpub.81 <- as.numeric(window(fdpub, start=c(1981,3),end=c(1986,3)))
fdpub.90 <- as.numeric(window(fdpub, start=c(1990,3),end=c(1995,3)))
fdpub.01 <- as.numeric(window(fdpub, start=c(2001,1),end=c(2006,1)))
fdpub.07 <- as.numeric(window(fdpub, start=c(2007,4),end=NULL))

fdpub.73 <- ts((fdpub.73/fdpub.73[1] - 1)*100,start=1)
fdpub.81 <- ts((fdpub.81/fdpub.81[1] - 1)*100, start=1)
fdpub.90 <- ts((fdpub.90/fdpub.90[1] - 1)*100, start=1)
fdpub.01 <- ts((fdpub.01/fdpub.01[1] - 1)*100, start=1)
fdpub.07 <- ts((fdpub.07/fdpub.07[1] - 1)*100, start=1)

fdfor.73 <- as.numeric(window(fdfor, start=c(1973,4),end=c(1978,4)))
fdfor.81 <- as.numeric(window(fdfor, start=c(1981,3),end=c(1986,3)))
fdfor.90 <- as.numeric(window(fdfor, start=c(1990,3),end=c(1995,3)))
fdfor.01 <- as.numeric(window(fdfor, start=c(2001,1),end=c(2006,1)))
fdfor.07 <- as.numeric(window(fdfor, start=c(2007,4),end=NULL))

fdfor.73 <- ts((fdfor.73/fdfor.73[1] - 1)*100,start=1)
fdfor.81 <- ts((fdfor.81/fdfor.81[1] - 1)*100, start=1)
fdfor.90 <- ts((fdfor.90/fdfor.90[1] - 1)*100, start=1)
fdfor.01 <- ts((fdfor.01/fdfor.01[1] - 1)*100, start=1)
fdfor.07 <- ts((fdfor.07/fdfor.07[1] - 1)*100, start=1)

#####################################################################
#Graph Series

#####################################################################
#Total Consumer Credit Outstanding to GDP
x11()
#pdf(file = "ccgdp.pdf", family = "Times", pointsize = 12)
plot(ccgdp.73,
     main="Consumer Credit to GDP Ratio",
     ylab="",
     xlab="Quarters from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(ccgdp.73, ccgdp.81, ccgdp.90, ccgdp.01, ccgdp.07)-1,max(ccgdp.73, ccgdp.81, ccgdp.90, ccgdp.01, ccgdp.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,30,4)))
abline(h=0)  
lines(ccgdp.73,col="darkgreen",lwd=2)
lines(ccgdp.81,col="orange3",lwd=2)
lines(ccgdp.90,col="red",lwd=2)
lines(ccgdp.01,col="orangered4",lwd=2)
lines(ccgdp.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: Federal Reserve Board of Governors & U.S. Bureau of Economic Analysis",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("ccgdp-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("ccgdp-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("ccgdp-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Business Corporate Debt Oustanding to GDP
#pdf(file = "bcdebt.pdf", family = "Times", pointsize = 12)
plot(bcgdp.73,
     main="Business Corporate Debt Outstanding to GDP",
     ylab="",
     xlab="Quarters from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(bcgdp.73, bcgdp.81, bcgdp.90, bcgdp.01, bcgdp.07)-1,max(bcgdp.73, bcgdp.81, bcgdp.90, bcgdp.01, bcgdp.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,30,4)))
abline(h=0)  
lines(bcgdp.73,col="darkgreen",lwd=2)
lines(bcgdp.81,col="orange3",lwd=2)
lines(bcgdp.90,col="red",lwd=2)
lines(bcgdp.01,col="orangered4",lwd=2)
lines(bcgdp.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: Federal Reserve Board of Governors & U.S. Bureau of Economic Analysis",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("bottomleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("bcdebt-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("bcdebt-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("bcdebt-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Business Corporate Total Borrowing
#pdf(file = "bcborrow.pdf", family = "Times", pointsize = 12)
plot(borrow.73,
     main="Business Corporate Total Borrowing",
     ylab="",
     xlab="Quarters from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(borrow.73, borrow.81, borrow.90, borrow.01, borrow.07)-1,max(borrow.73, borrow.81, borrow.90, borrow.01, borrow.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,30,4)))
abline(h=0)  
lines(borrow.73,col="darkgreen",lwd=2)
lines(borrow.81,col="orange3",lwd=2)
lines(borrow.90,col="red",lwd=2)
lines(borrow.01,col="orangered4",lwd=2)
lines(borrow.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: Federal Reserve Board of Governors",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("bottomleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("bcborrow-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("bcborrow-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("bcborrow-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Households and nonprofit organizations, net worth
#pdf(file = "hhnetworth.pdf", family = "Times", pointsize = 12)
plot(networth.73,
     main="Household Sector Net Worth to GDP",
     ylab="",
     xlab="Quarters from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(networth.73, networth.81, networth.90, networth.01, networth.07)-1,max(networth.73, networth.81, networth.90, networth.01, networth.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,30,4)))
abline(h=0)  
lines(networth.73,col="darkgreen",lwd=2)
lines(networth.81,col="orange3",lwd=2)
lines(networth.90,col="red",lwd=2)
lines(networth.01,col="orangered4",lwd=2)
lines(networth.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: Federal Reserve Board of Governors",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("hhnetworth-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("hhnetworth-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("hhnetworth-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Households and nonprofit organizations, Assets - Real Estate
#plot(realestate.73,
#     main="Household Sector Assets - Real Estate at Market Value",
#     ylab="",
#     xlab="Quarters from previous peak",
#     col="white",
#     type="l",
#     lwd=2,
#     axes=FALSE,
#     yaxs="i",
#     xaxs="i",
#     tck=1,
#     bty="l",
#     family="Times",
#     ylim=c(min(realestate.73, realestate.81, realestate.90, realestate.01, realestate.07)-1,max(realestate.73, realestate.81, realestate.90, realestate.01, realestate.07)+1))
#axis(2,
#     tick=TRUE,
#     tck=1,
#     lwd.ticks=.1,
#     col.ticks="grey")
#axis(1,
#     tick=TRUE,
#     las=1,
#     at=c(seq(0,30,4)))
#abline(h=0)  
#lines(realestate.73,col="darkgreen",lwd=2)
#lines(realestate.81,col="orange3",lwd=2)
#lines(realestate.90,col="red",lwd=2)
#lines(realestate.01,col="orangered4",lwd=2)
#lines(realestate.07,col="mediumblue",lwd=4)
#mtext("Percentage change from previous peak, Seasonally Adjusted",
#      side = 3,
#      line=0.5,
#      cex = 1)
#mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
#      side = 4,
#      line= 0,
#      cex = .8,
#      adj = 0)
#mtext("Source: Federal Reserve Board of Governors",
#      side = 4,
#      line= 1,
#      cex = .8,
#      adj = 0)
#box()
#legend("topleft",
#      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
#       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
#       lwd=c(2,2,2,2,2),
#       lty=c(1,1,1,1,1),
#       inset=.02,
#       cex=.75,
#       bg="gray87")
#dev.copy2pdf(file=paste("realestate-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
#dev.copy2pdf(file=paste("realestate-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
#dev.print(png, file=paste("realestate-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Households and nonprofit organizations, Total Debt Outstanding
#pdf(file = "hhdebt.pdf", family = "Times", pointsize = 12)
plot(hhgdp.73,
     main="Household Sector Debt Oustanding to GDP",
     ylab="",
     xlab="Quarters from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(hhgdp.73, hhgdp.81, hhgdp.90, hhgdp.01, hhgdp.07)-1,max(hhgdp.73, hhgdp.81, hhgdp.90, hhgdp.01, hhgdp.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,30,4)))
abline(h=0)  
lines(hhgdp.73,col="darkgreen",lwd=2)
lines(hhgdp.81,col="orange3",lwd=2)
lines(hhgdp.90,col="red",lwd=2)
lines(hhgdp.01,col="orangered4",lwd=2)
lines(hhgdp.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: Federal Reserve Board of Governors",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("bottomleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("hhdebt-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("hhdebt-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("hhdebt-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Households and nonprofit organizations, Total Borrowing
#pdf(file = "hhborrow.pdf", family = "Times", pointsize = 12)
plot(hhborrow.73,
     main="Household Sector Total Borrowing",
     ylab="",
     xlab="Quarters from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(hhborrow.73, hhborrow.81, hhborrow.90, hhborrow.01, hhborrow.07)-1,max(hhborrow.73, hhborrow.81, hhborrow.90, hhborrow.01, hhborrow.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,30,4)))
abline(h=0)  
lines(hhborrow.73,col="darkgreen",lwd=2)
lines(hhborrow.81,col="orange3",lwd=2)
lines(hhborrow.90,col="red",lwd=2)
lines(hhborrow.01,col="orangered4",lwd=2)
lines(hhborrow.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: Federal Reserve Board of Governors",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("hhborrow-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("hhborrow-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("hhborrow-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Publically Held Federal Debt
#pdf(file = "fdpub.pdf", family = "Times", pointsize = 12)
plot(fdpub.73,
     main="Publicly Held Federal Debt as a Percentage GDP",
     ylab="",
     xlab="Quarters from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(fdpub.73, fdpub.81, fdpub.90, fdpub.01, fdpub.07)-1,max(fdpub.73, fdpub.81, fdpub.90, fdpub.01, fdpub.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,30,4)))
abline(h=0)  
lines(fdpub.73,col="darkgreen",lwd=2)
lines(fdpub.81,col="orange3",lwd=2)
lines(fdpub.90,col="red",lwd=2)
lines(fdpub.01,col="orangered4",lwd=2)
lines(fdpub.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: U.S. Department of Treasury & U.S. Bureau of Economic Analysis",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("fdpub-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("fdpub-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("fdpub-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Federal Debt held by foreign and international investors
#pdf(file = "fdfor.pdf", family = "Times", pointsize = 12)
plot(fdfor.73,
     main="Internationally Held Federal Debt as a Percentage of Total",
     ylab="",
     xlab="Quarters from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(fdfor.73, fdfor.81, fdfor.90, fdfor.01, fdfor.07)-1,max(fdfor.73, fdfor.81, fdfor.90, fdfor.01, fdfor.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,30,4)))
abline(h=0)  
lines(fdfor.73,col="darkgreen",lwd=2)
lines(fdfor.81,col="orange3",lwd=2)
lines(fdfor.90,col="red",lwd=2)
lines(fdfor.01,col="orangered4",lwd=2)
lines(fdfor.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: U.S. Department of Treasury & U.S. Bureau of Economic Analysis",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("fdfor-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("fdfor-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("fdfor-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

dev.off()


################################# Labor Market #######################################

#Get Data
#Total Employment - Establishment Survey - Nonfarm
emp <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/PAYEMS.txt",skip=15,widths=c(10,8),header=FALSE, col.names=c("date","value"))[,2], start=c(1939,1), deltat=1/12)

#Total Employment - Establishment Survey - Nonfarm Private
emp.private <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/USPRIV.txt",skip=12,widths=c(10,8),header=FALSE, col.names=c("date","value"))[,2], start=c(1939,1), deltat=1/12)

#Total Employment - ADP Report - Nonfarm Private
adp <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/NPPTTL.txt",skip=12,widths=c(10,8),header=FALSE, col.names=c("date","value"))[,2], start=c(2000,12), deltat=1/12)

#Labor Force Participation Rate
lfp <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/CIVPART.txt",skip=19,widths=c(10,6),header=FALSE, col.names=c("date","value"))[,2], start=c(1948,1), deltat=1/12)
#lfp <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/LNU01300000.txt",skip=12,widths=c(10,6),header=FALSE, col.names=c("date","value"))[,2], start=c(1948,1), deltat=1/12)

#Labor Force Participation Rate - Men
lfp.men <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/LNS11300001.txt",skip=12,widths=c(10,6),header=FALSE, col.names=c("date","value"))[,2], start=c(1948,1), deltat=1/12)

#Labor Force Participation Rate - Women
lfp.women <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/LNS11300002.txt",skip=12,widths=c(10,6),header=FALSE, col.names=c("date","value"))[,2], start=c(1948,1), deltat=1/12)


#Productivity: Output per hour - Nonfarm Business Sector
prod <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/OPHNFB.txt",skip=19,widths=c(10,9),header=FALSE, col.names=c("date","value"))[,2], start=c(1947,1), deltat=1/4)

#Hours of all Persons - Nonfarm Business
hours <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/HOANBS.txt",skip=12,widths=c(10,9),header=FALSE, col.names=c("date","value"))[,2], start=c(1947,1), deltat=1/4)

#Real Compensation Per Hour: Nonfarm Business
rc.nf <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/COMPRNFB.txt",skip=19,widths=c(10,9),header=FALSE, col.names=c("date","value"))[,2], start=c(1947,1), deltat=1/4)

#Vacancy Rate: Nonfarm Business
vac <- read.fwf("http://research.stlouisfed.org/fred2/data/JTSJOR.txt",skip=12,widths=c(10,6),header=FALSE, col.names=c("date","value"))

#Vacancy Level: Nonfarm Business
vaclevel <- read.fwf("http://research.stlouisfed.org/fred2/data/JTSJOL.txt",skip=12,widths=c(10,6),header=FALSE, col.names=c("date","value"))

vac$date <- as.Date(vac$date)
vaclevel$date <- as.Date(vaclevel$date)

#Civilian Unemployment Rate
unemp <- read.fwf("http://research.stlouisfed.org/fred2/data/UNRATE.txt", skip=21,widths=c(10,6),header=FALSE, col.names = c("date","value"))

unemp$date <- as.Date(unemp$date)

urate <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/UNRATE.txt", skip=21,widths=c(10,6),header=FALSE, col.names = c("date","value"))[,2], start=c(1948,1), deltat=1/12)

#Employment Population Ratio
epr <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/EMRATIO.txt",skip=19,widths=c(10,6),header=FALSE, col.names=c("date","value"))[,2], start=c(1948,1), deltat=1/12)

#Total Separations Rate
sep <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/JTSTSR.txt",skip=12,widths=c(10,6),header=FALSE, col.names=c("date","sep"))[,2], start=c(2000,12), deltat=1/12)

#Total Layoffs Discharges Rate
layoff <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/JTSLDR.txt",skip=12,widths=c(10,6),header=FALSE, col.names=c("date","layoff"))[,2], start=c(2000,12), deltat=1/12)

#Total Quits Rate
quits <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/JTSQUR.txt",skip=12,widths=c(10,6),header=FALSE, col.names=c("date","quits"))[,2], start=c(2000,12), deltat=1/12)

#Total Hires
hires <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/JTSHIR.txt",skip=12,widths=c(10,6),header=FALSE, col.names=c("date","hires"))[,2], start=c(2000,12), deltat=1/12)

#Drop years before JOLTS
unemp <- unemp[unemp$date>=vac$date[1],]

#Drop years not available in the other time series 
if(dim(vac)[1]!=dim(unemp)[1]){
  if (dim(vac)[1]>dim(unemp)[1]){
    vac <- vac[vac$date<=unemp$date[dim(unemp)[1]],]
  }
  else{
    unemp <- unemp[unemp$date<=vac$date[dim(vac)[1]],]
  }
}

#Format both as time series
unemp$value <- ts(unemp$value, start=c(2000,12),deltat=1/12)
vac$value <- ts(vac$value, start=c(2000,12),deltat=1/12)

#Average weeks unemployed
uduration <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/LNU03008275.txt",skip=12,widths=c(10,6),header=FALSE, col.names=c("date","value"))[,2], start=c(1948,1), deltat=1/12)


#Compute change from previous peak
emp.73 <- as.numeric(window(emp, start=c(1973,11),end=c(1978,11)))
emp.81 <- as.numeric(window(emp, start=c(1981,7),end=c(1986,7)))
emp.90 <- as.numeric(window(emp, start=c(1990,7),end=c(1995,7)))
emp.01 <- as.numeric(window(emp, start=c(2001,3),end=c(2006,3)))
emp.07 <- as.numeric(window(emp, start=c(2007,12),end=NULL))

emp.73 <- ts((emp.73/emp.73[1] - 1)*100,start=1)
emp.81 <- ts((emp.81/emp.81[1] - 1)*100, start=1)
emp.90 <- ts((emp.90/emp.90[1] - 1)*100, start=1)
emp.01 <- ts((emp.01/emp.01[1] - 1)*100, start=1)
emp.07 <- ts((emp.07/emp.07[1] - 1)*100, start=1)

emp.private.73 <- as.numeric(window(emp.private, start=c(1973,11),end=c(1978,11)))
emp.private.81 <- as.numeric(window(emp.private, start=c(1981,7),end=c(1986,7)))
emp.private.90 <- as.numeric(window(emp.private, start=c(1990,7),end=c(1995,7)))
emp.private.01 <- as.numeric(window(emp.private, start=c(2001,3),end=c(2006,3)))
emp.private.07 <- as.numeric(window(emp.private, start=c(2007,12),end=NULL))

emp.private.73 <- ts((emp.private.73/emp.private.73[1] - 1)*100,start=1)
emp.private.81 <- ts((emp.private.81/emp.private.81[1] - 1)*100, start=1)
emp.private.90 <- ts((emp.private.90/emp.private.90[1] - 1)*100, start=1)
emp.private.01 <- ts((emp.private.01/emp.private.01[1] - 1)*100, start=1)
emp.private.07 <- ts((emp.private.07/emp.private.07[1] - 1)*100, start=1)

adp.01 <- as.numeric(window(adp, start=c(2001,3),end=c(2006,3)))
adp.07 <- as.numeric(window(adp, start=c(2007,12),end=NULL))

adp.01 <- ts((adp.01/adp.01[1] - 1)*100, start=1)
adp.07 <- ts((adp.07/adp.07[1] - 1)*100, start=1)

lfp.73 <- as.numeric(window(lfp, start=c(1973,11),end=c(1978,11)))
lfp.81 <- as.numeric(window(lfp, start=c(1981,7),end=c(1986,7)))
lfp.90 <- as.numeric(window(lfp, start=c(1990,7),end=c(1995,7)))
lfp.01 <- as.numeric(window(lfp, start=c(2001,3),end=c(2006,3)))
lfp.07 <- as.numeric(window(lfp, start=c(2007,12),end=NULL))

lfp.73 <- ts((lfp.73/lfp.73[1] - 1)*100,start=1)
lfp.81 <- ts((lfp.81/lfp.81[1] - 1)*100, start=1)
lfp.90 <- ts((lfp.90/lfp.90[1] - 1)*100, start=1)
lfp.01 <- ts((lfp.01/lfp.01[1] - 1)*100, start=1)
lfp.07 <- ts((lfp.07/lfp.07[1] - 1)*100, start=1)

lfp.men.73 <- as.numeric(window(lfp.men, start=c(1973,11),end=c(1978,11)))
lfp.men.81 <- as.numeric(window(lfp.men, start=c(1981,7),end=c(1986,7)))
lfp.men.90 <- as.numeric(window(lfp.men, start=c(1990,7),end=c(1995,7)))
lfp.men.01 <- as.numeric(window(lfp.men, start=c(2001,3),end=c(2006,3)))
lfp.men.07 <- as.numeric(window(lfp.men, start=c(2007,12),end=NULL))

lfp.men.73 <- ts((lfp.men.73/lfp.men.73[1] - 1)*100,start=1)
lfp.men.81 <- ts((lfp.men.81/lfp.men.81[1] - 1)*100, start=1)
lfp.men.90 <- ts((lfp.men.90/lfp.men.90[1] - 1)*100, start=1)
lfp.men.01 <- ts((lfp.men.01/lfp.men.01[1] - 1)*100, start=1)
lfp.men.07 <- ts((lfp.men.07/lfp.men.07[1] - 1)*100, start=1)

lfp.women.73 <- as.numeric(window(lfp.women, start=c(1973,11),end=c(1978,11)))
lfp.women.81 <- as.numeric(window(lfp.women, start=c(1981,7),end=c(1986,7)))
lfp.women.90 <- as.numeric(window(lfp.women, start=c(1990,7),end=c(1995,7)))
lfp.women.01 <- as.numeric(window(lfp.women, start=c(2001,3),end=c(2006,3)))
lfp.women.07 <- as.numeric(window(lfp.women, start=c(2007,12),end=NULL))

lfp.women.73 <- ts((lfp.women.73/lfp.women.73[1] - 1)*100,start=1)
lfp.women.81 <- ts((lfp.women.81/lfp.women.81[1] - 1)*100, start=1)
lfp.women.90 <- ts((lfp.women.90/lfp.women.90[1] - 1)*100, start=1)
lfp.women.01 <- ts((lfp.women.01/lfp.women.01[1] - 1)*100, start=1)
lfp.women.07 <- ts((lfp.women.07/lfp.women.07[1] - 1)*100, start=1)

prod.73 <- as.numeric(window(prod, start=c(1973,4),end=c(1978,4)))
prod.81 <- as.numeric(window(prod, start=c(1981,3),end=c(1986,3)))
prod.90 <- as.numeric(window(prod, start=c(1990,3),end=c(1995,3)))
prod.01 <- as.numeric(window(prod, start=c(2001,1),end=c(2006,1)))
prod.07 <- as.numeric(window(prod, start=c(2007,4),end=NULL))

prod.73 <- ts((prod.73/prod.73[1] - 1)*100,start=1)
prod.81 <- ts((prod.81/prod.81[1] - 1)*100, start=1)
prod.90 <- ts((prod.90/prod.90[1] - 1)*100, start=1)
prod.01 <- ts((prod.01/prod.01[1] - 1)*100, start=1)
prod.07 <- ts((prod.07/prod.07[1] - 1)*100, start=1)

hours.73 <- as.numeric(window(hours, start=c(1973,4),end=c(1978,4)))
hours.81 <- as.numeric(window(hours, start=c(1981,3),end=c(1986,3)))
hours.90 <- as.numeric(window(hours, start=c(1990,3),end=c(1995,3)))
hours.01 <- as.numeric(window(hours, start=c(2001,1),end=c(2006,1)))
hours.07 <- as.numeric(window(hours, start=c(2007,4),end=NULL))

hours.73 <- ts((hours.73/hours.73[1] - 1)*100,start=1)
hours.81 <- ts((hours.81/hours.81[1] - 1)*100, start=1)
hours.90 <- ts((hours.90/hours.90[1] - 1)*100, start=1)
hours.01 <- ts((hours.01/hours.01[1] - 1)*100, start=1)
hours.07 <- ts((hours.07/hours.07[1] - 1)*100, start=1)

rc.nf.73 <- as.numeric(window(rc.nf, start=c(1973,4),end=c(1978,4)))
rc.nf.81 <- as.numeric(window(rc.nf, start=c(1981,3),end=c(1986,3)))
rc.nf.90 <- as.numeric(window(rc.nf, start=c(1990,3),end=c(1995,3)))
rc.nf.01 <- as.numeric(window(rc.nf, start=c(2001,1),end=c(2006,1)))
rc.nf.07 <- as.numeric(window(rc.nf, start=c(2007,4),end=NULL))

rc.nf.73 <- ts((rc.nf.73/rc.nf.73[1] - 1)*100,start=1)
rc.nf.81 <- ts((rc.nf.81/rc.nf.81[1] - 1)*100, start=1)
rc.nf.90 <- ts((rc.nf.90/rc.nf.90[1] - 1)*100, start=1)
rc.nf.01 <- ts((rc.nf.01/rc.nf.01[1] - 1)*100, start=1)
rc.nf.07 <- ts((rc.nf.07/rc.nf.07[1] - 1)*100, start=1)

urate.73 <- as.numeric(window(urate, start=c(1973,11),end=c(1978,11)))
urate.81 <- as.numeric(window(urate, start=c(1981,7),end=c(1986,7)))
urate.90 <- as.numeric(window(urate, start=c(1990,7),end=c(1995,7)))
urate.01 <- as.numeric(window(urate, start=c(2001,3),end=c(2006,3)))
urate.07 <- as.numeric(window(urate, start=c(2007,12),end=NULL))

urate.73 <- ts((urate.73/urate.73[1] - 1)*100,start=1)
urate.81 <- ts((urate.81/urate.81[1] - 1)*100, start=1)
urate.90 <- ts((urate.90/urate.90[1] - 1)*100, start=1)
urate.01 <- ts((urate.01/urate.01[1] - 1)*100, start=1)
urate.07 <- ts((urate.07/urate.07[1] - 1)*100, start=1)

epr.73 <- as.numeric(window(epr, start=c(1973,11),end=c(1978,11)))
epr.81 <- as.numeric(window(epr, start=c(1981,7),end=c(1986,7)))
epr.90 <- as.numeric(window(epr, start=c(1990,7),end=c(1995,7)))
epr.01 <- as.numeric(window(epr, start=c(2001,3),end=c(2006,3)))
epr.07 <- as.numeric(window(epr, start=c(2007,12),end=NULL))

epr.73 <- ts((epr.73/epr.73[1] - 1)*100,start=1)
epr.81 <- ts((epr.81/epr.81[1] - 1)*100, start=1)
epr.90 <- ts((epr.90/epr.90[1] - 1)*100, start=1)
epr.01 <- ts((epr.01/epr.01[1] - 1)*100, start=1)
epr.07 <- ts((epr.07/epr.07[1] - 1)*100, start=1)

vac.01 <- as.numeric(window(vac$value, start=c(2001,3),end=c(2006,3)))
vac.07 <- as.numeric(window(vac$value, start=c(2007,12),end=NULL))

vac.01 <- ts((vac.01/vac.01[1] - 1)*100, start=1)
vac.07 <- ts((vac.07/vac.07[1] - 1)*100, start=1)

sep.01 <- as.numeric(window(sep, start=c(2001,3),end=c(2006,3)))
sep.07 <- as.numeric(window(sep, start=c(2007,12),end=NULL))

sep.01 <- ts((sep.01/sep.01[1] - 1)*100, start=1)
sep.07 <- ts((sep.07/sep.07[1] - 1)*100, start=1)

layoff.01 <- as.numeric(window(layoff, start=c(2001,3),end=c(2006,3)))
layoff.07 <- as.numeric(window(layoff, start=c(2007,12),end=NULL))

layoff.01 <- ts((layoff.01/layoff.01[1] - 1)*100, start=1)
layoff.07 <- ts((layoff.07/layoff.07[1] - 1)*100, start=1)

quits.01 <- as.numeric(window(quits, start=c(2001,3),end=c(2006,3)))
quits.07 <- as.numeric(window(quits, start=c(2007,12),end=NULL))

quits.01 <- ts((quits.01/quits.01[1] - 1)*100, start=1)
quits.07 <- ts((quits.07/quits.07[1] - 1)*100, start=1)

hires.01 <- as.numeric(window(hires, start=c(2001,3),end=c(2006,3)))
hires.07 <- as.numeric(window(hires, start=c(2007,12),end=NULL))

hires.01 <- ts((hires.01/hires.01[1] - 1)*100, start=1)
hires.07 <- ts((hires.07/hires.07[1] - 1)*100, start=1)

uduration.73 <- as.numeric(window(uduration, start=c(1973,11),end=c(1978,11)))
uduration.81 <- as.numeric(window(uduration, start=c(1981,7),end=c(1986,7)))
uduration.90 <- as.numeric(window(uduration, start=c(1990,7),end=c(1995,7)))
uduration.01 <- as.numeric(window(uduration, start=c(2001,3),end=c(2006,3)))
uduration.07 <- as.numeric(window(uduration, start=c(2007,12),end=NULL))

uduration.73 <- ts((uduration.73/uduration.73[1] - 1)*100,start=1)
uduration.81 <- ts((uduration.81/uduration.81[1] - 1)*100, start=1)
uduration.90 <- ts((uduration.90/uduration.90[1] - 1)*100, start=1)
uduration.01 <- ts((uduration.01/uduration.01[1] - 1)*100, start=1)
uduration.07 <- ts((uduration.07/uduration.07[1] - 1)*100, start=1)

#HP Filter Employment - Nonfarm
emp.trend <- hpfilter(log(emp), 14400)
emp.trend <- ts(emp.trend, start=c(1939,1), deltat=1/12)

emp.cyc <- log(emp)-emp.trend

#HP Filter LFP
#All
lfp.trend <- hpfilter(log(lfp), 14400)
lfp.trend <- ts(lfp.trend, start=c(1948,1), deltat=1/12)

lfp.cyc <- log(lfp)-lfp.trend

#Men
lfp.men.trend <- hpfilter(log(lfp.men), 14400)
lfp.men.trend <- ts(lfp.men.trend, start=c(1948,1), deltat=1/12)

lfp.men.cyc <- log(lfp.men)-lfp.men.trend

#Women
lfp.women.trend <- hpfilter(log(lfp.women), 14400)
lfp.women.trend <- ts(lfp.women.trend, start=c(1948,1), deltat=1/12)

lfp.women.cyc <- log(lfp.women)-lfp.women.trend

#HP Filter Hours
hours.trend <- hpfilter(log(hours), 1600)
hours.trend <- ts(hours.trend, start=c(1947,1), deltat=1/4)

hours.cyc <- log(hours)-hours.trend


#####################################################################
#Graph Series

#####################################################################
#Total Employment - Nonfarm
x11()
plot(emp.73,
     main="Total Employment - Establishment Survey",
     ylab="",
     xlab="Months from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(emp.73, emp.81, emp.90, emp.01, emp.07)-1,max(emp.73, emp.81, emp.90, emp.01, emp.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,70,4)))
abline(h=0)  
lines(emp.73,col="darkgreen",lwd=2)
lines(emp.81,col="orange3",lwd=2)
lines(emp.90,col="red",lwd=2)
lines(emp.01,col="orangered4",lwd=2)
lines(emp.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted, Nonfarm Business",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: U.S. Bureau of Labor Statistics",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("emp-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("emp-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("emp-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Cyclical Component of Total Employment - Nonfarm
#pdf("emp-cyc.pdf", family="Times", pointsize=12)
plot(window(emp.cyc, start=c(1970,1), end=NULL),
     main="Cyclical Component of Employment",
     ylab="Percentage Deviation from Trend",
     xlab="Year",
     col="black",
     type="l",
     lwd=1,
     bty="l",
     ylim=c(-.04,.04))
abline(h=0)  
lines(window(emp.cyc,start=c(1973,11), end=c(1975,3)),col="darkgreen",lwd=2)
lines(window(emp.cyc,start=c(1981,7), end=c(1982,11)),col="orange3",lwd=2)
lines(window(emp.cyc,start=c(1990,7), end=c(1991,3)),col="red",lwd=2)
lines(window(emp.cyc,start=c(2001,3), end=c(2001,11)),col="orangered4",lwd=2)
lines(window(emp.cyc,start=c(2007,12), end=c(2009,6)),col="mediumblue",lwd=2)
mtext("Total Nonfarm, Seasonally Adjusted",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: U.S. Bureau of Labor Statistics",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("bottomleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("emp-cyc-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("emp-cyc-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("emp-cyc-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Trend and Level of Total Employment - Nonfarm
#pdf("emp-level.pdf", family="Times", pointsize=12)
plot(window(emp, start=c(1970,1), end=NULL),
     main="Trend Component of Log Employment",
     ylab="Thousands of Workers",
     xlab="Year",
     col="black",
     type="l",
     lwd=1,
     bty="l")
abline(h=0)  
lines(window(emp,start=c(1973,11), end=c(1975,3)),col="darkgreen",lwd=2)
lines(window(emp,start=c(1981,7), end=c(1982,11)),col="orange3",lwd=2)
lines(window(emp,start=c(1990,7), end=c(1991,3)),col="red",lwd=2)
lines(window(emp,start=c(2001,3), end=c(2001,11)),col="orangered4",lwd=2)
lines(window(emp,start=c(2007,12), end=c(2009,6)),col="mediumblue",lwd=2)
lines(emp.trend, col="red", lwd=1, lty=2)
mtext("Total Nonfarm, Seasonally Adjusted",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: U.S. Bureau of Labor Statistics",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("emp-level-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("emp-level-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("emp-level-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Total Employment - Establishment Survey - Nonfarm Private
plot(emp.private.73,
     main="Total Employment - Establishment Survey",
     ylab="",
     xlab="Months from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(emp.private.73, emp.private.81, emp.private.90, emp.private.01, emp.private.07)-1,max(emp.private.73, emp.private.81, emp.private.90, emp.private.01, emp.private.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,70,4)))
abline(h=0)  
lines(emp.private.73,col="darkgreen",lwd=2)
lines(emp.private.81,col="orange3",lwd=2)
lines(emp.private.90,col="red",lwd=2)
lines(emp.private.01,col="orangered4",lwd=2)
lines(emp.private.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted, Nonfarm Business",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: U.S. Bureau of Labor Statistics",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("emp-private-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("emp-private-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("emp-private-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")


#####################################################################
#Total Employment - ADP Report - Nonfarm Private
x11()
plot(adp.01,
     main="Total Employment - ADP Report",
     ylab="",
     xlab="Months from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(adp.01, adp.07)-1,max(adp.01, adp.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,70,4)))
abline(h=0)  
lines(adp.01,col="orangered4",lwd=2)
lines(adp.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted, Nonfarm Private Business",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: U.S. Bureau of Labor Statistics",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("2001 cycle","Current cycle"),
       col=c("orangered4","mediumblue"),
       lwd=c(2,2),
       lty=c(1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("adp-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("adp-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("adp-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Output per Hour: Nonfarm Business Sector
#pdf(file = "prod.pdf", family = "Times", pointsize = 12)
plot(prod.73,
     main="Output Per Hour of All Persons",
     ylab="",
     xlab="Quarters from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(prod.73, prod.81, prod.90, prod.01, prod.07)-1,max(prod.73, prod.81, prod.90, prod.01, prod.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,30,4)))
abline(h=0)  
lines(prod.73,col="darkgreen",lwd=2)
lines(prod.81,col="orange3",lwd=2)
lines(prod.90,col="red",lwd=2)
lines(prod.01,col="orangered4",lwd=2)
lines(prod.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted, Nonfarm Business",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("U.S. Bureau of Economic Analysis",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("prod-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("prod-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("prod-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Hours of all Persons: Nonfarm Business Sector
#plot(hours.73,
plot(hours.81,
     main="Total Hours",
     ylab="",
     xlab="Quarters from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(hours.73, hours.81, hours.90, hours.01, hours.07)-1,max(hours.73, hours.81, hours.90, hours.01, hours.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,90,4)))
abline(h=0)  
lines(hours.73,col="darkgreen",lwd=2)
lines(hours.81,col="orange3",lwd=2)
lines(hours.90,col="red",lwd=2)
lines(hours.01,col="orangered4",lwd=2)
lines(hours.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted, Nonfarm Business",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("U.S. Bureau of Labor Statistics",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("hours-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("hours-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("hours-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Cyclical Component of Total Hours
plot(window(hours.cyc, start=c(1970,1), end=NULL),
     main="Cyclical Component of Total Hours",
     ylab="Percentage Deviation from Trend",
     xlab="Year",
     col="black",
     type="l",
     lwd=1,
     bty="l",
     ylim=c(min(hours.cyc)-.01, max(hours.cyc)+.01))
abline(h=0)  
lines(window(hours.cyc,start=c(1973,4), end=c(1975,1)),col="darkgreen",lwd=4)
lines(window(hours.cyc,start=c(1981,3), end=c(1982,4)),col="orange3",lwd=4)
lines(window(hours.cyc,start=c(1990,3), end=c(1991,1)),col="red",lwd=4)
lines(window(hours.cyc,start=c(2001,1), end=c(2001,4)),col="orangered4",lwd=4)
lines(window(hours.cyc,start=c(2007,4), end=c(2009,2)),col="mediumblue",lwd=4)
mtext("Nonfarm Business, Seasonally Adjusted",
      side = 3,
      line=0.5,
      cex = 1,
      family="Times")
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: U.S. Bureau of Labor Statistics",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("bottomleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("hourscyc-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("hourscyc-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("hourscyc-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Trend Component & Level of Total Hours
plot(window(hours, start=c(1970,1), end=NULL),
     main="Trend Component of Log Total Hours",
     ylab="",
     xlab="Year",
     col="black",
     type="l",
     lwd=1,
     bty="l")
abline(h=0)  
lines(window(hours,start=c(1973,4), end=c(1975,1)),col="darkgreen",lwd=2)
lines(window(hours,start=c(1981,3), end=c(1982,4)),col="orange3",lwd=2)
lines(window(hours,start=c(1990,3), end=c(1991,1)),col="red",lwd=2)
lines(window(hours,start=c(2001,1), end=c(2001,4)),col="orangered4",lwd=2)
lines(window(hours,start=c(2007,4), end=c(2009,2)),col="mediumblue",lwd=2)
lines(hours.trend, col="red", lwd=1, lty=2)
mtext("Nonfarm Business, Seasonally Adjusted",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: U.S. Bureau of Labor Statistics",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("hours-level-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("hours-level-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("hours-level-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Real Compensation Per Hour: Nonfarm Business
#pdf(file = "rc-nf.pdf", family = "Times", pointsize = 12)
plot(rc.nf.73,
     main="Real Compensation per Hour",
     ylab="",
     xlab="Quarters from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(rc.nf.73, rc.nf.81, rc.nf.90, rc.nf.01, rc.nf.07)-1,max(rc.nf.73, rc.nf.81, rc.nf.90, rc.nf.01, rc.nf.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,30,4)))
abline(h=0)  
lines(rc.nf.73,col="darkgreen",lwd=2)
lines(rc.nf.81,col="orange3",lwd=2)
lines(rc.nf.90,col="red",lwd=2)
lines(rc.nf.01,col="orangered4",lwd=2)
lines(rc.nf.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted, Nonfarm Business",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: U.S. Bureau of Labor Statistics",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("rc-nf-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("rc-nf-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("rc-nf-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Labor Force Participation Rate
plot(lfp.73,
     main="Civilian Labor Force Participation Rate",
     ylab="",
     xlab="Months from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(lfp.73, lfp.81, lfp.90, lfp.01, lfp.07)-1,max(lfp.73, lfp.81, lfp.90, lfp.01, lfp.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,70,4)))
abline(h=0)  
lines(lfp.73,col="darkgreen",lwd=2)
lines(lfp.81,col="orange3",lwd=2)
lines(lfp.90,col="red",lwd=2)
lines(lfp.01,col="orangered4",lwd=2)
lines(lfp.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted, Nonfarm Business",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: U.S. Bureau of Labor Statistics",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("lfp-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("lfp-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("lfp-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Cyclical Component of LFP
plot(window(lfp.cyc, start=c(1970,1), end=NULL),
     main="Cyclical Component of Labor Force Participation",
     ylab="% of Population from Trend",
     xlab="Year",
     col="black",
     type="l",
     lwd=1,
     bty="l",
     ylim=c(min(lfp.cyc)-.001,max(lfp.cyc)+.001))
abline(h=0)  
lines(window(lfp.cyc,start=c(1973,11), end=c(1975,3)),col="darkgreen",lwd=2)
lines(window(lfp.cyc,start=c(1981,7), end=c(1982,11)),col="orange3",lwd=2)
lines(window(lfp.cyc,start=c(1990,7), end=c(1991,3)),col="red",lwd=2)
lines(window(lfp.cyc,start=c(2001,3), end=c(2001,11)),col="orangered4",lwd=2)
lines(window(lfp.cyc,start=c(2007,12), end=c(2009,6)),col="mediumblue",lwd=2)
mtext("Seasonally Adjusted, Nonfarm Busines",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: U.S. Bureau of Labor Statistics",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("bottomleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("lfp-cyc-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("lfp-cyc-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("lfp-cyc-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Labor Force Participation Rate - Men
plot(lfp.men.73,
     main="Civilian Labor Force Participation Rate - Men",
     ylab="",
     xlab="Months from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(lfp.men.73, lfp.men.81, lfp.men.90, lfp.men.01, lfp.men.07)-1,max(lfp.men.73, lfp.men.81, lfp.men.90, lfp.men.01, lfp.men.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,70,4)))
abline(h=0)  
lines(lfp.men.73,col="darkgreen",lwd=2)
lines(lfp.men.81,col="orange3",lwd=2)
lines(lfp.men.90,col="red",lwd=2)
lines(lfp.men.01,col="orangered4",lwd=2)
lines(lfp.men.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted, Nonfarm Business",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: U.S. Bureau of Labor Statistics",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("lfp-men-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("lfp-men-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("lfp-men-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Cyclical Component of LFP - Men
plot(window(lfp.men.cyc, start=c(1970,1), end=NULL),
     main="Cyclical Component of Labor Force Participation - Men",
     ylab="% of Population from Trend",
     xlab="Year",
     col="black",
     type="l",
     lwd=1,
     bty="l",
     ylim=c(min(lfp.men.cyc)-.001,max(lfp.men.cyc)+.001))
abline(h=0)  
lines(window(lfp.men.cyc,start=c(1973,11), end=c(1975,3)),col="darkgreen",lwd=2)
lines(window(lfp.men.cyc,start=c(1981,7), end=c(1982,11)),col="orange3",lwd=2)
lines(window(lfp.men.cyc,start=c(1990,7), end=c(1991,3)),col="red",lwd=2)
lines(window(lfp.men.cyc,start=c(2001,3), end=c(2001,11)),col="orangered4",lwd=2)
lines(window(lfp.men.cyc,start=c(2007,12), end=c(2009,6)),col="mediumblue",lwd=2)
mtext("Seasonally Adjusted, Nonfarm Busines",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: U.S. Bureau of Labor Statistics",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("bottomleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("lfp-men-cyc-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("lfp-men-cyc-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("lfp-men-cyc-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Labor Force Participation Rate - Women
plot(lfp.women.73,
     main="Civilian Labor Force Participation Rate - Women",
     ylab="",
     xlab="Months from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(lfp.women.73, lfp.women.81, lfp.women.90, lfp.women.01, lfp.women.07)-1,max(lfp.women.73, lfp.women.81, lfp.women.90, lfp.women.01, lfp.women.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,70,4)))
abline(h=0)  
lines(lfp.women.73,col="darkgreen",lwd=2)
lines(lfp.women.81,col="orange3",lwd=2)
lines(lfp.women.90,col="red",lwd=2)
lines(lfp.women.01,col="orangered4",lwd=2)
lines(lfp.women.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted, Nonfarm Business",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: U.S. Bureau of Labor Statistics",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("lfp-women-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("lfp-women-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("lfp-women-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Cyclical Component of LFP - Women
plot(window(lfp.women.cyc, start=c(1970,1), end=NULL),
     main="Cyclical Component of Labor Force Participation - Women",
     ylab="% of Population from Trend",
     xlab="Year",
     col="black",
     type="l",
     lwd=1,
     bty="l",
     ylim=c(min(lfp.women.cyc)-.001,max(lfp.women.cyc)+.001))
abline(h=0)  
lines(window(lfp.women.cyc,start=c(1973,11), end=c(1975,3)),col="darkgreen",lwd=2)
lines(window(lfp.women.cyc,start=c(1981,7), end=c(1982,11)),col="orange3",lwd=2)
lines(window(lfp.women.cyc,start=c(1990,7), end=c(1991,3)),col="red",lwd=2)
lines(window(lfp.women.cyc,start=c(2001,3), end=c(2001,11)),col="orangered4",lwd=2)
lines(window(lfp.women.cyc,start=c(2007,12), end=c(2009,6)),col="mediumblue",lwd=2)
mtext("Seasonally Adjusted, Nonfarm Busines",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: U.S. Bureau of Labor Statistics",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("bottomleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("lfp-women-cyc-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("lfp-women-cyc-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("lfp-women-cyc-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Employment Population Ratio
#pdf(file = "epr.pdf", family = "Times", pointsize = 12)
plot(epr.73,
     main="Civilian Employment Population Ratio",
     ylab="",
     xlab="Months from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(epr.73, epr.81, epr.90, epr.01, epr.07)-1,max(epr.73, epr.81, epr.90, epr.01, epr.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,70,4)))
abline(h=0)  
lines(epr.73,col="darkgreen",lwd=2)
lines(epr.81,col="orange3",lwd=2)
lines(epr.90,col="red",lwd=2)
lines(epr.01,col="orangered4",lwd=2)
lines(epr.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: U.S. Bureau of Labor Statistics",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("epr-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("epr-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("epr-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Unemployment Rate
#pdf(file = "urate.pdf", family = "Times", pointsize = 12)
plot(urate.73,
     main="Civilian Unemployment Rate",
     ylab="",
     xlab="Months from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(urate.73, urate.81, urate.90, urate.01, urate.07)-1,max(urate.73, urate.81, urate.90, urate.01, urate.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,70,4)))
abline(h=0)  
lines(urate.73,col="darkgreen",lwd=2)
lines(urate.81,col="orange3",lwd=2)
lines(urate.90,col="red",lwd=2)
lines(urate.01,col="orangered4",lwd=2)
lines(urate.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: U.S. Bureau of Labor Statistics",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("urate-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("urate-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("urate-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Job Openings: JOLTS
#pdf(file = "vac.pdf", family = "Times", pointsize = 12)
plot(vac.01,
     main="Job Openings",
     ylab="",
     xlab="Months from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(vac.01, vac.07)-1,max(vac.01, vac.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,70,4)))
abline(h=0)  
lines(vac.01,col="orangered4",lwd=2)
lines(vac.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted, Total Nonfarm",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: U.S. Bureau of Labor Statistics",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("bottomleft",
      c("2001 cycle","Current cycle"),
       col=c("orangered4","mediumblue"),
       lwd=c(2,2),
       lty=c(1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("vac-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("vac-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("vac-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Total Separations: JOLTS
#pdf(file = "sep.pdf", family = "Times", pointsize = 12)
plot(sep.01,
     main="Total Separations",
     ylab="",
     xlab="Months from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(sep.01, sep.07)-1,max(sep.01, sep.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,70,4)))
abline(h=0)  
lines(sep.01,col="orangered4",lwd=2)
lines(sep.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted, Total Nonfarm",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: U.S. Bureau of Labor Statistics",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("bottomleft",
      c("2001 cycle","Current cycle"),
       col=c("orangered4","mediumblue"),
       lwd=c(2,2),
       lty=c(1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("sep-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("sep-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("sep-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Total Layoffs and Discharges: JOLTS
#pdf(file = "layoffs.pdf", family = "Times", pointsize = 12)
plot(layoff.01,
     main="Total Layoffs and Discharges",
     ylab="",
     xlab="Months from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(layoff.01, layoff.07)-1,max(layoff.01, layoff.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,70,4)))
abline(h=0)  
lines(layoff.01,col="orangered4",lwd=2)
lines(layoff.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted, Total Nonfarm",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: U.S. Bureau of Labor Statistics",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("2001 cycle","Current cycle"),
       col=c("orangered4","mediumblue"),
       lwd=c(2,2),
       lty=c(1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("layoffs-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("layoffs-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("layoffs-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Total Quits: JOLTS
#pdf(file = "quits.pdf", family = "Times", pointsize = 12)
plot(quits.01,
     main="Total Quits",
     ylab="",
     xlab="Months from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(quits.01, quits.07)-1,max(quits.01, quits.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,70,4)))
abline(h=0)  
lines(quits.01,col="orangered4",lwd=2)
lines(quits.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted, Total Nonfarm",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: U.S. Bureau of Labor Statistics",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("bottomleft",
      c("2001 cycle","Current cycle"),
       col=c("orangered4","mediumblue"),
       lwd=c(2,2),
       lty=c(1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("quits-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("quits-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("quits-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Total Hires: JOLTS
#pdf(file = "hires.pdf", family = "Times", pointsize = 12)
plot(hires.01,
     main="Total Hires (Rate)",
     ylab="",
     xlab="Months from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(hires.01, hires.07)-1,max(hires.01, hires.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,70,4)))
abline(h=0)  
lines(hires.01,col="orangered4",lwd=2)
lines(hires.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted, Total Nonfarm",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: U.S. Bureau of Labor Statistics",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("bottomleft",
      c("2001 cycle","Current cycle"),
       col=c("orangered4","mediumblue"),
       lwd=c(2,2),
       lty=c(1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("hires-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("hires-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("hires-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Beveridge Curve
#pdf(file = "beveridge.pdf", family = "Times", pointsize = 12)
plot(unemp$value, vac$value,
     type="o",
     main="U.S. Beveridge Curve",
     xlab="unemployment rate (percent)",
     ylab="vacancy rate (percent)",
     col="white",
     xy.labels=FALSE,
     yaxt="n",
     xaxt="n",
     tck=1,
     lwd=.9,
     pch=20,
     family="Times")
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey80")
axis(1,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey80")
points(unemp$value, vac$value,
       type="o",
       col="mediumblue",
       lwd=.9,
       pch=20)
points(window(unemp$value,start=c(2008,1),end=NULL),
       window(vac$value,start=c(2008,1),end=NULL),
       col="red",
       type="o",
       pch=20,
       lwd=1.5)
box()
mtext("Source: U.S. Bureau of Labor Statistics",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext(paste("December 2000 - ",as.character(format(unemp$date[dim(unemp)[1]],"%B %Y")),sep=""),
      side = 3,
      line=0.5,
      cex = 1)
legend("topright",
       paste("January 2008 - ",as.character(format(unemp$date[dim(unemp)[1]],"%B %Y")),sep=""),
       col="red",
       lwd=1.5,
       inset=.02)
dev.copy2pdf(file=paste("beveridge-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.print(png, file=paste("beveridge-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")
dev.off()

#####################################################################
#Average weeks unemployed
plot(uduration.73,
     main="Average Weeks Unemployed",
     ylab="",
     xlab="Months from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(uduration.73, uduration.81, uduration.90, uduration.01, uduration.07)-1,max(uduration.73, uduration.81, uduration.90, uduration.01, uduration.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,70,4)))
abline(h=0)  
lines(uduration.73,col="darkgreen",lwd=2)
lines(uduration.81,col="orange3",lwd=2)
lines(uduration.90,col="red",lwd=2)
lines(uduration.01,col="orangered4",lwd=2)
lines(uduration.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Not Seasonally Adjusted",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: U.S. Bureau of Labor Statistics",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("uduration-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("uduration-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("uduration-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")


################################# Industrial Production and Inflation #######################################

#Industrial Production Index
ip <-ts(read.fwf("http://research.stlouisfed.org/fred2/data/INDPRO.txt",skip=12,widths=c(10,10),header=FALSE, col.names=c("date","ip"))[,2], start=c(1919,1), deltat=1/12)

#CPI
cpi <-ts(read.fwf("http://research.stlouisfed.org/fred2/data/CPIAUCSL.txt",skip=14,widths=c(10,9),header=FALSE, col.names=c("date","cpi"))[,2], start=c(1947,1), deltat=1/12)

#PCE
pce <- ts(read.fwf("http://research.stlouisfed.org/fred2/data/PCEPI.txt",skip=12,widths=c(10,9),header=FALSE, col.names=c("date","pce"))[,2], start=c(1959,1), deltat=1/12)

#PCI
ppi <-ts(read.fwf("http://research.stlouisfed.org/fred2/data/PPIACO.txt",skip=12,widths=c(10,7),header=FALSE, col.names=c("date","ppi"))[,2], start=c(1913,1), deltat=1/12)



#Compute change from previous peak
ip.73 <- as.numeric(window(ip, start=c(1973,11),end=c(1978,11)))
ip.81 <- as.numeric(window(ip, start=c(1981,7),end=c(1986,7)))
ip.90 <- as.numeric(window(ip, start=c(1990,7),end=c(1995,7)))
ip.01 <- as.numeric(window(ip, start=c(2001,3),end=c(2006,3)))
ip.07 <- as.numeric(window(ip, start=c(2007,12),end=NULL))

ip.73 <- ts((ip.73/ip.73[1] - 1)*100,start=1)
ip.81 <- ts((ip.81/ip.81[1] - 1)*100, start=1)
ip.90 <- ts((ip.90/ip.90[1] - 1)*100, start=1)
ip.01 <- ts((ip.01/ip.01[1] - 1)*100, start=1)
ip.07 <- ts((ip.07/ip.07[1] - 1)*100, start=1)

cpi.73 <- as.numeric(window(cpi, start=c(1973,11),end=c(1978,11)))
cpi.81 <- as.numeric(window(cpi, start=c(1981,7),end=c(1986,7)))
cpi.90 <- as.numeric(window(cpi, start=c(1990,7),end=c(1995,7)))
cpi.01 <- as.numeric(window(cpi, start=c(2001,3),end=c(2006,3)))
cpi.07 <- as.numeric(window(cpi, start=c(2007,12),end=NULL))

cpi.73 <- ts((cpi.73/cpi.73[1] - 1)*100,start=1)
cpi.81 <- ts((cpi.81/cpi.81[1] - 1)*100, start=1)
cpi.90 <- ts((cpi.90/cpi.90[1] - 1)*100, start=1)
cpi.01 <- ts((cpi.01/cpi.01[1] - 1)*100, start=1)
cpi.07 <- ts((cpi.07/cpi.07[1] - 1)*100, start=1)

pce.73 <- as.numeric(window(pce, start=c(1973,11),end=c(1978,11)))
pce.81 <- as.numeric(window(pce, start=c(1981,7),end=c(1986,7)))
pce.90 <- as.numeric(window(pce, start=c(1990,7),end=c(1995,7)))
pce.01 <- as.numeric(window(pce, start=c(2001,3),end=c(2006,3)))
pce.07 <- as.numeric(window(pce, start=c(2007,12),end=NULL))

pce.73 <- ts((pce.73/pce.73[1] - 1)*100,start=1)
pce.81 <- ts((pce.81/pce.81[1] - 1)*100, start=1)
pce.90 <- ts((pce.90/pce.90[1] - 1)*100, start=1)
pce.01 <- ts((pce.01/pce.01[1] - 1)*100, start=1)
pce.07 <- ts((pce.07/pce.07[1] - 1)*100, start=1)

ppi.73 <- as.numeric(window(ppi, start=c(1973,11),end=c(1978,11)))
ppi.81 <- as.numeric(window(ppi, start=c(1981,7),end=c(1986,7)))
ppi.90 <- as.numeric(window(ppi, start=c(1990,7),end=c(1995,7)))
ppi.01 <- as.numeric(window(ppi, start=c(2001,3),end=c(2006,3)))
ppi.07 <- as.numeric(window(ppi, start=c(2007,12),end=NULL))

ppi.73 <- ts((ppi.73/ppi.73[1] - 1)*100,start=1)
ppi.81 <- ts((ppi.81/ppi.81[1] - 1)*100, start=1)
ppi.90 <- ts((ppi.90/ppi.90[1] - 1)*100, start=1)
ppi.01 <- ts((ppi.01/ppi.01[1] - 1)*100, start=1)
ppi.07 <- ts((ppi.07/ppi.07[1] - 1)*100, start=1)

#####################################################################
#Industrial Production Index
x11()
#pdf(file = "indprod.pdf", family = "Times", pointsize = 12)
plot(ip.73,
     main="Industrial Production Index",
     ylab="",
     xlab="Months from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(ip.73, ip.81, ip.90, ip.01, ip.07)-1,max(ip.73, ip.81, ip.90, ip.01, ip.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,60,4)))
abline(h=0)  
lines(ip.73,col="darkgreen",lwd=2)
lines(ip.81,col="orange3",lwd=2)
lines(ip.90,col="red",lwd=2)
lines(ip.01,col="orangered4",lwd=2)
lines(ip.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: Federal Reserve Board of Governors",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("indprod-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("indprod-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("indprod-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Consumer Price Index
#pdf(file = "cpi.pdf", family = "Times", pointsize = 12)
plot(cpi.73,
     main="Consumer Price Index",
     ylab="",
     xlab="Months from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(cpi.73, cpi.81, cpi.90, cpi.01, cpi.07)-1,max(cpi.73, cpi.81, cpi.90, cpi.01, cpi.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,60,4)))
abline(h=0)  
lines(cpi.73,col="darkgreen",lwd=2)
lines(cpi.81,col="orange3",lwd=2)
lines(cpi.90,col="red",lwd=2)
lines(cpi.01,col="orangered4",lwd=2)
lines(cpi.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, Seasonally Adjusted, All Items",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: US Bureau of Labor Statistics",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("cpi-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("cpi-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("cpi-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Personal Consumption Expenditures: Price Index
#pdf(file = "pce.pdf", family = "Times", pointsize = 12)
plot(pce.73,
     main="Personal Consumption Expenditures Price Index",
     ylab="",
     xlab="Months from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(pce.73, pce.81, pce.90, pce.01, pce.07)-1,max(pce.73, pce.81, pce.90, pce.01, pce.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,60,4)))
abline(h=0)  
lines(pce.73,col="darkgreen",lwd=2)
lines(pce.81,col="orange3",lwd=2)
lines(pce.90,col="red",lwd=2)
lines(pce.01,col="orangered4",lwd=2)
lines(pce.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, All goods",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: US Bureau of Labor Statistics",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("pce-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("pce-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("pce-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

#####################################################################
#Producer Price Index - All Commodities
#pdf(file = "ppi.pdf", family = "Times", pointsize = 12)
plot(ppi.73,
     main="Producer Price Index",
     ylab="",
     xlab="Months from previous peak",
     col="white",
     type="l",
     lwd=2,
     axes=FALSE,
     yaxs="i",
     xaxs="i",
     tck=1,
     bty="l",
     family="Times",
     ylim=c(min(ppi.73, ppi.81, ppi.90, ppi.01, ppi.07)-1,max(ppi.73, ppi.81, ppi.90, ppi.01, ppi.07)+1))
axis(2,
     tick=TRUE,
     tck=1,
     lwd.ticks=.1,
     col.ticks="grey")
axis(1,
     tick=TRUE,
     las=1,
     at=c(seq(0,60,4)))
abline(h=0)  
lines(ppi.73,col="darkgreen",lwd=2)
lines(ppi.81,col="orange3",lwd=2)
lines(ppi.90,col="red",lwd=2)
lines(ppi.01,col="orangered4",lwd=2)
lines(ppi.07,col="mediumblue",lwd=4)
mtext("Percentage change from previous peak, All Commodities",
      side = 3,
      line=0.5,
      cex = 1)
mtext("Cooley-Rupert Economic Snapshot; http://econsnapshot.wordpress.com",
      side = 4,
      line= 0,
      cex = .8,
      adj = 0)
mtext("Source: US Bureau of Labor Statistics",
      side = 4,
      line= 1,
      cex = .8,
      adj = 0)
box()
legend("topleft",
      c("1973 cycle","1981 cycle","1990 cycle","2001 cycle","Current cycle"),
       col=c("darkgreen","orange3","red","orangered4","mediumblue"),
       lwd=c(2,2,2,2,2),
       lty=c(1,1,1,1,1),
       inset=.02,
       cex=.75,
       bg="gray87")
dev.copy2pdf(file=paste("ppi-",Sys.Date(),".pdf", sep=""), family="Times", pointsize=12)
dev.copy2pdf(file=paste("ppi-",Sys.Date(),"-presentation.pdf", sep=""), family="Times", pointsize=12, height = 7, width = 10)
dev.print(png, file=paste("ppi-",Sys.Date(),".png", sep=""), pointsize = 16, width = 600, height = 600, bg = "white")

dev.off()
graphics.off()






