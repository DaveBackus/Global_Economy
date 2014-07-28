%  notes_cycleind.m 
%  Calculations for notes, Business Cycle Indicators
format compact
format short 

mats = [1:5]';
y = [3.4 3.6 3.7 3.8 3.9]';
p = 100./(1+y/100).^mats

p = [96.71,  93.17, 89.67, 86.14,  82.59]';
y = 100*((100./p).^(1./mats)-1)
pm1 = [100; p(1:4,:)]
f = 100*((pm1./p)-1)

return