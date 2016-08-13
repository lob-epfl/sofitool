%Generate the CPU/GPU kernels for computing partial products.
%
%Writes kernels computing T+=A to T+=A.*B.*C.*D.*E.*F.*G.*H.

%Copyright © 2012 Marcel Leutenegger et al, École Polytechnique Fédérale de Lausanne,
%Laboratoire d'Optique Biomédicale, BM 5.142, Station 17, 1015 Lausanne, Switzerland.
%
%    This program is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with this program.  If not, see <http://www.gnu.org/licenses/>.
%
function gpus
for n=1:8
   var=char('A'+(0:n-1));
   arg=sprintf(',%c',var);
   cmd=sprintf('.*%c',var);
   file=fopen(sprintf('gpu%d.m',n),'w');
   fprintf(file,'function term=gpu%d(term%s)\nterm=term + %s;\n',n,arg,cmd(3:end));
   fclose(file);
end
