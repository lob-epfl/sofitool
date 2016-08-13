%[C,n]=contourLength(S,n)
%------------------------
%
%Contour length C of segments n in segmented image S.
%
function [C,n]=contourLength(S,n)

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

h=zeros(1,size(S,2));
v=zeros(size(S,1),1);
h=diff([h;S;h],1,1);
v=diff([v S v],1,2);
N=max(S(:));
C=hist(abs([h(:);v(:)]),0:N);
if nargin > 1
   C=reshape(C(1+n),size(n));
else
   C=C(2:end);
   n=1:N;
end
