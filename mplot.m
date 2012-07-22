%MPLOT	plot multiple data 
%
% Plot y versus t in multiple windows.
%
%      MPLOT(y)
%      MPLOT(y, n)
%      MPLOT(y, n, {labels})
%
% Where y is multicolumn data and first column is time.  n is a row vector
% specifying which variables to plot (1 is first data column, or y(:,2)).
% labels is a cell array of labels for the subplots.
%
%      MPLOT(t, y)
%      MPLOT(t, y, n)
%      MPLOT(t, y, {labels})
%
% Where y is multicolumn data and t is time.  n is a row vector
% specifying which variables to plot (1 is first data column, or y(:,2)).
% labels is a cell array of labels for the subplots.
%
%      MPLOT(S)
%
%  Where S is a structure and one element 't' is assumed to be time.  Plot
% all other vectors versus time in subplots.  Subplots are labelled as per
% the data fields.
%
%
function mplot(varargin)

if isstruct(varargin{1})
   s = varargin{1};
   if isfield(s, 'signals'),
	% To Workspace type structure
	matplot(s.time, s.signals.values);
	if isfield(s, 'blockName'),
		title(s.blockName)
	end

   else
	% retriever type structure
	   structplot(varargin{:})
   end
else
   matplot(varargin{:})
end
%datestamp

mtools

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function structplot(s)
if ~isfield(s, 't') & ~isfield(s, 'time')
   error('structure must include a time element t')
end
if isfield(s, 't'),
	t = s.t;
elseif isfield(s, 'time'),
	t = s.time;
end
f = fieldnames(s);
n = length(f) - 1;
sp = n*100 + 11;
tmax = max(t);
i = 1;
for ff = f'
   fieldnam = char(ff);
   switch fieldnam,
   case {'t', 'time'},
   otherwise,
      h(i) = subplot(sp);
    	plot(t, getfield(s, fieldnam));
	        set(h(i), 'UserData', i);
		v = axis;
		v(2) = tmax;
		axis(v);
		grid
		xlabel('Time');
      ylabel(fieldnam);
      sp = sp +1;
      i = i + 1;
   end
   end
	axes(h(1));
	figure(gcf)
	  

   
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% legacy function for matrix input data, old mplot() compatible
function matplot(a1, a2, a3)
[r,c]=size(a1);
	if nargin == 1
		t = a1(:,1);
		y = a1(:,2:c);
		cols = 1:(c-1);
		gain = 1;
	elseif nargin == 2
		if isvector(a1) & ismatrix(a2)
			t = a1(:);
			cols = 1:numcols(a2);
			y = a2;
		elseif isempty(a1) & ismatrix(a2)
			cols = 1:numcols(a2);
			y = a2;
			t = ramp(numrows(y), 1);
		elseif ismatrix(a1),
			if ismatrix(a1) & iscell(a2)
				t = a1(:,1);
				y = a1(:,2:c);
				cols = 1:(c-1);
				labl = a2;
			elseif (numrows(a2) == 1)
				t = a1(:,1);
				cols = a2;
				y = a1(:,a2+1);
		end
		end
	elseif nargin == 3
		if isvector(a1) & ismatrix(a2)
			t = a1;
			if iscell(a3)
				labl = a3;
				y = a2;
			else
				cols = a3;
				y = a2(:,cols);
			end
		elseif ismatrix(a1) & (numrows(a2) == 1)
			t = a1(:,1);
			cols = a2;
			y = a1(:,a2+1)*diag(a3);
		end
	end
	t = t(:);
   [r,c]=size(y);
   sp = c*100 + 10;
   	tmax = max(t);
	for i=1:c
		if (sp+i) == 111,
			clf
			plot(t,y(:,i));
			h(i) = gca;
		else
			h(i) = subplot(sp+i);
			plot(t,y(:,i));
		end
	        set(h(i), 'UserData', i);
		set(h(i), 'Tag', 'mplot');
		v = axis;
		v(2) = tmax;
		axis(v);
		grid
		xlabel('Time');
		if ~exist('labl')
			lab = sprintf('Y(%2d)', cols(i));
		else
			lab = labl{i};
		end
		ylabel(lab);
	end
	axes(h(1));
	figure(gcf)
