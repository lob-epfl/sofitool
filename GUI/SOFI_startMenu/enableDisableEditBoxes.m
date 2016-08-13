function [] = enableDisableEditBoxes(handles,mode,twoDiracs)
%Enables or disables all the edit boxes of the SOFItutorial_startMenu which
%the user can usually edit to enter the simulation parameters
%
%Inputs:
% handles       handles to SOFItutorial_startMenu interface [Figure] 
% mode          string specifying whether edit boxes should be enabled 
%               (mode: 'on') or disabled (mode: 'off') 
% twoDiracs     boolean specifying whether only a subset of edit boxes should be
%               disabled or whether all boxes should

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

if(twoDiracs == false)
    set(handles.startMenu_magnification_edit,'Enable',mode);
    set(handles.startMenu_wavelength_edit,'Enable',mode);
    set(handles.startMenu_numAperture_edit,'Enable',mode);
    set(handles.startMenu_pixelsY_edit,'Enable',mode);
    set(handles.startMenu_pixelSizeY_edit,'Enable',mode);
    set(handles.startMenu_pixelsX_edit,'Enable',mode);
    set(handles.startMenu_pixelSizeX_edit,'Enable',mode);
    set(handles.startMenu_gain_edit,'Enable',mode);
    set(handles.startMenu_quantumEfficiency_edit,'Enable',mode);
    set(handles.startMenu_darkCurrent_edit,'Enable',mode);
    set(handles.startMenu_readNoise_edit,'Enable',mode);
    set(handles.startMenu_acqSpeed_edit,'Enable',mode);
    set(handles.startMenu_radius_edit,'Enable',mode);
    set(handles.startMenu_bleach_edit,'Enable',mode);
    set(handles.startMenu_offstate_edit,'Enable',mode);
    set(handles.startMenu_onstate_edit,'Enable',mode);
    set(handles.startMenu_density_edit,'Enable',mode);
    set(handles.startMenu_number_edit,'Enable',mode);
    set(handles.startMenu_duration_edit,'Enable',mode);
    
    if(get(handles.startMenu_radiobutton,'Value'))
        set(handles.startMenu_SB_edit,'Enable',mode);
        set(handles.startMenu_Peak_edit,'Enable',mode);
    else
        set(handles.startMenu_background_edit,'Enable',mode);
        set(handles.startMenu_signal_edit,'Enable',mode);
    end
    set(handles.startMenu_radiobutton,'Enable',mode);
    set(handles.startMenu_zoom_pushbutton,'Enable',mode);
else
    set(handles.startMenu_magnification_edit,'Enable',mode);
    set(handles.startMenu_density_edit,'Enable',mode);
    set(handles.startMenu_number_edit,'Enable',mode);
end

end

