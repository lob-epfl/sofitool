%[ratio,density,bright]=sofiParameters(sofi,tirf)
%------------------------------------------------
%
%Estimate emitter parameters from flat cumulants.
%
%Inputs:
% sofi      Flat cumulants of orders 2 to 4
% tirf      TIRF illumination if true
%
%Outputs:
% ratio     On-time ratio
% density   Emitter density
% bright    Emitter brightness

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
function [ratio,density,bright]=sofiParameters(sofi,tirf)
if nargin > 1 && tirf
   tirf=2;
else
   tirf=1.5;
end
if numel(sofi) < 4 || any(cellfun(@isempty,sofi(2:4)))
   error('sofi:orders','Require flat cumulant images of 2nd, 3rd and 4th order.');
end
cum2=sofi{2}(:,:,:);
cum3=sofi{3}(:,:,:);
cum4=sofi{4}(:,:,:);
%
% Resample cumulants to highest order.
%
[x,y]=xygrid(size(cum4));
cum2=interpolate(cum2,x,y);
cum3=interpolate(cum3,x,y);
%
% Estimate the parameters.
%
k1=1.5^tirf*cum3./cum2;
k2=2^tirf*cum4./cum2;
t0=1./sum(cum2,3);
t1=sqrt(max(0,3*k1.^2 - 2*k2));
bright=sum(cum2.*t1,3).*t0;
t2=max(0,min(0.5-0.5*k1./t1,1));
ratio=sum(cum2.*t2,3).*t0;
t2=max(0,cum2./(t1.^2.*t2.*(1-t2)));
density=sum(cum2.*t2,3).*t0;
