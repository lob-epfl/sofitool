function [SOFI,orders] = SOFIcalculations(hMainGui,gpu)
%Applies SOFI algorithm, stores all intermediate images and store 
%the results in the graphics object hMainGui
%
%Inputs:
% hMainGui  handles to SOFIsim interfaces [Figure] 
% gpu       boolean specifying whether CUDA-enabled GPU computing is available
%
%Outputs:
% SOFI      SOFI processing steps results of an input image sequence. 
% orders    cumulant orders for which SOFI images are computed

% Copyright © 2015 Arik Girsault 
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

if nargin < 2 || isempty(gpu)
    gpu=false;
end
    
% Parameters
timeTraces = getappdata(hMainGui,'digital_timeTraces');
Optics = getappdata(hMainGui,'Optics');clear hMainGui;
fwhm = Optics.fwhm_digital;

SOFI = struct();

% SOFI orders to compute
orders = 1:7;
h = waitbar(0,'SOFI calculations, Please Wait...');
waitbar(1/9);

% ---- CROSS-CUMULANTS computation ----
% 2nd order cross-cumulants of pixel time traces 
[SOFI.cumulants_traces] = sofiCumulants2D_traces(timeTraces);
waitbar(2/9);

% cross-cumulants of pixel timeTraces integrated over time
if gpu 
    %[SOFI.cumulants,~]=sofiCumulants(timeTraces,[],[],[],orders,gpu);
    [SOFI.cumulants,~]=sofiCumulants2D(uint16(timeTraces),[],[],[],orders,gpu);
    %figure,imshow(SOFI.cumulants{2},[]);
else
    [SOFI.cumulants,~]=sofiCumulants(timeTraces,[],[],[],orders);
end
waitbar(3/9); 

% cross-cumulants flattened
SOFI.flattened=sofiAllFlatten(SOFI.cumulants);
waitbar(4/9);

% cross-cumulants linearized
SOFI.linearized=sofiLinearize(SOFI.flattened,fwhm);
waitbar(5/9);

% cross-cumulants reconvolution
SOFI.reconvolved=sofiReconvolution(SOFI.linearized,fwhm);
waitbar(6/9);

% parameters of the fluorophores extracted
[SOFI.fluo_ratio,~,~]=sofiParameters(SOFI.linearized);
waitbar(7/9);

% bSOFI
SOFI.balanced=sofiBalance(SOFI.reconvolved,SOFI.fluo_ratio);
waitbar(8/9);

waitbar(9/9);close(h);

end

