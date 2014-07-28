%  Measurement notes
%  Price index problem 
format compact
format long

p = [100 10 5; 50 20 15; 25 30 30];
q = [25 100 250; 50 125 200; 100 150 150];

pq = p.*q;
ngdp = sum(pq,2)

p0 = p(1,:);
p0big = [p0; p0; p0];
p0q = p0big.*q;
rgdp = sum(p0q,2)

deflator = 100*ngdp./rgdp

q0 = q(1,:);
q0big = [q0; q0; q0]
pq0 = p.*q0big;
cpi = sum(pq0,2)
cpibase = 100*cpi/cpi(1)