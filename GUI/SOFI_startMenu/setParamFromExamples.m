function [] = setParamFromExamples(handles,Optics,Fluo,Cam,Grid,intensity_peak_mode)
%Sets the simulation parameters in the handles from the parameters stored
%in the root structures Cam, Optics, Fluo and Grid
%
%Inputs:
% handles               handles to SOFItutorial_startMenu interface [Figure] 
% Optics                parameters of the optical set-up and sample 
%                       distribution [struct]
% Cam                   parameters of the recording camera [struct]
% Fluo                  parameters of the fluorophore and sample 
%                       fluorescent properties [struct]
% Grid                  parameters of the sampling grid [struct]
% intensity_peak_mode   boolean specifying whether the simulation is based 
%                       on the intensity peak and S/B or on the signal per 
%                       frame and background

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

if ~exist('intensity_peak_mode','var')
    intensity_peak_mode = false;
end

% Optics
set(handles.startMenu_numAperture_edit,'String',num2str(Optics.NA));
set(handles.startMenu_wavelength_edit,'String',num2str(Optics.wavelength*(1e9)));
set(handles.startMenu_magnification_edit,'String',num2str(Optics.magnification));

% Cam
set(handles.startMenu_acqSpeed_edit,'String',num2str(Cam.acq_speed));
set(handles.startMenu_readNoise_edit,'String',num2str(Cam.readout_noise));
set(handles.startMenu_darkCurrent_edit,'String',num2str(Cam.dark_current));
set(handles.startMenu_quantumEfficiency_edit,'String',num2str(Cam.quantum_efficiency));
set(handles.startMenu_gain_edit,'String',num2str(Cam.gain));
set(handles.startMenu_pixelSizeX_edit,'String',num2str(Cam.pixel_size*(1e6)));
set(handles.startMenu_pixelSizeY_edit,'String',num2str(Cam.pixel_size*(1e6)));

% Fluo
%set(handles.startMenu_density_edit,'String',num2str(Fluo.density*(1e-12)));
set(handles.startMenu_density_edit,'String',num2str(Fluo.density));
set(handles.startMenu_number_edit,'String',num2str(Fluo.number));
set(handles.startMenu_duration_edit,'String',num2str(Fluo.duration));
set(handles.startMenu_onstate_edit,'String',num2str(Fluo.Ton*(1e3)));
set(handles.startMenu_offstate_edit,'String',num2str(Fluo.Toff*(1e3)));
set(handles.startMenu_bleach_edit,'String',num2str(Fluo.Tbl));
set(handles.startMenu_radius_edit,'String',num2str((Fluo.radius*(1e9))^2));

if intensity_peak_mode
    set(handles.startMenu_radiobutton,'Value',1);    
    set(handles.startMenu_signal_edit,'String','0');set(handles.startMenu_signal_edit,'Enable','off');
    set(handles.startMenu_background_edit,'String','0');set(handles.startMenu_background_edit,'Enable','off');
    set(handles.startMenu_SB_edit,'String',num2str(Fluo.SB));set(handles.startMenu_SB_edit,'Enable','on');
    set(handles.startMenu_Peak_edit,'String',num2str(Fluo.Peak));set(handles.startMenu_Peak_edit,'Enable','on');
else
    set(handles.startMenu_radiobutton,'Value',0);
    set(handles.startMenu_signal_edit,'String',num2str(Fluo.Ion));set(handles.startMenu_signal_edit,'Enable','on');
    set(handles.startMenu_background_edit,'String',num2str(Fluo.background));set(handles.startMenu_background_edit,'Enable','on');
    set(handles.startMenu_SB_edit,'String','0');set(handles.startMenu_SB_edit,'Enable','off');
    set(handles.startMenu_Peak_edit,'String','0');set(handles.startMenu_Peak_edit,'Enable','off');
end

% Grid
set(handles.startMenu_pixelsX_edit,'String',num2str(Grid.sy));
set(handles.startMenu_pixelsY_edit,'String',num2str(Grid.sx));

end

