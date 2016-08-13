%[S,n]=segmentImage(I)
%---------------------
%
%Segment an image I and return the segment map S and the number of segments n.
%
function [I,n]=segmentImage(I)
I(end+1,end+1)=0;

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


%
% Segment along x
%
a=find(I);
I(a)=cumsum([1;diff(a) > 1]);
I=I.';
%
% Segment along y
%
a=find(I);
b=I(a);
for n=find(diff(a) == 1).'
   b(b == b(n+1))=b(n);
end
%
% Enumerate segments
%
c=unique(b);
n=numel(c);
d=zeros(c(end),1);
d(c+0)=1:n;          % avoid logicals
I(a)=d(b+0);
I=I(1:end-1,1:end-1).';
