%YAYIS	set Y-axis scaling
%
%	YAYIS(max)
%	YAYIS(min, max)
%
%	YAXIS	restore automatic scaling for this axis

function yaxis(a1, a2)
	if nargin == 0,
		set(gca, 'YLimMode', 'auto')
		return
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

	set(gca, 'YLimMode', 'manual', 'YLim', [mn mx])
