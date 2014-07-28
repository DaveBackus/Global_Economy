%  taxes.m
%  Tax calculations for Global Economy tax notes.  
%  Written by:  Dave Backus, Dec 2006 and after 
format compact
clear all 
disp(' ')
disp('******************************************************')
disp('Cascade')
disp('******************************************************')

tau = 0.1;
nstage = 5;
va = ones(nstage,1);
stages = [1:nstage]';
taxes = (1+tau).^stages
valueall = cumsum(taxes.*va)

vaplustaxlast = 0;
vaplustax = zeros(nstage,1);
for i=1:nstage
    vaplustaxlast = (1+tau)*(vaplustaxlast + va(i));
    vaplustax(i) = vaplustaxlast;
end

vaplustax

disp(' ')
disp('******************************************************')
disp('Labor taxes')
disp('******************************************************')

gamma = 4;
tau = 0.25;
theta = 0.5;  % fraction of tax revenuie spent on transfers
L = 1/(1+gamma*(1+theta*tau))

return 

disp(' ')
disp('******************************************************')
disp('Capital taxes')
disp('******************************************************')

tau = 0.25;
r = 0.04;
n = [1:25]';
pbt = 1./(1+(1-tau)*r).^n;
pat = 1./(1+r).^n;
[pbt pat pat./pbt]

return 

