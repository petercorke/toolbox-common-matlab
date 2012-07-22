%MTOOLS	add simple/useful tools to all windows in figure
%
function mtools
	global DDXFILENAME

	h = uicontextmenu;
	uimenu(h, 'Label', 'X zoom', 'CallBack', 'xaxis');
	uimenu(h, 'Label', '-->', 'CallBack', 'xscroll(0.5)');
	uimenu(h, 'Label', '<--', 'CallBack', 'xscroll(-0.5)');
	uimenu(h, 'Label', 'CrossHairs', 'CallBack', 'crosshair');
	uimenu(h, 'Label', 'X UNzoom', 'CallBack', 'unzoom');
	uimenu(h, 'Label', 'Pick delta', 'CallBack', 'fprintf(''%f %f\n'', diff(ginput(2)))');
	uimenu(h, 'Label', 'Line fit', 'CallBack', 'ilinefit');
	uimenu(h, 'Label', 'Show points', 'CallBack', 'showpoints(gca)');
	uimenu(h, 'Label', 'Apply X zoom to all', 'CallBack', 'xaxisall');
	for c=get(gcf, 'Children')',
		set(c, 'UIContextMenu', h);
		l = get(c, 'Children');
	end

	
  	axes('pos', [0 0 1 0.05], 'visible', 'off')
    if 0
        if ~isempty(DDXFILENAME),
            s = sprintf('[%s]  %s', DDXFILENAME, date);
        else
            s = sprintf('%s', date);
        end
        text(0.95, 0.1, s, 'horizontalalign', 'right', 'verticalalign', 'baseli')      
    end
