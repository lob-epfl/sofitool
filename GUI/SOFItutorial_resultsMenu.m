function varargout = SOFItutorial_resultsMenu(varargin)
% SOFITUTORIAL_RESULTSMENU MATLAB code for SOFItutorial_resultsMenu.fig
%      SOFITUTORIAL_RESULTSMENU, by itself, creates a new SOFITUTORIAL_RESULTSMENU or raises the existing
%      singleton*.
%
%      H = SOFITUTORIAL_RESULTSMENU returns the handle to a new SOFITUTORIAL_RESULTSMENU or the handle to
%      the existing singleton*.
%
%      SOFITUTORIAL_RESULTSMENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SOFITUTORIAL_RESULTSMENU.M with the given input arguments.
%
%      SOFITUTORIAL_RESULTSMENU('Property','Value',...) creates a new SOFITUTORIAL_RESULTSMENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SOFItutorial_resultsMenu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SOFItutorial_resultsMenu_OpeningFcn via varargin.
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
                   'gui_OpeningFcn', @SOFItutorial_resultsMenu_OpeningFcn, ...
                   'gui_OutputFcn',  @SOFItutorial_resultsMenu_OutputFcn, ...
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


% --- Executes just before SOFItutorial_resultsMenu is made visible.
function SOFItutorial_resultsMenu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SOFItutorial_resultsMenu (see VARARGIN)

% Choose default command line output for SOFItutorial_resultsMenu
handles.output = hObject;
%set(hObject,'Color',[93/255 162/255 255/255]);

hMainGui =getappdata(0,'hMainGui');
setappdata(hMainGui,'scalebar',1);

% set icon of resultsMenu buttons
set(handles.resultsMenu_scale_pushbutton,'cdata',loadim('scalebar.png'));
set(handles.storm_pushbutton,'cdata',loadim('dynrange.png'));
set(handles.sofi_pushbutton,'cdata',loadim('dynrange_sofi.png'));
set(handles.resultsMenu_settings_pushbutton,'cdata',loadim('settings.png'));
set(handles.resultsMenu_save_pushbutton,'cdata',loadim('save_icon.jpg'));

Fluo = getappdata(hMainGui,'Fluo');
Grid = getappdata(hMainGui,'Grid');
Optics = getappdata(hMainGui,'Optics');

% sample with upsampled grid
sample = zeros(7*Grid.sy,7*Grid.sx);
for k=1:size(Fluo.emitters,1)
    sample(floor(7*Fluo.emitters(k,1)),floor(7*Fluo.emitters(k,2))) = 1;
end
Optics.sample = sample;
setappdata(hMainGui,'Optics',Optics);
    
updateWidefield(hMainGui,handles);
updateSofi(hMainGui,handles);
updateStorm(hMainGui,handles); 

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SOFItutorial_resultsMenu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SOFItutorial_resultsMenu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in resultsMenu_settings_pushbutton.
function resultsMenu_settings_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to resultsMenu_settings_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.resultsMenu_bSOFI_slider,'Enable','off');
if ishandle(findobj('name','SOFItutorial_resultsMenu'))
    close(findobj('name','SOFItutorial_resultsMenu'));
end
if ishandle(findobj('name','SOFItutorial_demoMenu'))
    close(findobj('name','SOFItutorial_demoMenu'));
end
% open the other GUI
%SOFItutorial_startMenu;
set(findobj('name','SOFItutorial_startMenu'),'Visible','on');
set(findobj('tag','startMenu_examples_popupmenu'),'Enable','on');
set(findobj('tag','startMenu_return_pushbutton'),'Enable','on');

% % save hMainGui variables
% hMainGui = getappdata(0,'hMainGui');
% SOFI=getappdata(hMainGui,'SOFI');
% orders=getappdata(hMainGui,'sofi_orders');
% storm=getappdata(hMainGui,'storm');
% Optics=getappdata(hMainGui,'Optics');
% Cam=getappdata(hMainGui,'Cam');
% Grid=getappdata(hMainGui,'Grid');
% Fluo=getappdata(hMainGui,'Fluo');
% save('referenceData.mat','SOFI','orders','storm','Optics','Cam','Fluo','Grid');
% digital_timeTraces=getappdata(hMainGui,'digital_timeTraces');
% analog_timeTraces=getappdata(hMainGui,'analog_timeTraces');
% save referenceDataTraces.mat -v7.3;


% --- Executes on slider movement.
function resultsMenu_bSOFI_slider_Callback(hObject, eventdata, handles)
% hObject    handle to resultsMenu_bSOFI_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hMainGui = getappdata(0,'hMainGui');
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
updateSofi(hMainGui,handles);

% --- Executes during object creation, after setting all properties.
function resultsMenu_bSOFI_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to resultsMenu_bSOFI_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

hMainGui = getappdata(0,'hMainGui');
orders = getappdata(hMainGui,'sofi_orders');
%orders = 1:7;
maxNumberOfImages = max(orders(:));

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
    set(hObject, 'Min', 2);
    set(hObject, 'Max', 1+maxNumberOfImages);
    set(hObject, 'Value', 2);
    set(hObject, 'SliderStep', [1/(maxNumberOfImages-1) , 2/(maxNumberOfImages-1)]); % must be between 0 and 1
end

function updateStorm(hMainGui,handles)

scalebar = getappdata(hMainGui,'scalebar');
Cam = getappdata(hMainGui,'Cam');
Grid = getappdata(hMainGui,'Grid');
Optics = getappdata(hMainGui,'Optics');

storm = getappdata(hMainGui,'storm');
% Normalization and Contrast adjustment
storm = storm./(max((storm(:))));%storm = storm./(storm+1);
%storm = imadjust(storm, stretchlim(storm, [0.01;0.993]), [0;1]);

if scalebar
    storm(1+end-7*2:end-7*1,end-7*(5+1)+1:end-7)=1;
    % scale = length(1+7*(Grid.sx-(5+1)):7*(Grid.sx-1))*Cam.pixel_size/(7*Grid.sx);clear Cam Grid Optics;
    scale = length(1+7*(Grid.sx-(5+1)):7*(Grid.sx-1))*Cam.pixel_size/(Optics.magnification*7);
    set(handles.resultsMenu_stormScale_st,'String',sprintf('%.2f nm',scale*(1e9)));
    clear Cam Grid Optics;
else
    set(handles.resultsMenu_stormScale_st,'String','');
end
axes(handles.resultsMenu_STORM_axes);
imshow(storm);set(handles.resultsMenu_STORM_axes,'XTick',[]);set(handles.resultsMenu_STORM_axes,'YTick',[]);
% colormap(handles.resultsMenu_STORM_axes,hot(255));
colormap(handles.resultsMenu_STORM_axes,morgenstemning(255));

function updateWidefield(hMainGui,handles)

scalebar = getappdata(hMainGui,'scalebar');
Cam = getappdata(hMainGui,'Cam');
Grid = getappdata(hMainGui,'Grid');
Optics = getappdata(hMainGui,'Optics');

if ~get(handles.resultsMenu_widefield_slider,'Value')
    timeTraces = getappdata(hMainGui,'digital_timeTraces');
    widefield = mean(timeTraces,3);clear timeTraces;
    if scalebar 
        widefield(end-1,end-5:end-1)=max(widefield(:)); % length of scale bar = 5 pixels
        scale = 5*Cam.pixel_size/Optics.magnification;
    end
    set(handles.resultsMenu_widefield_st,'String','Widefield');
else
    %Optics = getappdata(hMainGui,'Optics');
    widefield = imdilate(Optics.sample,strel('disk',2));
    %if scalebar; scale = 5*Cam.pixel_size/(Grid.blckSize*Grid.sx);end;
    if scalebar
        widefield(1+end-7*2:end-7*1,end-7*(5+1)+1:end-7)=1;
        %scale = length(1+7*(Grid.sx-(5+1)):7*(Grid.sx-1))*Cam.pixel_size/(7*Grid.sx);
        scale = length(1+7*(Grid.sx-(5+1)):7*(Grid.sx-1))*Cam.pixel_size/(7*Optics.magnification);
    end
    set(handles.resultsMenu_widefield_st,'String','Distribution');
end

clear Cam Grid Optics;
if scalebar
    %widefield(end-1,end-5:end-1)=max(widefield(:)); % length of scale bar = 4 pixels
    set(handles.resultsMenu_widefieldScale_st,'String',sprintf('%.2f nm',scale*(1e9)));
else
    set(handles.resultsMenu_widefieldScale_st,'String','');
end
axes(handles.resultsMenu_widefield_axes);
imagesc(widefield);set(handles.resultsMenu_widefield_axes,'XTick',[]);set(handles.resultsMenu_widefield_axes,'YTick',[]);
colormap(handles.resultsMenu_widefield_axes,morgenstemning(255));


function updateSofi(hMainGui,handles)

Cam = getappdata(hMainGui,'Cam');
Grid = getappdata(hMainGui,'Grid');
Optics = getappdata(hMainGui,'Optics');

% order ?
slider_pos = get(handles.resultsMenu_bSOFI_slider,'Value');
sofi_orders = getappdata(hMainGui,'sofi_orders');
scalebar = getappdata(hMainGui,'scalebar');

current_ord = round(slider_pos); clear slider_pos;

% raw or linearized ? 
set(handles.resultsMenu_lin_slider,'Enable','on');
set(handles.resultsMenu_lin_slider_st,'Enable','on');
raw = get(handles.resultsMenu_lin_slider,'Value');

SOFI = getappdata(hMainGui,'SOFI');
if sum(sofi_orders == current_ord)
    if raw
        sofi = SOFI.cumulants{current_ord};clear SOFI;
        set(handles.resultsMenu_lin_slider_st,'String','Raw');
    else
        sofi = SOFI.reconvolved{current_ord};clear SOFI;
        set(handles.resultsMenu_lin_slider_st,'String','Linear');
    end
    set(handles.resultsMenu_bSOFI_st,'String','SOFI');
    set(handles.resultsMenu_bSOFI_order_st,'String',strcat('order ',num2str(current_ord)));
elseif current_ord == 1+max(sofi_orders(:))
    current_ord = 4;
    sofi = SOFI.balanced; clear SOFI;sofi(sofi<0)=0;
    
    set(handles.resultsMenu_lin_slider,'Enable','off');
    set(handles.resultsMenu_lin_slider_st,'Enable','off');
    set(handles.resultsMenu_lin_slider_st,'String','');
    set(handles.resultsMenu_bSOFI_st,'String','bSOFI');
    set(handles.resultsMenu_bSOFI_order_st,'String','');
else % in case there is a problem with the slider: reinitialize the parameters
    current_ord = 2;
    sofi = SOFI.reconvolved{current_ord};clear SOFI;
    set(handles.resultsMenu_lin_slider,'Value',0);
    set(handles.resultsMenu_lin_slider_st,'String','Linear');
%     sofi = SOFI.cumulants{current_ord};clear SOFI;
%     set(handles.resultsMenu_lin_slider,'Value',1);
%     set(handles.resultsMenu_lin_slider_st,'String','Raw'); %change of the slider initial status in the fig menu
    
    set(handles.resultsMenu_bSOFI_slider,'Min', 2);
    set(handles.resultsMenu_bSOFI_slider,'Max', 1+max(sofi_orders(:)));
    set(handles.resultsMenu_bSOFI_slider,'Value',2);
    set(handles.resultsMenu_bSOFI_slider, 'SliderStep', [1/(max(sofi_orders(:))-1), 2/(max(sofi_orders(:))-1)]);
    set(handles.resultsMenu_bSOFI_st,'String','SOFI');
    set(handles.resultsMenu_bSOFI_order_st,'String','order 2');
end

% Normalization and Contrast Adjustment
%if (min(sofi(:))<0); sofi=sofi-min(sofi(:));end;
if ~raw
    sofi(sofi<0)=0;
else
    sofi = abs(sofi);
end
sofi = sofi/max(sofi(:));
sofi = imadjust(sofi,[min(sofi(:));max(sofi(:))],[0;1]);

if scalebar
    sofi(end-current_ord*2+1:end-current_ord*1,end-current_ord*(5+1)+1:end-current_ord)=1; % length of scale bar = 4 pixels
    % scale = length(1+current_ord*(Grid.sx-(5+1)):current_ord*(Grid.sx-1))*Cam.pixel_size/(current_ord*Grid.sx);clear Cam Grid Optics;
    scale = length(1+current_ord*(Grid.sx-(5+1)):current_ord*(Grid.sx-1))*Cam.pixel_size/(Optics.magnification*current_ord);
    set(handles.resultsMenu_sofiScale_st,'String',sprintf('%.2f nm',scale*(1e9))); 
    clear Cam Grid Optics;
else
    set(handles.resultsMenu_sofiScale_st,'String','');
end

axes(handles.resultsMenu_bSOFI_axes);
imshow(sofi);set(handles.resultsMenu_bSOFI_axes,'XTick',[]);set(handles.resultsMenu_bSOFI_axes,'YTick',[]);
colormap(handles.resultsMenu_bSOFI_axes,morgenstemning(255));

% --- Used to create icon data from an image, a
function out = iconize(a)

% Find the size of the acquired image and determine how much data will need
% to be lost in order to form a 18x18 icon
[r,c,~] = size(a);
r_skip = ceil(r/18);
c_skip = ceil(c/18);

% Create the 18x18 icon (RGB data)
out = a(1:r_skip:end,1:c_skip:end,:);

% --- Used to return 'CData' for the Play, Stop and Settings icons
function im = loadim(imname)
im = iconize(imread(imname));
im(im==255) = .8*255;


% --- Executes on button press in storm_pushbutton.
function storm_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to storm_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imcontrast(handles.resultsMenu_STORM_axes);


% --- Executes on slider movement.
function resultsMenu_widefield_slider_Callback(hObject, eventdata, handles)
% hObject    handle to resultsMenu_widefield_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hMainGui = getappdata(0,'hMainGui');
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
updateWidefield(hMainGui,handles);

% --- Executes during object creation, after setting all properties.
function resultsMenu_widefield_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to resultsMenu_widefield_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in resultsMenu_scale_pushbutton.
function resultsMenu_scale_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to resultsMenu_scale_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hMainGui = getappdata(0,'hMainGui');
scalebar = getappdata(hMainGui,'scalebar');
setappdata(hMainGui,'scalebar',abs(scalebar-1));

updateWidefield(hMainGui,handles);
updateSofi(hMainGui,handles);
updateStorm(hMainGui,handles);


% --- Executes on slider movement.
function resultsMenu_lin_slider_Callback(hObject, eventdata, handles)
% hObject    handle to resultsMenu_lin_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hMainGui = getappdata(0,'hMainGui');
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
updateSofi(hMainGui,handles);

% --- Executes during object creation, after setting all properties.
function resultsMenu_lin_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to resultsMenu_lin_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in sofi_pushbutton.
function sofi_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to sofi_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imcontrast(handles.resultsMenu_bSOFI_axes);
% hMainGui = getappdata(0,'hMainGui');
% storm = getappdata(hMainGui,'storm');


% --- Executes on button press in resultsMenu_save_pushbutton.
function resultsMenu_save_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to resultsMenu_save_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hMainGui = getappdata(0,'hMainGui');
folder_name = uigetdir(pwd,'Select folder');

if ~isnumeric(folder_name) && ~isempty(getappdata(hMainGui,'storm')) && ~isempty(getappdata(hMainGui,'SOFI')) && ~isempty(getappdata(hMainGui,'digital_timeTraces'))
    
    path_name = strcat(folder_name,'\');clear folder_name;
    % Save sofi data
    SOFI = getappdata(hMainGui,'SOFI');
    saveSOFIdata(SOFI,path_name);clear SOFI;
    % Save storm data
    storm = getappdata(hMainGui,'storm');
    %storm = storm./max(storm(:));
    imwrite(uint16(storm),gray(65536),strcat(path_name,'storm.tif'),'tif'); clear storm;
    % Save distribution
    Optics = getappdata(hMainGui,'Optics');
    distribution = imdilate(Optics.sample,strel('disk',2));
    imwrite(gray2ind(distribution,65536),morgenstemning,strcat(path_name,'sample.tif'),'tif'); clear distribution; 
    % Save widefield
    scale_widefield = getappdata(hMainGui,'scale_timeTraces');%[1,2]=[max_digTT,min_digTT]
    timeTraces = getappdata(hMainGui,'digital_timeTraces');
    widefield = mean(((scale_widefield(1)-scale_widefield(2))*timeTraces+scale_widefield(2)),3);clear timeTraces;
    imwrite(uint16(widefield),gray(65536),strcat(path_name,'widefield.tif'),'tif');
else
    uiwait(errordlg({'One dataset is empty' 'please generate a stack from the start men, press run and try again'},'','nonmodal'));
end

function saveSOFIdata(SOFI,path)

% SOFI.reconvolved{2}(SOFI.reconvolved{2}<0)=0;SOFI.reconvolved{2}=SOFI.reconvolved{2}/max(SOFI.reconvolved{2}(:));
% SOFI.reconvolved{3}(SOFI.reconvolved{3}<0)=0;SOFI.reconvolved{3}=SOFI.reconvolved{3}/max(SOFI.reconvolved{3}(:));
% SOFI.reconvolved{4}(SOFI.reconvolved{4}<0)=0;SOFI.reconvolved{4}=SOFI.reconvolved{4}/max(SOFI.reconvolved{4}(:));
% SOFI.reconvolved{5}(SOFI.reconvolved{5}<0)=0;SOFI.reconvolved{5}=SOFI.reconvolved{5}/max(SOFI.reconvolved{5}(:));
% SOFI.reconvolved{6}(SOFI.reconvolved{6}<0)=0;SOFI.reconvolved{6}=SOFI.reconvolved{6}/max(SOFI.reconvolved{6}(:));
% SOFI.reconvolved{7}(SOFI.reconvolved{7}<0)=0;SOFI.reconvolved{7}=SOFI.reconvolved{7}/max(SOFI.reconvolved{7}(:));
% 
% SOFI.cumulants{2} = abs(SOFI.cumulants{2});SOFI.cumulants{2}=SOFI.cumulants{2}/max(SOFI.cumulants{2}(:));
% SOFI.cumulants{3} = abs(SOFI.cumulants{3});SOFI.cumulants{3}=SOFI.cumulants{3}/max(SOFI.cumulants{3}(:));
% SOFI.cumulants{4} = abs(SOFI.cumulants{4});SOFI.cumulants{4}=SOFI.cumulants{4}/max(SOFI.cumulants{4}(:));
% SOFI.cumulants{5} = abs(SOFI.cumulants{5});SOFI.cumulants{5}=SOFI.cumulants{5}/max(SOFI.cumulants{5}(:));
% SOFI.cumulants{6} = abs(SOFI.cumulants{6});SOFI.cumulants{6}=SOFI.cumulants{6}/max(SOFI.cumulants{6}(:));
% SOFI.cumulants{7} = abs(SOFI.cumulants{7});SOFI.cumulants{7}=SOFI.cumulants{7}/max(SOFI.cumulants{7}(:));
% 
% % contrast adjustment
% SOFI.reconvolved{2} = imadjust(SOFI.reconvolved{2},[min(SOFI.reconvolved{2}(:));max(SOFI.reconvolved{2}(:))],[0;1]);
% SOFI.reconvolved{3} = imadjust(SOFI.reconvolved{3},[min(SOFI.reconvolved{3}(:));max(SOFI.reconvolved{3}(:))],[0;1]);
% SOFI.reconvolved{4} = imadjust(SOFI.reconvolved{4},[min(SOFI.reconvolved{4}(:));max(SOFI.reconvolved{4}(:))],[0;1]);
% SOFI.reconvolved{5} = imadjust(SOFI.reconvolved{5},[min(SOFI.reconvolved{5}(:));max(SOFI.reconvolved{5}(:))],[0;1]);
% SOFI.reconvolved{6} = imadjust(SOFI.reconvolved{6},[min(SOFI.reconvolved{6}(:));max(SOFI.reconvolved{6}(:))],[0;1]);
% SOFI.reconvolved{7} = imadjust(SOFI.reconvolved{7},[min(SOFI.reconvolved{7}(:));max(SOFI.reconvolved{7}(:))],[0;1]);
% 
% SOFI.cumulants{2} = imadjust(SOFI.cumulants{2},[min(SOFI.cumulants{2}(:));max(SOFI.cumulants{2}(:))],[0;1]);
% SOFI.cumulants{3} = imadjust(SOFI.cumulants{3},[min(SOFI.cumulants{3}(:));max(SOFI.cumulants{3}(:))],[0;1]);
% SOFI.cumulants{4} = imadjust(SOFI.cumulants{4},[min(SOFI.cumulants{4}(:));max(SOFI.cumulants{4}(:))],[0;1]);
% SOFI.cumulants{5} = imadjust(SOFI.cumulants{5},[min(SOFI.cumulants{5}(:));max(SOFI.cumulants{5}(:))],[0;1]);
% SOFI.cumulants{6} = imadjust(SOFI.cumulants{6},[min(SOFI.cumulants{6}(:));max(SOFI.cumulants{6}(:))],[0;1]);
% SOFI.cumulants{7} = imadjust(SOFI.cumulants{7},[min(SOFI.cumulants{7}(:));max(SOFI.cumulants{7}(:))],[0;1]);
% 
% % bSOFI contrast adjustment
% SOFI.balanced(SOFI.balanced<0)=0;SOFI.balanced=SOFI.balanced/max(SOFI.balanced(:));
% SOFI.balanced = imadjust(SOFI.balanced,[min(SOFI.balanced(:));max(SOFI.balanced(:))],[0;1]);
f=1;
if max(max(SOFI.reconvolved{2}))<1;f=65336;end;
imwrite(uint16(f*SOFI.balanced),gray(65536),strcat(path,'bsofi4.tif'),'tif'); 

% save SOFI
imwrite(uint16(f*SOFI.reconvolved{2}),gray(65536),strcat(path,'linear_sofi2.tif'),'tif'); 
imwrite(uint16(f*SOFI.reconvolved{3}),gray(65536),strcat(path,'linear_sofi3.tif'),'tif'); 
imwrite(uint16(f*SOFI.reconvolved{4}),gray(65536),strcat(path,'linear_sofi4.tif'),'tif'); 
imwrite(uint16(f*SOFI.reconvolved{5}),gray(65536),strcat(path,'linear_sofi5.tif'),'tif'); 
imwrite(uint16(f*SOFI.reconvolved{6}),gray(65536),strcat(path,'linear_sofi6.tif'),'tif'); 
imwrite(uint16(f*SOFI.reconvolved{7}),gray(65536),strcat(path,'linear_sofi7.tif'),'tif'); 

imwrite(uint16(f*SOFI.cumulants{2}),gray(65536),strcat(path,'raw_sofi2.tif'),'tif'); 
imwrite(uint16(f*SOFI.cumulants{3}),gray(65536),strcat(path,'raw_sofi3.tif'),'tif'); 
imwrite(uint16(f*SOFI.cumulants{4}),gray(65536),strcat(path,'raw_sofi4.tif'),'tif'); 
imwrite(uint16(f*SOFI.cumulants{5}),gray(65536),strcat(path,'raw_sofi5.tif'),'tif'); 
imwrite(uint16(f*SOFI.cumulants{6}),gray(65536),strcat(path,'raw_sofi6.tif'),'tif'); 
imwrite(uint16(f*SOFI.cumulants{7}),gray(65536),strcat(path,'raw_sofi7.tif'),'tif'); 
