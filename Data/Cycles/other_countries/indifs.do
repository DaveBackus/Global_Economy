* indifs.do 
* Input Indian IFS data  
* Written by:  Backus, Henriksen, Lambert, and Telmer, April 2005 and after  
* ****************************************************************
clear 
*cd "C:\Documents and Settings\dbackus\My Documents\Userdata\Papers\CA\Data IFS"
cd "Q:\ECO\Global Economy\BCEFP\Backus_10\Data\Cycles\other_countries"

* Read data from csv file  
insheet year ex g i v c nfi im gni gdp p ///
	using indifs.csv, clear 
* verify contents from headers 
*list in 1
* Drop 2 header rows and last obs (NA) 
drop in 1/2     /* first two rows are description and Datastream mnemonic */
drop in -1
destring _all, replace force
gen str3 country = "IND"

* Check sums 
gen zero1 = gdp-c-i-v-g-ex+im
gen zero2 = gdp+nfi-gni
list zero1 zero2  /* !! zero1 needs to be checked */

* Adjustments 
gen y = gdp 
replace i = i+v

* Save in Stata file 
save indifs, replace 

/*
* Messing around
drop if year<1975
gen cy = c/y
gen gy = g/y
gen sy = (y-c-g)/y
gen iy = i/y
gen nxy = (ex-im)/y

drop if year<1990 
summarize iy 

line nxy year || line sy year || line iy year, ///
	text(0.45 1995 "Saving", place(e)) ///
	text(0.34 1995 "Investment", place(e)) ///
	text(0.07 1995 "Net Exports", place(e)) /// 
	legend(off) xtitle("Year") ytitle("Ratio to GDP") 
graph export indflows.eps, replace 
graph export indflows.emf, replace 

gen debty = debt/y
gen dreer1 = reer[_n+1]/reer[_n]-1
gen dreer2 = reer[_n+2]/reer[_n]-1
gen dreerm1 = reer[_n]/reer[_n-1]-1

scatter reer nxy 
scatter dreer1 nxy
scatter dreer1 cay 
scatter dreerm1 cay 
scatter dreer2 cay 

tsset year, yearly
xcorr nxy reer, lags(5)
*/
