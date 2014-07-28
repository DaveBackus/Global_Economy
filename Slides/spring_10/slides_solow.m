clear all
clc
clf

% Parameters

n=110;

alpha=.5; % Capital share
delta=.1; % Depreciation rate
s=.2;     % Saving rate


capital = zeros(n,1); % Capital Stock
prod   = zeros(n,1);  % Output
saving = zeros(n,1);  % Gross Investment
net_inv = zeros(n,1); % Net Investment
cons   = zeros(n,1);  % Consumptin
date   = zeros(n,1);  % Time
growth = zeros(n,1);  % Growth Rate of GDP

date(1)=1;

capital(1)=1; % Set the initial capital stock

%%%%%%%%%%%% Simulate the system for n periods

for i=1:n-1    
    
   prod(i)   = capital(i)^alpha;
   saving(i) = s*prod(i); 
   net_inv(i) = saving(i) - delta*capital(i);
   cons(i) = prod(i)-saving(i);
   
   capital(i+1) = capital(i)*(1-delta)+saving(i);   
   growth(i+1) = capital(i+1)/capital(i) - 1;
   date(i+1)=date(i)+1;
   
end
   
%%%%%%%%%%%% Prepare for the classical Solow graph

k_num  = 50;
k_grid = zeros(k_num,1); % Grid for capital
f_inv  = zeros(k_num,1); % Gross investment
f_dep  = zeros(k_num,1); % depreciation  

st_st = (s/delta)^(1/(1-alpha)); % Compute the steady state

step=1.5*st_st/(k_num-1);
for i=1:k_num-1
    k_grid(i+1) = k_grid(i)+step;
    f_inv(i+1)  = s*k_grid(i+1)^alpha;
    f_dep(i+1)  = delta*k_grid(i+1);
end    


% Plot the simulation and the graph

for k=1:n-1
    
figure(1)

subplot(3,2,1) % Plot the growth rate of GDP

plot(date(2:k+1),growth(2:k+1),'.');
title('Growth Rate of GDP','fontsize',18);
xlabel('Time','fontsize',14);   

text(50,(2/3)*growth(2),'Year:','fontsize',18)
uffa=num2str(1950+date(k));
text(65,(2/3)*growth(2),uffa,'fontsize',18)

%text(50,(1/3)*growth(2),'Growth Rate:','fontsize',18)
uffa=num2str(growth(k+1)*100);
%text(90,(1/3)*growth(2),uffa,'fontsize',18)

axis([date(1) date(n-1) 0 1.1*growth(2)]);

subplot(3,2,3) % Plot Net Investment

plot(date(1:k),net_inv(1:k),'.');
title('Net Investment','fontsize',18);
xlabel('Time','fontsize',14);
axis([date(1) date(n-1) 0 1.1*max(net_inv)]);

subplot(3,2,5) % Plot Capital, Output, Consumption

plot(date(1:k),prod(1:k),'.');
hold on
plot(date(1:k),cons(1:k),'.r');
plot(date(1:k),capital(1:k),'.r');

title('Capital, GDP, Consumption','fontsize',18);
xlabel('Time','fontsize',14);

axis([date(1) date(n-1) .9*capital(1) 1.1*st_st]);

hold off

subplot(3,2,4) % Plot the classical Solow graph

plot(k_grid,f_inv);

hold on;

plot(k_grid,f_dep);

plot(capital(1:k),zeros(1,k),'.r');

plot(capital(1:k),delta*capital(1:k),'.k');
plot(capital(1:k),saving(1:k),'.m');

title('The Solow Model','fontsize',18);
xlabel('Capital','fontsize',14);

hold off


pause

end

