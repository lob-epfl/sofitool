function stacks=simStacks(frames,Optics,Cam,Fluo,Grid,intensity_peak_mode,tutorial)

%Simulate the acquisition of an image sequence of blinking emitters.
%
%Inputs:
% frames                number of frames of the simulated image sequence
% Optics                parameters of the optical set-up and sample 
%                       distribution [struct]
% Cam                   parameters of the recording camera [struct]
% Fluo                  parameters of the fluorophore and sample 
%                       fluorescent properties [struct]
% Grid                  parameters of the sampling grid [struct]
% intensity_peak_mode   boolean specifying whether the simulation is based 
%                       on the intensity peak and S/B or on the signal per 
%                       frame and background
% tutorial              boolean specifying whether analog time traces 
%                       should be computed or not
%
%Outputs:
% stacks.analog      Analog signal - Diffraction-limited 
%                    [numel(x) x numel(y) x frames]
% stacks.discrete    Discrete signal as acquired by the camera 
%                    Image sequence [numel(x) x numel(y) x frames]

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

stacks =struct;

% Generating Diffraction-Limited and Noisy Brightness Profiles
[grid,stacks.analog]=simStacksCore(frames,Optics,Cam,Fluo,Grid,intensity_peak_mode,tutorial);

% Discretization: photoelectron conversion, electron multiplication,
% readout and thermal noise
fig = statusbar('Discretization...');
for frame = 1:frames
    stacks.discrete(:,:,frame) = uint16(gamrnd(grid(:,:,frame),Cam.quantum_gain) + Cam.readout_noise*(randn(Grid.sy,Grid.sx)) + Cam.thermal_noise*randn(Grid.sy,Grid.sx));
    fig = statusbar(frame/frames,fig);
end
delete(fig);clear grid;

% compute peak Signal to Noise Ratio and Mean Square Error: need to change simStacksCore-->
% uncomment line: GridblckSize = 1 at the beginning.
% psnr_dB=0;mse=0;maxana=max(stacks.analog(:)); maxdig = max(stacks.discrete(:));
% for k=1:frames
%     mse = mse + (1/frames)*mean(mean((uint8(256*stacks.analog(:,:,k)/maxana) - uint8(256*stacks.discrete(:,:,k)/maxdig)).^2));
%     psnr_dB = psnr_dB + calcPSNR(uint8(256*stacks.analog(:,:,k)/maxana),uint8(256*stacks.discrete(:,:,k)/maxdig),8); 
% end
% psnr_dB = psnr_dB/frames;
% mse_dB = 10*log(mse)/log(10);

end



