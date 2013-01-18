% SYMEXPR2SLBLOCK Version independent Embedded Matlab Function block creation for symbolic expressions.
%
% symexpr2slblock(VARARGIN)
% The input arguments are just as used with the functions 
% 'emlBlock' or 'matlabFunctionBlock'.
%
% Notes::
%  In Symbolic Toolbox versions prior to V5.7 (2011b) the function to 
%  create Embedded Matlab Function blocks from symbolic expressions is 
%  'emlBlock'.
%  Since V5.7 (2011b) there is another function named 
%  'matlabFunctionBlock' which replaces the old function. 
%
%  symexpr2slblock is a wrapper around both functions, which apriori 
%  checks for the installed Symbolic Toolbox version and calls the 
%  required function accordingly.
%
% Authors::
%  Jörn Malzahn   
%  2012 RST, Technische Universität Dortmund, Germany
%  http://www.rst.e-technik.tu-dortmund.de
%
% See also emlBlock, matlabFunctionBlock.

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

function [] = symexpr2slblock(varargin)
 
% V5.8 (R2012a)
if verLessThan('symbolic','5.7')                                   
    emlBlock(varargin{:});
else
    matlabFunctionBlock(varargin{:});
end
