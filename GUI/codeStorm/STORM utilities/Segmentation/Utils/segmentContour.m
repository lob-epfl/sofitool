%C=segmentContour(I)
%-------------------
%
%Find enclosing contours of image segments.
%
function C=segmentContour(I)

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

C=conv2([1 1],[1 1],I ~= 0,'full') > 0;
C=(C(1:end-1,1:end-1) ~= C(2:end,2:end)) | (C(1:end-1,2:end) ~= C(2:end,1:end-1));
C=C | ((C | I) == 0 & conv2([1 1 1],[1 1 1],C | I,'same') == 8);
