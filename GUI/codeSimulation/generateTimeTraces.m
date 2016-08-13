function [] = generateTimeTraces(hRoot,intensity_peak_mode,tutorial)
%Generate the image sequence of blinking emitters.
%
%Inputs:
% hRoot                 handles to SOFIsim interfaces [Figure] 
% intensity_peak_mode   boolean specifying whether the simulation is based 
%                       on the intensity peak and S/B or on the signal per 
%                       frame and background
% tutorial              boolean specifying whether analog time traces 
%                       should be computed or not

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

% --- Parameters
Optics = getappdata(hRoot,'Optics');
Cam = getappdata(hRoot,'Cam');
Grid = getappdata(hRoot,'Grid');
Fluo = getappdata(hRoot,'Fluo');

% check whether the simulation is based on the intensity peak and S/B 
% or on the signal per frame and background
if intensity_peak_mode
    % adjust signal per frame and background according to Ipeak and S/B
    Fluo.Ion = Fluo.Peak; 
    Fluo.background = (Fluo.Peak/Fluo.SB)/Cam.quantum_gain;
    % store structure Fluo in root
    setappdata(hRoot,'Fluo',Fluo);
else
    intensity_peak_mode = false;
end

% conversion of time unit in frames
Fluo.Ton = Fluo.Ton * Cam.acq_speed; 
Fluo.Toff = Fluo.Toff * Cam.acq_speed;
Fluo.Tbl = Fluo.Tbl * Cam.acq_speed;

% time Traces of the digital signal recorded at the camera
stacks = simStacks(Optics.frames,Optics,Cam,Fluo,Grid,intensity_peak_mode,tutorial);

if tutorial
    % normalize the analog time traces between 0 and 1
    stacks.analog = double(stacks.analog);
    max_anaTT = max(stacks.analog(:));
    min_anaTT = min(stacks.analog(:));
    stacks.analog = (stacks.analog - min_anaTT) / (max_anaTT - min_anaTT);
    clear max_anaTT min_anaTT;
    setappdata(hRoot,'analog_timeTraces',stacks.analog);
end

% store the digital time traces in the root
setappdata(hRoot,'digital_timeTraces',stacks.discrete);
clear stacks; clear Optics; clear Cam; clear Fluo;clear Grid; clear h;

end

