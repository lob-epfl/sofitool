function [pattern,emitters_position,nPulses,dPulses,sizePattern] = emitterGenRandom(def,defType,Grid,Cam,Optics,genType,shift)
%Generates randomly localized emitters within a given spatial distribution
%
%Inputs:
% def       can either be
%               dPulses: density of emitters [#/um^2], number of points per
%               area
%               nPulses: number of emitters [#]
% defType   type of def, either 'number' or 'density'
% Optics    parameters of the optical set-up and sample 
%           distribution [struct]
% Cam       parameters of the recording camera [struct]
% Fluo      parameters of the fluorophore and sample 
%           fluorescent properties [struct]
% Grid      parameters of the sampling grid [struct]
% gentype   type of the spatial distribution of emitters [string]
% shift     if gentype = 'random' and nPulses = 2, shift specifies the 
%           distance between the two emitters. If gentype = ' ... patches',
%           shift specifies the number of patches.
%
%Outputs:
% pattern               output image with nPulses randomly placed within a
%                       chosen distribution
% emitters_position     (x,y) localization of each emitter
% size                  size of the pattern image (in case of user defined)

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

if ~exist('shift','var')
    shift = round(Grid.sx/4);
end
if ~exist('genType','var')
    genType = 'random';
end
if ~isa(def,'double')
    error('invalid def. Has to be a double (# or density of fluorophores)')
end

% Determine the area one pixel images in the sample plane
pixel_area = (Cam.pixel_size/Optics.magnification).^2; % in [m^2] 
pixel_area = pixel_area * (1e12); % [in um^2]
if strcmp(defType,'number')
    Pulses = def; % in [#]
elseif strcmp(defType,'density')
    Pulses = -def; % in [#/um.^2]    
else
    error('wrong type, replace by either "number" or "density"');
end

% Generate the fluorophores' positions according to different distributions
switch(genType)
    case 'random'
        Grid.template_size = 7;
        [emitters_position(:,1),emitters_position(:,2),nPulses,dPulses]=templateDistribution(Pulses,Grid,'random',pixel_area,shift);
    case 'circular'
        Grid.template_size = 7;
        [emitters_position(:,1),emitters_position(:,2),nPulses,dPulses]=templateDistribution(Pulses,Grid,'circular',pixel_area);    
    case 'circular_patches'
        Grid.template_size = 7;
        % modify number of pulses according to number of patches
        nPatches = shift;%rest = mod(Pulses,nPatches);if rest~=0 && Pulses>0;Pulses = Pulses - rest;end;
        % offset to center of each circularPath
        offset = [0.7071*abs(round(Grid.sy/2)-round(Grid.sy/Grid.template_size))*(2*rand(nPatches,1)-1),0.7071*abs(round(Grid.sx/2)-round(Grid.sx/Grid.template_size))*(-1+2*rand(nPatches,1))];
        
        if strcmp(defType,'density')
            Pulses = -def*nPatches; % in [#/um.^2]    
        end
        % offset k=1, determine the number of pulses per patch and create
        % the first patch
        [emitters_position_init(:,1),emitters_position_init(:,2),nPulses_init,dPulses_init]=templateDistribution(round(Pulses/nPatches),Grid,'circular',pixel_area,offset(1,:)); 
        nPulses = nPulses_init*nPatches;
        dPulses = dPulses_init*nPatches;
        
        emitters_position = zeros(nPulses,2);
        emitters_position(1:nPulses_init,1) = emitters_position_init(:,1);
        emitters_position(1:nPulses_init,2) = emitters_position_init(:,2);
        clear emitters_position_init;
        
        % offset k=2:patches
        for k=2:nPatches
            [emitters_position(1+(k-1)*nPulses/nPatches:(k*nPulses)/nPatches,1),emitters_position(1+(k-1)*nPulses/nPatches:(k*nPulses)/nPatches,2)]=templateDistribution(nPulses/nPatches,Grid,'circular',pixel_area,offset(k,:));
        end
     case 'annular'
        Grid.template_size = 7;
        [emitters_position(:,1),emitters_position(:,2),nPulses,dPulses]=templateDistribution(Pulses,Grid,'annular',pixel_area);    
     case 'annular_patches'
        Grid.template_size = 7;
        % modify number of pulses according to number of patches
        nPatches = shift;%rest = mod(Pulses,nPatches);if rest~=0 && Pulses>0;Pulses = Pulses - rest;end;
        % offset to center of each annular patch
        offset = [0.7071*abs(round(Grid.sy/2)-round(Grid.sy/Grid.template_size))*(2*rand(nPatches,1)-1),0.7071*abs(round(Grid.sx/2)-round(Grid.sx/Grid.template_size))*(-1+2*rand(nPatches,1))];
        
        if strcmp(defType,'density')
            Pulses = -def*nPatches; % in [#/um.^2]    
        end
        % offset k=1, determine the number of pulses per patch and create
        % the first patch
        [emitters_position_init(:,1),emitters_position_init(:,2),nPulses_init,dPulses]=templateDistribution(round(Pulses/nPatches),Grid,'annular',pixel_area,offset(1,:)); 
        nPulses = nPulses_init*nPatches;
        %dPulses = dPulses_init*nPatches;
        
        emitters_position = zeros(nPulses,2);
        emitters_position(1:nPulses_init,1) = emitters_position_init(:,1);
        emitters_position(1:nPulses_init,2) = emitters_position_init(:,2);
        clear emitters_position_init;
        
        % offset k=2:patches
        for k=1:nPatches
            [emitters_position(1+(k-1)*nPulses/nPatches:(k*nPulses)/nPatches,1),emitters_position(1+(k-1)*nPulses/nPatches:(k*nPulses)/nPatches,2)]=templateDistribution(nPulses/nPatches,Grid,'annular',pixel_area,offset(k,:));
        end
     case 'segment'
        Grid.template_size = 5;
        [emitters_position(:,1),emitters_position(:,2),nPulses,dPulses]=templateDistribution(Pulses,Grid,'segment',pixel_area);    
     case 'segment_patches'
        Grid.template_size = 3; % must be greater than 3 at least
        % modify number of pulses according to number of patches
        nPatches = shift;%rest = mod(Pulses,nPatches);if rest~=0 && Pulses>0;Pulses = Pulses - rest;end;
        % offset to center of each segment patch
        offset = [0.7071*abs(round(Grid.sy/2)-round(Grid.sy/Grid.template_size))*(2*rand(nPatches,1)-1),0.7071*abs(round(Grid.sx/2)-round(Grid.sx/Grid.template_size))*(-1+2*rand(nPatches,1))];
        if strcmp(defType,'density')
            Pulses = -def*nPatches; % in [#/um.^2]    
        end
        % offset k=1, determine the number of pulses per patch and create
        % the first patch
        [emitters_position_init(:,1),emitters_position_init(:,2),nPulses_init,dPulses]=templateDistribution(round(Pulses/nPatches),Grid,'segment',pixel_area,offset(1,:)); 
        nPulses = nPulses_init*nPatches;
        %dPulses = dPulses_init*nPatches;
        
        emitters_position = zeros(nPulses,2);
        emitters_position(1:nPulses_init,1) = emitters_position_init(:,1);
        emitters_position(1:nPulses_init,2) = emitters_position_init(:,2);
        clear emitters_position_init;
        
        % offset k=2:patches
        for k=1:nPatches
            [emitters_position(1+(k-1)*nPulses/nPatches:(k*nPulses)/nPatches,1),emitters_position(1+(k-1)*nPulses/nPatches:(k*nPulses)/nPatches,2)]=templateDistribution(nPulses/nPatches,Grid,'segment',pixel_area,offset(k,:));
        end 
    case 'siemens star'
        nCycles=shift;
        Grid.template_size=0.5;
        %rest = mod(Pulses,nPatches);if rest~=0 && Pulses>0;Pulses = Pulses - rest;end;
        [emitters_position(:,1),emitters_position(:,2),nPulses,dPulses]=templateDistribution(Pulses,Grid,'siemens star',pixel_area,nCycles);
    case 'user defined'
        Grid.template_size=0.5;
        [emitters_position(:,1),emitters_position(:,2),nPulses,dPulses,sizePattern]=templateDistribution(Pulses,Grid,'user defined',pixel_area);
        Grid.sy = sizePattern; Grid.sx = sizePattern;
    otherwise 
end

% nPulses = size(emitters_position,1);
% Generate the distribution of fluorophores from their positions
pattern = zeros(Grid.blckSize*Grid.sy,Grid.blckSize*Grid.sx);
for k=1:nPulses
    pattern(floor(Grid.blckSize*emitters_position(k,1)),floor(Grid.blckSize*emitters_position(k,2))) = 1;
end
   
end


