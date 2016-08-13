function [Ihr] = STORMcalculations(hMainGui,gpu)
%Applies either STORM or FALCON depending on the CUDA-enabled GPU
%computing availibility
%
%Inputs:
% hMainGui  handles to SOFIsim interfaces [Figure] 
% gpu       boolean specifying whether CUDA-enabled GPU computing is available
%
%Outputs:
% Ihr      STORM image

% Copyright © 2015 Arik Girsault, Tomas Lukes, Stefan Geissbuehler 
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

% profile off
% profile on -history 
if nargin < 2 || isempty(gpu)
    gpu=false;
end

if gpu
    Ihr = falconSTORM(hMainGui);
else
stack = getappdata(hMainGui,'digital_timeTraces');
Optics = getappdata(hMainGui,'Optics');
Fluo = getappdata(hMainGui,'Fluo');
clear hMainGui;

[k,l]=size(stack(:,:,1));
fRes = 7;
Ihr=zeros(k*fRes,l*fRes);

% normalize the discrete time traces between 0 and 1
stack = double(stack);
max_digTT = max(stack(:));min_digTT = min(stack(:));
stack = (stack - min_digTT) / (max_digTT - min_digTT);
clear max_digTT min_digTT;

fig=statusbar('STORM calculations...');
for n=1:Optics.frames
    clear segData a nseg;
    segData = dataSegments(stack(:,:,n),Fluo,Optics);

    a= segData.ru-1;
    nseg=size(segData.d,3);
    xo=zeros(nseg,1);yo=xo;w=xo;A=xo;b=xo;%r=xo;bg=xo;
    
    for m=1:nseg
        %fitGaussian2D_LS has a (0,0) reference for pixel in lower left corner
        [xo(m),yo(m),A(m),w(m),b(m)]=fitGaussian2D_LS(double(segData.d(:,:,m)), segData.ru-0.5, segData.ru-0.5, segData.d(segData.ru,segData.ru,m), segData.ru/2.3548, segData.bg, 'xyAsc'); 
        xo(m)=(segData.xoAbsolute(m)+xo(m)-a);
        yo(m)=(segData.yoAbsolute(m)+yo(m)-a);

        if w(m) < 3
            sigmaE2 = 1;
            s = round(2*sqrt(sigmaE2));

            if s < 20
                x0=fRes*xo(m);x00=round(x0);
                y0=fRes*yo(m);y00=round(y0);

                if x00-s >= 1 && x00+s <= k*fRes && y00-s >= 1 && y00+s <= l*fRes
                    [x,y]=meshgrid((-s:s),(-s:s));
                    Ihr((x00-s:x00+s),(y00-s:y00+s))=Ihr((x00-s:x00+s),(y00-s:y00+s))+1/(2*pi*sigmaE2)*exp(-((x+x00-x0).^2+(y+y00-y0).^2)./(2*sigmaE2));
                end
            end
        end

    end
    fig = statusbar(n/Optics.frames,fig);
end
delete(fig);
end
% profile viewer
% p = profile('info');

