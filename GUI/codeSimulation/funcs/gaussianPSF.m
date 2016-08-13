function [psf,psf_digital,fwhm,fwhm_digital] = gaussianPSF(NA,magn,lambda,radius,pixel_size)
%Computes a gaussian point-spread function whose width is determined by 
%the optical parameters of the system
%
%Inputs:
% NA            numerical aperture
% lambda        wavelength of the source [m]
% radius        molecular radius of the fluorophore [m] 
% pixel_size    physical size of the camera pixel [m] 
%
%Outputs:
% psf           analog point-spread function
% psf_digital   discrete point-spread function
% fwhm          analog full-width-half-maximum [pixels]
% fwhm          discrete full-width-half-maximum [pixels]

% Copyright © 2015 Arik Girsault, Tomas Lukes, Marcel Leutenegger 
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

% Rayleigh criterion: maximum of a airy psf falls onto the first minimum of
% a neighboring airy psf --> maximum of a gaussian psf falls onto the
% half-maximum value of a neighboring gaussian psf

airy_psf_radius = 0.61*lambda/NA; % [m]
airy_psf_radius_digital = 0.61*lambda*magn/(NA); % [m]

fwhm = airy_psf_radius/radius; % pixels, if size of one pixel = size of one fluorophore
fwhm_digital = airy_psf_radius_digital/pixel_size; % pixels

% --- Gaussian Point Spread Function Design
psfSize = 2*round(fwhm_digital)+1;
psfSize_digital = 2*round(fwhm_digital)+1;

psf_digital = fspecial('gaussian',[psfSize_digital psfSize_digital],fwhm_digital/2.3548);
psf = fspecial('gaussian',[psfSize psfSize],fwhm/2.3548); % 2D Gaussian PSF
psf = max(psf_digital(:))*psf/max(psf(:));

end

