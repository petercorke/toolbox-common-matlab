function [] = symexpr2slblock(varargin)
%% SYMEXPR2SLBLOCK Version independent Embedded Matlab Function block creation for symbolic expressions.
%
%   [] = symexpr2slblock(varargin)
%
%  Description::
%    In Symbolic Toolbox versions prior to V5.7 (2011b) the function to 
%    create Embedded Matlab Function blocks from symbolic expressions is 
%    'emlBlock'.
%    Since V5.7 (2011b) there is another function named 
%    'matlabFunctionBlock' which replaces the old function. 
%
%    symexpr2slblock is a wrapper around both functions, which apriori 
%    checks for the installed Symbolic Toolbox version and calls the 
%    required function accordingly.
%
%  Input::
%       varargin:  Input arguments as used with 'emlBlock' or
%                  'matlabFunctionBlock'.
%
%  Authors::
%        Jörn Malzahn   
%        2012 RST, Technische Universität Dortmund, Germany
%        http://www.rst.e-technik.tu-dortmund.de
%
%  See also emlBlock, matlabFunctionBlock.
%

% V5.8 (R2012a)
if verLessThan('symbolic','5.7')                                   
    emlBlock(varargin{:});
else
    matlabFunctionBlock(varargin{:});
end
