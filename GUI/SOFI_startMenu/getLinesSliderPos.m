function [lines] = getLinesSliderPos(upscaled_digTT,slider_pos,blckSize)
%Get the position of the lines from the slider's camera grid of the
%SOFItutorial_demoMenu interface
%
%Inputs:
% upscaled_digTT      discrete image of the image sequence of blinking
%                     emitters incorporating the camera grids (vertical
%                     black lines)
% slider_pos          relative position of the slider in the camera grid
% blckSize            spacing in between the lines defining the camera grid
%
%Outputs:
% lines               position of the lines from the slider's camera grid

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

x1 = [0, size(upscaled_digTT,2)+1];
x2 = x1;
y1 = [1+round(slider_pos*(size(upscaled_digTT,1)-1)), 1+round(slider_pos*(size(upscaled_digTT,1)-1))]; 
%while(upscaled_digTT(y1(1),int)~=0)
while(max(upscaled_digTT(y1(1),:))~=0 && y1(1) < 1+size(upscaled_digTT,1) && y1(1) > blckSize)
    y1 = y1+1;
end
if(y1(1) < blckSize);y1=[1+blckSize,1+blckSize];end;
y2 = y1-blckSize;
% while(upscaled_digTT(y2(1),int)~=0)
%     y2 = y2+1;
% end
% max(upscaled_digTT(y1(1),:))

x3 = [0,0];
x4 = [1+size(upscaled_digTT,2),1+size(upscaled_digTT,2)];
y3 = [y1(1),y2(1)];
y4 = y3;

lines = struct('x1',x1,'x2',x2,'x3',x3,'x4',x4,'y1',y1,'y2',y2,'y3',y3,'y4',y4);
clear x1; clear x2; clear x3; clear x4; clear y1; clear y2; clear y3; clear y4;

end

