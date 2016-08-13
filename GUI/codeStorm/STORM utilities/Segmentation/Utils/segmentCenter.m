%[x,y,E,n]=segmentCenter(S,I,n)
%------------------------------
%
%Intensity center (x,y) and energy E of segments n in segmented image S.
%
function [x,y,E,n]=segmentCenter(S,I,n)

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

x=size(S);
y=find(S);
S=double(S(y));
if nargin > 1
   I=double(I(y));
else
   I=ones(size(S));
end
[x,y]=ind2sub(x,y);

E=indsum(S,I);
y=indsum(S,y.*I)./E;
x=indsum(S,x.*I)./E;

if nargin > 2
   x=reshape(x(1+n),size(n));
   y=reshape(y(1+n),size(n));
else
   n=1:numel(x);
end
