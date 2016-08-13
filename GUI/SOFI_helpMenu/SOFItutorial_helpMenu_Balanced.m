function varargout = SOFItutorial_helpMenu_Balanced(varargin)
% SOFITUTORIAL_HELPMENU_BALANCED MATLAB code for SOFItutorial_helpMenu_Balanced.fig
%      SOFITUTORIAL_HELPMENU_BALANCED, by itself, creates a new SOFITUTORIAL_HELPMENU_BALANCED or raises the existing
%      singleton*.
%
%      H = SOFITUTORIAL_HELPMENU_BALANCED returns the handle to a new SOFITUTORIAL_HELPMENU_BALANCED or the handle to
%      the existing singleton*.
%
%      SOFITUTORIAL_HELPMENU_BALANCED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SOFITUTORIAL_HELPMENU_BALANCED.M with the given input arguments.
%
%      SOFITUTORIAL_HELPMENU_BALANCED('Property','Value',...) creates a new SOFITUTORIAL_HELPMENU_BALANCED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SOFItutorial_helpMenu_Balanced_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SOFItutorial_helpMenu_Balanced_OpeningFcn via varargin.
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
                   'gui_OpeningFcn', @SOFItutorial_helpMenu_Balanced_OpeningFcn, ...
                   'gui_OutputFcn',  @SOFItutorial_helpMenu_Balanced_OutputFcn, ...
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


% --- Executes just before SOFItutorial_helpMenu_Balanced is made visible.
function SOFItutorial_helpMenu_Balanced_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SOFItutorial_helpMenu_Balanced (see VARARGIN)

help = 5;
% Choose default command line output for SOFItutorial_helpMenu_Balanced
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

displayText(hObject,handles,help);
displayAxes(hObject,handles,help);

% UIWAIT makes SOFItutorial_helpMenu_Balanced wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SOFItutorial_helpMenu_Balanced_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
%varargout{1} = handles.output;



function helpMenu_edit_Callback(hObject, eventdata, handles)
% hObject    handle to helpMenu_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of helpMenu_edit as text
%        str2double(get(hObject,'String')) returns contents of helpMenu_edit as a double


% --- Executes during object creation, after setting all properties.
function helpMenu_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to helpMenu_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
