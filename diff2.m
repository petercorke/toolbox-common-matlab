%
%  DIFF3(v)
%
%  compute 2-point difference for each point in the vector v.
%
function d = diff2(v)
	[r,c] =size(v);

	d = [zeros(1,c); diff(v)];
