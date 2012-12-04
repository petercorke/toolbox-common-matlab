function [res] = doesblockexist(mdlName, blockAddress)
%% DOESBLOCKEXIST Checks wether a Simulink block already exists in a Simulink model.
% =========================================================================
%
% [res] = doesblockexist(mdlName, blockAddress)
%
%  Input::
%       mdlName: Name of the Simulink model to work in.
%       blockAdress: Adress of the Simulink block within the model.
%
%  Input::
%       res: True, if the block exists, false otherwise.
%
%  Authors::
%        Jörn Malzahn   
%        2012 RST, Technische Universität Dortmund, Germany
%        http://www.rst.e-technik.tu-dortmund.de  
%
%  See also symexpr2slblock, distributeblocks.

wasntLoaded = 0;
if ~bdIsLoaded(mdlName)
    load_system(mdlName)
    wasntLoaded = 1;
end

blockList = find_system(mdlName);
blockList = strfind(blockList,blockAddress);
emptyList = cellfun(@isempty,blockList);
res = any(~emptyList);


if wasntLoaded
    close_system(mdlName)
end

