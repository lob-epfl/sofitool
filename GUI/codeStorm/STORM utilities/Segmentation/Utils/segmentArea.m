%[A,n]=segmentArea(S,n)
%----------------------
%
%Area A of segments n in segmented image S.
%
function [A,n]=segmentArea(S,n)

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

N=max(S(:));
A=hist(S(:),0:N);
if nargin > 1
   A=reshape(A(1+n),size(n));
else
   A=A(2:end);
   n=1:N;
end
