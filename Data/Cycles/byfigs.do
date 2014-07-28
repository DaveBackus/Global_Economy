* ----------------------------------------------------------------------------------
*  byfigs.do
*  Program reads in selected series for description of US business cycles 
*  Calculations of acf for output and consumption growth for comparison with 
*  Bansal-Yaron components model.  
*  Written by:  Dave Backus (Feb 06 and after)
* ----------------------------------------------------------------------------------
clear 
*set memory 1m
cd "Q:\ECO\Global Economy\BCEFP\Backus_06\Data\Cycles"
*cd "C:\Documents and Settings\David Backus\My Documents\Classes\Backus_06\Data\Cycles"

*  Input data from spreadsheet  
insheet date yr cr cdr cndr csr ir vr xr mr gr y c cd cnd cs i v x m g ///
	py pce cpi cpicore ppi ///
	iip lf empciv pop16 un empnfp awh ///
	rff r3m r6m r1y r5y y10y sp500 djia nyse ///
	lei lei1 lei2 lei3 lei4 lei5 lei6 lei8 lei9 lei10 lei11 lei12 ///
	using cycles_basic.csv, clear 
* Drop 2 header rows and last obs (NA) 
drop in 1/2     /* first two rows are description and Datastream mnemonic */
*drop in -1
destring _all, replace force
replace date = 1950+_n/4-1/8
gen time = _n
tsset time

*  (i) Generate growth rates 
*replace yr = cr
gen gqyr = 400*log(yr/yr[_n-1])
gen gyr = 100*log(yr/yr[_n-4])
*
gen gqcr = 400*log(cr/cr[_n-1]) 
gen gqcdr = 400*log(cdr/cdr[_n-1]) 
gen gqcndr = 400*log(cndr/cndr[_n-1]) 
gen gqcsr = 400*log(csr/csr[_n-1]) 
gen gcr = 100*log(cr/cr[_n-4])
gen gcdr = 100*log(cdr/cdr[_n-4])
gen gcndr = 100*log(cndr/cndr[_n-4])
gen gir = 100*log(ir/ir[_n-4])
*
gen gemp = 100*log(empnfp/empnfp[_n-4])
gen gh = 100*log(awh/awh[_n-4])
gen gip = 100*log(iip/iip[_n-4])
gen gsp500 = 100*log(sp500/sp500[_n-4])
gen glei1 = 100*log(lei1/lei1[_n-4])
gen glei2 = 100*log(lei2/lei2[_n-4])
gen glei6 = 100*log(lei6/lei6[_n-4])
gen glei10 = 100*log(lei10/lei10[_n-4])

*
gen gcpi = 100*log(cpi/cpi[_n-4])
gen gwpi = 100*log(ppi/ppi[_n-4])
gen gpce = 100*log(pce/pce[_n-4])
*
drop if date<1960

*  (ii) ACFs 
ac gqyr, lags(60)
ac gqcr, lags(60)   
ac gqcndr, lags(60) 
ac gqcsr, lags(60)   
ac gqcdr, lags(60) 

/*
corrgram gqyr, lags(36)  
ac gqyr, lags(36)  
graph export usacfgqy.emf, replace
arima gqyr, ar(1) ma(1)
arima gqyr, ar(1) ma(1 2)
arima gqyr, ar(1) ma(1 2 3)
arima gqyr, ar(1 2) ma(1 2)
*/ 
