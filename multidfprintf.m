%MULTIDFPRINTF Print formatted text to multiple IDs.
%
% count = multidfprintf(IDVEC, FORMAT, A, ...) is the vector with the
% number of bytes written to each target ID specified in the vector IDVEC.
% FORMAT is the format string as used by sprintf and fprintf. 
% A is the array of elements, to which the format will be applied similar
% to sprintf and fprint.
%
% Notes::
% Matlab ships with a function for writing formatted strings into a text
% file or to the console (fprintf). The function works with single 
% target identifiers (file, console, string). This function uses the 
% same syntax as for the fprintf function, but also permits a vector of 
% multiple target identifiers.
%
% Example::
% % Create and open a new example file:
% fid = fopen('exampleFile.txt','w+');
% % Write something to the file and the console simultaneously:
% multidfprintf([1 FID],'% s % d % d % d!\n','This is a test!',1,2,3);
% % Close the file:
% fclose(FID);
%
% Authors::
%  Jörn Malzahn   
%  2012 RST, Technische Universität Dortmund, Germany
%  http://www.rst.e-technik.tu-dortmund.de
%
% See also fprintf,sprintf.

% Copyright (C) 1993-2012, by Peter I. Corke
%
% This file is part of The Robotics Toolbox for Matlab (RTB).
% 
% RTB is free software: you can redistribute it and/or modify
% it under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% RTB is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU Lesser General Public License for more details.
% 
% You should have received a copy of the GNU Leser General Public License
% along with RTB.  If not, see <http://www.gnu.org/licenses/>.
%
% http://www.petercorke.com

function [count] = multidfprintf(idVec,varargin)
 
if isempty(idVec)
    warning('multIDFprintf','Target ID is empty. Nothing is written.')
    count = [];
else
    count = zeros(size(idVec));
    for iID = 1:numel(idVec)
        if idVec(iID) < 1
            count(iID) = 0;
        else
            count(iID) = fprintf(idVec(iID),varargin{:});
        end
    end
end