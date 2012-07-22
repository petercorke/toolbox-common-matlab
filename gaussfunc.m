%GAUSS1	Gaussian kernel
%
%	k = gauss1(, c, sigma)
%
%	Returns a unit volume Gaussian smoothing kernel.  The Gaussian has 
%	a standard deviation of sigma, and the convolution
%	kernel has a half size of w, that is, k is (2W+1) x (2W+1).
%
function g = gaussfunc(c, var, x, y)

    if length(c) == 1
        g = 1/sqrt(2*pi*var) * exp( -((x-c).^2)/(2*var) );
    elseif length(c) == 2
        if nargin < 4
            [x,y] = imeshgrid(x);
        end
        xx = x(:)-c(1); yy = y(:)-c(2);
        ci = inv(var);
        g = 1/(2*pi*sqrt(det(var))) * exp( -0.5*(xx.^2*ci(1,1) + yy.^2*ci(2,2) + 2*xx.*yy*ci(1,2)));
        g = reshape(g, size(x));
    end
