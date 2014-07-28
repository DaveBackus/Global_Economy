* korifs.do 
* Input Korean IFS data  
* Global economy version 
* Written by:  Backus, Clementi, and Lambert, April 2005 and after  
* ****************************************************************
cd "Q:\ECO\Global Economy\BCEFP\Backus_06\Data\Crises"

* Read data from csv file  
insheet year ex g i v c nfi im gni gdp p sd dep bgs caus eus /*reer*/ /*gsur debt*/ iipa iipl ///
	using korifs.csv, clear 
/* no govt finance data */
* verify contents from headers 
*list in 1
* Drop 2 header rows and last obs (NA) 
drop in 1/2     /* first two rows are description and Datastream mnemonic */
drop in -1
destring _all, replace force
gen str3 country = "KOR"

* Check sums (data garbage before mid-1980s because of inflation -- round down to zero) 
gen zero1 = gdp-c-i-v-g-ex+im-sd
gen zero2 = gni-c-i-v-g-ex+im-sd-nfi
*list year gdp zero1 zero2 v nfi  /* doesn't quite add up */

* Adjustments 
gen nx = ex-im
gen y = gdp 
replace i = i+v
replace bgs = eus*bgs/1000
gen ca = eus*caus/1000
replace iipa = eus*iipa/1000
replace iipl = eus*iipl/1000
*replace debt = debt/1000  

* Messing around 
gen cy = c/y
gen gy = g/y
gen sy = (y-c-g)/y
gen iy = i/y
gen nxy = nx/y
gen bgsy = bgs/y
gen cay = ca/y
gen nfay = (iipa-iipl)/y
gen rer = log(eus/p) - 2.4

drop if year<1990 

line rer year, ///  
	title(Korea: Real Exchange Rate) xtitle("") ytitle(Log of Real Exchange Rate) legend(off) 
graph export korrer.emf, replace

line nxy year || line cay year /*|| line bgsy year*/, ///  
	title(Korea: Net Exports and Current Account) xtitle("") ytitle(Ratio to GDP) legend(off) 
graph export korbop.emf, replace

line nxy year || line sy year || line iy year, ///
	title("Korea: Saving, Investment, and Net Exports") xtitle("") ytitle(Ratio to GDP) legend(off) 
graph export korflows.emf, replace


line nxy year || line cay year, ///
	title("Net Exports and Current Account") xtitle("") ytitle(Ratio to GDP) legend(off)
line nxy year || line sy year || line iy year || line cy year || line gy year

