function [] = setAnnularEditBoxes(handles)
%Sets the default simulation parameters of emitters distributed in annular
%structures
%
%Inputs:
% handles       handles to SOFItutorial_startMenu interface [Figure] 

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

set(handles.startMenu_magnification_edit,    'String','100');
set(handles.startMenu_wavelength_edit,       'String','600');
set(handles.startMenu_numAperture_edit,      'String','1.3');
set(handles.startMenu_pixelsY_edit,          'String','100');
set(handles.startMenu_pixelSizeY_edit,       'String','6.45');
set(handles.startMenu_pixelsX_edit,          'String','100');
set(handles.startMenu_pixelSizeX_edit,       'String','6.45');
set(handles.startMenu_gain_edit,             'String','6');
set(handles.startMenu_quantumEfficiency_edit,'String','0.7');
set(handles.startMenu_darkCurrent_edit,      'String','0.06');
set(handles.startMenu_readNoise_edit,        'String','1.6');
set(handles.startMenu_acqSpeed_edit,         'String','100');
set(handles.startMenu_radius_edit,           'String','64');
set(handles.startMenu_background_edit,       'String','4');
set(handles.startMenu_bleach_edit,           'String','80');
set(handles.startMenu_offstate_edit,         'String','40');
set(handles.startMenu_onstate_edit,          'String','20');
set(handles.startMenu_signal_edit,           'String','400');
set(handles.startMenu_density_edit,          'String','3.61');
set(handles.startMenu_number_edit,           'String','150');
set(handles.startMenu_duration_edit,         'String','6');

set(handles.startMenu_SB_edit,               'String','0');
set(handles.startMenu_Peak_edit,             'String','0');
set(handles.startMenu_radiobutton,'Value',0);
set(handles.startMenu_SB_edit,'Enable','off');
set(handles.startMenu_Peak_edit,'Enable','off');

end



