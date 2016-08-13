function out=hriSegmentation(Id,LoGsize,out)
% Description
% ===========
% hriSegmentation filters an image with a LaplacianOfGaussian and segments
% it with a threshold for the background
%
% Input
% =====
% Id:   image to be segmented
% bgth: background threshold
%
% Output
% ======
% out.segx,out.segy:    The segments weighted center of gravity
% out.segA,out.segE:    The segments area and energy
%
% Author
% ======
%      Stefan Geissbuehler
%      Swiss Federal Institute of Technology, CH-1015 Lausanne
%      Laboratoire d'optique biomedicale, LOB
%      Biomedical imaging group, BIG

% Copyright © 2011 Stefan Geissbuehler
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.


%Compute Laplacian of Gaussian
Is=LaplacianOfGaussian(Id,LoGsize);

% imagesp(Is,'LoG(Id)');
% disp(min(Is(:)));

%subtract background
bgth = 0.8*min(Is(:)) + 0.2*max(Is(:));
out.bgmap=double((Is<bgth));
Is=out.bgmap.*Id;

%imagesp(Is,'Background subtracted');

%segment processed image
if any(Is(:))
    [S,n]=segmentImage(Is);
% imagesp((S>0),'Segments');

% imagesp(S,'Segments');

%analyze segments
    [out.segx,out.segy,out.segA,out.segE]=analyzeSegments(S,Id,n,1); %ms=1 (Minimum subtraction on)
else
    out.segx = [];
    out.segy = [];
    out.segA = [];
    out.segE = [];
end