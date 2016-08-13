function [] = cameraUpdate(hMainGui,handles,frame)
%Updates the camera animation (draw lines and display discrete image) of 
%the SOFItutorial_demoMenu interface
%
%Inputs:
% hMainGui  handles to SOFIsim interfaces [Figure] 
% handles   handles to SOFItutorial_startMenu interface [Figure] 
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

Grid = getappdata(hMainGui,'Grid');

digital_timeTraces = getappdata(hMainGui,'digital_timeTraces');
max_digTT = max(digital_timeTraces(:));
min_digTT = min(digital_timeTraces(:));
digital_timeTraces = (digital_timeTraces - min_digTT) / (max_digTT - min_digTT); 

digital_TT = squeeze(digital_timeTraces(:,:,frame)); clear digital_timeTraces;

% Resize digital_timeTraces to make it the same size as the camera
upscaled_digTT = zeros((Grid.sy*Grid.blckSize)+1,(Grid.sx*Grid.blckSize)+1);
upscaled_digTT(1:end-1,1:end-1) = kron(digital_TT,ones(Grid.blckSize));
% upscaled_digTT(end,:)=min(digital_TT(:)); upscaled_digTT(:,end)=min(digital_TT(:)); clear digital_TT;
% upscaled_digTT = (upscaled_digTT-min(upscaled_digTT(:))) ./ (max_digTT-min(upscaled_digTT(:)));
%upscaled_digTT = (upscaled_digTT-min(upscaled_digTT(:))) ./ (max(upscaled_digTT(:)-min(upscaled_digTT(:))));

% Camera grid: draw the lines delimiting each camera pixel
upscaled_digTT(1:Grid.blckSize:end,:)=0;
upscaled_digTT(:,1:Grid.blckSize:end)=0;
% figure,imagesc(upscaled_digTT);colormap hot;

% get lines around the position of the slider
slider_pos = 1 - get(handles.demoMenu_camera_axes2_slider,'Value');
lines = getLinesSliderPos(upscaled_digTT,slider_pos,Grid.blckSize);

axes(handles.demoMenu_axes2);
% colormap(handles.demoMenu_axes2,hot(16));
imagesc(upscaled_digTT);caxis(handles.demoMenu_axes2,[0 1]);

% Display the lines given by the slider's position
line(lines.x1,lines.y1,'color',[0.4353 1 0.5608],'LineWidth',1.5);
line(lines.x2,lines.y2,'color',[0.4353 1 0.5608],'LineWidth',1.5);
line(lines.x3,lines.y3,'color',[0.4353 1 0.5608],'LineWidth',1.5);
line(lines.x4,lines.y4,'color',[0.4353 1 0.5608],'LineWidth',1.5);
set(gca,'YTick',[]);set(gca,'XTick',[]);

end

