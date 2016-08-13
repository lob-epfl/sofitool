%fwhm=sofiPSFfwhm(sofi,grid,orders)
%----------------------------------
%
%Estimate PSF full widths at half-maximum diameters.
%
%Inputs:
% sofi      Raw cumulants
% grid
%  .dists   Total distances
% orders    Cumulant orders   {all}
%
%Output:
% fwhm      Estimated PSF diameter(s) [radial;axial]

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
function fwhm=sofiPSFfwhm(sofi,grid,orders)
if nargin < 3
   orders=find(~cellfun(@isempty,sofi));
end
orders=orders(orders > 1);
if isempty(orders)
   error('sofi:fwhm','Cannot estimate the PSF diameter: no image of cumulant order 2 or higher.');
end
%
% Estimate cumulant ratios within pixel groups.
%
ratios=[];
dists=sofi;
for order=orders(:).'
   image=abs(sofi{order});
   [X,Y,Z,N]=size(image);
   means=zeros(order,Y*Z*N);
   for x=1:order
      means(x,:)=mean(image(x:order:X,:),1);
   end
   image=reshape(means,order,Y,Z*N);
   means=zeros(order,order,Z*N);
   for y=1:order
      means(:,y,:)=mean(image(:,y:order:Y,:),2);
   end
   dists{order}=sum(grid(order).dists(:,1:2).^2,2);
   dims=size(grid(order).dists,2);
   if dims == 3
      dists{order}(:,2)=grid(order).dists(:,3).^2;
      image=reshape(means,order^2,Z,N);
      means=zeros(order^2,order,N);
      for z=1:order
         means(:,z,:)=mean(image(:,z:order:Z,:),2);
      end
   else
      N=Z*N;
   end
   means=reshape(means,order^dims,N);
   means=means./repmat(mean(means,1),order^dims,1);
   ratios=[ratios;mean(means,2)];
end
%
% Find best match with ratios for estimating the FWHM diameters.
%
fwhm=[4;2];       % start values
lower=[1;1];      % lower bounds
upper=[7;3];      % upper bounds
dims=1:dims-1;
fwhm=lsqnonlin(@residuals,fwhm(dims),lower(dims),upper(dims),optimset('Display','off'),dists(orders),ratios);


%Residual differences of ratios.
%
% fwhm      FWHMs of the PSF
% dists     Squared distances
% ratios    Estimated ratios
%
function resid=residuals(fwhm,dists,ratios)
waist=-4.*log(2)./fwhm.^2;
resid=[];
for n=1:numel(dists)
   ratio=exp(dists{n}*waist);
   resid=[resid;ratio./mean(ratio)];
end
resid=resid - ratios;
