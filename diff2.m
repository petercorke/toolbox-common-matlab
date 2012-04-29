%DIFF2 Two point difference
%
% D = DIFF2(V) is the 2-point difference for each point in the vector v
% and the first element is zero.  The vector D has the same length as V.
%
% See also DIFF.
function d = diff2(v)
	[r,c] =size(v);

	d = [zeros(1,c); diff(v)];
