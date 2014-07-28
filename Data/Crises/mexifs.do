* mexifs.do 
* Input Mexican IFS data 
* Global Economy version  
* Written by:  Backus, Clementi, and Lambert, April 2005 and after  
* ****************************************************************
cd "Q:\ECO\Global Economy\BCEFP\Backus_06\Data\Crises"  

* Read data from csv file  
insheet year ex g i v c /*nfi*/ im /*gni*/ gdp p /*dep*/ bgs ca eus /*reer*/ gnb /*debt*/ iipa iipl ///
	using mexifs.csv, clear 
* verify contents from headers 
*list in 1
* Drop 2 header rows and last obs (NA) 
drop in 1/2     /* first two rows are description and Datastream mnemonic */
drop in -1
destring _all, replace force
gen str3 country = "MEX"


* Check sums (data garbage before mid-1980s because of inflation -- round down to zero) 
gen zero1 = gdp-c-i-v-g-ex+im
*gen zero2 = gni-c-i-v-g-ex+im-nfi
list gdp zero1 

* Adjustments 
gen nx = ex-im
gen y = gdp 
replace i = i+v
replace bgs = eus*bgs/1000
replace ca = eus*ca/1000
replace iipa = eus*iipa/1000
replace iipl = eus*iipl/1000
*replace debt = debt/1000  

* Save in Stata file 
save mexifs, replace 

gen cy = c/y
gen gy = g/y
gen sy = (y-c-g)/y
gen iy = i/y
gen nxy = nx/y
gen bgsy = bgs/y
gen cay = ca/y
gen nfay = (iipa-iipl)/y
gen rer = log(eus/p) + 2.2

drop if year<1990 

line rer year, ///  
	title(Mexico: Real Exchange Rate) xtitle("") ytitle(Log of Real Exchange Rate) legend(off) 
graph export mexrer.emf, replace

line nxy year || line cay year /*|| line bgsy year*/, ///  
	title(Mexico: Net Exports and Current Account) xtitle("") ytitle(Ratio to GDP) legend(off) 
graph export mexbop.emf, replace

line nxy year || line sy year || line iy year, ///
	title("Mexico: Saving, Investment, and Net Exports") xtitle("") ytitle(Ratio to GDP) legend(off) 
graph export mexflows.emf, replace
*line gy year || line cy year 
