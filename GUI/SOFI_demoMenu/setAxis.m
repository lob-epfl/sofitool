function [] = setAxis(handles)
%Set the axes properties of the SOFItutorial_demoMenu interface
%
%Inputs:
% handles  handles to SOFItutorial_demoMenu interface [Figure] 
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

% demoMenu_axes1:
axes(handles.demoMenu_axes1);
colormap(handles.demoMenu_axes1,parula(255));
axis(handles.demoMenu_axes1,'square');
set(gca,'YTick',[]);set(gca,'XTick',[]);

% demoMenu_axes2:
axes(handles.demoMenu_axes2);
colormap(handles.demoMenu_axes2,hot(16));
axis(handles.demoMenu_axes2,'square');% colormap copper;
set(gca,'YTick',[]);set(gca,'XTick',[]);

% demoMenu_axes3:
axes(handles.demoMenu_axes3);
axis(handles.demoMenu_axes3,'square');
xlabel('pixel x axis','FontSize',8,'FontWeight','bold');
set(gca,'YTick',[]);set(gca,'XTick',[]);

% demoMenu_axes4:
axes(handles.demoMenu_axes4);
view([37,48]);xlabel(handles.demoMenu_axes4,'time','FontSize',8,'FontWeight','bold','Units','normalized','Position',[0.26 0.001 0],'rotation',-26);
ylabel(handles.demoMenu_axes4,'Pixels x axis','FontSize',8,'FontWeight','bold','Units','normalized','Position',[0.83 0.01 0],'rotation',40);

% demoMenu_axes5:
axes(handles.demoMenu_axes5);
view([37,48]);xlabel(handles.demoMenu_axes5,'lag','FontSize',8,'FontWeight','bold','Units','normalized','Position',[0.26 0.001 0],'rotation',-22);
ylabel(handles.demoMenu_axes5,'Pixels x axis','FontSize',8,'FontWeight','bold','Units','normalized','Position',[0.83 0.01 0],'rotation',40);

% demoMenu_axes6:
axes(handles.demoMenu_axes6);
xlabel('pixel x axis','FontSize',8,'FontWeight','bold');
set(gca,'YTick',[]);set(gca,'XTick',[]);

% demoMenu_axes7:
axes(handles.demoMenu_axes7);
xlabel('pixel x axis','FontSize',8,'FontWeight','bold');
set(gca,'YTick',[]);set(gca,'XTick',[]);

% demoMenu_axes8:
axes(handles.demoMenu_axes8);
xlabel('pixel x axis','FontSize',8,'FontWeight','bold');
set(gca,'YTick',[]);set(gca,'XTick',[]);

% demoMenu_axes9:
axes(handles.demoMenu_axes9);
xlabel('pixel x axis','FontSize',8,'FontWeight','bold');
set(gca,'YTick',[]);set(gca,'XTick',[]);

% demoMenu_axes10:
axes(handles.demoMenu_axes10);
xlabel('pixel x axis','FontSize',8,'FontWeight','bold');
set(gca,'YTick',[]);set(gca,'XTick',[]);

% demoMenu_axes11:
axes(handles.demoMenu_axes11);
colormap(handles.demoMenu_axes11,morgenstemning(255));
axis(handles.demoMenu_axes11,'square');
set(gca,'YTick',[]);set(gca,'XTick',[]);

% demoMenu_axes12:
axes(handles.demoMenu_axes12);
colormap(handles.demoMenu_axes11,morgenstemning(255));
axis(handles.demoMenu_axes12,'square');
set(gca,'YTick',[]);set(gca,'XTick',[]);

% demoMenu_axes13:
axes(handles.demoMenu_axes13);
colormap(handles.demoMenu_axes11,morgenstemning(255));
axis(handles.demoMenu_axes13,'square');
set(gca,'YTick',[]);set(gca,'XTick',[]);

% demoMenu_axes14:
axes(handles.demoMenu_axes14);
colormap(handles.demoMenu_axes11,morgenstemning(255));
axis(handles.demoMenu_axes14,'square');
set(gca,'YTick',[]);set(gca,'XTick',[]);

% demoMenu_axes15:
axes(handles.demoMenu_axes15);
colormap(handles.demoMenu_axes11,morgenstemning(255));
axis(handles.demoMenu_axes15,'square');
set(gca,'YTick',[]);set(gca,'XTick',[]);

end

