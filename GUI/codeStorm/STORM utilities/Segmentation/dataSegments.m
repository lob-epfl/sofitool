function segData = dataSegments(Id,Fluo,Optics)

% Copyright © 2015 Arik Girsault, Stefan Geissbuehler
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

    segData = struct('ru',round(Optics.fwhm_digital),'nh',0,'bg',Fluo.background);
    alol=Optics.fwhm_digital;aupl=4*Optics.fwhm_digital;
    
    segData=hriSegmentation(Id,Optics.fwhm_digital/sqrt(2),segData);
    segData=hriFilterSegments(Id,aupl,alol,segData);
    
end

