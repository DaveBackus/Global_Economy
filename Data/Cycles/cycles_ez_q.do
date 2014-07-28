* ----------------------------------------------------------------------------------
*  cycles_ez_q.do
*  Program reads in selected quarterly series for description of Euro Zone
*  business cycles and figure of Taylor rule  
*  Spreadsheet contains data from Datastream listed in GE cycles ez q.llt (?)
*  Written by:  Dave Backus (Feb 06 and after)
* ----------------------------------------------------------------------------------
clear 
cd "Q:\ECO\Global Economy\BCEFP\Backus_08\Data\Cycles"

*  Input data from spreadsheet  
insheet date yr cli rrepo r3m emp un cpi ip ///
	using cycles_indicators_ez_q.csv, clear 
* Drop 2 header rows and last obs (NA) 
drop in 1/2     /* first two rows are description and Datastream mnemonic */
*drop in -1
destring _all, replace force
replace date = 1980+_n/4-1/8
gen time = _n
tsset time

* 
*  Part 1:  growth rates 
* 
#delimit cr
*gen gqyr = 400*log(yr/yr[_n-1])
gen gyr = 100*log(yr/yr[_n-4])
gen gcpi = 100*log(cpi/cpi[_n-4])
*

*  Part 2:  Interest rates and Taylor rules 
*drop if date<1960

#delimit cr
gen rfftr = 2 + gcpi + 0.5*(gcpi-2) + 0.5*(gyr-2.5)
drop if date<1999

#delimit;
line rrepo date || line rfftr date, 
	legend(off) xtitle("") ytitle("Annual Percentage") 
	text(5 2002 "Taylor rule", place(e))
	text(2.6 2001.5 "Repo rate", place(e))
	name(eztaylorrule,replace); 
graph export eztaylorrule.emf, replace;

list date rrepo rfftr gyr gcpi


