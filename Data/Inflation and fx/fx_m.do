* ----------------------------------------------------------------------------------
*  fx_m.do
*  Program reads in selected monthly series on prices and exchange rate 
*  for several countries:  Brazil, China, /*India, Mexico, Venezuela,*/
*  France, /*Greece*/, US.  
*  Written by:  Dave Backus (Feb 07 and after)
* ----------------------------------------------------------------------------------
clear 
cd "Q:\ECO\Global Economy\BCEFP\Backus_09\Data\Inflation and fx"

*  Input data from spreadsheet  
insheet date ///
	pbra dpbra erbra rbra ///
	dpchn erchn reerchn rchn ///
	pfra dpfra erfra  reerfra rfra ///
	pusa dpusa reerusa rus ///
	pmex dpmex ermex reermex resmex ///
	pjap dpjap erjap rjap  ///
	using fx_monthly.csv, clear 
drop in 1/2  /* Drop 2 header rows -- description and Datastream mnemonic */
*drop in -1
destring _all, replace force
replace date = 1950+_n/12-1/24
gen time = _n
tsset time
drop if date<1980

/*
*  1. Nominal exchange rates 
* 
gen sfra = 1/erfra
gen reerusafra = log(sfra*pusa/pfra)
line erfra date, ///
	name(sfra,replace) ///
	xtitle("") ///
	ytitle("Dollars Per Euro (francs prior to 1999)") 
graph export sfra.emf, replace  

line erjap date, ///
	name(sjap,replace) ///
	xtitle("") ///
	ytitle("Yen Per Dollar") 
graph export sjap.emf, replace  

gen smex = 1/ermex
line smex date, ///
	name(smex,replace) ///
	xtitle("") ///
	ytitle("Dollars Per Peso") 
graph export smex.emf, replace  
line smex date if date>1990 , ///
	name(smex,replace) ///
	xtitle("") ///
	ytitle("Dollars Per Peso") 
graph export smex90s.emf, replace  

line erchn date, ///
	name(erchn,replace) ///
	xtitle("") ///
	ytitle("Exchange Rate (yuan per dollar)") 
graph export erchn.emf, replace 
*/

/* 
2. Real exchange rates 

*gen ppsusafra = pus/pmex
gen rerusafra = (erfra*pfra)/pus
line rerusafra date, ///
	name(rerfra,replace) ///
	xtitle("") ///
	ytitle("US-France Real Exchange Rate") 
graph export rerfra.emf, replace  

gen ppsusamex = pus/pmex
gen rerusamex = smex*pmex/pus
line rerusamex date if date>1990, ///
	name(smex,replace) ///
	xtitle("") ///
	ytitle("US-Mexico Real Exchange Rate") 
graph export rermex.emf, replace  

replace resmex = resmex/1000
line resmex date, ///
	name(resmex,replace) ///
	xtitle("") ///
	ytitle("Mexican FX Reserves (USD billions)") 
graph export resmex.emf, replace  

* no pchn -- need to cumulate inflation rates 
gen ldp = log(1+dpchn/1200)
gen lp = sum(ldp)
gen pchn = exp(lp) 
gen ppsusachn = pusa/pchn
gen schn = 1/erchn
gen rerusachn = schn*pchn/pus
drop if date<1990
replace rerusachn = rerusachn/rerusachn[1]
line rerusachn date if date>1990, ///
	name(schn,replace) ///
	xtitle("") ///
	ytitle("US-China Real Exchange Rate") 
graph export rerchn.emf, replace  

line reerusa date, ///
	name(reerusa,replace) ///
	xtitle("") ///
	ytitle("US Real Exchange Rate (trade-weighted)") 
graph export reerusa.emf, replace  
*/

*xlabel(1950(10)2010)


/*
*  2. China  
*
gen ldp = log(1+dpchn/1200)
gen lp = sum(ldp)
gen pchn = exp(lp) 
gen reerchnusa = log(echn*pusa/pchn) 
gen ppstar = pchn/pusa

line echn date, ///
	name(echn,replace) ///
	xtitle("") ///
	ytitle("Exchange Rate (yuan per dollar)") 
graph export echn.emf, replace 

line reerchn date, ///
	name(rerchn,replace) ///
	xtitle("") ///
	ytitle("Real Exchange Rate (inverse, weighted)") 
graph export rerchn.emf, replace 

line ppstar date, ///
	name(ppsusachn,replace) ///
	xtitle("") ///
	ytitle("Price Ratio (China v US)") ///
	legend(off)
graph export ppsusachn.emf, replace 

line reerchnusa date || line ppstar date, ///
	name(rerchn,replace) ///
	xtitle("") ///
	ytitle("Real Exchange Rate (v US)") ///
	legend(off)
graph export rerchnusa.emf, replace 

line dpchn date, ///
	name(dpchn,replace) ///
	xtitle("") ///
	ytitle("Inflation Rate") 
graph export dpchn.emf, replace
*/