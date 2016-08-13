%[x,y,A,E]=analyzeSegments(S,I,n)
%--------------------------------
%
%Analyze image segments S and image I. 
%ms: minimum subtraction on each segment (on(1)/off(0))
%
% x,y    Intensity center
% A      Segment area
% E      Energy
%
function [x,y,A,E]=analyzeSegments(S,I,n,ms)

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

s=size(S);
i=find(S);
S=S(i);
if nargin < 2
   I=ones(size(S));
else
   I=I(i);
end
if nargin < 3
   n=max(S);
end

[xi,yi]=ind2sub(s,i.');
x=zeros(n,1);
y=x;
A=x;
E=x;

for m=1:n
   t=S == m;
   J=I(t)-ms*min(I(t));
   E(m)=sum(J);
   A(m)=numel(J);
   y(m)=yi(t)*J/E(m);
   x(m)=xi(t)*J/E(m);
end
