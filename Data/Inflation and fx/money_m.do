* ----------------------------------------------------------------------------------
*  money_m.do
*  Program reads in money supply and price series for US and EU.  
*  Written by:  Dave Backus (April 08 and after)
* ----------------------------------------------------------------------------------
clear 
cd "Q:\ECO\Global Economy\BCEFP\Backus_09\Data\Inflation and fx"

*  Input data from spreadsheet  
insheet date ///
	m1eu m2eu m3eu cpieu cpiyoyeu  ///
	mbus m1us m2us cpius pceus ipeu  ///
	using money_monthly.csv, clear 
drop in 1/2  /* Drop 2 header rows -- description and Datastream mnemonic */
*drop in -1
destring _all, replace force
replace date = 1990+_n/12-1/24
gen time = _n
tsset time

list date m1eu

*  1. Inflation and money growth 
*
gen gm1eu = 100*log(m1eu/m1eu[_n-12]) 
gen gm2eu = 100*log(m2eu/m2eu[_n-12]) 
gen gm3eu = 100*log(m3eu/m3eu[_n-12]) 
gen gcpieu = 100*log(cpieu/cpieu[_n-12]) 
gen gipeu = 100*log(ipeu/ipeu[_n-12]) 
* 
gen gmbus = 100*log(mbus/mbus[_n-12]) 
gen gm1us = 100*log(m1us/m1us[_n-12]) 
gen gm2us = 100*log(m2us/m2us[_n-12]) 
gen gcpius = 100*log(cpius/cpius[_n-12]) 
gen gpceus = 100*log(pceus/pceus[_n-12]) 

*  2. Figures 
*
#delimit ;
line gmbus date || line gm1us date || line gm2us date, 
	/*xlabel(2006(1)2009)*/
	legend(on) 
	xtitle("") ytitle("Year-on-Year Growth Rate");

#delimit ;
line gm1eu date || line gm2eu date || line gm3eu date, 
	/*xlabel(2006(1)2009)*/
	legend(on) 
	xtitle("") ytitle("Year-on-Year Growth Rate");

drop if date<2006
#delimit ;
line gcpieu date || line gipeu date , 
	xlabel(2006(1)2009)
	legend(off) 
	text(1.5 2007 "Cconsumer Prices", place(e))
	text(4.5 2007.3 "Industrial Production", place(e))
	xtitle("") ytitle("Year-on-Year Growth Rate");
graph export final_08.eps, replace;  



*xlabel(1950(10)2010)

