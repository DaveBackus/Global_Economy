%  Solow model for notes
%  Example:  numbers and figures 
format compact
format short 

% parameters 
alpha = 1/3;
delta = 0.1;
s = 0.20;
s2 = 0.25;
A = 1;
L = 100;
Kss = (s*A/delta)^(1/(1-alpha))*L
Yss = A*Kss^alpha*L^(1-alpha)
Iss = delta*Kss 
Css = Yss - Iss 

%return 

% --------------------------------------------------------------------
% Figure 1:  Solow Model 
Kgrid = [1:400]';
Ygrid = A*Kgrid.^alpha*L^(1-alpha);
sY = s*Ygrid;
s2Y = s2*Ygrid;
dK = delta*Kgrid;

FontSize = 14;
LineWidth = 1.5;
h = figure(1)
clf
plot(Kgrid,Ygrid,'-','LineWidth',LineWidth,'Color','r')
hold on
plot(Kgrid,sY,'-','LineWidth',LineWidth,'Color','b')
plot(Kgrid,dK,'-','LineWidth',LineWidth,'Color','m')
xlabel('Capital Stock','FontSize',FontSize)
text(200,120,'output','FontSize',FontSize)
text(100,30,'saving','FontSize',FontSize)
text(200,14,'depreciation','FontSize',FontSize)
set(gca,'LineWidth',1.5,'FontSize',FontSize)

print -depsc notes_solow1.eps

return 

% --------------------------------------------------------------------
% Figure 1A:  Solow Model with diff saving rates 

FontSize = 14;
LineWidth = 1.5;
h = figure(2)
clf
plot(Kgrid,s2Y,'--','LineWidth',LineWidth,'Color','b')
hold on
plot(Kgrid,sY,'-','LineWidth',LineWidth,'Color','b')
plot(Kgrid,dK,'-','LineWidth',LineWidth,'Color','m')
xlabel('Capital Stock','FontSize',FontSize)
%text(200,120,'output','FontSize',FontSize)
text(50,31,'saving (higher rate)','FontSize',FontSize)
text(100,18,'saving','FontSize',FontSize)
text(100,8,'depreciation','FontSize',FontSize)
set(gca,'LineWidth',1.5,'FontSize',FontSize)

print -depsc notes_solow1a.eps

return 

% --------------------------------------------------------------------
% Figure 2:  Solow Model per worker 
Kgrid = [1:500]';
kgrid = Kgrid/L;
ygrid = A*kgrid.^alpha;
sy = s*ygrid;
s2y = s2*ygrid;
dk = delta*kgrid;

FontSize = 14;
LineWidth = 1.5;
h = figure(2)
clf
plot(kgrid,sy,'-','LineWidth',LineWidth,'Color','b')
hold on
plot(kgrid,s2y,'--','LineWidth',LineWidth,'Color','b')
plot(kgrid,dk,'-','LineWidth',LineWidth,'Color','m')
xlabel('Capital Per Worker','FontSize',FontSize)
%text(200,120,'output','FontSize',FontSize)
text(3.2,0.27,'saving per worker','FontSize',FontSize)
text(1,0.37,'higher saving per worker','FontSize',FontSize)
text(1.2,0.1,'depreciation per worker','FontSize',FontSize)
set(gca,'LineWidth',1.5,'FontSize',FontSize)

print -depsc solow2.eps

return 

% OLD STUFF 
% Fig of prod function 
Kgrid = [1:400]';
Ygrid = A*Kgrid.^alpha*L^(1-alpha);

FontSize = 14;
LineWidth = 1.5;
h = figure(1)
clf
plot(Kgrid,Ygrid,'-','LineWidth',LineWidth,'Color','r')
hold on
xlabel('Capital Stock','FontSize',FontSize)
ylabel('Output','FontSize',FontSize)
%text(200,120,'output','FontSize',FontSize)
%text(100,30,'saving','FontSize',FontSize)
%text(175,10,'depreciation','FontSize',FontSize)
set(gca,'LineWidth',LineWidth,'FontSize',FontSize)

print -depsc prodfn.eps

% simulation
maxit = 20;
dates = [0:maxit]';
K = 0*dates; 
K(1) = 250;
%K(1) = 0.75*Kss;   %  review question 1 

for it = 1:maxit
    K(it+1) = (1-delta)*K(it)+s*A*K(it)^alpha*L^(1-alpha);
end

Y = A*K.^alpha*L^(1-alpha);
disp('Date K A')
[dates K Y]



% Review question 2 
alpha = 1/3;
delta = 0.1;
s = 0.20;
A = 1;
n = 0.02;

n = 0.01;

kss = (s*A/(n+delta))^(1/(1-alpha))
yss = A*kss^alpha 

return 