function [] = enableDisableTutorialPanel(hObject,handles,mode,name)
%Enables or disables all the buttons of the Launch panel of the 
%SOFItutorial_startMenu
%
%Inputs:
% hObject       handles to current graphics object
% handles       handles to SOFItutorial_startMenu interface [Figure] 
% mode          string specifying whether edit boxes should be enabled 
%               (mode: 'on') or disabled (mode: 'off') 
% name          string specifying from which hObject the function is being 
%               called

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

if ~exist('name','var')
    name = 'all';
end
if strcmp(name,'start')
        set(hObject,'Enable',mode);
        set(handles.startMenu_return_pushbutton,'Enable',mode);
        set(handles.startMenu_examples_popupmenu,'Enable',mode);
elseif strcmp(name,'return')
        set(handles.startMenu_start_pushbutton,'Enable',mode);
        set(hObject,'Enable',mode);
        set(handles.startMenu_examples_popupmenu,'Enable',mode);
        set(handles.startMenu_loadStack_pushbutton,'Enable',mode);
        set(handles.startMenu_saveStack_pushbutton,'Enable',mode);
elseif strcmp(name,'examples')
        set(handles.startMenu_start_pushbutton,'Enable',mode);
        set(handles.startMenu_return_pushbutton,'Enable',mode);
        set(hObject,'Enable',mode);
        set(handles.startMenu_loadStack_pushbutton,'Enable',mode);
        set(handles.startMenu_saveStack_pushbutton,'Enable',mode);
elseif strcmp(name,'all')
        set(handles.startMenu_start_pushbutton,'Enable',mode);
        set(handles.startMenu_return_pushbutton,'Enable',mode);
        set(handles.startMenu_examples_popupmenu,'Enable',mode);
        set(handles.startMenu_templates_popupmenu,'Enable',mode);
        set(handles.startMenu_loadStack_pushbutton,'Enable',mode);
        set(handles.startMenu_saveStack_pushbutton,'Enable',mode);
else
end



