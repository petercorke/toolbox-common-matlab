%RUNSCRIPT Run an M-file in interactive fashion
%
% RUNSCRIPT(FNAME, OPTIONS) runs the M-file FNAME and pauses after every
% executable line in the file until a key is pressed.  Comment lines are shown
% without any delay between lines.
%
% Options::
% 'delay',D    Don't wait for keypress, just delay of D seconds (default 0)
% 'cdelay',D   Pause of D seconds after each comment line (default 0)
% 'begin'      Start executing the file after the commnent line %%begin (default true)
% 'dock'       Cause the figures to be docked when created
% 'path',P     Look for the file FNAME in the folder P (default .)
%
% Notes::
% - If not file extension is given in FNAME, .m is assumed.
% - If the executable statement has comments immediately afterward (no blank lines)
%   then the pause occurs after those comments are displayed.
% - A simple '-' prompt indicates when the script is paused, hit enter.
%
% See also eval.

% Copyright (C) 1993-2013, by Peter I. Corke
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

function runscript(fname, varargin)
    
    opt.path = [];
    opt.delay = [];
    opt.begin = true;
    opt.cdelay = 0;
    opt.dock = false;
    
    opt = tb_optparse(opt, varargin);
        
    close all
    
    if opt.dock
        prevDockStatus = get(0,'DefaultFigureWindowStyle');
        set(0,'DefaultFigureWindowStyle','docked');
    end

    
    if ~isempty(opt.path)
        fname = fullfile(opt.path, [fname '.m']);
    else
        fname = [fname '.m'];
    end
    
    fp = fopen(fname, 'r');
    
    clc
    fprintf('--- runscript <-- %s\n', fname);
    
    running = false;
    shouldPause = false;
    loopText = [];
        if ~opt.begin
        running = true;
    end
    
    while 1
        % get the next line from the file, bail if EOF
        line = fgetl(fp);
        if line == -1
            break
        end
        
        % logic to skip lines until we see one beginning with %%begin
        if ~running
            if strcmp(line, '%%begin')
                running = true;
            end
            continue;
        end;
        

        % display the line and if executable execute it
        if length(strtrim(line)) == 0
            % line was blank
            fprintf(' \n');
            if shouldPause
                scriptwait(opt);
                shouldPause = false;
            end
        elseif strfind1(strtrim(line), '%')
            % line was a comment
            disp(line)
            pause(opt.cdelay)
            
        else
            % line is executable
            if shouldPause
                scriptwait(opt);
                
                shouldPause = false;
            end
            
            % if the start of a loop, stash the text for now
            if strfind1(line, 'for') || strfind1(line, 'while')
                % found a loop, don't eval it until we get to the end
                loopText = strcat(loopText, [line ';']);
                % display the line with a pretend MATLAB prompt
                fprintf('>> '); disp(line)
                continue;
            end
            
            if ~isempty(loopText)
                % we're in stashing mode
                loopText = strcat(loopText, line);
                % display the line with a pretend MATLAB prompt
                disp(line);
                
                % if the end of a loop, unstash the text and eval it
                if strfind1(line, 'end') && ~isempty(loopText)
                    loopText
                    evalin('base', loopText);
                    shouldPause = true;
                    loopText = [];
                    continue;
                end
            else
                            % display the line with a pretend MATLAB prompt
            fprintf('>> '); disp(line)
                evalin('base', line);
                shouldPause = true;
            end
        end
    end
    fprintf('------ done --------\n');
    if opt.dock
        % restore the docking mode if we set it
        set(0,'DefaultFigureWindowStyle', prevDockStatus)
    end
end

function scriptwait(opt)
    if isempty(opt.delay)
        %a = input('-', 's');
        prompt = 'continue?';
        fprintf(prompt); pause;
        for i=1:length(prompt)
            fprintf('\b');
        end
    else
        pause(opt.delay);
    end
end

% test if s2 is at the start of s1
function res = strfind1(s1, s2)

    r = strfind(s1, s2);
    res = false;
    if ~isempty(r) && (r(1) == 1)
        res = true;
    end
end
    
