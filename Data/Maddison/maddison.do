* ----------------------------------------------------------------------------------
*  maddison.do
*  Per capita GDP from Maddison's OECD Historical Statistics, OECD 2003.  
*  Selected countries for Global Economy class.
*  Written by:  Dave Backus, 2007 and after.  
* ----------------------------------------------------------------------------------
clear 
*cd "C:\Documents and Settings\David Backus\My Documents\Classes\Backus_07\Data\Maddison"
cd "Q:\ECO\Global Economy\BCEFP\Backus_07\Data\Maddison"

*  Input data from spreadsheet  
insheet using maddison.csv, clear 


line usa year || line gbr year || line fra year || line ger year,  /// 
	legend(rows(1)) /*yscale(log)*/ xtitle("") ytitle("Per Capita GDP (1990 US Dollars)") 
graph export maddisonuseu.emf, replace 

drop if year<1900
line usa year || line arg year || line jpn year,  /// 
	legend(rows(1)) /*yscale(log)*/ xtitle("") ytitle("Per Capita GDP (1990 US Dollars)") 
graph export maddisonargjpn.emf, replace 

line usa year || line arg year || line chl year,  /// 
	legend(rows(1)) /*yscale(log)*/ xtitle("") ytitle("Per Capita GDP (1990 US Dollars)") 
graph export maddisonargchl.emf, replace 

line arg year || line brz year || line chl year || line mex year || line ven year,  /// 
	legend(rows(1)) /*yscale(log)*/ xtitle("") ytitle("Per Capita GDP (1990 US Dollars)") 
graph export maddisonlatam.emf, replace 

line mex year || line cub year,  /// 
	legend(rows(1)) xtitle("") ytitle("Per Capita GDP (1990 US Dollars)") 
graph export maddisonmexcub.emf, replace 

line chn year || line ind year,  /// 
	legend(rows(1)) xtitle("") ytitle("Per Capita GDP (1990 US Dollars)") 
graph export maddisonchnind.emf, replace 


