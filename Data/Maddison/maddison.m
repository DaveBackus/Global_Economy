%  Maddison data 
%  Graphs of per capita GDP for various countries
format compact
clear all
clf reset 
close all

[table2,names] = xlsread('Maddison','Table2');
[table4,names] = xlsread('Maddison','Table4');
[table7,names] = xlsread('Maddison','Table7');
[nobs,m4] = size(table4);

dates = table2(:,1);
us = table2(:,2);
world = table7(:,2);
table4us = table4./us(:,[ones(1,m4)]) - 1;
table4w  = table4./world(:,[ones(1,m4)]) - 1;

figure(1)
plot(dates(31:nobs),table4(31:nobs,2),'LineWidth',1.5,'Color','b','LineStyle','-')
axis([1900 2000 0 12000])
hold on
plot(dates(31:nobs),table4(31:nobs,3),'LineWidth',1.5,'Color','g','LineStyle','-')
plot(dates(31:nobs),table4(31:nobs,4),'LineWidth',1.5,'Color','r','LineStyle','-')
plot(dates(31:nobs),table4(31:nobs,5),'LineWidth',1.5,'Color','k','LineStyle','-')
plot(dates(31:nobs),table4(31:nobs,6),'LineWidth',1.5,'Color','y','LineStyle','-')
ylabel('GDP Per Capita (1990 US Dollars)')
print -depsc la.eps

figure(2)
plot(dates(31:nobs),table4us(31:nobs,2),'LineWidth',1.5,'Color','b','LineStyle','-')
axis([1900 2000 -0.9 0])
hold on
plot(dates(31:nobs),table4us(31:nobs,3),'LineWidth',1.5,'Color','g','LineStyle','-')
plot(dates(31:nobs),table4us(31:nobs,4),'LineWidth',1.5,'Color','r','LineStyle','-')
plot(dates(31:nobs),table4us(31:nobs,5),'LineWidth',1.5,'Color','k','LineStyle','-')
plot(dates(31:nobs),table4us(31:nobs,6),'LineWidth',1.5,'Color','y','LineStyle','-')
ylabel('GDP Per Capita (Relative to US)')
print -depsc laus.eps

figure(3)
plot(dates(81:nobs),table4w(81:nobs,2),'LineWidth',1.5,'Color','b','LineStyle','-')
axis([1950 2000 -0.5 3.0])
hold on
plot(dates(81:nobs),table4w(81:nobs,3),'LineWidth',1.5,'Color','g','LineStyle','-')
plot(dates(81:nobs),table4w(81:nobs,4),'LineWidth',1.5,'Color','r','LineStyle','-')
plot(dates(81:nobs),table4w(81:nobs,5),'LineWidth',1.5,'Color','k','LineStyle','-')
plot(dates(81:nobs),table4w(81:nobs,6),'LineWidth',1.5,'Color','y','LineStyle','-')
ylabel('GDP Per Capita (Relative to World)')
print -depsc law.eps

return 