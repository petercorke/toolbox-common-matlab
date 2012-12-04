function [count] = multidfprintf(idVec,varargin)
%% MULTIDFPRINTF Print formatted text to multiple IDs.
%
%   [count] = multidfprintf(idVec, FORMAT, A, ...)
%
%  Description::
%    Matlab ships with a function for writing formatted strings into a text
%    file or to the console (fprintf). The function works with single 
%    target identifiers (file, console, string). This function uses the 
%    same syntax as for the fprintf function, but also permits a vector of 
%    multiple target identifiers.
%
%  Input::
%       idVec:         Vector of target IDs.
%       FORMAT:        Format string as used by sprintf and fprintf. 
%       A:             Array of elements, to which the format will be applied.
%
%  Output::
%       count:         Vector with the number of bytes written to each ID
%
%  Example::
%        % Create and open a new example file:
%        fid = fopen('exampleFile.txt','w+');
%        % Write something to the file and the console simultaneously:
%        multidfprintf([1 FID],'% s % d % d % d!\n','This is a test!',1,2,3);
%        % Close the file:
%        fclose(FID);
%
%  Authors::
%        Jörn Malzahn   
%        2012 RST, Technische Universität Dortmund, Germany
%        http://www.rst.e-technik.tu-dortmund.de
%
%  See also fprintf,sprintf.

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