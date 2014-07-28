%  growth.m
%  Calculations for the growth accounting notes 
format compact
format short 

%  US-Mexico example 
disp('US and Mexico')
%       L       H    K      Y 
mex = [34.65  7.23  1617  852];
us =  [142.08 12.05 19600 9169]; 

yldiff = (us(4)/us(1))/(mex(4)/mex(1)) 

kldiff = (us(3)/us(1))/(mex(3)/mex(1)) 
kldiff = kldiff^(1/3)

hdiff = (us(2))/(mex(2)) 
hdiff = hdiff^(2/3) 

amexnoh = mex(4)/(mex(3)^(1/3)*(mex(1))^(2/3))
ausnoh = us(4)/(us(3)^(1/3)*(us(1))^(2/3))

anohdiff = ausnoh/amexnoh

amex = mex(4)/(mex(3)^(1/3)*(mex(2)*mex(1))^(2/3))
aus = us(4)/(us(3)^(1/3)*(us(2)*us(1))^(2/3))

adiff = aus/amex

return 

%  France-UK example 
disp('France and UK')
%       L       H    K      Y 
f =  [27.497 7.86 3852	1351];
uk = [29.697 9.42 2873	1326];

diff = f./uk

yldiff = diff(4)/diff(1)
kldiff = diff(3)/diff(1)

af = f(4)/(f(3)^(1/3)*(f(2)*f(1))^(2/3))
auk = uk(4)/(uk(3)^(1/3)*(uk(2)*uk(1))^(2/3))
adiff = af/auk

check = adiff*kldiff^(1/3)*diff(2)^(2/3)







