* ----------------------------------------------------------------------------------
*  cycles_q.do
*  Program reads in selected quarterly series for description of US business cycles 
*  Spreadsheet contains data from Datastream listed in GE cycles basic.llt (?)
*  Written by:  Dave Backus (Feb 06 and after)
* ----------------------------------------------------------------------------------
clear 
cd "Q:\ECO\Global Economy\BCEFP\Backus_10\Data\Cycles"

*  Input data from spreadsheet 
insheet date yr cr cdr cndr csr ir vr xr mr gr y c cd cnd cs i v x m g ///
	py pce cpi cpicore ppi ///
	iip lf empciv pop16 un empnfp awh ///
	rff r3m r6m r1y r5y r10y sp500 djia nyse lei  ///
	savp savg istr ieqr iresr ist ieq ires hnw hasset hh hliab ///
	ypot ygap /* check this one */ mb m1 m2 ///
	using cycles_indicators_q.csv, clear 
* Drop 2 header rows and last obs (NA) 
drop in 1/2     /* first two rows are description and Datastream mnemonic */
*drop in -1
destring _all, replace force
replace date = 1950+_n/4-1/8
gen time = _n
tsset time

/*
*  Part 1:  various ratios for measurement class 
*  expenditure shares 
gen con = c/y
gen inv = i/y
gen gov = g/y
gen nx = (x-m)/y
gen sav = (y-c-g)/y

#delimit ;
line con date || line inv date || line gov date || line nx date 
	, legend(off) xtitle("") ytitle("Share of GDP (current prices)") 
	xlabel(1950(10)2010)
	text(0.67 1953 "Consumption",place(e))
	text(0.10 1953 "Investment",place(e))
	text(0.28 1953 "Government Purchases",place(e))
	text(0.03 2005 "Net Exports",place(w));
graph export us_expshares.emf, replace; 
graph export us_expshares.eps, replace; 

#delimit ;
line sav date || line inv date || line nx date 
	, legend(off) xtitle("") ytitle("Share of GDP (current prices)") 
	xlabel(1950(10)2010)
	text(0.09 2005 "Saving",place(w))
	text(0.19 2005 "Investment",place(w))
	text(0.01 2005 "Net Exports",place(w));
graph export us_flows1.emf, replace; 
graph export us_flows1.eps, replace; 
 
*  saving rates and net worth 
#delimit cr
gen rsavp = savp/y
gen rsavg = savg/y
gen rsav = (savp+savg)/y

#delimit ; 
line rsav date || line rsavp date || line rsavg date, 
	legend(off) xtitle("") ytitle("US Saving Rates") 
	xlabel(1950(10)2010)
	text(-0.02 1953 "Government",place(e))
	text(0.11 1987 "Private",place(e))
	text(0.045 1982 "Total (National)",place(w))
	name(ussavall,replace); 
graph export ussavall.emf, replace;

gen nwy = hnw/y
gen hy = hh/y
gen ay = hasset/y
gen ly = hliab/y

line nwy date || line ay date || line ly date || line hy date, ///
	xlabel(1950(10)2010) ///
	legend(off) xtitle("") ytitle("Ratio to GDP") ///
	text(3.25 1993 "Net Worth", place(e))	///
	text(4.50 1988 "Assets", place(e))	///
	text(1.50 1993 "Housing", place(e))	///
	text(0.40 1993 "Liabilities", place(e))	///
	name(usnwy,replace) 
graph export usnwy.emf, replace
graph export usnwy.eps, replace
*/

/*
*  Part 2:  growth rates for business cycle classes 
*  (i) Generate growth rates 
*replace yr = cr
gen gqyr = 400*log(yr/yr[_n-1])
gen gyr = 100*log(yr/yr[_n-4])
*
gen gcr = 100*log(cr/cr[_n-4])
gen gcdr = 100*log(cdr/cdr[_n-4])
gen gcndr = 100*log(cndr/cndr[_n-4])
gen gcsr = 100*log(csr/csr[_n-4])
gen gir = 100*log(ir/ir[_n-4])
gen gistr = 100*log(istr/istr[_n-4])
gen gieqr = 100*log(ieqr/ieqr[_n-4])
gen giresr = 100*log(iresr/iresr[_n-4])

*
gen gemp = 100*log(empnfp/empnfp[_n-4])
gen gh = 100*log(awh/awh[_n-4])
gen gip = 100*log(iip/iip[_n-4])
*
gen gcpi = 100*log(cpi/cpi[_n-4])
gen gwpi = 100*log(ppi/ppi[_n-4])
gen gpce = 100*log(pce/pce[_n-4])
* 
replace sp500 = sp500/pce
gen gsp500 = 100*log(sp500/sp500[_n-4])
gen rr = r3m - gcpi
*
drop if date<1960
summarize gyr gcr gcsr gcndr gcdr gir gistr gieqr giresr gemp gsp500 
correlate gyr gcr gcsr gcndr gcdr gir gistr gieqr giresr gemp gsp500 

*line rr date 
*/

/*
*  (ii) GDP growth figs 
replace yr = yr/1000
line yr date, ///
	legend(off) xtitle("") ytitle("Real GDP (Trillions of 2000 Dollars)") ///
	name(usyr,replace) 
graph export usyr.emf, replace 
line gqyr date, ///
	legend(off) xtitle("") ytitle("Quarterly Growth Rate") ///
	/*nodraw*/ name(usgyqr,replace) 
graph export usgqy.emf, replace 
line gyr date, ///
	legend(off) xtitle("") ytitle("Year-on-Year Growth Rate") ///
	nodraw name(usgyr,replace) 
graph export usgy.emf, replace 
graph combine usyr usgyr, rows(2) xcommon 
graph export usygy.eps, replace

*  histogram
hist gqyr, ///
	norm nodraw name(usgqhist,replace) ///
	ytitle(Frequency) xtitle(Quarterly Growth Rate (Annual Percent))
hist gyr, ///
	norm nodraw name (usghist,replace) ///
	ytitle(Frequency) xtitle(Year-on-Year Growth Rate (Percent))
graph combine usgqhist usghist, rows(2) xcommon ycommon 
graph export ushist.emf, replace 
graph export ushist.eps, replace 

*  (iii) Components of GDP 
line gyr date || line gcsr date, ///
	title("Consumption of Services") ///
	legend(off) xtitle("") ytitle("YOY Growth Rate") ///
	name(usgycs,replace) 
graph export usgycs.emf, replace 
line gyr date || line gcndr date, ///
	title("Consumption of Nondurables") ///
	legend(off) xtitle("") ytitle("YOY Growth Rate") ///
	name(usgycnd,replace) 
graph export usgycnd.emf, replace 
*xcorr gcndr gyr, lags(12)	
line gyr date || line gcdr date, ///
	title("Consumption of Durables") ///
	legend(off) xtitle("") ytitle("YOY Growth Rate") ///
	name(usgycd,replace) 
graph export usgycd.emf, replace 
*xcorr gcdr gyr, lags(12)	
graph combine usgycs usgycnd usgycd, rows(3) xcommon ycommon  
graph export usgcall.eps, replace
*xcorr gir gyr, lags(12)

line gyr date || line gistr date, ///
	title("Investment in Structures") ///
	legend(off) xtitle("") ytitle("YOY Growth Rate") ///
	name(usgyist,replace) 
graph export usgyist.emf, replace 
line gyr date || line gieqr date, ///
	title("Investment in Equipment") ///
	legend(off) xtitle("") ytitle("YOY Growth Rate") ///
	name(usgyieq,replace) 
graph export usgyieq.emf, replace 
*xcorr gcndr gyr, lags(12)	
line gyr date || line giresr date, ///
	title("Investment in Housing") ///
	legend(off) xtitle("") ytitle("YOY Growth Rate") ///
	name(usgyires,replace) 
graph export usgyires.emf, replace 
*xcorr gcdr gyr, lags(12)	
graph combine usgyist usgyieq usgyires, rows(3) xcommon ycommon  
graph export usgiall.eps, replace

*  (iv) Other indicators
line gyr date || line gemp date, ///
	title("Employment (Nonfarm Payroll)") ///
	legend(off) xtitle("") ytitle("YOY Growth Rate") ///
	name(usgyemp,replace) 
graph export usgyemp.emf, replace 
line gyr date || line gsp500 date, ///
	title("S&P 500 Stock Market Index") ///
	legend(off) xtitle("") ytitle("YOY Growth Rate") ///
	name(usgysp500,replace) 
xcorr gsp500 gyr, lags(12)	
graph combine usgyemp usgysp500, rows(2) xcommon /*ycommon*/
graph export usgother.eps, replace
*/


/*
*  Part 3:  Money growth, inflation, and Taylor rules (mon pol class) 
gen gmb = 100*log(mb/mb[_n-4])
gen gm1 = 100*log(m1/m1[_n-4])
gen gm2 = 100*log(m2/m2[_n-4]) /*if date<2008.8*/
gen gpce = 100*log(pce/pce[_n-4])
gen gyr = 100*log(yr/yr[_n-4])
gen gmy = gm2 - gyr 

drop if date<1960
gen lmb = log(mb/mb[1])
gen lm1 = log(m1/m1[1])
gen lm2 = log(m2/m2[1])
gen lpce = log(pce/pce[1])
gen ly = log(y/y[1]) 
gen lyr = log(yr/yr[1]) 
gen lmy = lm2 - lyr 

#delimit;
line lpce date || line lmy date,
	legend(off) xtitle("") ytitle("M/Y and P (log scale)") 
	text(1.2  1995 "M/Y", place(e)) 	
	text(1.62 1995 "P", place(e)) 
	name(py_us,replace); 
graph export py_us.emf, replace;

#delimit;
line gpce date || line gmy date,
	legend(off) xtitle("") ytitle("Year-on-Year Growth") 
	text(-3.5 1960 "blue=P growth, brown=M/Y growth", place(e)) 	
	name(gpy_us,replace); 
graph export gpy_us.emf, replace;

#delimit;
line r3m date || line r10y date, 
	legend(off) xtitle("") ytitle("Annual Percentage") 
	text(2.2 1985 "3-month tbill rate", place(e))
	text(9.5 1990 "10-year treasury yield", place(e))
	name(usrates3m10y,replace); 
graph export usrates.emf, replace;

#delimit;
line r3m date || line gpce date, 
	legend(off) xtitle("") ytitle("Annual Percentage") 
	text(9.0 1990 "3-month tbill rate", place(e))
	text(1.5 1985 "inflation rate", place(e))
	name(usratespi,replace); 
graph export usratespi.emf, replace;

#delimit cr
gen rfftr = 2 + gpce + 0.5*(gpce-2) + 0.5*(gyr-3.0)
*drop if date<1990

#delimit;
line rff date || line rfftr date, 
	legend(off) xtitle("") ytitle("Annual Percentage") 
	text(13 1966 "Taylor rule", place(e))
	text(1.0 1993 "Fed funds rate", place(e))
	name(ustaylorrule,replace); 
graph export ustaylorrule.emf, replace;

#delimit;
line lmb date,
	legend(off) xtitle("") ytitle("Monetary Base (log scale)") 
	name(mb_us,replace); 
graph export mb_us.emf, replace;

*/

