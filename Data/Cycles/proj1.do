* ----------------------------------------------------------------------------------
*  proj1.do
*  Program reads in nominal expenditure components for three countries:  
*  China, India, and the US.  
*  Draws graphs of S, I, and NX for Group Project #1. 
*  Written by:  Dave Backus (Feb 09 and after)
* ----------------------------------------------------------------------------------
clear 
cd "Q:\ECO\Global Economy\BCEFP\Backus_09\Data\Cycles"

*  Input data from spreadsheet  
# delimit ;
insheet date nx_c g_c i_c v_c c_c gdp_c 		/* China */
		 x_i g_i i_i v_i c_i m_i gdp_i	/* India */ 
		 x_u gc_u gi_u v_u i_u c_u m_u gdp_u   /* US */
		 x_b g_b i_b v_b c_b m_b gdp_b 	/* Brazil */
	using proj1_09.csv; 
* Drop 2 header rows and last obs (NA) 
drop in 1/2;     /* first two rows are description and Datastream mnemonic */
*drop in -1;
destring _all, replace force;
*replace date = 1950+_n-1;
*gen time = _n;
*tsset time;
drop if date<1990;
drop if date>2009;

*  (i) Generate ratios 

*gen sy_c = (gdp_c - c_c - g_c)/gdp_c; 
gen iy_c = (i_c+v_c)/gdp_c;
gen nxy_c  = nx_c/gdp_c;
gen sy_c = iy_c + nxy_c;  /* cheap fix */

gen sy_i = (gdp_i - c_i - g_i)/gdp_i;
gen iy_i = (i_i+v_i)/gdp_i;
gen nxy_i  = (x_i-m_i)/gdp_i;

gen sy_u = (gdp_u - c_u - gc_u)/gdp_u;
gen cy_u = c_u/gdp_u;
gen iy_u = (i_u+v_u)/gdp_u;
gen nxy_u  = (x_u-m_u)/gdp_u;
replace iy_u = sy_u - nxy_u;  /* cheap fix */

gen sy_b = (gdp_b - c_b - g_b)/gdp_b;
gen iy_b = (i_b+v_b)/gdp_b;
gen nxy_b  = (x_b-m_b)/gdp_b;

*  (ii) plot ratios 

/* 
# delimit ;
line sy_c date || line iy_c date || line nxy_c date, 
	legend(off) xtitle("") ytitle("Share of GDP") 
	text(0.00 2006 "Net Exports", place(l))
	text(0.375 2006 "Investment", place(l))
	text(0.53 2006 "Saving", place(l));
graph export shares_china.emf, replace;
graph export shares_china.eps, replace;
*/

/* 
line sy_i date || line iy_i date || line nxy_i date, 
	legend(off) xtitle("") ytitle("Share of GDP") 
	text(0.02 2002 "Net Exports", place(r))
	text(0.35 2002 "Investment", place(r))
	text(0.18 1992 "Saving", place(l));
graph export shares_india.emf, replace;
graph export shares_india.eps, replace;
*/

/* 
line sy_u date || line iy_u date || line nxy_u date, 
	legend(off) xtitle("") ytitle("Share of GDP")
	text(-0.03 2007 "Net Exports", place(l))
	text(0.215 2007 "Investment", place(l))
	text(0.125 2007 "Saving", place(l));
graph export shares_us.emf, replace;
graph export shares_us.eps, replace;
*/

/* 
# delimit ;
line sy_b date || line iy_b date || line nxy_b date, 
	legend(off) xtitle("") ytitle("Share of GDP") 
	text(0.00 2006 "Net Exports", place(l))
	text(0.13 2006 "Investment", place(l))
	text(0.23 2006 "Saving", place(l));
graph export shares_brazil.emf, replace;
graph export shares_brazil.eps, replace;
*/
