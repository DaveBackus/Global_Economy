* ----------------------------------------------------------------------------------
*  cycles_m.do
*  Program reads in selected monthly series for description of US business cycles 
*  Spreadsheet contains data from Datastream listed in "GE cycles m.llt" 
*  Written by:  Dave Backus (Feb 06 and after)
* ----------------------------------------------------------------------------------
clear all 
set memory 10m 
version 10
set more off 
cd "Q:\ECO\Global Economy\BCEFP\Backus_10\Data\Cycles"

*  Input data from spreadsheet  
insheet date ///
	ip ipfp ipcg ipcd ipcnd ipbe ipmat ipmfg caput iumfg iumv iucomp ///
	pop16 emptot emppop /*empcps*/ unr undur un5 un27 unnew ///
	emp emppvt empgds empsvc emprm empcon empmfg empdg empnd empttu empwho empret empfin empgov ///
	awh awhg awhs awhrm awhcon awhmfg aohmfg empdinf empdimfg ///
	pi picomp pidisp pout psav psavr pce pcech pcep pcepcore ///
	bp bpne bpmw bps bpw hs hsne hsmw hss hsw nhs nhsp ehs ehsp newcars salesmt ///
	mcsi mcsc mcse mcs12m mcs5y mcsp1y mcsp5y ///
	tcbcci tcbccp tcbcce tcbli tcbcui tcborders tcbmtinv tcbhwi tcbbs tcbci tcblgi ecrili ///
	pmi pmp pmno pmbl mpemp napmi napmp napmno napmbl napminv napmemp iscsi ///
	mb m1 m2 ciloans consloans ///
	sp500 sp500ind nyse djia ///
	rff rtb3m rtb6m rtr1y rtr2y rtr5y rtr10y rtr20y rtip5y rtip10y ///
	red3m red6m rprime raaa rbaa vix comdji comdjen comdjmt comdjag combrent ///
	eravg ereuro ///
	cpi cpicore ppifg ppicore pimp pexp ///	
	using cycles_indicators_m.csv, clear 
drop in 1/2  /* Drop 2 header rows -- description and Datastream mnemonic */
*drop in -1
destring _all, replace force
replace date = 1950+_n/12-1/24
gen time = _n
tsset time

*  1. Data manipulation 
*  ----------------------------------------------------------------------------
* growth rates mostly
gen gip = 100*log(ip[_n]/ip[_n-12])
gen gmip = 1200*log(ip/ip[_n-1])
gen gmiplag = gmip[_n-1]
gen gemp = 100*log(emp[_n+6]/emp[_n-6])
gen demp = emp - emp[_n-1] 
gen gawh = log(awh[_n+6]/awh[_n-6]) 
gen gawhm = log(awhmfg[_n+6]/awhmfg[_n-6])
gen awhmL6 = awhmfg[_n-6]
gen dunr = unr[_n+6] - unr[_n-6]
gen unrL6  = unr[_n-6]
gen dundur = undur[_n+6] - undur[_n-6]
gen gun5 = log(un5[_n+6]/un5[_n-6])
gen gun27 = log(un27[_n+6]/un27[_n-6])  /* bad data?? */
gen gunnew = log(unnew[_n+6]/unnew[_n-6])
gen dunnew = unnew[_n+6] - unnew[_n-6]
gen unnewL6 = unnew[_n-6] 
replace pce = pce/pcep
gen gpce = log(pce[_n+6]/pce[_n-6])  /* ??? */
gen gpcep = log(pcep[_n+6]/pcep[_n-6])
gen gpcepcore = log(pcepcore/pcepcore[_n-12])
gen gmpcep = log(pcep/pcep[_n-1])
gen gmpcepcore = log(pcepcore/pcepcore[_n-1])
gen ghs = log(hs[_n+6]/hs[_n-6])
gen hsL6 = hs[_n-6] 
gen gbp = log(bp[_n+6]/bp[_n-6]) 
gen bpL6 = bp[_n-6]
gen gnc = log(newcars[_n+6]/newcars[_n-6]) 
gen gmcsi = log(mcsi[_n+6]/mcsi[_n-6]) 
gen gtcbli = log(tcbli[_n+6]/tcbli[_n-6]) 
gen gtcbci = log(tcbci[_n+6]/tcbci[_n-6]) 
gen gtcblgi = log(tcblgi[_n+6]/tcblgi[_n-6]) 
gen gecrili = log(ecrili[_n+6]/ecrili[_n-6]) 
gen gsp500 = log(sp500[_n+6]/sp500[_n-6])
gen s10yff = rtr10y - rff
gen s10y3m = rtr10y - rtb3m
gen s3mff = rtb3m - rff
gen sbaa = rbaa - rtb3m

drop if date<1960    /* ****** */

/* 
*  2. Figs and summary stats  
*  ----------------------------------------------------------------------------
program muplusminus, rclass
	summ `1' 
	local mu = r(mean)
	local muplus  = r(mean) + r(sd)
	local muminus = r(mean) - r(sd)
	return scalar mu = `mu'
	return scalar muplus  = `muplus'
	return scalar muminus = `muminus'
end 

#delimit ; 
graph twoway spike gmip date,   
	ytitle("Growth Rate (annual percentage)") xtitle(" ")
	name(gmip,replace);
graph export gmip.emf, replace;	

#delimit ; 
muplusminus gmip;
graph twoway spike gmip date,   
	yline(`r(mu)', lstyle(refline) lw(medthin) lc(red) lp(solid)) 	
	yline(`r(muplus)', lstyle(refline) lw(medthin) lc(red) lp(dash)) 	
	yline(`r(muminus)', lstyle(refline) lw(medthin) lc(red) lp(dash)) 	
	ytitle("Growth Rate (annual percentage)") xtitle(" ")
	name(gmip_grid,replace);
graph export gmip_grid.emf, replace;	

#delimit ; 
graph twoway spike demp date, 
	ytitle("Change in Employment (thousands)") xtitle(" ")
	name(demp,replace);	
graph export demp.emf, replace name(demp);	

#delimit ; 
muplusminus demp;
graph twoway spike demp date, 
	yline(`r(mu)', lstyle(refline) lw(medthin) lc(red) lp(solid)) 	
	yline(`r(muplus)', lstyle(refline) lw(medthin) lc(red) lp(dash)) 	
	yline(`r(muminus)', lstyle(refline) lw(medthin) lc(red) lp(dash)) 	
	ytitle("Change in Employment (thousands)") xtitle(" ")
	name(demp_grid,replace);	
graph export demp_grid.emf, replace;	

graph combine gmip demp, rows(2) xcommon; 
graph export gmip_demp.eps, replace;

#delimit ; 
graph twoway spike unnew date if date>1970,   
	ytitle("New Claims (thousands per week)") xtitle(" ")
	name(unnew,replace);
graph export unnew.emf, replace name(unnew);	

#delimit ; 
muplusminus unnew;
graph twoway spike unnew date if date>1970,   
	yline(`r(mu)', lstyle(refline) lw(medthin) lc(red) lp(solid)) 	
	yline(`r(muplus)', lstyle(refline) lw(medthin) lc(red) lp(dash)) 	
	yline(`r(muminus)', lstyle(refline) lw(medthin) lc(red) lp(dash)) 	
	ytitle("New Claims (thousands per week)") xtitle(" ")
	name(unnew_grid,replace);
graph export unnew_grid.emf, replace;	

#delimit ; 
muplusminus hs;
graph twoway spike hs date,   
	ytitle("Housing Starts (thousands)") xtitle(" ")
	name(hs,replace);
graph export hs.emf, replace name(hs);	

#delimit ; 
muplusminus hs;
graph twoway spike hs date,   
	yline(`r(mu)', lstyle(refline) lw(medthin) lc(red) lp(solid)) 	
	yline(`r(muplus)', lstyle(refline) lw(medthin) lc(red) lp(dash)) 	
	yline(`r(muminus)', lstyle(refline) lw(medthin) lc(red) lp(dash)) 	
	ytitle("Housing Starts (thousands)") xtitle(" ")
	name(hs_grid,replace);
graph export hs_grid.emf, replace name(hs);	

graph combine unnew hs, rows(2) xcommon; 
graph export newclaims_hs.eps, replace;

#delimit ; 
graph twoway spike awhmfg date,   
	ytitle("Avg Weekly Hours (manuf)") xtitle(" ")
	name(awhrm,replace);
graph export awhm.emf, replace;	

#delimit ; 
muplusminus awhmfg;
graph twoway spike awhmfg date,   
	yline(`r(mu)', lstyle(refline) lw(medthin) lc(red) lp(solid)) 	
	yline(`r(muplus)', lstyle(refline) lw(medthin) lc(red) lp(dash)) 	
	yline(`r(muminus)', lstyle(refline) lw(medthin) lc(red) lp(dash)) 	
	ytitle("Avg Weekly Hours (manuf)") xtitle(" ")
	name(awhrm_grid,replace);
graph export awhm_grid.emf, replace;	
*/

/*
#delimit ; 
graph twoway spike demp date if date>1990,   
	xlabel(1990(2)2009) 
	ytitle("Thousands") xtitle(" ");
graph export intro_demp.emf, replace;	

graph twoway spike hs date if date>1990,  
	xlabel(1990(2)2009) ytitle("Thousands") xtitle(" ");
graph export intro_hs.emf, replace;	

graph twoway spike sbaa date if date>1990,  
	xlabel(1990(2)2009) ytitle("Percent") xtitle(" ");
graph export intro_sbaa.emf, replace;	

summ gip unr unnew gemp awh bp hs newcars mcsi s10yff gsp500 if date>=1990
summ gip unr unnew gemp awh bp hs newcars mcsi s10yff gsp500 if date>=2000
list gip unr unnew gemp awh bp hs newcars mcsi s10yff gsp500 if date>=2007
*/


*  3. Cross-correlation functions 
*  ----------------------------------------------------------------------------
/*
*  S&P 500
xcorr gip gsp500, ///
	lags(20) ///
	name(xcsp500,replace) /*nodraw*/ xline(0) ///
	title("S&P 500 Index") ///
	ytitle("Cross-Correlation with Industrial Production") ///
	xtitle("Lag in Months Relative to Industrial Production") ///
	text(0.90 -10 "Leads IP", place(c)) text(0.90 10 "Lags IP", place(c))
graph export xcsp500.eps, replace
graph export xcsp500.emf, replace
*/

/* 
*  Labor markets 
xcorr gip gemp if date>1960, ///
	lags(20) ///
	name(xcemp,replace) /*nodraw*/ title("") xline(0) ///
	title("Employment") ///
	ytitle("Cross-Correlation with IP") ///
	xtitle("Lag in Months Relative to Industrial Production") ///
	text(0.90 -10 "Leads IP", place(c)) text(0.90 10 "Lags IP", place(c))
graph export xcemp.emf, replace name(xcemp)
graph export xcemp.eps, replace name(xcemp)

xcorr gip unrL6, ///
	lags(20) ///
	name(xcur,replace) /*nodraw*/ title("") xline(0) ///
	title("Unemployment Rate") ///
	ytitle("Cross-Correlation with IP") ///
	xtitle("Lag in Months Relative to IP") ///
	text(0.90 -10 "Leads IP", place(c)) text(0.90 10 "Lags IP", place(c))
*graph export xcur.eps, replace
graph export xcur.emf, replace 

xcorr gip dunr, ///
	lags(20) ///
	name(xcdur,replace) /*nodraw*/ title("") xline(0) ///
	title("Unemployment Rate") ///
	ytitle("Cross-Correlation with IP") ///
	xtitle("Lag in Months Relative to IP") ///
	text(0.90 -10 "Leads IP", place(c)) text(0.90 10 "Lags IP", place(c))
*graph export xcdur.eps, replace
*graph export xcdur.emf, replace

xcorr gip unnew if date>1990, ///
	lags(20) ///
	name(xcunnew,replace) /*nodraw*/ title("") xline(0) ///
	title("New Claims") ///
	ytitle("Cross-Correlation with IP") ///
	xtitle("Lag in Months Relative to IP") ///
	text(0.90 -10 "Leads IP", place(c)) text(0.90 10 "Lags IP", place(c))
*graph export xcnewclaims.eps, replace
graph export xcnewclaims.emf, replace

xcorr gip dunnew, ///
	lags(20) ///
	name(xcdunnew,replace) /*nodraw*/ title("") xline(0) ///
	title("New Claims:  YOY Change") ///
	ytitle("Cross-Correlation with IP") ///
	xtitle("Lag in Months Relative to IP") ///
	text(0.90 -10 "Leads IP", place(c)) text(0.90 10 "Lags IP", place(c))
*graph export xcdnewclaims.eps, replace
*graph export xcdnewclaims.emf, replace

xcorr gip gun5, ///
	lags(20) ///
	name(xcgun5,replace) /*nodraw*/ title("") xline(0) ///
	title("Growth Rate of Recently Unemployed") ///
	ytitle("Cross-Correlation with IP") ///
	xtitle("Lag in Months Relative to IP") ///
	text(0.90 -10 "Leads IP", place(c)) text(0.90 10 "Lags IP", place(c))

xcorr gip undur, ///
	lags(20) ///
	name(xcdundur,replace) /*nodraw*/ title("") xline(0) ///
	title("Unemployment Duration") ///
	ytitle("Cross-Correlation with IP") ///
	xtitle("Lag in Months Relative to Industrial Production") ///
	text(0.90 -10 "Leads IP", place(c)) text(0.90 10 "Lags IP", place(c))

xcorr gip awhmL6, ///
	lags(20) ///
	name(xcawhm,replace) /*nodraw*/ title("") xline(0) ///
	title("Avg Weekly Hours in Mfg") ///
	ytitle("Cross-Correlation with IP") ///
	xtitle("Lag Relative to Industrial Production") ///
	text(0.90 -10 "Leads IP", place(c)) text(0.90 10 "Lags IP", place(c))
*graph export xcawhm.eps, replace
graph export xcawhm.emf, replace

xcorr gip gawhm, ///
	lags(20) ///
	name(xcgawhm,replace) /*nodraw*/ title("") xline(0) ///
	title("Avg Weekly Hours in Mfg (YOY)") ///
	ytitle("Cross-Correlation with IP") ///
	xtitle("Lag Relative to Industrial Production") ///
	text(0.90 -10 "Leads IP", place(c)) text(0.90 10 "Lags IP", place(c))
*graph export xcgawhm.eps, replace
graph export xcgawhm.emf, replace

xcorr gip gawh, ///
	lags(20) ///
	name(xcawh,replace) /*nodraw*/ title("") xline(0) ///
	title("Avg Weekly Hours (Total)") ///
	ytitle("Cross-Correlation with Industrial Production") ///
	xtitle("Lag Relative to IP") ///
	text(0.90 -10 "Leads IP", place(c)) text(0.90 10 "Lags IP", place(c))
*graph export xcawh.eps, replace
*graph export xcawh.emf, replace

graph combine xcemp xcur xcunnew xcdunnew, rows(2) ycommon xcommon 
graph export xclabor.eps, replace
*/

/* 
*  Census and surveys 
xcorr gip ghs, ///
	lags(20) ///
	name(xcghs,replace) /*nodraw*/ title("") xline(0) ///
	title("Housing Starts") ///
	ytitle("Cross-Correlation with IP") ///
	xtitle("Lag in Months Relative to Industrial Production") ///
	text(0.90 -10 "Leads IP", place(c)) text(0.90 10 "Lags IP", place(c))
*graph export xcghs.eps, replace
graph export xcghs.emf, replace

xcorr gip gbp, ///
	lags(20) ///
	name(xcgbp,replace) /*nodraw*/ title("") xline(0) ///
	title("Building Permits") ///
	ytitle("Cross-Correlation with IP") ///
	xtitle("Lag in Months Relative to Industrial Production") ///
	text(0.90 -10 "Leads IP", place(c)) text(0.90 10 "Lags IP", place(c))
graph export xcgbp.eps, replace
graph export xcgbp.emf, replace

xcorr gip caput, ///
	lags(20) ///
	name(xccaput,replace) /*nodraw*/ title("") xline(0) ///
	title("Capacity Utilization") ///
	ytitle("Cross-Correlation with Industrial Production") ///
	xtitle("Lag in Months Relative to Industrial Production") ///
	text(0.90 -10 "Leads IP", place(c)) text(0.90 10 "Lags IP", place(c))

xcorr gip pmi, ///
	lags(20) ///
	name(xcpmi,replace) /*nodraw*/ title("") xline(0) ///
	title("Purchasing Managers Index") ///
	ytitle("Cross-Correlation with IP") ///
	xtitle("Lag in Months Relative to Industrial Production") ///
	text(0.90 -10 "Leads IP", place(c)) text(0.90 10 "Lags IP", place(c))
*graph export xcpmi.eps, replace
*graph export xcpmi.emf, replace

xcorr gip mcsi, ///
	lags(20) ///
	name(xcgmcsi,replace) /*nodraw*/ title("") xline(0) ///
	title("Consumer Sentiment") ///
	ytitle("Cross-Correlation with IP") ///
	xtitle("Lag in Months Relative to Industrial Production") ///
	text(0.90 -10 "Leads IP", place(c)) text(0.90 10 "Lags IP", place(c))
graph export xcmcsi.eps, replace
graph export xcmcsi.emf, replace

xcorr gip gmcsi, ///
	lags(20) ///
	name(xcgmcsi,replace) /*nodraw*/ title("") xline(0) ///
	title("Consumer Sentiment") ///
	ytitle("Cross-Correlation with IP") ///
	xtitle("Lag in Months Relative to Industrial Production") ///
	text(0.90 -10 "Leads IP", place(c)) text(0.90 10 "Lags IP", place(c))
graph export xcgmcsi.eps, replace
graph export xcgmcsi.emf, replace

graph combine xcgbp xcghs xcgmcsi xcpmi, rows(2) ycommon xcommon 
graph export xcsurvey.eps, replace

*  Financial indicators
xcorr gip gsp500, ///
	lags(20) ///
	name(xcsp500,replace) /*nodraw*/ xline(0) ///
	title("S&P 500 Index") ///
	ytitle("Cross-Correlation with Industrial Production") ///
	xtitle("Lag in Months Relative to Industrial Production") ///
	text(0.90 -10 "Leads IP", place(c)) text(0.90 10 "Lags IP", place(c))
graph export xcsp500.eps, replace
graph export xcsp500.emf, replace

xcorr gip s10y3m, ///
	lags(20) ///
	name(xcs10y3m,replace) /*nodraw*/ title("") xline(0) ///
	title("Yield Spread (10y - 3m)") ///
	ytitle("Cross-Correlation with Industrial Production") ///
	xtitle("Lag Relative to IP") ///
	text(0.90 -10 "Leads IP", place(c)) text(0.90 10 "Lags IP", place(c))

xcorr gip s10yff, ///
	lags(20) ///
	name(xcs10yff,replace) /*nodraw*/ xline(0) ///
	title("Yield Spread (10y - Fed Funds)") ///
	ytitle("Cross-Correlation with Industrial Production") ///
	xtitle("Lag Relative to IP") ///
	text(0.90 -10 "Leads IP", place(c)) text(0.90 10 "Lags IP", place(c))
graph export xcs10yff.eps, replace
graph export xcs10yff.emf, replace

xcorr gip s3mff, ///
	lags(20) ///
	name(xcs3mff,replace) /*nodraw*/ xline(0) ///
	title("Yield Spread (3m - Fed Funds)") ///
	ytitle("Cross-Correlation with Industrial Production") ///
	xtitle("Lag Relative to IP") ///
	text(0.90 -10 "Leads IP", place(c)) text(0.90 10 "Lags IP", place(c))

xcorr gip sbaa, ///
	lags(20) ///
	name(xcsbaa,replace) /*nodraw*/ xline(0) ///
	title("Yield Spread (Aaa - Baa)") ///
	ytitle("Cross-Correlation with Industrial Production") ///
	xtitle("Lag Relative to IP") ///
	text(0.90 -10 "Leads IP", place(c)) text(0.90 10 "Lags IP", place(c))
graph export xcsbaa.eps, replace
graph export xcsbaa.emf, replace

*/

/*
*  IP acf
scatter gmip gmiplag, ///
	title("Current Growth v Future Growth") ///
	xtitle("Current Growth Rate") ///
	ytitle("Next Month's Growth Rate")
graph export gmipscatter.emf, replace 
	
ac gmip, lags(24) ///
	title("Autocorrelations for Monthly Growth Rates") ///
	ytitle("Correlations")
graph export acgmip.emf, replace 

ac gip, lags(24) ///
	title("Autocorrelations for Year-on-Year Growth Rates") ///
	ytitle("Correlations")
graph export acgip.emf, replace 

*  TCB indicators 
xcorr gip gtcbli, ///
	lags(20) ///
	name(xcgtcbli,replace) /*nodraw*/ title("") xline(0) ///
	title("TCB Leading Indicators") ///
	ytitle("Cross-Correlation with Industrial Production") ///
	xtitle("Lag Relative to IP") ///
	text(0.90 -10 "Leads IP", place(c)) text(0.90 10 "Lags IP", place(c))

xcorr gip gtcbci, ///
	lags(20) ///
	name(xcgtcbci,replace) /*nodraw*/ title("") xline(0) ///
	title("TCB Coincident Indicators") ///
	ytitle("Cross-Correlation with Industrial Production") ///
	xtitle("Lag Relative to IP") ///
	text(0.90 -10 "Leads IP", place(c)) text(0.90 10 "Lags IP", place(c))

xcorr gip gtcblgi, ///
	lags(20) ///
	name(xcgtcblgi,replace) /*nodraw*/ title("") xline(0) ///
	title("TCB Lagging Indicators") ///
	ytitle("Cross-Correlation with Industrial Production") ///
	xtitle("Lag Relative to IP") ///
	text(0.90 -10 "Leads IP", place(c)) text(0.90 10 "Lags IP", place(c))

xcorr gip gecrili, ///
	lags(20) ///
	name(xcgecri,replace) /*nodraw*/ title("") xline(0) ///
	title("ECRI Leading Indicators") ///
	ytitle("Cross-Correlation with Industrial Production") ///
	xtitle("Lag in Months Relative to Industrial Production") ///
	text(0.90 -10 "Leads IP", place(c)) text(0.90 10 "Lags IP", place(c))

*  Various survey indicators 
xcorr gip gnc, ///
	lags(20) ///
	name(xcgnc,replace) /*nodraw*/ title("") xline(0) ///
	title("New Car Purchases") ///
	ytitle("Cross-Correlation with Industrial Production") ///
	xtitle("Lag in Months Relative to Industrial Production") ///
	text(0.90 -10 "Leads IP", place(c)) text(0.90 10 "Lags IP", place(c))

xcorr gip gpce, ///
	lags(20) ///
	name(xcpce,replace) /*nodraw*/ title("") xline(0) ///
	title("Personal Consumption") ///
	ytitle("Cross-Correlation with Industrial Production") ///
	xtitle("Lag in Months Relative to Industrial Production") ///
	text(0.90 -10 "Leads IP", place(c)) text(0.90 10 "Lags IP", place(c))
*/


* OLD STUFF
*  inflation dynamics (core and headline) 
/*
xcorr gip gpcep, ///
	lags(20) ///
	name(xcgtcbli,replace) /*nodraw*/ title("") xline(0) ///
	title("PCE Inflation") ///
	ytitle("Cross-Correlation with Industrial Production") ///
	xtitle("Lag Relative to IP") ///
	text(0.90 -10 "Leads IP", place(c)) text(0.90 10 "Lags IP", place(c))

ac gmpcep, ///
	name(acpi,replace) nodraw ///
	title("Autocorrelations for Inflation") ///
	ytitle("Correlations")
ac gmpcepcore, ///
	name(acpicore,replace) nodraw ///
	title("Autocorrelations for Core Inflation") ///
	ytitle("Correlations")
graph combine acpi acpicore, rows(2) ycommon xcommon 

xcorr gpcep gpcep, ///
	lags(20) ///
	name(xcpipi,replace) nodraw title("") xline(0) 
xcorr gpcep gpcepcore, ///
	lags(20) ///
	name(xcpipicore,replace) nodraw title("") xline(0) 
graph combine xcpipi xcpipicore, rows(2) ycommon xcommon 
*/



