function varargout = SOFItutorial_startMenu(varargin)
% SOFITUTORIAL_STARTMENU MATLAB code for SOFItutorial_startMenu.fig
%      SOFITUTORIAL_STARTMENU, by itself, creates a new SOFITUTORIAL_STARTMENU or raises the existing
%      singleton*.
%
%      H = SOFITUTORIAL_STARTMENU returns the handle to a new SOFITUTORIAL_STARTMENU or the handle to
%      the existing singleton*.
%
%      SOFITUTORIAL_STARTMENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SOFITUTORIAL_STARTMENU.M with the given input arguments.
%
%      SOFITUTORIAL_STARTMENU('Property','Value',...) creates a new SOFITUTORIAL_STARTMENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SOFItutorial_startMenu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SOFItutorial_startMenu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
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
                   'gui_OpeningFcn', @SOFItutorial_startMenu_OpeningFcn, ...
                   'gui_OutputFcn',  @SOFItutorial_startMenu_OutputFcn, ...
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


% --- Executes just before SOFItutorial_startMenu is made visible.
function SOFItutorial_startMenu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.

% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SOFItutorial_startMenu (see VARARGIN)
addpath(genpath(strcat(pwd))); % pwd: must be ...\misSOFI\ 

% Choose default command line output for SOFItutorial_startMenu
handles.output = hObject;
%set(hObject,'Color',[93/255 162/255 255/255]);

% Create a Main GUI that store the parameters of the system
setappdata(0, 'hMainGui', gcf);
hMainGui = getappdata(0,'hMainGui');

set(handles.startMenu_loadStack_pushbutton,'cdata',loadim('load_icon.jpg'));
set(handles.startMenu_saveStack_pushbutton,'cdata',loadim('save_icon.jpg'));
set(handles.startMenu_return_pushbutton,'cdata',loadim('return.jpg'));
set(handles.startMenu_zoom_pushbutton,'cdata',loadim('zoom.png'));

% UPDATE all parameters from handles into 4 structures: Optics, Cam, Fluo and
% Grid all available in the Main GUI 'hMainGui'
updateAllParams(handles,hMainGui);
updateAxes(str2double(get(handles.startMenu_number_edit,'String')),'number',hMainGui,handles);

% Update handles structure
guidata(hObject, handles);

% Close all hidden figures
hiddenFigures = findall(findall(0,'Visible','Off'),'Type','Figure');
for k=1:length(hiddenFigures)
    close(hiddenFigures(k));
end
clear hiddenFigures;

% Disable all warning messages
warning ('off','all');

% UIWAIT makes SOFItutorial_startMenu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SOFItutorial_startMenu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if verLessThan('matlab','8.4')
msgbox('This GUI was developed for MATLAB version 2014b and higher. Some functionalities can be limited for your MATLAB version.'); 
end

% Get default command line output from handles structure
varargout{1} = handles.output;


function startMenu_duration_edit_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_duration_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

checkValue(hObject,0.0001,1000);
% Hints: get(hObject,'String') returns contents of startMenu_duration_edit as text
%        str2double(get(hObject,'String')) returns contents of startMenu_duration_edit as a double
hMainGui = getappdata(0,'hMainGui');
updateParam(handles,hObject,'duration','Fluo',hMainGui,1);


% --- Executes during object creation, after setting all properties.
function startMenu_duration_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_duration_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    set(hObject,'String','3'); % 3 seconds
end


function startMenu_number_edit_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_number_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

checkValue(hObject,0,100000);
if (str2double(get(hObject,'String')) == 2); set(hObject,'String',num2str(3));end;
% Hints: get(hObject,'String') returns contents of startMenu_number_edit as text
%        str2double(get(hObject,'String')) returns contents of startMenu_number_edit as a double
hMainGui = getappdata(0,'hMainGui');
updateParam(handles,hObject,'number','Fluo',hMainGui,1);
updateAxes(str2double(get(hObject,'String')),'number',hMainGui,handles);



% --- Executes during object creation, after setting all properties.
function startMenu_number_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_number_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    %set(hObject,'String',2);
    %set(hObject,'Max',3);
end




function startMenu_density_edit_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_density_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

checkValue(hObject,0,50000);
% Hints: get(hObject,'String') returns contents of startMenu_density_edit as text
%        str2double(get(hObject,'String')) returns contents of startMenu_density_edit as a double
hMainGui = getappdata(0,'hMainGui');
updateParam(handles,hObject,'density','Fluo',hMainGui,1e12);
updateAxes(str2double(get(hObject,'String')),'density',hMainGui,handles);

% --- Executes during object creation, after setting all properties.
function startMenu_density_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_density_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    set(hObject,'String',0);
    %set(hObject,'Max',3);
end



function startMenu_signal_edit_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_signal_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

checkValue(hObject,10,5000);
% Hints: get(hObject,'String') returns contents of startMenu_signal_edit as text
%        str2double(get(hObject,'String')) returns contents of startMenu_signal_edit as a double
hMainGui = getappdata(0,'hMainGui');
updateParam(handles,hObject,'Ion','Fluo',hMainGui,1);
% Make sure that Fluo.Peak and Fluo.SB are both 0 when Fluo-signal is
% non-zero
Fluo = getappdata(hMainGui,'Fluo');
Fluo.Peak = 0;Fluo.SB = 0;
setappdata(hMainGui,'Fluo',Fluo);clear Fluo;

% --- Executes during object creation, after setting all properties.
function startMenu_signal_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_signal_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    set(hObject,'String','200');
end


function startMenu_onstate_edit_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_onstate_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

checkValue(hObject,1,1000);
% Hints: get(hObject,'String') returns contents of startMenu_onstate_edit as text
%        str2double(get(hObject,'String')) returns contents of startMenu_onstate_edit as a double
hMainGui = getappdata(0,'hMainGui');
updateParam(handles,hObject,'Ton','Fluo',hMainGui,1e-3);

% --- Executes during object creation, after setting all properties.
function startMenu_onstate_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_onstate_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    set(hObject,'String','20');
end


function startMenu_offstate_edit_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_offstate_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

checkValue(hObject,1,100000);
% Hints: get(hObject,'String') returns contents of startMenu_offstate_edit as text
%        str2double(get(hObject,'String')) returns contents of startMenu_offstate_edit as a double
hMainGui = getappdata(0,'hMainGui');
updateParam(handles,hObject,'Toff','Fluo',hMainGui,1e-3);

% --- Executes during object creation, after setting all properties.
function startMenu_offstate_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_offstate_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    set(hObject,'String','40');
end


function startMenu_bleach_edit_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_bleach_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

checkValue(hObject,1,100000);
% Hints: get(hObject,'String') returns contents of startMenu_bleach_edit as text
%        str2double(get(hObject,'String')) returns contents of startMenu_bleach_edit as a double
hMainGui = getappdata(0,'hMainGui');
updateParam(handles,hObject,'Tbl','Fluo',hMainGui,1);

% --- Executes during object creation, after setting all properties.
function startMenu_bleach_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_bleach_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    set(hObject,'String','80');
end


function startMenu_background_edit_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_background_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

checkValue(hObject,0,5000);
% Hints: get(hObject,'String') returns contents of startMenu_background_edit as text
%        str2double(get(hObject,'String')) returns contents of startMenu_background_edit as a double
hMainGui = getappdata(0,'hMainGui');
updateParam(handles,hObject,'background','Fluo',hMainGui,1);
% Make sure that Fluo.Peak and Fluo.SB are both 0 when Fluo.background is
% non-zero
Fluo = getappdata(hMainGui,'Fluo');
Fluo.Peak = 0;Fluo.SB = 0;
setappdata(hMainGui,'Fluo',Fluo);clear Fluo;


% --- Executes during object creation, after setting all properties.
function startMenu_background_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_background_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    set(hObject,'String','2');
end


function startMenu_radius_edit_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_radius_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

checkValue(hObject,0.1,100);
% Hints: get(hObject,'String') returns contents of startMenu_radius_edit as text
%        str2double(get(hObject,'String')) returns contents of startMenu_radius_edit as a double
hMainGui = getappdata(0,'hMainGui');
updateParam(handles,hObject,'radius','Fluo',hMainGui,(1e-9)/sqrt(str2double(get(hObject,'String'))));

% --- Executes during object creation, after setting all properties.
function startMenu_radius_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_radius_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    set(hObject,'String','64');
end


function startMenu_acqSpeed_edit_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_acqSpeed_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

checkValue(hObject,0.5,10000);
% Hints: get(hObject,'String') returns contents of startMenu_acqSpeed_edit as text
%        str2double(get(hObject,'String')) returns contents of startMenu_acqSpeed_edit as a double
hMainGui = getappdata(0,'hMainGui');
updateParam(handles,hObject,'acq_speed','Cam',hMainGui,1);

% --- Executes during object creation, after setting all properties.
function startMenu_acqSpeed_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_acqSpeed_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    set(hObject,'String','100');
end


function startMenu_readNoise_edit_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_readNoise_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

checkValue(hObject,0.1,100);
% Hints: get(hObject,'String') returns contents of startMenu_readNoise_edit as text
%        str2double(get(hObject,'String')) returns contents of startMenu_readNoise_edit as a double
hMainGui = getappdata(0,'hMainGui');
updateParam(handles,hObject,'readout_noise','Cam',hMainGui,1);

% --- Executes during object creation, after setting all properties.
function startMenu_readNoise_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_readNoise_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    set(hObject,'String','1.6');
end


function startMenu_darkCurrent_edit_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_darkCurrent_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

checkValue(hObject,0.0001,10);
% Hints: get(hObject,'String') returns contents of startMenu_darkCurrent_edit as text
%        str2double(get(hObject,'String')) returns contents of startMenu_darkCurrent_edit as a double
hMainGui = getappdata(0,'hMainGui');
updateParam(handles,hObject,'dark_current','Cam',hMainGui,1);

% --- Executes during object creation, after setting all properties.
function startMenu_darkCurrent_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_darkCurrent_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    set(hObject,'String','0.06');
end


function startMenu_quantumEfficiency_edit_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_quantumEfficiency_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

checkValue(hObject,0.001,1);
% Hints: get(hObject,'String') returns contents of startMenu_quantumEfficiency_edit as text
%        str2double(get(hObject,'String')) returns contents of startMenu_quantumEfficiency_edit as a double
hMainGui = getappdata(0,'hMainGui');
updateParam(handles,hObject,'quantum_efficiency','Cam',hMainGui,1);

% --- Executes during object creation, after setting all properties.
function startMenu_quantumEfficiency_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_quantumEfficiency_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    set(hObject,'String','0.7');
end



function startMenu_gain_edit_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_gain_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

checkValue(hObject,1,5000);
% Hints: get(hObject,'String') returns contents of startMenu_gain_edit as text
%        str2double(get(hObject,'String')) returns contents of startMenu_gain_edit as a double
hMainGui = getappdata(0,'hMainGui');
updateParam(handles,hObject,'gain','Cam',hMainGui,1);

% --- Executes during object creation, after setting all properties.
function startMenu_gain_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_gain_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    set(hObject,'String','6');
end


function startMenu_pixelSizeX_edit_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_pixelSizeX_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

checkValue(hObject,0.1,500);
% Hints: get(hObject,'String') returns contents of startMenu_pixelSizeX_edit as text
%        str2double(get(hObject,'String')) returns contents of startMenu_pixelSizeX_edit as a double
hMainGui = getappdata(0,'hMainGui');
set(handles.startMenu_pixelSizeY_edit,'String',get(hObject,'String'));
updateParam(handles,hObject,'pixel_size','Cam',hMainGui,1e-6);
updateAxes(str2double(get(handles.startMenu_number_edit,'String')),'number',hMainGui,handles);

% --- Executes during object creation, after setting all properties.
function startMenu_pixelSizeX_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_pixelSizeX_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    set(hObject,'String','6.45');
end


function startMenu_pixelsX_edit_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_pixelsX_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

checkValue(hObject,10,4096);
% Hints: get(hObject,'String') returns contents of startMenu_pixelsX_edit as text
%        str2double(get(hObject,'String')) returns contents of startMenu_pixelsX_edit as a double
hMainGui = getappdata(0,'hMainGui');
updateParam(handles,hObject,'sy','Grid',hMainGui,1);
updateAxes(str2double(get(handles.startMenu_number_edit,'String')),'number',hMainGui,handles);

% --- Executes during object creation, after setting all properties.
function startMenu_pixelsX_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_pixelsX_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    set(hObject,'String','30');
end


function startMenu_pixelSizeY_edit_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_pixelSizeY_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

checkValue(hObject,0.1,500);
% Hints: get(hObject,'String') returns contents of startMenu_pixelSizeY_edit as text
%        str2double(get(hObject,'String')) returns contents of startMenu_pixelSizeY_edit as a double
hMainGui = getappdata(0,'hMainGui');
set(handles.startMenu_pixelSizeX_edit,'String',get(hObject,'String'));
updateParam(handles,hObject,'pixel_size','Cam',hMainGui,1e-6);
updateAxes(str2double(get(handles.startMenu_number_edit,'String')),'number',hMainGui,handles);

% --- Executes during object creation, after setting all properties.
function startMenu_pixelSizeY_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_pixelSizeY_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    set(hObject,'String','6.45');
end


function startMenu_pixelsY_edit_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_pixelsY_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

checkValue(hObject,10,4096);
% Hints: get(hObject,'String') returns contents of startMenu_pixelsY_edit as text
%        str2double(get(hObject,'String')) returns contents of startMenu_pixelsY_edit as a double
hMainGui = getappdata(0,'hMainGui');
updateParam(handles,hObject,'sx','Grid',hMainGui,1);
updateAxes(str2double(get(handles.startMenu_number_edit,'String')),'number',hMainGui,handles);

% --- Executes during object creation, after setting all properties.
function startMenu_pixelsY_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_pixelsY_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    set(hObject,'String','30');
end


function startMenu_numAperture_edit_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_numAperture_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

checkValue(hObject,0.1,2);
% Hints: get(hObject,'String') returns contents of startMenu_numAperture_edit as text
%        str2double(get(hObject,'String')) returns contents of startMenu_numAperture_edit as a double
hMainGui = getappdata(0,'hMainGui');
updateParam(handles,hObject,'NA','Optics',hMainGui,1);

% --- Executes during object creation, after setting all properties.
function startMenu_numAperture_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_numAperture_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    set(hObject,'String','0.8');
end



function startMenu_wavelength_edit_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_wavelength_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

checkValue(hObject,10,5000);
% Hints: get(hObject,'String') returns contents of startMenu_wavelength_edit as text
%        str2double(get(hObject,'String')) returns contents of startMenu_wavelength_edit as a double
hMainGui = getappdata(0,'hMainGui');
updateParam(handles,hObject,'wavelength','Optics',hMainGui,1e-9);

% --- Executes during object creation, after setting all properties.
function startMenu_wavelength_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_wavelength_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    set(hObject,'String','600');
end


function startMenu_magnification_edit_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_magnification_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

checkValue(hObject,0.1,5000);
% Hints: get(hObject,'String') returns contents of startMenu_magnification_edit as text
%        str2double(get(hObject,'String')) returns contents of startMenu_magnification_edit as a double
hMainGui = getappdata(0,'hMainGui');
updateParam(handles,hObject,'magnification','Optics',hMainGui,1);
updateAxes(str2double(get(handles.startMenu_number_edit,'String')),'number',hMainGui,handles);

% --- Executes during object creation, after setting all properties.
function startMenu_magnification_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_magnification_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    set(hObject,'String','100');
end

% --- Executes on button press in startMenu_start_pushbutton.
function startMenu_start_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_start_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.startMenu_windowsProc_checkbox,'Value') ==0 && get(handles.startMenu_windowsResults_checkbox,'Value') == 0; 
    msgbox('One of the options "Tutorial" and/or "Simulation" has to be checked');
    return;
end
    
hMainGui = getappdata(0,'hMainGui');
enableDisableEditBoxes(handles,'off',false);
set(handles.startMenu_twoDiracs_slider,'Enable','off'); 
set(findobj('Tag','startMenu_fluoDistance_st'),'Enable','off');

% disable tutorial and simulator checkboxes
set(handles.startMenu_windowsProc_checkbox,'Enable','off');
set(handles.startMenu_windowsResults_checkbox,'Enable','off');


if(strcmp(get(hObject,'String'),'Stack'))
    enableDisableTutorialPanel(hObject,handles,'off','all');
    
    intensity_peak_mode = get(handles.startMenu_radiobutton,'Value');
    tutorial = get(handles.startMenu_windowsProc_checkbox,'Value'); 
    generateTimeTraces(hMainGui,intensity_peak_mode,tutorial);
    %set(handles.startMenu_start_pushbutton,'String','start');
    %set(handles.startMenu_start_pushbutton,'Enable','on');
    set(handles.startMenu_run_pushbutton,'Enable','on');
    set(handles.startMenu_saveStack_pushbutton,'Enable','on');
    set(handles.startMenu_loadStack_pushbutton,'Enable','on');
else
%     set(handles.startMenu_return_pushbutton,'Enable','off');
%     set(handles.startMenu_start_pushbutton,'Enable','off');
%     %tic
%     % compute SOFI data
%     [SOFI,orders]=SOFIcalculations(hMainGui);
%     % store SOFI data in structures and in hMainGui
%     setappdata(hMainGui,'SOFI',SOFI);
%     setappdata(hMainGui,'sofi_orders',orders);
%     
%     % compute STORM data
%     if(get(handles.startMenu_windowsResults_checkbox,'Value'))
%         storm = STORMcalculations(hMainGui);
%         hMainGui = getappdata(0,'hMainGui');
%         setappdata(hMainGui,'storm',storm);clear storm;
%     end
% 
%     % open the other GUI
%     h = waitbar(0,'Opening, please wait...');
%     waitbar(1/2);
%     if(get(handles.startMenu_windowsProc_checkbox,'Value'));SOFItutorial_demoMenu;end;
%     if(get(handles.startMenu_windowsResults_checkbox,'Value'));SOFItutorial_resultsMenu;end;
%     waitbar(1);
%     close(h);
%     set(hObject,'String','Stack');
%     set(handles.startMenu_templates_popupmenu,'Enable','on');
%     % set(handles.startMenu_start_pushbutton,'Enable','on');
%     % set(handles.startMenu_return_pushbutton,'Enable','on');
%     enableDisableEditBoxes(handles,'on',false);
%     enableDisableTutorialPanel(hObject,handles,'on','start');
%     set(findobj('name','SOFItutorial_startMenu'),'Visible','off');
end


% --- Executes on selection change in startMenu_templates_popupmenu.
function startMenu_templates_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_templates_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

hMainGui = getappdata(0,'hMainGui');
% Hints: contents = cellstr(get(hObject,'String')) returns startMenu_templates_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from startMenu_templates_popupmenu
% items = get(hObject,'String');
% index_selected = get(hObject,'Value');
% item_selected = items{index_selected};
contents = cellstr(get(hObject,'String'));
val = cellstr(contents{get(hObject,'Value')});

% -- Waitbar
h = waitbar(0,'Updating, please wait...');
waitbar(1/2);
if(strcmp(val{1},'two emitters'))
    % generate a pattern containing two fluorophores at a fixed distance
    setTwoSpacedDiracsEditBoxes(handles);
    updateAllParams(handles,hMainGui);clear hMainGui; hMainGui = getappdata(0,'hMainGui');
    enableDisableEditBoxes(handles,'off',true);
    % updateAxes
    updateAxes(2,'number',hMainGui,handles,1);
    % enable and set the slider
    adjustSlider(hMainGui,handles);

elseif strcmp(val{1},'random')
    % disable the slider
    set(handles.startMenu_twoDiracs_slider,'Enable','off'); 
    set(findobj('Tag','startMenu_fluoDistance_st'),'Enable','off');
    % updateAxes
    enableDisableEditBoxes(handles,'on',false);
    updateAxes(str2double(get(handles.startMenu_number_edit,'String')),'number',hMainGui,handles);
    
elseif strcmp(val{1},'circular')
    % generate a pattern containing two fluorophores at a fixed distance
    setCircularEditBoxes(handles);
    updateAllParams(handles,hMainGui);clear hMainGui; hMainGui = getappdata(0,'hMainGui');
    enableDisableEditBoxes(handles,'off',true);
    % enable and set the slider
    adjustSlider(hMainGui,handles,20,10);
    % updateAxes
    updateAxes(str2double(get(handles.startMenu_number_edit,'String')),'number',hMainGui,handles,10);

    
elseif strcmp(val{1},'annular')
    % generate a pattern containing two fluorophores at a fixed distance
    setAnnularEditBoxes(handles);
    updateAllParams(handles,hMainGui);clear hMainGui; hMainGui = getappdata(0,'hMainGui');
    enableDisableEditBoxes(handles,'off',true);
    % enable and set the slider
    adjustSlider(hMainGui,handles,20,10);
    % updateAxes
    updateAxes(str2double(get(handles.startMenu_number_edit,'String')),'number',hMainGui,handles,10);

elseif strcmp(val{1},'segment')
    % generate a pattern containing two fluorophores at a fixed distance
    setAnnularEditBoxes(handles);
    updateAllParams(handles,hMainGui);clear hMainGui; hMainGui = getappdata(0,'hMainGui');
    enableDisableEditBoxes(handles,'off',true);
    % enable and set the slider
    adjustSlider(hMainGui,handles,20,10);
    % updateAxes
    updateAxes(str2double(get(handles.startMenu_number_edit,'String')),'number',hMainGui,handles,10);

elseif strcmp(val{1},'siemens star')
    % generate a pattern containing two fluorophores at a fixed distance
    setAnnularEditBoxes(handles);
    updateAllParams(handles,hMainGui);clear hMainGui; hMainGui = getappdata(0,'hMainGui');
    enableDisableEditBoxes(handles,'off',true);
    % enable and set the slider
    adjustSlider(hMainGui,handles,40,10);
    % updateAxes
    updateAxes(str2double(get(handles.startMenu_number_edit,'String')),'number',hMainGui,handles,10);
    
elseif strcmp(val{1},'user defined')
    % Update all parameters according to change of distribution
    setAnnularEditBoxes(handles);
    set(handles.startMenu_number_edit,'String','2000');
    updateParam(handles,handles.startMenu_number_edit,'number','Fluo',hMainGui,1);
    updateAllParams(handles,hMainGui);clear hMainGui; hMainGui = getappdata(0,'hMainGui');
    enableDisableEditBoxes(handles,'off',true);
    % disable the slider
    set(handles.startMenu_twoDiracs_slider,'Enable','off'); 
    set(findobj('Tag','startMenu_fluoDistance_st'),'Enable','off');
    % updateAxes
    updateAxes(str2double(get(handles.startMenu_number_edit,'String')),'number',hMainGui,handles,10);
    
else
end
waitbar(1);close(h);


% --- Executes during object creation, after setting all properties.
function startMenu_templates_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_templates_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    set(hObject,'Enable','on');
end

% --- Executes on button press in startMenu_windowsProc_checkbox.
function startMenu_windowsProc_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_windowsProc_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if verLessThan('matlab','8.4')
msgbox('Tutorial menu is using graphics supported by MATLAB version 2014b and higher. For your MATLAB version the tutorial menu is disabled.'); 
set(hObject,'Value',0.0);
end

% Hint: get(hObject,'Value') returns toggle state of startMenu_windowsProc_checkbox


% --- Executes on button press in startMenu_windowsResults_checkbox.
function startMenu_windowsResults_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_windowsResults_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of startMenu_windowsResults_checkbox


% --- Executes during object creation, after setting all properties.
function startMenu_windowsProc_checkbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_windowsProc_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'Value',0.0);

% --- Executes during object creation, after setting all properties.
function startMenu_windowsResults_checkbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_windowsResults_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'Value',1.0);

function updateAxes(def,type,hMainGui,handles,shift)
% updateAxes(def,type,hMainGui) updates the figure "Preview of Fluorophore
% Distribution" from the startMenu.
Grid = getappdata(hMainGui,'Grid');
Cam = getappdata(hMainGui,'Cam');
Optics = getappdata(hMainGui,'Optics');
Fluo = getappdata(hMainGui,'Fluo');
    
% -- Waitbar
h = waitbar(0,'Updating, please wait...');
waitbar(1/3);

enableDisableEditBoxes(handles,'off',false); % disable all edit boxes
% get the string from the popupmenu
contents = cellstr(get(handles.startMenu_templates_popupmenu,'String')); 
val = cellstr(contents{get(handles.startMenu_templates_popupmenu,'Value')});

% generate emitter positions as well as patterns
if ~exist('shift','var') && strcmp(val{1},'random')
    [pattern,Fluo.emitters,nPulses,dPulses] = emitterGenRandom(def,type,Grid,Cam,Optics,'random');
    enableDisableEditBoxes(handles,'on',false);
elseif strcmp(val{1},'two emitters')
    if (~exist('shift','var')); shift = floor(get(handles.startMenu_twoDiracs_slider,'Value'));end;
    [pattern,Fluo.emitters,nPulses,dPulses] = emitterGenRandom(def,type,Grid,Cam,Optics,'random',shift);
    enableDisableEditBoxes(handles,'on',false);
    enableDisableEditBoxes(handles,'off',true);
elseif strcmp(val{1},'circular')
    if (~exist('shift','var')); shift = floor(get(handles.startMenu_twoDiracs_slider,'Value'));end;
    [pattern,Fluo.emitters,nPulses,dPulses] = emitterGenRandom(def,type,Grid,Cam,Optics,'circular_patches',shift);
    enableDisableEditBoxes(handles,'on',false);
elseif strcmp(val{1},'annular')
    if (~exist('shift','var')); shift = floor(get(handles.startMenu_twoDiracs_slider,'Value'));end;
    [pattern,Fluo.emitters,nPulses,dPulses] = emitterGenRandom(def,type,Grid,Cam,Optics,'annular_patches',shift);
    enableDisableEditBoxes(handles,'on',false);
elseif strcmp(val{1},'segment')
    if (~exist('shift','var')); shift = floor(get(handles.startMenu_twoDiracs_slider,'Value'));end;
    [pattern,Fluo.emitters,nPulses,dPulses] = emitterGenRandom(def,type,Grid,Cam,Optics,'segment_patches',shift);
    enableDisableEditBoxes(handles,'on',false);
elseif strcmp(val{1},'siemens star')
    if (~exist('shift','var')); shift = floor(get(handles.startMenu_twoDiracs_slider,'Value'));end;
    % Edit the number of fluorophores so that there is at least 10
    % fluorophores per cycle
    if (Fluo.number < 10*shift)
        set(handles.startMenu_number_edit,'String',num2str(10*shift));
        updateParam(handles,handles.startMenu_number_edit,'number','Fluo',hMainGui,1);
    end
    [pattern,Fluo.emitters,nPulses,dPulses] = emitterGenRandom(def,type,Grid,Cam,Optics,'siemens star',shift);
    enableDisableEditBoxes(handles,'on',false);
    
elseif strcmp(val{1},'user defined')
    [pattern,Fluo.emitters,nPulses,dPulses,L] = emitterGenRandom(def,type,Grid,Cam,Optics,'user defined');
    Grid.sy=L; Grid.sx=L;clear L;
    enableDisableEditBoxes(handles,'on',false);
    set(handles.startMenu_pixelsY_edit,'String',num2str(Grid.sx));set(handles.startMenu_pixelsY_edit,'Enable','off');
    set(handles.startMenu_pixelsX_edit,'String',num2str(Grid.sy));set(handles.startMenu_pixelsX_edit,'Enable','off');
    %updateParam(handles,handles.startMenu_pixelsY_edit,'sx','Grid',hMainGui,1);

else
end

% Update number and density of Pulses
set(handles.startMenu_number_edit,'String',num2str(nPulses));Fluo.number=nPulses;
set(handles.startMenu_density_edit,'String',num2str(dPulses));Fluo.density=dPulses;

% Image the pattern
Optics.object = pattern;setappdata(hMainGui,'Optics',Optics);setappdata(hMainGui,'Fluo',Fluo);setappdata(hMainGui,'Grid',Grid);
waitbar(2/3); 
axes(handles.startMenu_fluoDisFig_axes); % gcf = handles.startMenu_fluoDisFig_axes
if(Grid.sx > 180);pattern = imdilate(pattern,strel('disk',2));end;
imagesc(Grid.blckSize*Grid.sy,Grid.blckSize*Grid.sx,pattern);colormap gray;
axis square;% xlabel('pixel x axis','FontSize',8,'FontWeight','bold');ylabel('pixel y axis','FontSize',8,'FontWeight','bold');
set(gca,'YTick',[]);set(gca,'XTick',[]);

waitbar(1);
close(h);

% --

% --- Executes during object creation, after setting all properties.
function startMenu_fluoDisFig_axes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_fluoDisFig_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate startMenu_fluoDisFig_axes


% --- Executes during object creation, after setting all properties.
function startMenu_density_st_units_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_density_st_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% set(hObject,'Enable','off');
% jEditbox = java(findjobj(hObject));
% htmlStr = '<html>/&mu;m<sup>2</sup></html>';
% jEditbox.setText(htmlStr);
% jEditbox.setBorder([]);

% set(hObject,'enable','off');
% jStaticText = java(findjobj(hObject));
% jStaticText.setText('<html>/&mu;m<sup>2</sup></html>');
% jStaticText.setBorderPainted(false);
% jStaticText.setBorder([]);

% --- Executes on slider movement.
function startMenu_twoDiracs_slider_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_twoDiracs_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hMainGui = getappdata(0,'hMainGui');

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% Grid = getappdata(hMainGui,'Grid');
% %max = Grid.blckSize*Grid.sx/2;min=1;clear Grid;
% max = Grid.sx/2;min=1;clear Grid;
% shift_pixels = 1+floor(get(hObject,'Value')*(max-min));
shift_pixels = floor(get(hObject,'Value'));
fluoDistance_fill(hMainGui,handles);

contents = cellstr(get(handles.startMenu_templates_popupmenu,'String')); 
val = cellstr(contents{get(handles.startMenu_templates_popupmenu,'Value')});

if strcmp(val{1},'two emitters')
    updateAxes(2,'number',hMainGui,handles,shift_pixels);
% elseif strcmp(val{1},'circular')
%     updateAxes(str2double(get(handles.startMenu_number_edit,'String')),'number',hMainGui,handles,shift_pixels);
% elseif strcmp(val{1},'annular')
%     updateAxes(str2double(get(handles.startMenu_number_edit,'String')),'number',hMainGui,handles,shift_pixels);
% elseif strcmp(val{1},'segment')
%     updateAxes(str2double(get(handles.startMenu_number_edit,'String')),'number',hMainGui,handles,shift_pixels);
else
    updateAxes(str2double(get(handles.startMenu_number_edit,'String')),'number',hMainGui,handles,shift_pixels);    
end
    
% --- Executes during object creation, after setting all properties.
function startMenu_twoDiracs_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_twoDiracs_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
    set(hObject,'Enable','off');
    %set(hObject,'Value',0);
end


% --- Executes during object creation, after setting all properties.
function startMenu_fluoDistance_st_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_fluoDistance_st (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% hMainGui = getappdata(0,'hMainGui');
% % Hints: get(hObject,'Value') returns position of slider
% %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% Grid = getappdata(hMainGui,'Grid');
% Cam = getappdata(hMainGui,'Cam');
% Optics = getappdata(hMainGui,'Optics');
% 
% max = Grid.blckSize*Grid.sx/2;min=1;clear Grid;
% shift_meters = 1+0.5*(max-min)*Cam.pixel_size/Optics.magnification; clear Optics;clear Cam;
% 
% set(hObject,'String',strcat('distance between fluorophores: ',strcat(shift_meters*(1e-9),' nm')));

function fluoDistance_fill(hMainGui,handles)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
Cam = getappdata(hMainGui,'Cam');
Optics = getappdata(hMainGui,'Optics');

contents = cellstr(get(handles.startMenu_templates_popupmenu,'String')); 
val = cellstr(contents{get(handles.startMenu_templates_popupmenu,'Value')});
shift_pixels = floor(get(handles.startMenu_twoDiracs_slider,'Value'));

if strcmp(val{1},'two emitters')
    shift_nm = (1e9)*shift_pixels*Cam.pixel_size/Optics.magnification; clear Optics;clear Cam;
    if(shift_nm > 1000);
        shift_nm = (1e-3)*shift_nm;
        string = strcat(num2str(shift_nm),' um');
    else
        string = strcat(num2str(shift_nm),' nm');
    end
    set(findobj('Tag','startMenu_fluoDistance_st'),'String',strcat('distance between fluorophores: ',string));
    
elseif strcmp(val{1},'circular')
    string = strcat(num2str(shift_pixels));
    set(findobj('Tag','startMenu_fluoDistance_st'),'String',strcat('Number of Disks: ',string));
    
elseif strcmp(val{1},'annular')
    string = strcat(num2str(shift_pixels));
    set(findobj('Tag','startMenu_fluoDistance_st'),'String',strcat('Number of Annulus: ',string));
    
elseif strcmp(val{1},'segment')
    string = strcat(num2str(shift_pixels));
    set(findobj('Tag','startMenu_fluoDistance_st'),'String',strcat('Number of Segments: ',string));
    
elseif strcmp(val{1},'siemens star')
    string = strcat(num2str(shift_pixels));
    set(findobj('Tag','startMenu_fluoDistance_st'),'String',strcat('Frequency: ',string));
end


function adjustSlider(hMainGui,handles,MaxVal,Init)

if ~exist('MaxVal','var')
    Grid = getappdata(hMainGui,'Grid');
    MaxVal = round(Grid.sy/2)-1;
    Init = 1;
end
set(handles.startMenu_twoDiracs_slider,'Enable','on');
set(handles.startMenu_twoDiracs_slider,'SliderStep',[1/(MaxVal-1),2/(MaxVal-1)]);
set(handles.startMenu_twoDiracs_slider,'Min',1);set(handles.startMenu_twoDiracs_slider,'Max',MaxVal); 
set(handles.startMenu_twoDiracs_slider,'Value',Init);clear MaxVal;
set(findobj('Tag','startMenu_fluoDistance_st'),'Enable','on');fluoDistance_fill(hMainGui,handles);


% --- Executes on selection change in startMenu_examples_popupmenu.
function startMenu_examples_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_examples_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

enableDisableEditBoxes(handles,'off',false);
enableDisableTutorialPanel(hObject,handles,'off','examples')
set(handles.startMenu_templates_popupmenu,'Enable','off');
set(handles.startMenu_twoDiracs_slider,'Enable','off'); 
set(findobj('Tag','startMenu_fluoDistance_st'),'Enable','off');

% disable the demonstration menu
set(handles.startMenu_windowsProc_checkbox,'Value',0);
set(handles.startMenu_windowsProc_checkbox,'Enable','off');

% Hints: contents = cellstr(get(hObject,'String')) returns startMenu_examples_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from startMenu_examples_popupmenu
contents = cellstr(get(hObject,'String')); 
val = cellstr(contents{get(hObject,'Value')});
loading = true;

% open the other GUI
h = waitbar(0,'Loading the Data, please wait...');
waitbar(1/2);

if strcmp(val{1},'high density')
    % timeTraces, SOFI, storm, time traces, Optics, Cam, Grid and Fluo
    load highDensityData; 
    load('highDensityDataTraces.mat','digital_timeTraces');
elseif strcmp(val{1},'few frames')
    % timeTraces, SOFI, storm, time traces, Optics, Cam, Grid and Fluo
    load fewFramesData; 
    load('fewFramesDataTraces.mat','digital_timeTraces');
elseif strcmp(val{1},'short off-state')
    % timeTraces, SOFI, storm, time traces, Optics, Cam, Grid and Fluo
    load shortOffStateData; 
    load('shortOffStateDataTraces.mat','digital_timeTraces');
elseif strcmp(val{1},'low SNR')
    % timeTraces, SOFI, storm, time traces, Optics, Cam, Grid and Fluo
    load lowSnr2Data; 
    load('lowSnr2DataTraces.mat','digital_timeTraces');
elseif strcmp(val{1},'STORM optimal')
    % timeTraces, SOFI, storm, time traces, Optics, Cam, Grid and Fluo
    load stormOptimizedData; 
    load('stormOptimizedDataTraces.mat','digital_timeTraces');
elseif strcmp(val{1},'reference')
    % timeTraces, SOFI, storm, time traces, Optics, Cam, Grid and Fluo
    load referenceData; 
    load('referenceDataTraces.mat','digital_timeTraces');
else
    loading = false;
end

if loading
    hMainGui = getappdata(0,'hMainGui');

    setappdata(hMainGui,'SOFI',SOFI);
    setappdata(hMainGui,'storm',storm);
    setappdata(hMainGui,'sofi_orders',orders);
    setappdata(hMainGui,'Optics',Optics);
    setappdata(hMainGui,'Cam',Cam);
    setappdata(hMainGui,'Grid',Grid);
    setappdata(hMainGui,'Fluo',Fluo); 
    setappdata(hMainGui,'digital_timeTraces',digital_timeTraces);
%     setappdata(hMainGui,'digital_timeTraces',uint16(0.25*Fluo.Ion*digital_timeTraces));
%     clear storm;storm = STORMcalculations(hMainGui,true);

    %setappdata(hMainGui,'analog_timeTraces',analog_timeTraces);
    
    setParamFromExamples(handles,Optics,Fluo,Cam,Grid);
    % Image the pattern
    axes(handles.startMenu_fluoDisFig_axes); % gcf = handles.startMenu_fluoDisFig_axes
    imagesc(Grid.blckSize*Grid.sy,Grid.blckSize*Grid.sx,Optics.object);colormap gray;
    axis square;set(gca,'YTick',[]);set(gca,'XTick',[]);
    
    if(get(handles.startMenu_windowsResults_checkbox,'Value'));SOFItutorial_resultsMenu;end;
    %if(get(handles.startMenu_windowsProc_checkbox,'Value'));SOFItutorial_demoMenu;end;
    waitbar(1);
    close(h);

    % enable the demo menu 
    set(handles.startMenu_windowsProc_checkbox,'Enable','on');

    enableDisableEditBoxes(handles,'on',false);
    enableDisableTutorialPanel(hObject,handles,'on','examples');
    set(handles.startMenu_templates_popupmenu,'Enable','on');
    set(findobj('name','SOFItutorial_startMenu'),'Visible','off');
end


% --- Executes during object creation, after setting all properties.
function startMenu_examples_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_examples_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in startMenu_return_pushbutton.
function startMenu_return_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_return_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hMainGui = getappdata(0,'hMainGui');

if ~isempty(getappdata(hMainGui,'SOFI'))
    
    enableDisableEditBoxes(handles,'off',false);
    enableDisableTutorialPanel(hObject,handles,'off','return');
    set(handles.startMenu_twoDiracs_slider,'Enable','off'); 
    set(findobj('Tag','startMenu_fluoDistance_st'),'Enable','off');

    % open the other GUI
    h = waitbar(0,'Opening, please wait...');
    waitbar(1/2);

    if(get(handles.startMenu_windowsProc_checkbox,'Value'));
        if isempty(getappdata(hMainGui,'analog_timeTraces'))
            % disable the demonstration menu
            set(handles.startMenu_windowsProc_checkbox,'Value',0);
            set(handles.startMenu_windowsProc_checkbox,'Enable','off');
        else
            SOFItutorial_demoMenu;
        end
    end;

    if(get(handles.startMenu_windowsResults_checkbox,'Value'))
        if isempty(getappdata(hMainGui,'storm'))
            Grid = getappdata(hMainGui,'Grid');
            storm = zeros(7*Grid.sy,7*Grid.sx);
            %storm = STORMcalculations(hMainGui);
            setappdata(hMainGui,'storm',storm);clear storm;clear Grid;
        end
        SOFItutorial_resultsMenu;
    end
    waitbar(1);
    close(h);

    enableDisableEditBoxes(handles,'on',false);
    set(handles.startMenu_templates_popupmenu,'Enable','on');
    set(handles.startMenu_start_pushbutton,'Enable','on');
    set(handles.startMenu_windowsProc_checkbox,'Enable','on');
    set(findobj('name','SOFItutorial_startMenu'),'Visible','off');
else
    uiwait(errordlg({'No SOFI data' 'Please run the simulation first'},'','nonmodal'));
end

% --- Executes during object creation, after setting all properties.
function startMenu_return_pushbutton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_return_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'Enable','off');

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


% --- Executes on button press in startMenu_run_pushbutton.
function startMenu_run_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_run_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% enableDisableTutorialPanel(hObject,handles,'on','all');
% enableDisableEditBoxes(handles,'on',false);
if(get(handles.startMenu_windowsResults_checkbox,'Value') || get(handles.startMenu_windowsProc_checkbox,'Value'))
    hMainGui = getappdata(0,'hMainGui');

    set(handles.startMenu_return_pushbutton,'Enable','off');
    set(hObject,'Enable','off');

    if(get(handles.startMenu_windowsResults_checkbox,'Value'))
        algorithms;
        uiwait(findobj('name','algorithms'));
    else
        % compute SOFI data
        [SOFI,orders]=SOFIcalculations(hMainGui);
        % store SOFI data in structures and in hMainGui
        setappdata(hMainGui,'SOFI',SOFI);
        setappdata(hMainGui,'sofi_orders',orders);  
    end
    
    if ~isempty(getappdata(hMainGui,'SOFI'))
        % normalize time traces
        stacks_discrete = double(getappdata(hMainGui,'digital_timeTraces'));
        max_digTT = max(stacks_discrete(:));min_digTT = min(stacks_discrete(:));
        stacks_discrete = (stacks_discrete - min_digTT) / (max_digTT - min_digTT);
        setappdata(hMainGui,'digital_timeTraces',stacks_discrete);
        setappdata(hMainGui,'scale_timeTraces',[max_digTT,min_digTT]);
        clear stacks_discrete max_digTT min_digTT;
        
        % open the other GUIs
        h = waitbar(0,'Opening, please wait...');
        waitbar(1/2);
        if(get(handles.startMenu_windowsProc_checkbox,'Value')) &&  ~isempty(getappdata(hMainGui,'analog_timeTraces'))
            SOFItutorial_demoMenu;
        else
            set(handles.startMenu_windowsProc_checkbox,'Value',0);
        end
        
        if(get(handles.startMenu_windowsResults_checkbox,'Value'));SOFItutorial_resultsMenu;end;
        waitbar(1);
        close(h);
        set(findobj('name','SOFItutorial_startMenu'),'Visible','off');
    end
    
    set(handles.startMenu_templates_popupmenu,'Enable','on');
    enableDisableEditBoxes(handles,'on',false);
    enableDisableTutorialPanel(hObject,handles,'on','all');
    % disable tutorial and simulator checkboxes
    set(handles.startMenu_windowsProc_checkbox,'Enable','on');
    set(handles.startMenu_windowsResults_checkbox,'Enable','on');
    
end


% --- Executes on button press in startMenu_saveStack_pushbutton.
function startMenu_saveStack_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_saveStack_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hMainGui = getappdata(0,'hMainGui');

h = waitbar(0,'Saving data, please wait...');
waitbar(1/3);  

if ~isempty(getappdata(hMainGui,'digital_timeTraces'))
    set(hObject,'Enable','off');
    set(handles.startMenu_loadStack_pushbutton,'Enable','off');
    set(handles.startMenu_run_pushbutton,'Enable','off');
    
    % load stack and parameter set
    Optics = getappdata(hMainGui,'Optics');
    Fluo = getappdata(hMainGui,'Fluo');
    Cam = getappdata(hMainGui,'Cam');
    Grid = getappdata(hMainGui,'Grid');
    stacks_discrete = getappdata(hMainGui,'digital_timeTraces');
    stacks_analog = getappdata(hMainGui,'analog_timeTraces');
    
    % save stack and parameter set
    waitbar(2/3);
    foldername = uigetdir(pwd,'Select folder');
    if ~isnumeric(foldername)
        filename = strcat(foldername,'\image_sequence.mat');clear foldername;
        save(filename,'Optics','Fluo','Cam','Grid','stacks_discrete','stacks_analog','-v7.3')
        %uisave({'Optics','Fluo','Cam','Grid','stacks_discrete','stacks_analog'},'image_sequence');
        clear Optics Fluo Cam Grid stacks_discrete stacks_analog;
    end
    set(hObject,'Enable','on');
    set(handles.startMenu_loadStack_pushbutton,'Enable','on');
    set(handles.startMenu_run_pushbutton,'Enable','on');
else
    uiwait(errordlg({'No image sequence in memory' 'please generate a stack'},'','nonmodal'));
end
waitbar(1);close(h);



% --- Executes on button press in startMenu_loadStack_pushbutton.
function startMenu_loadStack_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_loadStack_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.mat','Select the image sequence matlab file');
if ~isnumeric(FileName)
    path = strcat(PathName,strcat('\',FileName));clear PathName;

    h = waitbar(0,'Loading data, please wait...');
    waitbar(1/3); 

    if strcmp(FileName(end-3:end),'.mat')
        temp_struct = load(path);
        timeTraces = temp_struct.stacks_discrete;
    else
        timeTraces = 0;
    end
    clear path;clear FileName;

    if size(timeTraces,1) <= 4096  && size(timeTraces,1) >= 10 && size(timeTraces,1) == size(timeTraces,2) && size(timeTraces,3) >= 15 && isa(timeTraces,'uint16')
        % disable the start menu
        enableDisableEditBoxes(handles,'off',false);
        set(handles.startMenu_twoDiracs_slider,'Enable','off'); 
        set(findobj('Tag','startMenu_fluoDistance_st'),'Enable','off');
        enableDisableTutorialPanel(hObject,handles,'off','all');

        % update hMainGui
        hMainGui = getappdata(0,'hMainGui');
        setappdata(hMainGui,'Optics',temp_struct.Optics);
        setappdata(hMainGui,'Cam',temp_struct.Cam);
        setappdata(hMainGui,'Fluo',temp_struct.Fluo);
        setappdata(hMainGui,'Grid',temp_struct.Grid);
        setappdata(hMainGui,'digital_timeTraces',timeTraces);
        if ~isempty(temp_struct.stacks_analog)
            setappdata(hMainGui,'analog_timeTraces',temp_struct.stacks_analog);
        end
        waitbar(2/3);
        if temp_struct.Fluo.SB
            intensity_peak_mode = true;
        else
            intensity_peak_mode = false;
        end
        setParamFromExamples(handles,temp_struct.Optics,temp_struct.Fluo,temp_struct.Cam,temp_struct.Grid,intensity_peak_mode); 

        % enable the start menu
        enableDisableEditBoxes(handles,'on',false);
        set(handles.startMenu_twoDiracs_slider,'Enable','on'); 
        set(findobj('Tag','startMenu_fluoDistance_st'),'Enable','on');
        enableDisableTutorialPanel(hObject,handles,'on','all');
        % enable the run button
        set(handles.startMenu_run_pushbutton,'Enable','on');
        % plot the preview
        pattern = temp_struct.Optics.object;
        axes(handles.startMenu_fluoDisFig_axes); % gcf = handles.startMenu_fluoDisFig_axes
        if(temp_struct.Grid.sx > 180);pattern = imdilate(pattern,strel('disk',2));end;
        imagesc(temp_struct.Grid.blckSize*temp_struct.Grid.sy,temp_struct.Grid.blckSize*temp_struct.Grid.sx,pattern);colormap gray;
        axis square;% xlabel('pixel x axis','FontSize',8,'FontWeight','bold');ylabel('pixel y axis','FontSize',8,'FontWeight','bold');
        set(gca,'YTick',[]);set(gca,'XTick',[]);
        clear temp_struct;
    else
        uiwait(errordlg({'Image sequence not compatible' 'Please choose an image sequence generated by the GUI'},'','nonmodal'));
    end
    clear timeTraces;
    waitbar(1);close(h);
end


function startMenu_Peak_edit_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_Peak_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

checkValue(hObject,10,65536);
% Hints: get(hObject,'String') returns contents of startMenu_signal_edit as text
%        str2double(get(hObject,'String')) returns contents of startMenu_signal_edit as a double
hMainGui = getappdata(0,'hMainGui');
updateParam(handles,hObject,'Peak','Fluo',hMainGui,1);
% Make sure that Fluo.Ion and Fluo.background are both 0 when Peak is
% non-zero
Fluo = getappdata(hMainGui,'Fluo');
Fluo.Ion = 0;Fluo.background = 0;
setappdata(hMainGui,'Fluo',Fluo);clear Fluo;

% --- Executes during object creation, after setting all properties.
function startMenu_Peak_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_Peak_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in startMenu_radiobutton.
function startMenu_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of startMenu_radiobutton
if get(hObject,'Value')
    set(handles.startMenu_SB_edit,'String','10');set(handles.startMenu_SB_edit,'Enable','on');
    set(handles.startMenu_Peak_edit,'String','8000');set(handles.startMenu_Peak_edit,'Enable','on');
    set(handles.startMenu_signal_edit,'String','0');set(handles.startMenu_signal_edit,'Enable','off');
    set(handles.startMenu_background_edit,'String','0');set(handles.startMenu_background_edit,'Enable','off');
else
    set(handles.startMenu_SB_edit,'String','0');set(handles.startMenu_SB_edit,'Enable','off');
    set(handles.startMenu_Peak_edit,'String','0');set(handles.startMenu_Peak_edit,'Enable','off');
    set(handles.startMenu_signal_edit,'String','400');set(handles.startMenu_signal_edit,'Enable','on');
    set(handles.startMenu_background_edit,'String','4');set(handles.startMenu_background_edit,'Enable','on');
end

hMainGui = getappdata(0,'hMainGui');
updateParam(handles,handles.startMenu_signal_edit,'Ion','Fluo',hMainGui,1);
updateParam(handles,handles.startMenu_background_edit,'background','Fluo',hMainGui,1);
updateParam(handles,handles.startMenu_Peak_edit,'Peak','Fluo',hMainGui,1);
updateParam(handles,handles.startMenu_SB_edit,'SB','Fluo',hMainGui,1);



function startMenu_SB_edit_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_SB_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

checkValue(hObject,1,1000);
% Hints: get(hObject,'String') returns contents of startMenu_signal_edit as text
%        str2double(get(hObject,'String')) returns contents of startMenu_signal_edit as a double
hMainGui = getappdata(0,'hMainGui');
updateParam(handles,hObject,'SB','Fluo',hMainGui,1);
% Make sure that Fluo.Ion and Fluo.background are both 0 when SB is
% available
Fluo = getappdata(hMainGui,'Fluo');
Fluo.Ion = 0;Fluo.background = 0;
setappdata(hMainGui,'Fluo',Fluo);clear Fluo;

% --- Executes during object creation, after setting all properties.
function startMenu_SB_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startMenu_SB_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in startMenu_zoom_pushbutton.
function startMenu_zoom_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to startMenu_zoom_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hMainGui = getappdata(0,'hMainGui');
Fluo = getappdata(hMainGui,'Fluo');
Grid = getappdata(hMainGui,'Grid');

figure('color',[1 1 1],'tag','fig_zoom_preview','name','Preview','position',[400 100 800 600]);
xlabel('Pixel y axis','FontWeight','bold');
ylabel('Pixels x axis','FontWeight','bold');

% sample with upsampled grid
sample = zeros(7*Grid.sy,7*Grid.sx);
if str2double(get(handles.startMenu_number_edit,'String'))~= 0
    for k=1:size(Fluo.emitters,1)
        sample(floor(7*Fluo.emitters(k,1)),floor(7*Fluo.emitters(k,2))) = 1;
    end
    if(Grid.sx > 100);sample = imdilate(sample,strel('disk',2));end;
end
imagesc(sample);colormap gray;axis square;
set(gca,'XTick',[]);set(gca,'YTick',[]);
title('Distribution of Emitters');
