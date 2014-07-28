%  -----------------------------------------------------------------------------
%  slides_cycles_yields.m
%  Use zero yields to compute EH-based interest rate forecasts 
%  Written by:  Dave Backus, March 2006.
%  -----------------------------------------------------------------------------
format compact short 

y = xlsread('slides_yields.xls','euro'); 
[m,n] = size(y)
y = y(2:m,6:n);
obs = m-1;
matmax = n-5;
mean(y);

% compute prices and forward rates 
mats = [1:matmax];
matsbig = mats([ones(obs,1)],:);

p = 1./(1+y/100).^matsbig;
pm1 = [ones(obs,1) p(:,1:matmax-1)];
f = 100.*(pm1./p - 1);
fbar = mean(f)
rp = fbar - fbar(1);
ybar = mean(y)

ynow = y(obs,:);
fnow = f(obs,:);
Ei = fnow - rp;

table = [mats' ynow' fnow' fbar' rp' Ei'] 

FontSize = 14;
LineWidth = 1.5;


figure(1)
clf
plot(table(:,1),table(:,2),'-','LineWidth',LineWidth,'Color','r')  % yields
hold on
ylabel('Interest Rate (Annual Percentage)','FontSize',FontSize)
xlabel('Maturity (Years)','FontSize',FontSize)
set(gca,'LineWidth',1.5,'FontSize',FontSize)
axis([0 10 0 5])
print -depsc slides_cycles2_y.eps

figure(1)
clf
plot(table(:,1),table(:,2),'-','LineWidth',LineWidth,'Color','r')  % yields
hold on
plot(table(:,1),table(:,3),'-','LineWidth',LineWidth,'Color','b')  % forwards
ylabel('Interest Rate (Annual Percentage)','FontSize',FontSize)
xlabel('Maturity (Years)','FontSize',FontSize)
set(gca,'LineWidth',1.5,'FontSize',FontSize)
axis([0 10 0 5])
print -depsc slides_cycles2_yf.eps

figure(1)
clf
plot(table(:,1),table(:,2),'-','LineWidth',LineWidth,'Color','r')  % yields
hold on
plot(table(:,1),table(:,3),'-','LineWidth',LineWidth,'Color','b')  % forwards
plot(table(:,1),table(:,5),'-','LineWidth',LineWidth,'Color','m') % risk premium
ylabel('Interest Rate (Annual Percentage)','FontSize',FontSize)
xlabel('Maturity (Years)','FontSize',FontSize)
%text(7,4.1,'f','FontSize',FontSize)
%text(7,3.3,'y','FontSize',FontSize)
%text(4,1,'rp','FontSize',FontSize)
%text(4,1.9,'E(i)','FontSize',FontSize)
set(gca,'LineWidth',1.5,'FontSize',FontSize)
axis([0 10 0 5])
print -depsc slides_cycles2_yfrp.eps

figure(1)
clf
plot(table(:,1),table(:,2),'-','LineWidth',LineWidth,'Color','r')  % yields
hold on
plot(table(:,1),table(:,3),'-','LineWidth',LineWidth,'Color','b')  % forwards
plot(table(:,1),table(:,5),'-','LineWidth',LineWidth,'Color','m') % risk premium
plot(table(:,1),table(:,6),'--','LineWidth',LineWidth,'Color','g') % future shorts
ylabel('Interest Rate (Annual Percentage)','FontSize',FontSize)
xlabel('Maturity (Years)','FontSize',FontSize)
text(7,4.1,'f','FontSize',FontSize)
text(7,3.3,'y','FontSize',FontSize)
text(4,1,'rp','FontSize',FontSize)
text(4,1.9,'E(i)','FontSize',FontSize)
set(gca,'LineWidth',1.5,'FontSize',FontSize)
axis([0 10 0 5])
print -depsc slides_cycles2_yfi.eps

return 

