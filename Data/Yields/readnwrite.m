%  ----------------------------------------------------------------------------------------------------------
%  Read in Treasury yields and output spreadsheet with selected maturities 
%  Written by:  Dave Backus, March 2006.
%  Data from:  Liuren Wu.  
%  ----------------------------------------------------------------------------------------------------------
format compact

load sfbfull.yld
%sfbfull(1:5,2:7)
yields = sfbfull(:,[1:12:121]);  % take annual maturites only 
dlmwrite('usyields.csv',yields) %,'\t')
