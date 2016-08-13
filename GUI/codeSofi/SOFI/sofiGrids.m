%grid=sofiGrids(orders,dims,all)
%-------------------------------
%
%Initialize the partitions and unique pixel grids for the desired cumulant orders.
%
% The coordinates refer to the pixel neighbourhood, which spans 4 pixels along the
% x and y axes (-1:2) and 2 pixels (0:1) along the z axis. The coordinates are put
% as indices into the 4*4*2 pixels neighbourhood. The reference pixel is encoded
% as (1,1,0) corresponding to the origin (x,y,z) = (0,0,0).
%
% The cumulants are evaluated in two steps. First, each basic products described by
% the terms and the pixels fields is accumulated. Secondly, the full partitions by
% the parts field are obtained as products of the basic products. The cumulants are
% then obtained as a weighted sum over these partitions.
%
% The calculation effort is minimized by squeezing out redundant terms. Repeated
% partial products in partial products are not eliminated to keep the evaluation
% simple. By default, it is assumed that the cumulants will be calculated on zero-
% mean pixel traces. Setting the all flag keeps the singular partial products as
% well, which allows calculating the cumulants without prior mean removal.
%
% Grids are cached in a persistent variable for reuse.
%
% The orders are limited to a reasonable range.
%
%Inputs:
% orders    List of orders
% dims      Grid dimensions         {2D}
% all       All terms if true       {no}
%
%Output:
% grid(order)
%  .dists   Total pixel distances [pixel]
%  .parts   Partitions (products) [term index]
%  .shifts  Corner pixels of terms [coordinate]
% grid(1)
%  .pixels  Pixels for terms [coordinate]
%  .terms   Product terms [pixel index]

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
function grid=sofiGrids(orders,dims,all)
persistent grids hashs
if isempty(grids)
   grids=cell(0);
   hashs=zeros(0);
end
orders=unique(round(orders(:)));
orders=orders(orders > 0);
if nargin < 2 || ~isequal(dims,3)
   orders=orders(orders < 9);
   dims=2;
else
   orders=orders(orders < 7);
end
hash=sum(pow2(1,orders-1)) + pow2(dims,24);
if nargin > 2 && all
   hash=hash + pow2(1,20);
   all=@partitions;
else
   all=@products;
end
last=find(hash == hashs);
if last
   grid=grids{last(1)};
   return;
end
for order=orders.'
   parts=feval(all,order);
   pixels=combinations(order,dims);
   grid(order).dists=distances(pixels);
   [grid(order).parts,grid(order).terms,grid(order).shifts]=eliminate(parts,pixels,dims);
end
grid=finalize(grid,orders,dims);
last=numel(hashs) + 1;
grids{last}=grid;
hashs(last)=hash;


%Best pixel combinations and center positions for generating an
%order^dims sub-pixel grid in the unit cell [0,1)*[0,1)*[0,1).
%
function pixels=combinations(order,dims)
if dims > 2
   pixels=nchoosek(uint8(0:31),order);       % pixel combinations
   pixels=cat(3,bitand(pixels,3), ...
      bitand(bitshift(pixels,-2),3), ...     % pixel coordinates
      bitshift(pixels,-4));
else
   pixels=nchoosek(uint8(0:15),order);
   pixels=cat(3,bitand(pixels,3),bitshift(pixels,-2));
end
center=sum(pixels,2)/order;                  % sub-pixel centers
%
% Minimize the total distance of the pixels to their centers.
%
x=double(pixels) - center(:,ones(1,order),:);
x=sum(x(:,:).^2,2);
[x,y]=sort(x);             % v  sort in ascending center position
[center,x]=unique(center(y,dims:-1:1),'first','rows');
pixels=pixels(y(x),:,:);
%
% Retain all centers in the unit cell.
%
if dims > 2
   center(:,1)=center(:,1) + 1;
end
center=all(0.99 < center,2) & all(center < 1.99,2);
pixels=double(pixels(center,:,:));


%Total mutual pixel distances in x, y and z.
%
function dists=distances(pixels)
N=size(pixels,2);
v=repmat(1:N,N-1,1);
m=v(logical(tril(true(N-1,N))));
v=repmat((2:N).',1,N-1);
n=v(logical(tril(true(N-1))));
m=pixels(:,m,:) - pixels(:,n,:);
dists=sqrt(sum(m.^2,2)/N);
dists=dists(:,:);


%Partial products, unique terms and shifts in pixel neighborhood.
%
% parts     Partitions [index]
% pixels    Pixels [coordinate]
% dims      Dimensions {2,3}
%
% parts     Partitions [term index]
% terms     Terms in group [distance]
% shifts    Corner pixels [coordinate]
%
function [parts,terms,shifts]=eliminate(parts,pixels,dims)
[k,m,n]=size(pixels);
pixels=reshape(pixels,k*m,n);
[pixels,n,n]=unique(pixels,'rows');
p=1:size(pixels,1);
p=reshape(p(n),k,m);
%
% List all terms in the pixel group.
%
terms=cat(2,parts{:});
M=size(p,1);
N=numel(terms);
t=cell(M,N);
for n=1:N
   pnt=sort(p(:,terms{1,n}),2);
   str=char(pnt);                            % strings of variable length
   for m=1:M
      terms{m,n}=pnt(m,:);
      t{m,n}=str(m,:);
   end
end
%
% Eliminate multiple term instances.
%
[t,m,n]=unique(t(:));
n=reshape(int16(n),[M N]);
terms=terms(m).';
k=1;
for m=1:numel(parts)
   K=numel(parts{m});
   parts{m}=n(:,k:k+K-1);
   k=k + K;
end
%
% Reference terms to the lower-left corner.
%
N=numel(terms);
s=zeros(N,dims);
for n=1:N
   p=pixels(sort(terms{n}),:);
   s(n,:)=min(p,[],1);
   terms{n}=p-s(n(ones(size(p,1),1)),:);
end
s=uint8(s + 1);
N=numel(parts);
shifts=cell(1,N);
for n=1:N
   p=parts{n};
   shifts{n}=reshape(s(p,:),[size(p) dims]);
end


%Finalize multiple term instance elimination.
%
% grid(order)
%  .parts   Partitions [term index]
%  .terms   Terms in group [distance]
%  .shifts  Corner pixels [coordinate]
% orders    List of orders
% dims      Dimensions {2,3}
%
% grid(1)
%  .pixels  Pixels for terms [coordinate (ascending)]
%  .terms   Product terms [pixel index (ascending)]
%
function grid=finalize(grid,orders,dims)
xyz=[1;4;16];
xyz=xyz(1:dims);
terms=cat(2,grid(orders).terms);
t=cell(size(terms));
for n=1:numel(terms)
   t{n}=char(terms{n}*xyz).';
end
[t,n,m]=unique(t(:));
terms=terms(n);
m=int16(m);
N=0;
for order=orders.'
   parts=grid(order).parts;
   for n=1:numel(parts)
      parts{n}=m(N+double(parts{n}));
   end
   N=N + numel(grid(order).terms);
   grid(order).parts=parts;
end
%
% Store terms and pixels in first order.
%
grid=rmfield(grid,'terms');
term=uint8(zeros(4,4,2));
term(1+cat(1,terms{:})*xyz)=1;
term(term ~= 0)=1:sum(term(:));
for n=1:numel(terms)
   terms{n}=sort(term(1+terms{n}*xyz)).';
end
[x,y,z]=ind2sub(size(term),find(term));
xyz=[x y z] - 1;
grid(1).pixels=xyz(:,1:dims);
grid(1).terms=terms;


%All partitions up to the specified order.
%
function parts=partitions(order,next,parts)
if nargin < 3
   next=0;
   parts={{}};
end
if next < order
   next=next + 1;
   N=numel(parts);
   m=N;
   for n=1:N
      P=numel(parts{n});
      for p=1:P
         m=m + 1;
         parts{m}=parts{n};
         parts{m}{p}(end+1)=next;
      end
      parts{n}{P+1}=next;
   end
   parts=partitions(order,next,parts);
end


%All partitions without mean values (cross-products).
%
function parts=products(order)
parts=partitions(order);
use=true(size(parts));
for k=1:numel(parts)
   use(k)=all(cellfun(@numel,parts{k}) > 1);
end
parts=parts(use);
