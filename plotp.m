%PLOTP Plot trajectories
%
% PLOTP(P) plots a set of points P, which by Toolbox convention are stored
% one per column.  P can be Nx2 or Nx3.  By default a linestyle of 'bx'
% is used.
%
% PLOTP(P, LS) as above but the line style arguments LS are passed to plot.
%
% See also PLOT, PLOT2.
function h = plotp(p1, varargin)

    if length(varargin) == 0
        varargin = {'bx'};
    end

    if numrows(p1) == 3,
        hh = plot3(p1(1,:), p1(2,:), p1(3,:), varargin{:});
        xyzlabel
    else
        hh = plot(p1(1,:), p1(2,:), varargin{:});
        xlabel('x');
        ylabel('y');
    end
    if nargout == 1,
        h = hh;
    end
