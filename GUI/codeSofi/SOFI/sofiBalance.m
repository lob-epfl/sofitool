%image=sofiBalance(sofi,ratio)
%-----------------------------
%
%Balanced image from linear cumulant images.
%
%Inputs:
% sofi      Linear cumulants of orders 3 and 4
% ratio     On-time ratio (see sofiParameters)
%
%Output:
% image     Balanced cumulant image

%Copyright © 2012 Marcel Leutenegger et al, École Polytechnique Fédérale de Lausanne,
%Laboratoire d'Optique Biomédicale, BM 5.142, Station 17, 1015 Lausanne, Switzerland.
%
%    This program is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with this program.  If not, see <http://www.gnu.org/licenses/>.
%
function image=sofiBalance(sofi,ratio)
if numel(sofi) < 4 || any(cellfun(@isempty,sofi(3:4)))
   error('sofi:orders','Require linear cumulant images of 3rd and 4th order.');
end
cum3=sum(sofi{3}(:,:,:),3);
cum4=sum(sofi{4}(:,:,:),3);
[x,y]=xygrid(size(cum4));
cum3=interpolate(cum3,x,y);
%
% Balance both cumulants.
%
mask=zeros(size(cum3));
mask(ratio > 0.278 & ratio < 0.722)=1;
mask(ratio < 0.128 | ratio > 0.872)=1;
psf=gaussian(1.5);
mask=conv2(psf,psf,mask,'same');
image=mask.*cum4/max(cum4(:)) + (1-mask).*cum3/max(cum3(:));
