* ----------------------------------------------------------------------------------
*  emp_indics.do
*  Program reads in OECD standardized unemployment rates 
*  Can download monthly or annual series 
*  Written by:  Dave Backus (Feb 09 and after)
* ----------------------------------------------------------------------------------
clear 
cd "Q:\ECO\Global Economy\BCEFP\Backus_09\Data\Cycles"

*  Input data from spreadsheet  
# delimit ;
insheet date u_us u_fr u_ge u_it u_ja u_uk 
	using employment_indics_oecd.csv; 
* Drop 2 header rows and last obs (NA) 
drop in 1/2;     /* first two rows are description and Datastream mnemonic */
*drop in -1;
destring _all, replace force;
*replace date = 1950+_n-1;
*gen time = _n;
*tsset time;
*drop if date<1990;
*drop if date>2009;

*  (i) plot un rates  

/* 
# delimit ;
line u_us date || line u_fr date , 
	legend(on) xtitle("") ytitle("Unemployment Rate (%)") 
	xlabel(1960(10)2010)
	/* text(0.00 2006 "Net Exports", place(l))
	text(0.375 2006 "Investment", place(l))
	text(0.53 2006 "Saving", place(l)) */;
graph export urates_oecd.emf, replace;
*/

