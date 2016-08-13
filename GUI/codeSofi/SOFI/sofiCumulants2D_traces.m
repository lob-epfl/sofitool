function [sofi_xc] = sofiCumulants2D_traces(timeTraces)
% computes the one-dimensional 2nd order cross-cumulant of the input image
% sequence
%
%Inputs:
% timeTraces    Discrete signal as acquired by the camera image sequence 
%               [numel(x) x numel(y) x frames]
%
%Outputs:
% sofi_xc       1D 2nd order cross-cumulant of the input image sequence 

% Copyright © 2015 Arik Girsault, Tomas Lukes 
% École Polytechnique Fédérale de Lausanne,
% Laboratoire d'Optique Biomédicale, BM 5.142, Station 17, 1015 Lausanne, Switzerland.
% arik.girsault@epfl.ch, tomas.lukes@epfl.ch
% http://lob.epfl.ch/
 
% This file is part of SOFIsim.
%
% SOFIsim is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% SOFIsim is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with SOFIsim.  If not, see <http://www.gnu.org/licenses/>.

timeTraces1D = squeeze(timeTraces(floor(size(timeTraces,1)/2)+1,:,:)); 
timeTraces1D = timeTraces1D./max(timeTraces1D(:));

maxLag = size(timeTraces1D,2);  % x axis: time ---> number of columns
maxPosX = size(timeTraces1D,1); % y axis: xpos ---> number of lines

% 1D Cross-Cumulants 2nd order (cross-correlations): interpixels are
% computed
sofi_xc = zeros(2*maxPosX-1,maxLag);

first = timeTraces1D(1,:)-mean(timeTraces1D(1,:));
prev_last = timeTraces1D(end-1,:)-mean(timeTraces1D(end-1,:));
last = timeTraces1D(end,:)-mean(timeTraces1D(end,:));

autoCum_1 = xcorr(first,first,maxLag);clear first;
autoCum_2 = xcorr(last,last,maxLag);
xCum_1 = xcorr(last,prev_last,maxLag);clear last; clear prev_last;

sofi_xc(1,:)=autoCum_1(2+maxLag:end); clear autoCum_1;
sofi_xc(end-1,:)=xCum_1(2+maxLag:end); clear xCum_1;
sofi_xc(end,:)=autoCum_2(2+maxLag:end); clear autoCum_2;

for m = 2:maxPosX-1
    temp_prev = timeTraces1D(m-1,:);
    temp = timeTraces1D(m,:);
    temp_lag = timeTraces1D(m+1,:);
    
    xCum = xcorr(temp_lag-mean(temp_lag(:)),temp_prev-mean(temp_prev(:)),maxLag);
    sofi_xc(2*(m-1)+1,:)=xCum(2+maxLag:end);clear xCum;
    xCum_inter = xcorr(temp-mean(temp(:)),temp_prev-mean(temp_prev(:)),maxLag);
    sofi_xc(2*(m-1),:) = xCum_inter(2+maxLag:end);clear xCum_inter;
end

sofi_xc = sofi_xc./max(sofi_xc(:)); 
clear maxLag; clear maxPosX;

end