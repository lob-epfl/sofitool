function [] = zoomAxes(hMainGui,handles,ax_num)
%Zoom over the cross-cumulant traces or the intensity time traces of the 
%SOFItutorial_demoMenu interface
%
%Inputs:
% hMainGui  handles to SOFIsim interfaces [Figure] 
% handles   handles to SOFItutorial_demoMenu interface [Figure] 
% ax_num    axis number specifying which figure will be magnified
%

% Copyright © 2015 Arik Girsault 
% École Polytechnique Fédérale de Lausanne,
% Laboratoire d'Optique Biomédicale, BM 5.142, Station 17, 1015 Lausanne, Switzerland.
% arik.girsault@epfl.ch, tomas.lukes@epfl.ch
% http://lob.epfl.ch/
 
% This file is part of SOFIsim.
%
% SOFIsim is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% SOFIsim is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with SOFIsim.  If not, see <http://www.gnu.org/licenses/>.

Grid = getappdata(hMainGui,'Grid');
Optics = getappdata(hMainGui,'Optics');frames = Optics.frames; clear Optics;
% color: [0 102/255 204/255]
if (ax_num == 5)
    
    axes(findobj('Tag','ax_zoom_axes5'));h_axes = animatedline('Color',[255/255 51/255 51/255],'MaximumNumPoints',frames);
    for k=1:2*Grid.sx-1
        h_axes = [h_axes,animatedline('Color',[255/255 51/255 51/255],'MaximumNumPoints',frames)];
    end
    
    SOFI = getappdata(hMainGui,'SOFI');
    sofi_xc = abs(SOFI.cumulants_traces); clear SOFI;
    sofi_xc = sofi_xc.';
    
    % Record Video: writerObj
    % writerObj = VideoWriter('flowChart\cross_cumulants.avi');
    % writerObj.FrameRate = 30; 
    % open(writerObj);
    while ishandle(findobj('tag','fig_zoom_axes5'))
        % Surface plot of height, colored by velocity.
        frame = getappdata(hMainGui,'current_frame');
        updateAnimatedLines(hMainGui,handles,h_axes,sofi_xc,frame,ax_num);
        drawnow;
        % videoFrame = getframe(findobj('Tag','fig_zoom_axes5'));
        % writeVideo(writerObj,videoFrame);
        if frame < frames
            frame = frame+1;
        else
            frame=1;
            clearAnimatedLines(hMainGui,h_axes,ax_num);
            % close(writerObj);close(findobj('tag','fig_zoom_axes5'));
        end
        setappdata(hMainGui,'current_frame',frame);
    end
    
elseif(ax_num == 4)

    axes(findobj('tag','ax_zoom_axes4'));h_axes = animatedline('Color',[51/255 153/255 255/255],'MaximumNumPoints',frames);
    for k=1:Grid.sx
        h_axes = [h_axes,animatedline('Color',[51/255 153/255 255/255],'MaximumNumPoints',frames)];
    end
    
    % Record Video: writerObj
    % writerObj = VideoWriter('flowChart\time_traces.avi');
    % writerObj.FrameRate = 30; 
    % open(writerObj);
    while ishandle(findobj('tag','fig_zoom_axes4'))
        % Surface plot of height, colored by velocity.
        frame = getappdata(hMainGui,'current_frame');
        updateAnimatedLines(hMainGui,handles,h_axes,0,frame,ax_num);
        drawnow;
        % videoFrame = getframe(findobj('Tag','fig_zoom_axes4'));
        % writeVideo(writerObj,videoFrame);
        if frame < frames
            frame = frame+1;
        else
            frame=1;
            clearAnimatedLines(hMainGui,h_axes,ax_num);
            % close(writerObj);close(findobj('tag','fig_zoom_axes4'));
        end
        setappdata(hMainGui,'current_frame',frame);
    end
end

end

function [] = updateAnimatedLines(hMainGui,handles,h_axes,sig,frame,ax_num)
%Updates the animated lines of the cross-cumulants and intensity time 
%traces SOFItutorial_demoMenu interface
%
%Inputs:
% hMainGui  handles to SOFIsim interfaces [Figure] 
% handles   handles to SOFItutorial_demoMenu interface [Figure] 
% h_axes    handles to axes of the current animated line
% sig       animated line
% frame     image frame at which the animated line will be updated
% ax_num    axis number specifying which figure will be magnified
%
Optics = getappdata(hMainGui,'Optics');
frames = Optics.frames; clear Optics;

if(ax_num == 4)
    slider_pos = get(handles.demoMenu_camera_axes2_slider,'Value');

    digital_timeTraces = getappdata(hMainGui,'digital_timeTraces');
    digital_TT = digital_timeTraces(:,:,frame); 
    digital_TT_2D = squeeze(digital_timeTraces(1+round(slider_pos*(size(digital_TT,1)-1)),:,1:frame)).';
    clear sig; sig = digital_TT_2D; clear digital_TT_2D;
    
    % demoMenu_axes4:
    axes(findobj('Tag','ax_zoom_axes4'));
    pixel_x_axis = 1:size(sig,2);
    xlim(findobj('Tag','ax_zoom_axes4'),[0 1+frames]);
    ylim(findobj('Tag','ax_zoom_axes4'),[0 1+size(sig,2)]);
    zlim(findobj('Tag','ax_zoom_axes4'),[0 1.1*max(sig(:))]);caxis([0 1.1*max(sig(:))]);
    hold on;
    for x=1:length(pixel_x_axis)
        addpoints(h_axes(x),frame,x,sig(frame,x));
    end
    hold off;
end

if(ax_num == 5)    
    %demoMenu_axes5:
    axes(findobj('Tag','ax_zoom_axes5'));
    sofi_x_axis = 1:size(sig,2);
    xlim(findobj('tag','ax_zoom_axes5'),[0 1+frames]);
    ylim(findobj('tag','ax_zoom_axes5'),[0 1+size(sig,2)]);
    zlim(findobj('tag','ax_zoom_axes5'),[0 1.1*max(sig(:))]);caxis([0 1.1*max(sig(:))]);

    hold on;
    for x=1:length(sofi_x_axis)
        addpoints(h_axes(x),frame,x,sig(frame,x));
    end
    hold off;
end

end

function clearAnimatedLines(hMainGui,h_axes,ax_num)
%Clears the animated lines of the cross-cumulants and intensity time 
%traces SOFItutorial_demoMenu interface
%
%Inputs:
% hMainGui  handles to SOFIsim interfaces [Figure] 
% h_axes    handles to axes of the current animated line
% ax_num    axis number specifying which figure will be magnified
%
Grid = getappdata(hMainGui,'Grid');
if(ax_num == 4)
    for k=1:Grid.sx
        clearpoints(h_axes(k));
    end
elseif ax_num == 5
    for k=1:2*Grid.sx-1
        clearpoints(h_axes(k));
    end
end
end
