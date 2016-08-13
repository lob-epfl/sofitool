function varargout = algorithms(varargin)
% ALGORITHMS MATLAB code for algorithms.fig
%      ALGORITHMS, by itself, creates a new ALGORITHMS or raises the existing
%      singleton*.
%
%      H = ALGORITHMS returns the handle to a new ALGORITHMS or the handle to
%      the existing singleton*.
%
%      ALGORITHMS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ALGORITHMS.M with the given input arguments.
%
%      ALGORITHMS('Property','Value',...) creates a new ALGORITHMS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before algorithms_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to algorithms_OpeningFcn via varargin.
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
                   'gui_OpeningFcn', @algorithms_OpeningFcn, ...
                   'gui_OutputFcn',  @algorithms_OutputFcn, ...
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


% --- Executes just before algorithms is made visible.
function algorithms_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to algorithms (see VARARGIN)

% Choose default command line output for algorithms
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes algorithms wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = algorithms_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in algorithms_sofi_menu.
function algorithms_sofi_menu_Callback(hObject, eventdata, handles)
% hObject    handle to algorithms_sofi_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns algorithms_sofi_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from algorithms_sofi_menu


% --- Executes during object creation, after setting all properties.
function algorithms_sofi_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to algorithms_sofi_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in algorithms_storm_menu.
function algorithms_storm_menu_Callback(hObject, eventdata, handles)
% hObject    handle to algorithms_storm_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns algorithms_storm_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from algorithms_storm_menu


% --- Executes during object creation, after setting all properties.
function algorithms_storm_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to algorithms_storm_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in algorithms_run_pushbutton.
function algorithms_run_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to algorithms_run_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hMainGui = getappdata(0,'hMainGui');

contentsStorm = cellstr(get(handles.algorithms_storm_menu,'String')); 
valStorm = cellstr(contentsStorm{get(handles.algorithms_storm_menu,'Value')});

contentsSofi = cellstr(get(handles.algorithms_sofi_menu,'String')); 
valSofi = cellstr(contentsSofi{get(handles.algorithms_sofi_menu,'Value')});

if strcmp(valSofi{1},'2D SOFI GPU') || strcmp(valStorm{1},'FalconSTORM GPU')
    gpu = cudaAvailable;
    if(~gpu)
        uiwait(errordlg({'GPU-enabled computing not available' 'please switch to 2D SOFI and STORM algorithms'},'GPU alert','modal'));
        %msgbox({'GPU-enabled computing not available' 'please switch to 2D SOFI and STORM algorithms'},'GPU alert','help','replace');
    else
        set(hObject,'Enable','off');
        set(handles.algorithms_cancel_pushbutton,'Enable','off');
        set(handles.algorithms_storm_menu,'Enable','off');
        set(handles.algorithms_sofi_menu,'Enable','off');
        
        if strcmp(valSofi{1},'2D SOFI GPU') && strcmp(valStorm{1},'FalconSTORM GPU')
            
            [SOFI,orders]=SOFIcalculations(hMainGui,gpu);
            setappdata(hMainGui,'SOFI',SOFI);clear SOFI;
            setappdata(hMainGui,'sofi_orders',orders);clear sofi_orders;
            
            storm = STORMcalculations(hMainGui,gpu);
            setappdata(hMainGui,'storm',storm);clear storm;
            
            close(findobj('name','algorithms'));
        elseif strcmp(valSofi{1},'2D SOFI GPU') && strcmp(valStorm{1},'STORM')
            
            [SOFI,orders]=SOFIcalculations(hMainGui,gpu);
            setappdata(hMainGui,'SOFI',SOFI);clear SOFI;
            setappdata(hMainGui,'sofi_orders',orders);clear sofi_orders;
            
            storm = STORMcalculations(hMainGui,false);
            setappdata(hMainGui,'storm',storm);clear storm;
            
            close(findobj('name','algorithms'));
        elseif strcmp(valSofi{1},'2D SOFI GPU') && strcmp(valStorm{1},'None')
            
            [SOFI,orders]=SOFIcalculations(hMainGui,gpu);
            setappdata(hMainGui,'SOFI',SOFI);clear SOFI;
            setappdata(hMainGui,'sofi_orders',orders);clear sofi_orders;
            Grid= getappdata(hMainGui,'Grid');
            
            storm = zeros(7*Grid.sy,7*Grid.sx);
            setappdata(hMainGui,'storm',storm);clear storm;
            
            close(findobj('name','algorithms'));
        elseif strcmp(valSofi{1},'2D SOFI') && strcmp(valStorm{1},'FalconSTORM GPU')
            
            [SOFI,orders]=SOFIcalculations(hMainGui,false);
            setappdata(hMainGui,'SOFI',SOFI);clear SOFI;
            setappdata(hMainGui,'sofi_orders',orders);clear sofi_orders;
            
            storm = STORMcalculations(hMainGui,gpu);
            setappdata(hMainGui,'storm',storm);clear storm;
            
            close(findobj('name','algorithms'));
        else
        end
    end
else
    set(hObject,'Enable','off');
    set(handles.algorithms_cancel_pushbutton,'Enable','off');
    set(handles.algorithms_storm_menu,'Enable','off');
    set(handles.algorithms_sofi_menu,'Enable','off');
        
    [SOFI,orders]=SOFIcalculations(hMainGui,false);
    setappdata(hMainGui,'SOFI',SOFI);clear SOFI;
    setappdata(hMainGui,'sofi_orders',orders);clear sofi_orders;
    
    if strcmp(valStorm{1},'None')
        Grid = getappdata(hMainGui,'Grid');
        storm = zeros(7*Grid.sy,7*Grid.sx);
    else 
        storm = STORMcalculations(hMainGui,false);
    end
    setappdata(hMainGui,'storm',storm);clear storm;
    
    close(findobj('name','algorithms'));
end



% --- Executes on button press in algorithms_cancel_pushbutton.
function algorithms_cancel_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to algorithms_cancel_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(findobj('name','algorithms'));
