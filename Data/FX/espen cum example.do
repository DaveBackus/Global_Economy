
clear all

input year inf_rate

  2006   0.032
  2005   0.034
  2004   0.027
  2003   0.023
  2002   0.016
  2001   0.028
  2000   0.034
  1999   0.022
  1998   0.016
  1997   0.023
  1996   0.029

end
label var year "year"
label var inf_rate "rate of inflation"

sort year

gen ln_infl = ln(1+inf_rate)
label var ln_infl "log (1 + rate of inflation)"

gen ln_plev = sum(ln_infl)
label var ln_plev "log cumulative inflation"

gen plev = exp(ln_plev)
label var plev "cumulative inflation"

twoway (scatter  inf_rate year, c(l) yaxis(1)) (scatter plev   year, c(l) yaxis(2)), ylabel(0(.025).1,axis(1)) scheme(s1color)
