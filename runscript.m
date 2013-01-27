function runscript(fname, varargin)
    
    opt.path = [];
    opt.delay = [];
    
    opt = tb_optparse(opt, varargin);
    
    opt
    
    close all
    %set(0,'DefaultFigureWindowStyle','docked')
    
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
    
    while 1
        % get the next line from the file, bail if EOF
        line = fgetl(fp);
        if line == -1
            break
        end
        if strcmp(line, '%%begin')
            running = true;
            continue;
        end
        
        if ~running
            continue;
        end
        %fprintf('%s >> ', fname);
        
        
        % display the line and if executable execute it
        if length(line) == 0
            % line was blank
            fprintf('\n');
                        if shouldPause
                if isempty(opt.delay)
                    pause
                else
                    pause(opt.delay);
                end
                shouldPause = false;
            end
        elseif line(1) == '%'
            % line was a comment
            disp(line)
        else
            % line is executable
            if shouldPause
                if isempty(opt.delay)
                    pause
                else
                    pause(opt.delay);
                end
                shouldPause = false;
            end
            
            fprintf('>> '); disp(line)
            evalin('base', line);
            shouldPause = true;
                


        end

        
        
    end
    fprintf('------ done --------\n');
end
