%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% function err = swapens(par,X);
% Erro function for estimating the spot rates curve from swap rates data
% Extended Nelson-Bliss Method
% X=LIBOR (at 1,3,6,12 months) and swpa rates at (2,3,4,5,7,10 years)
% Liuren Wu, October 19, 2000
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function err = swapens(par,X);

mat=[1:120]'/12;
f=par(1)+par(2)*(1-exp(-mat/par(5)))./(mat/par(5)) ...
	+par(3)*((1-exp(-mat/par(5)))./(mat/par(5))-exp(-mat/par(5))) ...
	+par(4)*((1-exp(-mat/par(6)))./(mat/par(6))-exp(-mat/par(6)));

ym=cumsum(f); %y.*mat
dis=exp(-ym);

x2=X;
mat1=[1 3 6 12]'/12;
x2(1:4)=100*(1./dis(mat1*12)-1)./mat1;

mat2=[2 3 4 5 7 10]';
swr=200*(1-dis([6:6:120]))./cumsum(dis([6:6:120]));
x2(5:10)=swr(mat2*2);

ev=x2-X;
err=ev'*ev;

