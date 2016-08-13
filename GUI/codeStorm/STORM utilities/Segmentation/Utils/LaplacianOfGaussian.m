%I=LaplacianOfGaussian(I,w)
%--------------------------
%
%Laplacian of Gaussian filter with subsampling and mirrored borders.
%
% I   Image
% w   Width (waist/sqrt(2))
%
function I=LaplacianOfGaussian(I,w)

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

G=exp(-1/w^2*(-0.45-3*ceil(w):0.1:3*ceil(w)+0.5).^2);
G=mean(reshape(G,[10 numel(G)/10]));
G=G/sum(G);

n=numel(G)/2 + 0.5;
I=[I(n:-1:2,:);I;I(end-1:-1:end+1-n,:)];
I=[I(:,n:-1:2) I I(:,end-1:-1:end+1-n)];
I=conv2(G,G,double(I),'valid');

I=[I(2,:);I;I(end-1,:)];
I=[I(:,2) I I(:,end-1)];
I=conv2(I,[0 1 0;1 -4 1;0 1 0],'valid');
