%  ps4.m
%  Calculations for ps 4
format compact
format short 

disp('Problem 2 (JAP yield curve)') 
[y] = xlsread('ps4','Sheet2');
[obs,matmax] = size(y)

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
