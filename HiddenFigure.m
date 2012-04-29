classdef HiddenFigure

    properties
         h      % the graphics handle   
    end

    methods
        function hf = HiddenFigure(varargin)
            hf.h = figure('HandleVisibility', 'off', varargin{:});
        end

        function clf(hf)
            clf(hf.h)
        end

        function axes(hf, varargin)
            axes('Parent', hf.h, varargin{:});
        end

        function axis(hf, varargin)
            axis(hf.h, varargin{:});
        end

        function plot(hf, varargin)
            hf.axes();
            plot(varargin{:});
        end

        function title(hf, name)
            set(hf.h, 'Name', name);
        end
    end
end
