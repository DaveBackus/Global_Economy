%  proj6_06.m
%  Calculations for Group Project #6, yield curve 
format compact
format short 

%  1. Input data
disp('Reading the US Yield Curve (Group Project #6)') 
[y] = xlsread('proj6','zeros');
[nr,nc] = size(y);
y = y(4:nr,6:nc)    % drop missing obs and maturities < 1 year
[obs,matmax] = size(y)

%  2. Compute forwards etc 
mats = [1:matmax];
matsbig = mats([ones(obs,1)],:);

p = 1./(1+y/100).^matsbig;
pm1 = [ones(obs,1) p(:,1:matmax-1)];
f = 100.*(pm1./p - 1);
fbar = mean(f);
rp = fbar - fbar(1);
ybar = mean(y);
ynow = y(obs,:);
fnow = f(obs,:);
Ei = fnow - rp;

table = [mats' ynow' fnow' fbar' rp' Ei'] 

FontSize = 14;
LineWidth = 1.5;
figure(1)
clf
plot(table(:,1),table(:,2),'-','LineWidth',LineWidth,'Color','r')
hold on
plot(table(:,1),table(:,3),'-','LineWidth',LineWidth,'Color','b')
plot(table(:,1),table(:,5),'-','LineWidth',LineWidth,'Color','m')
plot(table(:,1),table(:,6),'--','LineWidth',LineWidth,'Color','r')
ylabel('Interest Rate (Annual Percentage)','FontSize',FontSize)
xlabel('Maturity (Years)','FontSize',FontSize)
text(2,0.5,'f','FontSize',FontSize)
text(3.3,0.35,'y','FontSize',FontSize)
text(4,0.8,'rp','FontSize',FontSize)
text(4.2,0.3,'E(i)','FontSize',FontSize)
set(gca,'LineWidth',1.5,'FontSize',FontSize)

return 
