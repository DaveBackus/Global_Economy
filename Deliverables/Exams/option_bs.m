function [value] = opbs(X,F,r,n,sigma,op_type)
%  function [value] = opbs(X,F,r,n,sigma,op_type)
%  Black-Scholes-like option formula
%  (vectorized, dim=length(X), other inputs assumed scalars)
%  Parameters:
%	F 	 forward price of underlying
% 	X	 strike price
%	r 	 interest rate [bn = exp(-r*n)]
% 	n	 maturity of option in years
%	sigma	 annualized volatility
%	op_type	 option type ('C' or 'P')
dim = length(X);
if dim > 1
    if length(F)==1
        F = F*ones(size(X));
    end
    if length(r)==1
        r = r*ones(size(X));
    end
    if length(n)==1
        n = n*ones(size(X));
    end
    if length(sigma)==1
        sigma = sigma*ones(size(X));
    end
end

sigman = sigma.*sqrt(n);
bn = exp(-r.*n);
d = (log(F./X)+sigman.^2/2)./sigman;
n1 = cdfnor(d);
n2 = cdfnor(d-sigman);

value = bn.*F.*n1-bn.*X.*n2;
if op_type=='P'
    value = value + bn.*(X-F);
end

