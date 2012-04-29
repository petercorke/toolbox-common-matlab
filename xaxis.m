%XAXIS  Set X-axis scaling
%
% XAXIS(MAX) set x-axis scaling from 0 to MAX.
%
% XAXIS(MIN, MAX) set x-axis scaling from MIN to MAX.
%
% XAXIS([MIN MAX]) as above.
%
% XAXIS restore automatic scaling for x-axis.

function xaxis(a1, a2)
    if nargin == 0,
        [x,y] = ginput(2);
        mn = x(1);
        mx = x(2);
    elseif nargin == 1,
        if length(a1) == 1,
            mn = 0;
            mx = a1;
        elseif length(a1) == 2,
            mn = a1(1);
            mx = a1(2);
        end
    elseif nargin == 2,
        mn = a1;
        mx = a2;
    end

    for a=get(gcf,'Children')',
        if strcmp(get(a, 'Type'), 'axes') == 1,
            set(a, 'XLimMode', 'manual', 'XLim', [mn mx])
            set(a, 'YLimMode', 'auto')
        end
    end
