function [] = updateAllParams(handles,hMainGui)
%updaParam(handles,hMainGui) create four structures that will contain all
% the parameters of the optical system (entered in the startMenu).
%
%Inputs:
% handles       structure containing all the items from the current graphical
%               inteface
% hMainGui     graphics object to fill with the structures of handles

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

Optics = struct('NA',str2double(get(handles.startMenu_numAperture_edit,'String')),'wavelength',str2double(get(handles.startMenu_wavelength_edit,'String')),'magnification',str2double(get(handles.startMenu_magnification_edit,'String')));
Cam = struct('acq_speed',str2double(get(handles.startMenu_acqSpeed_edit,'String')),'readout_noise',str2double(get(handles.startMenu_readNoise_edit,'String')),'dark_current',str2double(get(handles.startMenu_darkCurrent_edit,'String')),'quantum_efficiency',str2double(get(handles.startMenu_quantumEfficiency_edit,'String')),'gain',str2double(get(handles.startMenu_gain_edit,'String')),'pixel_size',str2double(get(handles.startMenu_pixelSizeX_edit,'String')));
Fluo = struct('density',str2double(get(handles.startMenu_density_edit,'String')),'number',str2double(get(handles.startMenu_number_edit,'String')),'duration',str2double(get(handles.startMenu_duration_edit,'String')),'Peak',str2double(get(handles.startMenu_Peak_edit,'String')),'Ion',str2double(get(handles.startMenu_signal_edit,'String')),'Ton',str2double(get(handles.startMenu_onstate_edit,'String')),'Toff',str2double(get(handles.startMenu_offstate_edit,'String')),'Tbl',str2double(get(handles.startMenu_bleach_edit,'String')),'background',str2double(get(handles.startMenu_background_edit,'String')),'SB',str2double(get(handles.startMenu_SB_edit,'String')),'radius',(str2double(get(handles.startMenu_radius_edit,'String'))/sqrt(str2double(get(handles.startMenu_radius_edit,'String')))));
Grid = struct('sy',str2double(get(handles.startMenu_pixelsX_edit,'String')),'sx',str2double(get(handles.startMenu_pixelsY_edit,'String')));

% ---- conversion in standard units for computation
Fluo.density = Fluo.density * 1e12;                                         % [#/um.^2] --> [#/m.^2]
if(Optics.wavelength > 1);Optics.wavelength = Optics.wavelength * 1e-9;end; % [nm] --> [m]
if(Cam.pixel_size > 1);Cam.pixel_size = Cam.pixel_size * 1e-6;end;          % [um] --> [m]
if(Fluo.Ton > 0.01);Fluo.Ton = Fluo.Ton * 1e-3;end;                          % [ms] --> [s]
if(Fluo.Toff > 0.01);Fluo.Toff = Fluo.Toff * 1e-3;end;                       % [ms] --> [s]
if(Fluo.radius > 0.01);Fluo.radius = Fluo.radius * 1e-9;end;                 % [nm] --> [m]

% ---- user-masked parameters:
% Grid.blckSize = round(Cam.pixel_size/(Optics.magnification*Fluo.radius)); % 1 pixel = 1 fluorophore = 1-10nm
Grid.blckSize = 3;
Cam.thermal_noise = Cam.dark_current/Cam.acq_speed; % # of electrons per pixel per frame at ambiant air (+20°C)
Cam.quantum_gain = Cam.quantum_efficiency * Cam.gain; % # of electrons per incoming photon ;
[Optics.psf,Optics.psf_digital,Optics.fwhm,Optics.fwhm_digital] = gaussianPSF(Optics.NA,Optics.magnification,Optics.wavelength,Fluo.radius,Cam.pixel_size); % Point-spread function of the optical system
[pattern,Fluo.emitters] = emitterGen(Fluo.number,'number',Grid,Cam,Optics);
%pattern = generatePattern(Fluo.number,'number',Grid,Cam,Optics);
Optics.object = pattern; clear pattern;

% ---- converting time in frames
Optics.frames = Cam.acq_speed * Fluo.duration; % number of frames acquired during the experiment

% --- Update hMainGui
setappdata(hMainGui,'Optics',Optics);
setappdata(hMainGui,'Cam',Cam);
setappdata(hMainGui,'Fluo',Fluo);
setappdata(hMainGui,'Grid',Grid);


end

