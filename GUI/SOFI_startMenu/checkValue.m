function [] = checkValue(hObject,minV,maxV)
%checks if the value entered by the user in hObject
%is plausible. If not, then readjust value to a reasonable range.
%
%Inputs:
% hObject: UIcontrol of graphic object (edit box)
% minV:    minimum value the edit text can take
% maxV:    maximum value the edit text can take

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
check = str2double(get(hObject,'String'));
if(~isnan(check) && isa(check,'double'))
    check = max([check,minV]);
    check = min([check,maxV]);
else
    clear check;
    check = minV;
end

set(hObject,'String',num2str(check));

end

