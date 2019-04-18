disp('Robotics, Vision & Control: (c) Peter Corke 1992-2019 http://www.petercorke.com')

if verLessThan('matlab', '7.0')
    warning('You are running a very old (and unsupported) version of MATLAB.  You will very likely encounter significant problems using the toolboxes but you are on your own with this');
end
tb = false;
rvcpath = fileparts( mfilename('fullpath') );

robotpath = fullfile(rvcpath, 'robot');
if exist(robotpath, 'dir')
    addpath(robotpath);
    tb = true;
    if exist('startup_rtb') == 2
        startup_rtb
    end
end

visionpath = fullfile(rvcpath, 'vision');
if exist(visionpath, 'dir')
    addpath(visionpath);
    tb = true;
    if exist('startup_mvtb') == 2
        startup_mvtb
    end
end

if tb
    % RTB or MVTB is present
    
    % add common files
    addpath(fullfile(rvcpath, 'common'));
    
    % add spatial math toolbox
    if exist('./smtb', 'dir')
        addpath(fullfile(rvcpath, 'smtb'));
    end
    
    % add a top-level simulink folder as created for mltbx installs
    if exist('./simulink', 'dir')
        addpath(fullfile(rvcpath, 'simulink'));
    end
end

clear tb rvcpath robotpath visionpath

% check for any install problems
rvccheck