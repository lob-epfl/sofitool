function displayAxes(hObject,handles,help)
%Displays the figures and animations from the help menus of the 
%SOFItutorial_demoMenu
%
%Inputs:
% hObject   current handle object
% handles   handles to SOFItutorial_demoMenu interface [Figure] 
% help      number specifying which figure/animation to display since it 
%           is different for each help menus

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

switch help
    case 1
        load helpMenu_axes6; % Cam, Optics, Fluo, Grid, mixed_traces, mixed_image, sk1 and sk2
        axes1Plot(mixed_image,handles,hObject);
        axes2Plot(Cam,sk1,sk2,handles);
        axes3PlotParam(handles,hObject);

        k=1;
        while ishandle(hObject)
            delete(findall(hObject,'Tag','annot1'));delete(findall(hObject,'Tag','annot2'));
            axes3PlotTime(hObject,k,Cam);
            axes3Plot(mixed_traces,k,handles);
            drawnow;
            if(k<size(mixed_traces,3))
                k=k+1;
            else
                k=1;
            end
        end
    case 2
        [~,msgId] = lastwarn;
        warnStruct = warning('off',msgId);
        img = imread('codeUtils/help_TextFigures/axes7/sofi_grids.jpg');   % Load a sample image
        axes(handles.axes1);imshow(img);axis image; % Plot the image
        set(gca,'XTick',[]);set(gca,'YTick',[]);
        warning(warnStruct);
    case 3
        load helpMenu_axes8; % gridLin and gridRaw
        
        axes(handles.axes1);colormap(handles.axes1,jet(64));
        mesh(handles.axes1,gridRaw);caxis([0 1]);xlim(handles.axes1,[1 80]);ylim(handles.axes1,[1 80]);
        axis(handles.axes1,'square');view(handles.axes1,[51 26]);
        xl1=xlabel(handles.axes1,'pixel y axis','FontSize',8,'FontWeight','bold');pos = get(xl1,'Position');set(xl1,'Position',pos + [0 12 0]);set(xl1,'rotation',-30);
        yl1=ylabel(handles.axes1,'pixel x axis','FontSize',8,'FontWeight','bold');pos = get(yl1,'Position');set(yl1,'Position',pos + [-15 0 0]);set(yl1,'rotation',22);
        title(handles.axes1,'Before Linearization');

        axes(handles.axes2);colormap(handles.axes2,jet(64));
        mesh(handles.axes2,gridLin+0.075*rand(size(gridLin,1),size(gridLin,2)));caxis([0 1]);xlim(handles.axes2,[1 80]);ylim(handles.axes2,[1 80]);
        axis(handles.axes2,'square');view(handles.axes2,[51 26]);
        xl2=xlabel(handles.axes2,'pixel y axis','FontSize',8,'FontWeight','bold');pos = get(xl2,'Position');set(xl2,'Position',pos + [0 12 0]);set(xl2,'rotation',-30);
        yl2=ylabel(handles.axes2,'pixel x axis','FontSize',8,'FontWeight','bold');pos = get(yl2,'Position');set(yl2,'Position',pos + [-15 0 0]);set(yl2,'rotation',22);
        title(handles.axes2,'After Linearization');
    case 4
        load helpMenu_axes9; % gridConv and gridRaw
        
        axes(handles.axes1);colormap(handles.axes1,jet(64));
        mesh(handles.axes1,gridRaw);caxis([0 1]);xlim(handles.axes1,[1 80]);ylim(handles.axes1,[1 80]);
        axis(handles.axes1,'square');view(handles.axes1,[51 26]);
        xl1=xlabel(handles.axes1,'pixel y axis','FontSize',8,'FontWeight','bold');pos = get(xl1,'Position');set(xl1,'Position',pos + [0 12 0]);set(xl1,'rotation',-30);
        yl1=ylabel(handles.axes1,'pixel x axis','FontSize',8,'FontWeight','bold');pos = get(yl1,'Position');set(yl1,'Position',pos + [-15 0 0]);set(yl1,'rotation',22);
        title(handles.axes1,'Before Linearization');

        axes(handles.axes2);colormap(handles.axes2,jet(64));
        mesh(handles.axes2,gridConv);caxis([0 1]);xlim(handles.axes2,[1 80]);ylim(handles.axes2,[1 80]);
        axis(handles.axes2,'square');view(handles.axes2,[51 26]);
        xl2=xlabel(handles.axes2,'pixel y axis','FontSize',8,'FontWeight','bold');pos = get(xl2,'Position');set(xl2,'Position',pos + [0 12 0]);set(xl2,'rotation',-30);
        yl2=ylabel(handles.axes2,'pixel x axis','FontSize',8,'FontWeight','bold');pos = get(yl2,'Position');set(yl2,'Position',pos + [-15 0 0]);set(yl2,'rotation',22);
        title(handles.axes2,'After Linearization and Convolution'); 
    case 5 
        [~,msgId] = lastwarn;
        warnStruct = warning('off',msgId);
        img = imread('codeUtils/help_TextFigures/axes10/fn.jpg');   % Load a sample image
        axes(handles.axes1);imshow(img);axis image; % Plot the image
        set(gca,'XTick',[]);set(gca,'YTick',[]);
        warning(warnStruct);
    otherwise
        
end




function axes1Plot(mixed_image,handles,hObject)

str1 = ['High Resolved Cumulant',char(10),...
        '$$E\{I(\vec{r_1},t)I(\vec{r_2},t+\tau{}_0)\}$$'];

str2 = ['Low Resolved',char(10),...
        'Intensity',char(10),...
        '$$I(\vec{r},t_0)$$'];
    
% --- annotation textbox
annotation(hObject,'textbox',...
    [140/1366 512/599 0.276785714285716 0.076190476190477],...
    'Interpreter','latex',...
    'String',str1,...
    'FitBoxToText','off',...
    'FontSize',8,...
    'LineStyle','none',...
    'EdgeColor',[1 1 1]);
annotation(hObject,'textbox',...
    [66/1366 532/599 0.217857142857143 0.0547619047619072],...
    'Interpreter','latex',...
    'String',str2,...
    'FitBoxToText','off',...
    'FontSize',8,...
    'LineStyle','none',...
    'EdgeColor',[1 1 1]);

colormap(handles.axes1,jet(64));
mesh(handles.axes1,mixed_image);caxis([0 1]);
axis(handles.axes1,'square');view(handles.axes1,[12 12]);xlim(handles.axes1,[0 119]);
% labels
xl=xlabel(handles.axes1,'pixel y axis','FontSize',8,'FontWeight','bold');pos = get(xl,'Position');set(xl,'Position',pos + [0 40 0]);
% ylabel(handles.axes1,'pixel x axis','FontSize',8,'FontWeight','bold');

function axes2Plot(Cam,sk1,sk2,handles)

axes(handles.axes2);
time_axis = (1:length(sk1)).'/Cam.acq_speed;
plot(handles.axes2,time_axis,sk1,'b','LineWidth',1);
xlim(handles.axes2,[0 1+length(sk1)]/Cam.acq_speed);ylim(handles.axes2,[0 max(sk1)]);
xlabel(handles.axes2,'Time[s]','FontSize',8,'FontWeight','bold');
% legend_strings = {'s_k(t)','<s_k(t),s_k(t+\tau)>'};
% legend(handles.axes2,legend_strings);
% set(handles.axes2,'XTick',[0:round(length(sk1)/10):length(sk1)]/Cam.acq_speed);set(handles.axes2,'YTick',[0:0.25:4]);
% grid minor;

axes(handles.axes9);
time_axis = (1:length(sk1)).'/Cam.acq_speed;
plot(handles.axes9,time_axis,sk2-2,'r','LineWidth',1);
xlim(handles.axes9,[0 1+length(sk1)]/Cam.acq_speed);ylim(handles.axes9,[0 max(sk2-2)]);
xlabel(handles.axes9,'Time Lag[s]','FontSize',8,'FontWeight','bold');
% legend_strings = {'s_k(t)','<s_k(t),s_k(t+\tau)>'};
% legend(handles.axes9,legend_strings);
% set(handles.axes9,'XTick',[0:round(length(sk1)/10):length(sk1)]/Cam.acq_speed);set(handles.axes2,'YTick',[0:0.25:4]);
% grid minor;

% axes(handles.axes2);
% time_axis = (1:length(sk1)).'/Cam.acq_speed;
% plot(handles.axes2,time_axis,sk1,'b','LineWidth',1);hold on; plot(handles.axes2,time_axis,sk2,'r','LineWidth',1);
% xlim(handles.axes2,[0 1+length(sk1)]/Cam.acq_speed);ylim(handles.axes2,[0 max(sk2)]);
% xlabel(handles.axes2,'Time[s]','FontSize',8,'FontWeight','bold');
% legend_strings = {'s_k(t)','<s_k(t),s_k(t+\tau)>'};
% legend(handles.axes2,legend_strings);
% set(handles.axes2,'XTick',[0:round(length(sk1)/10):length(sk1)]/Cam.acq_speed);set(handles.axes2,'YTick',[0:0.25:4]);
% grid minor;


function axes3Plot(mixed_traces,k,handles)

mesh(handles.axes3,mixed_traces(:,:,k));
view(handles.axes3,[20 20]);
caxis(handles.axes3,[0 1]);zlim(handles.axes3,[0 1]);xlim(handles.axes3,[0 119]);
% xlabel(handles.axes3,'pixel y axis','FontSize',8,'FontWeight','bold');ylabel(handles.axes3,'pixel x axis','FontSize',8,'FontWeight','bold');


function axes3PlotParam(handles,hObject)

string1 = ['Cumulant Time Traces:',char(10),...
           '$$E\{I(\vec{r_1},t)I(\vec{r_2},t+\tau{})\}$$'];
       
string2 = ['Pixel Time Traces:',char(10),...
           '$$I(\vec{r_1},t)$$'];
       
% --- text boxes
annotation(hObject,'textbox',...
[780/1366 532/599 0.282018867924531 0.0571428571428572],...
'String',string1,...
'Interpreter','latex',...
'FitBoxToText','off',...
'FontWeight','bold',...
'FontSize',8,...
'LineStyle','none',...
'EdgeColor',[1 1 1]);

annotation(hObject,'textbox',...
[665/1366 532/599 0.237385199705956 0.0571428571428572],...
'String',string2,...
'Interpreter','latex',...
'FontWeight','bold',...
'FitBoxToText','off',...
'FontSize',8,...
'LineStyle','none',...
'EdgeColor',[1 1 1]);

%view(handles.axes3,[20 20]);
colormap(handles.axes3,jet(64));

function axes3PlotTime(hObject,num_str,Cam)

str1 = strcat('Lag \tau{} = ',strcat(num2str(num_str/Cam.acq_speed),' s')); 
str2 = strcat('Time t = ',strcat(num2str(num_str/Cam.acq_speed),' s'));
       
% --- text boxes
annotation(hObject,'textbox',...
[780/1366 502/599 0.282018867924531 0.0571428571428572],...
'String',str1,...
'FitBoxToText','off',...
'FontSize',8,...
'Tag','annot1',...
'LineStyle','none',...
'EdgeColor',[1 1 1]);

annotation(hObject,'textbox',...
[665/1366 502/599 0.237385199705956 0.0571428571428572],...
'String',str2,...
'FitBoxToText','off',...
'FontSize',8,...
'Tag','annot2',...
'LineStyle','none',...
'EdgeColor',[1 1 1]);

%view(handles.axes3,[20 20]);
%colormap(handles.axes3,jet(64));

