function varargout = SOFItutorial_demoMenu(varargin)
% SOFITUTORIAL_DEMOMENU MATLAB code for SOFItutorial_demoMenu.fig
%      SOFITUTORIAL_DEMOMENU, by itself, creates a new SOFITUTORIAL_DEMOMENU or raises the existing
%      singleton*.
%
%      H = SOFITUTORIAL_DEMOMENU returns the handle to a new SOFITUTORIAL_DEMOMENU or the handle to
%      the existing singleton*.
%
%      SOFITUTORIAL_DEMOMENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SOFITUTORIAL_DEMOMENU.M with the given input arguments.
%
%      SOFITUTORIAL_DEMOMENU('Property','Value',...) creates a new SOFITUTORIAL_DEMOMENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SOFItutorial_demoMenu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SOFItutorial_demoMenu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

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

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SOFItutorial_demoMenu_OpeningFcn, ...
                   'gui_OutputFcn',  @SOFItutorial_demoMenu_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before SOFItutorial_demoMenu is made visible.
function SOFItutorial_demoMenu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SOFItutorial_demoMenu (see VARARGIN)

% Choose default command line output for SOFItutorial_demoMenu
handles.output = hObject;
%set(hObject,'Color',[93/255 162/255 255/255]);

% uploda all the parameters from the SOFItutorial_startMenu GUI
hMainGui = getappdata(0,'hMainGui');
Grid = getappdata(hMainGui,'Grid');
setappdata(hMainGui,'current_frame',2);
setappdata(hMainGui,'slider_on',0);
% Set the icons of the buttons. %The 'playbutton' and the 'stopbutton' 
% functions read in image files and then extracts enough data from them to 
% form a small icons
set(handles.demoMenu_play_pushbutton,'cdata',loadim('play.jpg'));
set(handles.demoMenu_stop_pushbutton,'cdata',loadim('stop.jpg'));
set(handles.demoMenu_setting_pushbutton,'cdata',loadim('settings.png'));
set(handles.demoMenu_zoom_axes4,'cdata',loadim('zoom.png'));
set(handles.demoMenu_zoom_axes5,'cdata',loadim('zoom.png'));
set(handles.demoMenu_camera_axes2_slider,'SliderStep',[1/Grid.sx, 2/Grid.sx])

% update all axes
createAnimatedLines(hMainGui,handles);
updateStaticAxes(hMainGui,handles,2);
updateAnimations(hMainGui,handles,1);
setAxis(handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SOFItutorial_demoMenu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SOFItutorial_demoMenu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function demoMenu_camera_axes2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to demoMenu_camera_axes2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hMainGui = getappdata(0,'hMainGui');
% frame = getappdata(hMainGui,'current_frame');
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% updateAnimations(hMainGui,handles,frame);
% clearAnimatedLines(hMainGui,handles);

setappdata(hMainGui,'slider_on',1);
updateStaticAxes(hMainGui,handles,1);
drawnow;

% --- Executes during object creation, after setting all properties.
function demoMenu_camera_axes2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to demoMenu_camera_axes2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
    % set(hObject,'Min',1);set(hObject,'Max',Grid.sx);
    set(hObject,'Value',0.5);
end


% --- Executes on button press in demoMenu_zoom_axes4.
function demoMenu_zoom_axes4_Callback(hObject, eventdata, handles)
% hObject    handle to demoMenu_zoom_axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hMainGui = getappdata(0,'hMainGui');

set(handles.demoMenu_play_pushbutton,'Value',0);
set(handles.demoMenu_play_pushbutton,'Enable','on');
set(handles.demoMenu_camera_axes2_slider,'Enable','off');
set(handles.output,'Visible','off');

figure('color',[1 1 1],'tag','fig_zoom_axes4','name','Time Traces','position',[400 100 800 600]);
ax = axes('tag','ax_zoom_axes4');%axis(ax,'square');view([36 26]);-21,35
view([37,48]);xlabel(ax,'time t [s]','interpreter','latex','FontWeight','bold','Units','normalized','Position',[0.28 0.001 0],'rotation',-20);
ylabel(ax,'Pixels x axis','interpreter','latex','FontWeight','bold','Units','normalized','Position',[0.82 0.01 0],'rotation',38);
%grid ON;
strTitle = ['Intensity Time Traces',char(10),...
        '$$I(\vec{r},t)$$'];
title(strTitle,'interpreter','latex');
    
setappdata(hMainGui,'current_frame',1);
zoomAxes(hMainGui,handles,4);
setappdata(hMainGui,'current_frame',2);
set(handles.output,'Visible','on');


% --- Executes on button press in demoMenu_zoom_axes5.
function demoMenu_zoom_axes5_Callback(hObject, eventdata, handles)
% hObject    handle to demoMenu_zoom_axes5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hMainGui = getappdata(0,'hMainGui');

set(handles.demoMenu_play_pushbutton,'Value',0);
set(handles.demoMenu_play_pushbutton,'Enable','on');
set(handles.demoMenu_camera_axes2_slider,'Enable','off');
set(handles.output,'Visible','off');

figure('color',[1 1 1],'tag','fig_zoom_axes5','name','2nd order cross-cumulants','position',[400 100 800 600]);
ax = axes('tag','ax_zoom_axes5');%axis(ax,'square');
view([37,48]);xlabel(ax,'lag $\tau{}$ [s]','FontWeight','bold','interpreter','latex','Units','normalized','Position',[0.28 0.001 0],'rotation',-20);
ylabel(ax,'Pixels x axis','interpreter','latex','FontWeight','bold','Units','normalized','Position',[0.82 0.01 0],'rotation',38);
%grid ON;
strTitle = ['2nd order Cross-Cumulants Traces',char(10),...
        '$$E\{I(\vec{r_1},t)I(\vec{r_2},t+\tau{})\}$$'];    
title(strTitle,'interpreter','latex');

setappdata(hMainGui,'current_frame',1);
zoomAxes(hMainGui,handles,5);
setappdata(hMainGui,'current_frame',2);
set(handles.output,'Visible','on');


% --- Executes on button press in demoMenu_help_axes6_pushbutton.
function demoMenu_help_axes6_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to demoMenu_help_axes6_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SOFItutorial_helpMenu;

% --- Executes on button press in demoMenu_help_axes7_pushbutton.
function demoMenu_help_axes7_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to demoMenu_help_axes7_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SOFItutorial_helpMenu_Flattening;


% --- Executes on button press in demoMenu_help_axes8_pushbutton.
function demoMenu_help_axes8_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to demoMenu_help_axes8_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SOFItutorial_helpMenu_Linearization;

% --- Executes on button press in demoMenu_help_axes9_pushbutton.
function demoMenu_help_axes9_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to demoMenu_help_axes9_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SOFItutorial_helpMenu_Reconvolution;

% --- Executes on button press in demoMenu_help_axes10_pushbutton.
function demoMenu_help_axes10_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to demoMenu_help_axes10_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SOFItutorial_helpMenu_Balanced;

% --- Executes on button press in demoMenu_play_pushbutton.
function demoMenu_play_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to demoMenu_play_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

hMainGui = getappdata(0,'hMainGui');
Optics = getappdata(hMainGui,'Optics');
Grid = getappdata(hMainGui,'Grid');
frames = Optics.frames;clear Optics;

set(hObject,'Enable','off');
set(handles.demoMenu_camera_axes2_slider,'Enable','on');
set(handles.demoMenu_camera_axes2_slider,'SliderStep',[1/Grid.sx, 5/Grid.sx]); clear Grid;
setAxis(handles);

while ishandle(handles.figure1) && get(hObject,'Value') == 1
    % Surface plot of height, colored by velocity.
    frame = getappdata(hMainGui,'current_frame');
    updateAnimations(hMainGui,handles,frame);
    drawnow;
    if getappdata(hMainGui,'slider_on')==1
        frame = frames;
        setappdata(hMainGui,'slider_on',0);
    end
    if frame < frames
        frame = frame+1;
    else
        frame=1;
        clearAnimatedLines(hMainGui,handles);
    end
    setappdata(hMainGui,'current_frame',frame);
end

% --- Executes on button press in demoMenu_stop_pushbutton.
function demoMenu_stop_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to demoMenu_stop_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.demoMenu_play_pushbutton,'Value',0);
set(handles.demoMenu_play_pushbutton,'Enable','on');
% set(handles.demoMenu_camera_axes2_slider,'Value',0.5);
set(handles.demoMenu_camera_axes2_slider,'Enable','off');

% --- Executes on button press in demoMenu_setting_pushbutton.
function demoMenu_setting_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to demoMenu_setting_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.demoMenu_play_pushbutton,'Value',0);
% open the other GUI
if ishandle(findobj('name','SOFItutorial_resultsMenu'))
    close(findobj('name','SOFItutorial_resultsMenu'));
end
if ishandle(findobj('name','SOFItutorial_demoMenu'))
    close(findobj('name','SOFItutorial_demoMenu'));
end
%SOFItutorial_startMenu;
set(findobj('name','SOFItutorial_startMenu'),'Visible','on');
set(findobj('tag','startMenu_examples_popupmenu'),'Enable','on');
set(findobj('tag','startMenu_return_pushbutton'),'Enable','on');



% --- Used to create icon data from an image, a
function out = iconize(a)

% Find the size of the acquired image and determine how much data will need
% to be lost in order to form a 18x18 icon
[r,c,~] = size(a);
r_skip = ceil(r/18);
c_skip = ceil(c/18);

% Create the 18x18 icon (RGB data)
out = a(1:r_skip:end,1:c_skip:end,:);

% --- Used to return 'CData' for the Play, Stop, Zoom and Settings icons
function im = loadim(imname)
im = iconize(imread(imname));
im(im==255) = .8*255;


% --- Executes during object creation, after setting all properties.
function demoMenu_play_pushbutton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to demoMenu_play_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

set(hObject,'Value',1);

function createAnimatedLines(hMainGui,handles)

Grid = getappdata(hMainGui,'Grid');
Optics = getappdata(hMainGui,'Optics');
frames = Optics.frames; clear Optics;
% handles    empty - handles not created until after all CreateFcns called
axes(handles.demoMenu_axes4);h_axes4 = animatedline('Color',[0.5 0.5 0.5],'MaximumNumPoints',frames);
for k=1:Grid.sx
    h_axes4 = [h_axes4,animatedline('Color',[rand rand rand],'MaximumNumPoints',frames)];
end
setappdata(hMainGui,'animated_line_axes4',h_axes4);

axes(handles.demoMenu_axes5);h_axes5 = animatedline('Color',[0.5 0.5 0.5],'MaximumNumPoints',frames);
for k=1:2*Grid.sx-1
    h_axes5 = [h_axes5,animatedline('Color',[rand rand rand],'MaximumNumPoints',frames)];
end
setappdata(hMainGui,'animated_line_axes5',h_axes5);


function clearAnimatedLines(hMainGui,handles)

Grid = getappdata(hMainGui,'Grid');
% handles    empty - handles not created until after all CreateFcns called
h_axes4 = getappdata(hMainGui,'animated_line_axes4');
for k=1:Grid.sx
    clearpoints(h_axes4(k));
end
%setappdata(hMainGui,'animated_line_axes4',h_axes4);

h_axes5 = getappdata(hMainGui,'animated_line_axes5');
for k=1:2*Grid.sx-1
    clearpoints(h_axes5(k));
end

%axes(handles.demoMenu_axes4);
setappdata(hMainGui,'animated_line_axes4',h_axes4);
%axes(handles.demoMenu_axes5);
setappdata(hMainGui,'animated_line_axes5',h_axes5);
