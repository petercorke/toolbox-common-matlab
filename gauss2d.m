%GAUSS2d	Gaussian kernel
%
%	k = gauss2d(im, c, sigma)
%
%	Returns a unit volume Gaussian smoothing kernel.  The Gaussian has 
%	a standard deviation of sigma, and the convolution
%	kernel has a half size of w, that is, k is (2W+1) x (2W+1).
%
%	If w is not specified it defaults to 2*sigma.
%
function m = gaus2d(im, sigma, c)


	if length(sigma) == 1,
		sx = sigma(1);
        sy = sigma(1);
    else
		sx = sigma(1);
        sy = sigma(2);
	end

	[x,y] = imeshgrid(im);

	m = 1/(2*pi*sx*sy) * exp( -(((x-c(1))/sx).^2 + ((y-c(2))/sy).^2)/2);
