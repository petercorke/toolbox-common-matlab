% POLYDIFF       pd = polydiff(p)
%
%   Return the coefficients of the derivative of polynomial p
%
function pd = polydiff(p)
	n = length(p)-1;

	pd = [n:-1:1] .* p(1:n);
