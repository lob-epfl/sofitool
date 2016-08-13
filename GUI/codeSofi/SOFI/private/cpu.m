%terms=cpu(terms,image,tasks)
%----------------------------
%
%Accumulate partial products from an image in the terms (in place).
%
% terms  Storage for T partial products (double[X Y Z T])
% image  Image(s) to accumulate (double[X Y Z])
% tasks  Task descriptors (int32[1 N])
%
% tasks = [X*Y*Z T factors(1) factor{1} factors(2) factor{2} ...]
%
%     factors  Number of factors in product term
%     factor   Pixels of factors in [0,X*Y*Z) (ascending)
%
% terms(x,y,z,t) += prod(image(x+y*X+z*X*Y+factor{t})
%
%     x,y,z    Coordinates 1..X,1..Y,1..Z
%       t      Product term 1..T

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