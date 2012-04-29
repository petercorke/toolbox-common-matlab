%GAUSS2D    Gaussian kernel
%
% OUT = GAUSS2D(IM, SIGMA, C) is a unit volume Gaussian kernel rendered into
% matrix OUT (WxH) the same size as IM (WxH). The Gaussian has a standard 
% deviation of SIGMA.  The Gaussian is centered at C=[U,V].
function m = gaus2d(im, sigma, c)


    if length(sigma) == 1
        sx = sigma(1);
        sy = sigma(1);
    else
        sx = sigma(1);
        sy = sigma(2);
    end

    [x,y] = imeshgrid(im);

    m = 1/(2*pi*sx*sy) * exp( -(((x-c(1))/sx).^2 + ((y-c(2))/sy).^2)/2);
