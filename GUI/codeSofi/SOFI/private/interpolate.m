%Interpolate an image on new sampling grid.
%
% cum    Image to resample
% x,y    New sampling grid
%
% img    Resampled image

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
function img=interpolate(cum,x,y)
N=size(cum,3);
[X,Y]=xygrid(size(cum));
img=zeros([size(x) N]);
for n=1:N
   img(:,:,n)=interpn(X,Y,cum(:,:,n),x,y,'spline');
end
