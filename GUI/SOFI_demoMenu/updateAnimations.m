function [] = updateAnimations(hMainGui,handles,frame)
%Updates the animations of the SOFItutorial_demoMenu interface
%
%Inputs:
% hMainGui  handles to SOFIsim interfaces [Figure] 
% handles   handles to SOFItutorial_demoMenu interface [Figure] 
% frame     image frame at which the animations will be updated
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

Optics = getappdata(hMainGui,'Optics');
frames = Optics.frames; clear Optics;

slider_pos = get(handles.demoMenu_camera_axes2_slider,'Value');

analog_timeTraces = getappdata(hMainGui,'analog_timeTraces');
% max_anaTT = max(analog_timeTraces(:));
% min_anaTT = min(analog_timeTraces(:));
% analog_timeTraces = (analog_timeTraces - min_anaTT) / (max_anaTT - min_anaTT);
analog_TT = analog_timeTraces(:,:,frame); clear analog_timeTraces;

digital_timeTraces = getappdata(hMainGui,'digital_timeTraces');
max_digTT = max(digital_timeTraces(:));
% min_digTT = min(digital_timeTraces(:));
% digital_timeTraces = (digital_timeTraces - min_digTT) / (max_digTT - min_digTT); 
digital_TT = digital_timeTraces(:,:,frame); 
digital_TT_2D = squeeze(digital_timeTraces(1+round(slider_pos*(size(digital_TT,1)-1)),:,1:frame)).';
digital_TT_1D = digital_TT(1+round(slider_pos*(size(digital_TT,1)-1)),:);clear digital_timeTraces;

% demoMenu_axes1:
axes(handles.demoMenu_axes1);
%colormap(handles.demoMenu_axes1,parula(255));
imagesc(analog_TT);caxis(handles.demoMenu_axes1,[0 1]);
%axis(handles.demoMenu_axes1,'square');
set(gca,'YTick',[]);set(gca,'XTick',[]);


% demoMenu_axes2:
axes(handles.demoMenu_axes2);
cameraUpdate(hMainGui,handles,frame);

% demoMenu_axes3:
axes(handles.demoMenu_axes3);
bar(digital_TT_1D,'b');xlim([0 1+length(digital_TT_1D)]);ylim([0 1]);
xlabel('pixel x axis','FontSize',8,'FontWeight','bold');
set(gca,'YTick',[]);set(gca,'XTick',[]);

% demoMenu_axes4:
h_axes4 = getappdata(hMainGui,'animated_line_axes4');
axes(handles.demoMenu_axes4);
pixel_x_axis = 1:size(digital_TT_2D,2);
xlim(handles.demoMenu_axes4,[0 1+frames]);
ylim(handles.demoMenu_axes4,[0 1+size(digital_TT_2D,2)]);
zlim(handles.demoMenu_axes4,[0 1.05*max_digTT]);
%zlim(handles.demoMenu_axes4,[0 1.05*max(digital_TT_2D(:))]);
hold on;
for x=1:length(pixel_x_axis)
    addpoints(h_axes4(x),frame,x,digital_TT_2D(frame,x));
end
hold off;


SOFI = getappdata(hMainGui,'SOFI');
sofi_xc = abs(SOFI.cumulants_traces); clear SOFI;
sofi_xc = sofi_xc.';

%demoMenu_axes5:
axes(handles.demoMenu_axes5);
h_axes5 = getappdata(hMainGui,'animated_line_axes5');
sofi_x_axis = 1:size(sofi_xc,2);
xlim(handles.demoMenu_axes5,[0 1+frames]);
ylim(handles.demoMenu_axes5,[0 1+size(sofi_xc,2)]);
zlim(handles.demoMenu_axes5,[0 1.05*max(sofi_xc(:))]);
hold on;
for x=1:length(sofi_x_axis)
    addpoints(h_axes5(x),frame,x,sofi_xc(frame,x));
end
hold off;

% % demoMenu_axes4:
% axes(handles.demoMenu_axes4);
% pixel_x_axis = 1:size(digital_TT_2D,2);
% time_axis = 1:frame;
% xlim(handles.demoMenu_axes4,[0 1+frames]);
% ylim(handles.demoMenu_axes4,[0 1+size(digital_TT_2D,2)]);
% %view([37,48]);xl = xlabel('Time lag','FontSize',8,'FontWeight','bold');set(xl,'VerticalAlignment','bottom');
% %yl = ylabel('Pixels x axis','FontSize',8,'FontWeight','bold');set(yl,'VerticalAlignment','bottom');
% hold on;
% for x=1:length(pixel_x_axis)
%     plot3(time_axis,ones(size(time_axis))*x,digital_TT_2D(time_axis,x));
% end
% 
% hold off;
% 
% 
% SOFI = getappdata(hMainGui,'SOFI');
% sofi_xc = abs(SOFI.cumulants_traces); clear SOFI;
% sofi_xc = sofi_xc.';
% 
% %demoMenu_axes5:
% axes(handles.demoMenu_axes5);
% sofi_x_axis = 1:size(sofi_xc,2);
% time_axis = 1:frame;
% xlim(handles.demoMenu_axes5,[0 1+frames]);
% ylim(handles.demoMenu_axes5,[0 1+size(sofi_xc,2)]);
% % view([37,48]);xl = xlabel('Time lag','FontSize',8,'FontWeight','bold'); set(xl,'VerticalAlignment','bottom');
% % yl = ylabel('Pixels x axis','FontSize',8,'FontWeight','bold'); set(yl,'VerticalAlignment','bottom');
% hold on;
% for x=1:length(sofi_x_axis)
%     plot3(time_axis,ones(size(time_axis))*x,sofi_xc(time_axis,x));
% end
% hold off;

end

% clear a b c;
% a = [1:1:20]; % x pixel position
% b = [1:1:30]; % frames
% c = rand(100,20); % digital_TT_2D. size1 = length(frames), size2 = length(x)
% c(c>0.5)=1; c(c < 0.5)=0;
% 
% figure;
% hold on;
% xlim(gca,[0 1+100]); % length(b) = frames
% ylim(gca,[0 1+length(a)]);
% for x=1:length(a)
%     plot3(b,ones(size(b))*x,c(b,x),'b');
%     view([37,48]);xl = xlabel('Time lag','FontSize',8,'FontWeight','bold'); set(xl,'VerticalAlignment','bottom');
%     yl = ylabel('Pixels x axis','FontSize',8,'FontWeight','bold');set(yl,'VerticalAlignment','bottom');
% end
