function [pattern,emitters_position] = emitterGen(def,type,Grid,Cam,Optics,shift)
%emitterGen this function generates an image with arbitrarly or
%randomly positionned dirac pulses
%
%   Inputs:
%       def:
%           dPulses : density of dirac pulses [#/um]
%           nPulses: number of dirac pulses [#]
%           input: input image from which we should generate the pattern
%       type: type of def, either 'number', 'density' or 'image'
%       Grid: structure containing the grid parameters: Grid.blckSize, sx and sy
%       Cam: structure containing the camera parameters 
%       Optics: structure containing the optical parameters
%
%   Output:
%       pattern = output image with nPulses placed either randomly or
%       arbitrarly
if(nargin < 6)
    shift = round(Grid.sx/4);
end
if isa(def,'double') 
    if strcmp(type,'number')
        nPulses = def;
    elseif strcmp(type,'density')
        dPulses = def; % in [#/um.^2], then uncomment next line
        sample_area = Grid.sx*Grid.sy*(Cam.pixel_size/Optics.magnification).^2; % in [m^2] 
        sample_area = sample_area * (1e12); % in [um^2]
        nPulses = round(dPulses * sample_area);
    else
        error('wrong type, replace by either "number" or "density"');
    end
    
    if nPulses == 2
        %if(shift > round(Grid.sx/2)-1); shift=round(Grid.sx/2)-1;end;
        emitters_position = [round(Grid.sy/2),-shift + round(Grid.sx/2);round(Grid.sy/2),shift + round(Grid.sx/2)];
    else
        emitters_position = 2 + [(Grid.sy - 3)*rand(nPulses,1),(Grid.sx - 3)*rand(nPulses,1)];
    end
    pattern = zeros(Grid.blckSize*Grid.sy,Grid.blckSize*Grid.sx);
    for k=1:nPulses
        pattern(floor(Grid.blckSize*emitters_position(k,1)),floor(Grid.blckSize*emitters_position(k,2))) = 1;
    end
    
else
    error('invalid def. Has to be a double (# or density of fluorophores)')
end    



end

