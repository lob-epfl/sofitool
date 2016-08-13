function [] = updateParam(handles,hObject,paramName,type,hRoot,unit_f)
%store the parameter with paramName in the  structure of type 'type' 
%('Cam', 'Optics', 'Fluo' or 'Grid') from the  graphics object in the root
%'root' 
% 
%Inputs:
% handles:   handles structure from SOFItutorial_startMenu
% hObject:   current graphic object
% paramName: name of the parameter
% type:      type of the parameter, either a camera paremeter, a optics
%            parameter, a fluorophore parameter or a grid parameter
% hRoot:     graphics object contaning the structures 'Cam','Optics','Fluo'
%            and 'Grid'
% unit_f:    convert the parameter in standard units (i.e: [nm]-->[m])

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

if(nargin ~= 6);error('missing argument. Type "help updateParam" in the command line');end;
if(~ischar(paramName));error('invalid argument. Type "help updateParam" in the command line');end;

switch(type)
    case 'Cam'
        o = getappdata(hRoot,'Cam');
        o.(paramName) = unit_f * str2double(get(hObject,'String'));
        setappdata(hRoot,'Cam',o);
    case 'Optics'
        o = getappdata(hRoot,'Optics');
        o.(paramName) = unit_f * str2double(get(hObject,'String'));
        setappdata(hRoot,'Optics',o);
    case 'Fluo'
        o = getappdata(hRoot,'Fluo');
        o.(paramName) = unit_f * str2double(get(hObject,'String'));
        setappdata(hRoot,'Fluo',o);
    case 'Grid'
        o = getappdata(hRoot,'Grid');
        o.(paramName) = unit_f * str2double(get(hObject,'String'));
        setappdata(hRoot,'Grid',o);
    otherwise
        error('invalid argument. Type "help storeParam" in the command line');
end

Grid = getappdata(hRoot,'Grid');
Fluo = getappdata(hRoot,'Fluo');
Optics = getappdata(hRoot,'Optics');
Cam = getappdata(hRoot,'Cam');

% If we change a parameter PHYSICALLY related to another, we need to change 
% them in hRoot (store variable)

% % Density of fluorophores in sample
% if(strcmp(paramName,'pixel_size') || strcmp(paramName,'magnification') || strcmp(paramName,'sx') || strcmp(paramName,'sy'))
%     % Modify density in hRoot
%     sample_area = Grid.sx*Grid.sy*(Cam.pixel_size/Optics.magnification).^2; % in [m^2] 
%     number_of_emitters = str2double(get(handles.startMenu_number_edit,'String'));
%     Fluo.density = number_of_emitters/sample_area;
%     setappdata(hRoot,'Fluo',Fluo);
%     % Modify Density in the graphical interface
%     set(handles.startMenu_density_edit,'String',num2str((1e-12)*Fluo.density));
% end

% Block Size (smallest unit on the detector)
% if(strcmp(paramName,'pixel_size') || strcmp(paramName,'magnification') || strcmp(paramName,'radius'))
%     % Modify blckSize in hRoot
%     Grid.blckSize = round(Cam.pixel_size/(Optics.magnification*Fluo.radius));
%     setappdata(hRoot,'Grid',Grid);
% end

% Thermal Noise
if(strcmp(paramName,'dark_current') || strcmp(paramName,'acq_speed'))
    % Modify blckSize in hRoot
    Cam.thermal_noise = Cam.dark_current/Cam.acq_speed; % # of electrons per pixel per frame at ambiant air (+20°C)
    setappdata(hRoot,'Cam',Cam);
end

% Quantum Efficiency
if(strcmp(paramName,'quantum_effiency') || strcmp(paramName,'gain'))
    % Modify blckSize in hRoot
    Cam.quantum_gain = Cam.quantum_efficiency * Cam.gain; % # of electrons per incoming photon ;
    setappdata(hRoot,'Cam',Cam);
end

% Frames
if(strcmp(paramName,'acq_speed') || strcmp(paramName,'duration'))
    % Modify blckSize in hRoot
    Optics.frames = Cam.acq_speed * Fluo.duration; % number of frames acquired during the experiment
    setappdata(hRoot,'Optics',Optics);
end

% Point-Spread Function
if(strcmp(paramName,'NA') || strcmp(paramName,'wavelength') || strcmp(paramName,'magnification') || strcmp(paramName,'radius') || strcmp(paramName,'pixel_size'))
    % Modify psf information in hRoot
    [Optics.psf,Optics.psf_digital,Optics.fwhm,Optics.fwhm_digital] = gaussianPSF(Optics.NA,Optics.magnification,Optics.wavelength,Fluo.radius,Cam.pixel_size); % Point-spread function of the optical system
    setappdata(hRoot,'Optics',Optics);
end

% if we want to ARBITRARLY relate some parameters (for instance to keep a
% square size of the camera), we need to change them altogether in the
% graphical interface and store the changes in hRoot
           
% if(strcmp(paramName,'density'))
%     sample_area = Grid.sx*Grid.sy*(Cam.pixel_size/Optics.magnification).^2; % in [m^2] 
%     sample_area = sample_area * (1e12); % in [um^2]
%     % Modify number in the graphical interface
%     number_of_emitters = round(str2double(get(hObject,'String'))*sample_area);
%     set(handles.startMenu_number_edit,'String',num2str(number_of_emitters));
%     % Modify number accordingly in hRoot
%     Fluo.number = number_of_emitters;
%     setappdata(hRoot,'Fluo',Fluo);
%     
% elseif(strcmp(paramName,'number'))
%     sample_area = Grid.sx*Grid.sy*(Cam.pixel_size/Optics.magnification).^2; % in [m^2] 
%     sample_area = sample_area * (1e12); % in [um^2]
%     % Modify density in the graphical interface
%     density = str2double(get(hObject,'String'))/sample_area; % in [#/um^2]
%     set(handles.startMenu_density_edit,'String',num2str(density));
%     % Modify density accordingly in hMainGui
%     Fluo.density = 1e12 * density; % in [#/m^2]
%     setappdata(hRoot,'Fluo',Fluo);
    
if(strcmp(paramName,'sx'))
    % Modify sy in the graphical interface
    set(handles.startMenu_pixelsX_edit,'String',get(hObject,'String'));
    % Modify sy accordingly in hRoot
    Grid.sy = str2double(get(hObject,'String'));
    setappdata(hRoot,'Grid',Grid);
    
elseif(strcmp(paramName,'sy'))
    % Modify sx in the graphical interface
    set(handles.startMenu_pixelsY_edit,'String',get(hObject,'String'));
    % Modify sx accordingly in hRoot
    Grid.sx = str2double(get(hObject,'String'));
    setappdata(hRoot,'Grid',Grid);
    
else
end

% % Update handles structure
% guidata(hObject, handles);

end

