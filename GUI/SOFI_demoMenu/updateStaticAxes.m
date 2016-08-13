function [] = updateStaticAxes(hMainGui,handles,dim)
%Updates the static (no animations) axes of the SOFItutorial_demoMenu interface
%
%Inputs:
% hMainGui  handles to SOFIsim interfaces [Figure] 
% handles   handles to SOFItutorial_demoMenu interface [Figure] 
% dim       if dim=1, only the 1D profiles are updated and if dim=2 then 2D
%           images are also updated
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

SOFI = getappdata(hMainGui,'SOFI');

if(nargin < 3)
    dim = 1;
end
slider_pos = get(handles.demoMenu_camera_axes2_slider,'Value');

% digital_timeTraces = getappdata(hMainGui,'digital_timeTraces');
% digital_TT_2D = squeeze(digital_timeTraces(1+round(slider_pos*(size(digital_timeTraces,1)-1)),:,:)).';
% clear digital_timeTraces;
% 
% % demoMenu_axes4:
% axes(handles.demoMenu_axes4);
% pixel_x_axis = 1:size(digital_TT_2D,2);
% time_axis = 1:size(digital_TT_2D,1);
% xlim(handles.demoMenu_axes4,[0 1+size(digital_TT_2D,1)]);
% ylim(handles.demoMenu_axes4,[0 1+size(digital_TT_2D,2)]);
% %view([37,48]);xl = xlabel('Time lag','FontSize',8,'FontWeight','bold');set(xl,'VerticalAlignment','bottom');
% %yl = ylabel('Pixels x axis','FontSize',8,'FontWeight','bold');set(yl,'VerticalAlignment','bottom');
% hold on;
% for x=1:length(pixel_x_axis)
%     plot3(time_axis,ones(size(time_axis))*x,digital_TT_2D(time_axis,x));
% end
% hold off;
% 
% SOFI.cumulants_traces = abs(SOFI.cumulants_traces).';
% 
% %demoMenu_axes5:
% axes(handles.demoMenu_axes5);
% sofi_x_axis = 1:size(SOFI.cumulants_traces,2);
% time_axis = 1:size(SOFI.cumulants_traces,1);
% xlim(handles.demoMenu_axes5,[0 1+size(SOFI.cumulants_traces,1)]);
% ylim(handles.demoMenu_axes5,[0 1+size(SOFI.cumulants_traces,2)]);
% zlim(handles.demoMenu_axes5,[0 1]);
% % view([37,48]);xl = xlabel('Time lag','FontSize',8,'FontWeight','bold'); set(xl,'VerticalAlignment','bottom');
% % yl = ylabel('Pixels x axis','FontSize',8,'FontWeight','bold'); set(yl,'VerticalAlignment','bottom');
% hold on;
% for x=1:length(sofi_x_axis)
%     plot3(time_axis,ones(size(time_axis))*x,SOFI.cumulants_traces(time_axis,x));
% end
% hold off;

% SOFI:

%   demoMenu_axes6 and 11: 2nd order cross-cumulants of time integrated
%   digital_timeTraces:
%   SOFI.cumulants

axes(handles.demoMenu_axes6);
stem(SOFI.cumulants{2}(1+round(slider_pos*(size(SOFI.cumulants{2},1)-1)),:),'MarkerFaceColor',[1,0,0.4],'MarkerEdgeColor',[1,0,0.4],'MarkerSize',2,'Color',[1,0,0.4],'LineWidth',1);
xlim([0 size(SOFI.cumulants{2},2)+1]);ylim([0 max(SOFI.cumulants{2}(1+round(slider_pos*(size(SOFI.cumulants{2},1)-1)),:))]);axis(handles.demoMenu_axes6,'square');
% xlabel('pixel x axis','FontSize',8,'FontWeight','bold');
set(gca,'YTick',[]);set(gca,'XTick',[]);

%   demoMenu_axes7 and 12: flattened SOFI.cumulants
%   SOFI.flattened

axes(handles.demoMenu_axes7);
stem(SOFI.flattened{2}(1+round(slider_pos*(size(SOFI.flattened{2},1)-1)),:),'MarkerFaceColor',[1,0,0.4],'MarkerEdgeColor',[1,0,0.4],'MarkerSize',2,'Color',[1,0,0.4],'LineWidth',1);
xlim([0 size(SOFI.flattened{2},2)+1]);
ylim([0,max(SOFI.flattened{2}(1+round(slider_pos*(size(SOFI.flattened{2},1)-1)),:))]);
axis(handles.demoMenu_axes7,'square');
% xlabel('pixel x axis','FontSize',8,'FontWeight','bold');
set(gca,'YTick',[]);set(gca,'XTick',[]);

%   demoMenu_axes8 and 13: linearized SOFI.flattened
%   SOFI.linearized

axes(handles.demoMenu_axes8);
stem(SOFI.linearized{2}(1+round(slider_pos*(size(SOFI.linearized{2},1)-1)),:),'MarkerFaceColor',[1,0,0.4],'MarkerEdgeColor',[1,0,0.4],'MarkerSize',2,'Color',[1,0,0.4],'LineWidth',1);
xlim([0 size(SOFI.linearized{2},2)+1]);ylim([0 max(SOFI.linearized{2}(1+round(slider_pos*(size(SOFI.linearized{2},1)-1)),:))]);axis(handles.demoMenu_axes8,'square');
% xlabel('pixel x axis','FontSize',8,'FontWeight','bold');
set(gca,'YTick',[]);set(gca,'XTick',[]);

%   demoMenu_axes9 and 14: reconvolved SOFI.linearized
%   SOFI.reconvolved

axes(handles.demoMenu_axes9);
stem(SOFI.reconvolved{2}(1+round(slider_pos*(size(SOFI.reconvolved{2},1)-1)),:),'MarkerFaceColor',[1,0,0.4],'MarkerEdgeColor',[1,0,0.4],'MarkerSize',2,'Color',[1,0,0.4],'LineWidth',1);
xlim([0 size(SOFI.reconvolved{2},2)+1]);ylim([0 max(SOFI.reconvolved{2}(1+round(slider_pos*(size(SOFI.reconvolved{2},1)-1)),:))]);axis(handles.demoMenu_axes9,'square');
% xlabel('pixel x axis','FontSize',8,'FontWeight','bold');
set(gca,'YTick',[]);set(gca,'XTick',[]);

%   demoMenu_axes10 and 15: balanced SOFI
%   SOFI.balanced

bsofi = SOFI.balanced(1+round(slider_pos*(size(SOFI.balanced,1)-1)),:);
bsofi = (bsofi - min(bsofi(:))) / max(bsofi - min(bsofi(:)));
axes(handles.demoMenu_axes10);
stem(bsofi,'MarkerFaceColor',[1,0,0.4],'MarkerEdgeColor',[1,0,0.4],'MarkerSize',2,'Color',[1,0,0.4],'LineWidth',1);
xlim([0 size(SOFI.balanced,2)+1]);axis(handles.demoMenu_axes10,'square');
ylim([0,1]);
% ylim([min(SOFI.balanced(1+round(slider_pos*(size(SOFI.balanced,1)-1)),:)),max(SOFI.balanced(1+round(slider_pos*(size(SOFI.balanced,1)-1)),:))]);
set(gca,'YTick',[]);set(gca,'XTick',[]);

if(dim == 2)
    %   demoMenu_axes6 and 11: 2nd order cross-cumulants of time integrated
    %   digital_timeTraces:
    %   SOFI.cumulants

    axes(handles.demoMenu_axes11);
    if (min(SOFI.cumulants{2}(:))<0); SOFI.cumulants{2}=SOFI.cumulants{2}-min(SOFI.cumulants{2}(:));end;
    SOFI.cumulants{2}=SOFI.cumulants{2}/max(SOFI.cumulants{2}(:));
    SOFI.cumulants{2} = imadjust(SOFI.cumulants{2},[min(SOFI.cumulants{2}(:));max(SOFI.cumulants{2}(:))],[0;1]);
    imshow(SOFI.cumulants{2});
    colormap(handles.demoMenu_axes11,morgenstemning(255));
    % axis square;xlabel('pixel x axis','FontSize',8,'FontWeight','bold');
    set(gca,'YTick',[]);set(gca,'XTick',[]);

    %   demoMenu_axes7 and 12: flattened SOFI.cumulants
    %   SOFI.flattened

    axes(handles.demoMenu_axes12);    
    if (min(SOFI.flattened{2}(:))<0); SOFI.flattened{2}=SOFI.flattened{2}-min(SOFI.flattened{2}(:));end;
    SOFI.flattened{2}=SOFI.flattened{2}/max(SOFI.flattened{2}(:));
    SOFI.flattened{2} = imadjust(SOFI.flattened{2},[min(SOFI.flattened{2}(:));max(SOFI.flattened{2}(:))],[0;1]);
    imshow(SOFI.flattened{2});
    colormap(handles.demoMenu_axes12,morgenstemning(255));
    % axis square;xlabel('pixel x axis','FontSize',8,'FontWeight','bold');
    set(gca,'YTick',[]);set(gca,'XTick',[]);

    %   demoMenu_axes8 and 13: linearized SOFI.flattened
    %   SOFI.linearized

    axes(handles.demoMenu_axes13);
    if (min(SOFI.linearized{2}(:))<0); SOFI.linearized{2}=SOFI.linearized{2}-min(SOFI.linearized{2}(:));end;
    SOFI.linearized{2}=SOFI.linearized{2}/max(SOFI.linearized{2}(:));
    SOFI.linearized{2} = imadjust(SOFI.linearized{2},[min(SOFI.linearized{2}(:));max(SOFI.linearized{2}(:))],[0;1]);
    imshow(SOFI.linearized{2});
    colormap(handles.demoMenu_axes13,morgenstemning(255));
    % axis square;xlabel('pixel x axis','FontSize',8,'FontWeight','bold');
    set(gca,'YTick',[]);set(gca,'XTick',[]);

    %   demoMenu_axes9 and 14: reconvolved SOFI.linearized
    %   SOFI.reconvolved

    axes(handles.demoMenu_axes14);
    if (min(SOFI.reconvolved{2}(:))<0); SOFI.reconvolved{2}=SOFI.reconvolved{2}-min(SOFI.reconvolved{2}(:));end;
    SOFI.reconvolved{2}=SOFI.reconvolved{2}/max(SOFI.reconvolved{2}(:));
    SOFI.reconvolved{2} = imadjust(SOFI.reconvolved{2},[min(SOFI.reconvolved{2}(:));max(SOFI.reconvolved{2}(:))],[0;1]);
    imshow(SOFI.reconvolved{2});
    colormap(handles.demoMenu_axes14,morgenstemning(255));
    % axis square;xlabel('pixel x axis','FontSize',8,'FontWeight','bold');
    set(gca,'YTick',[]);set(gca,'XTick',[]);

    %   demoMenu_axes10 and 15: balanced SOFI
    %   SOFI.balanced

    axes(handles.demoMenu_axes15);
    SOFI.balanced(SOFI.balanced<0)=0;
    SOFI.balanced=SOFI.balanced/max(SOFI.balanced(:));
    SOFI.balanced = imadjust(SOFI.balanced,[min(SOFI.balanced(:));max(SOFI.balanced(:))],[0;1]);
    imshow(SOFI.balanced);
    colormap(handles.demoMenu_axes15,morgenstemning(255));
    % axis square;xlabel('pixel x axis','FontSize',8,'FontWeight','bold');
    set(gca,'YTick',[]);set(gca,'XTick',[]);
end

drawnow;
end


