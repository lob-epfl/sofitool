function [xp_est, yp_est, A_est, s_est, bgr_est, r] = fitGaussian2D_LS(data, x0, y0, A0, sigma, bgr, mode)
% data is supposed to contain a single spot located at the intensity maximum

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


% max_idx = find(data == max(data(:)));
% [y0 x0] = ind2sub(size(data), max_idx(1)); % convention: imagesc IP coordinates
% x0 = x0-1;
% y0 = y0-1;

% [x,y] = ndgrid(0:size(data,2)-1,0:size(data,1)-1);
% xa = 0:size(data,2)-1;
% ya = 0:size(data,1)-1;
% figure; imagesc(xa,ya,data); colormap(gray(256)); axis equal tight; hold on; plot(x0,y0,'ro');


%data_nobg = data - bgr;
%sum_data = sum(data_nobg(:));
%x0 = sum(sum(x.*data_nobg)) / sum_data;
%y0 = sum(sum(y.*data_nobg)) / sum_data;

%A0 = max(data_nobg(:)) - bgr;
%figure; imagesc(data); colormap(gray(256)); colorbar; axis('image');

opts = optimset('Jacobian', 'on', ...
                'MaxFunEvals', 1e4, ...
                'MaxIter', 1e4, ...
                'Display', 'off', ...
                'TolX', 1e-6, ...
                'Tolfun', 1e-6);
            %                'LargeScale', 'off', ...
             %   'LevenbergMarquardt', 'on', ...
%opts = ['Jacobian', 'off'];            
%'TypicalX', [0.5*xstep, 0.5*xstep, A_est, xstep]


if (strcmp(mode, 'xyAsc') == 1)
    %sx0 = sqrt( sum(sum(x.^2.*data_nobg))/sum_data - x0^2 );
    %sy0 = sqrt( sum(sum(y.^2.*data_nobg))/sum_data - y0^2 );
    %s0 = (sx0+sy0)/2;
    [xp_est yp_est A_est s_est bgr_est r] = xyAsc_MrqLv_Gaussian(x0, y0, A0, sigma, bgr, data, opts);
elseif (strcmp(mode, 'xyAs') == 1)
    [xp_est yp_est A_est s_est r] = xyAs_MrqLv_Gaussian(x0, y0, A0, sigma, bgr, data, opts);
    bgr_est = bgr;
elseif (strcmp(mode, 'xys') == 1)
    [xp_est yp_est s_est r] = xys_MrqLv_Gaussian(x0, y0, A0, sigma, bgr, data, opts);
    A_est = A0;
    bgr_est = bgr;
elseif (strcmp(mode, 'xyA') == 1)
    [xp_est yp_est A_est r] = xyA_MrqLv_Gaussian(x0, y0, A0, sigma, bgr, data, opts);
    s_est = sigma;
    bgr_est = bgr; 
elseif (strcmp(mode, 'xyAc') == 1)
    [xp_est yp_est A_est bgr_est r] = xyAc_MrqLv_Gaussian(x0, y0, A0, sigma, bgr, data, opts);
    s_est = sigma;    
elseif (strcmp(mode, 'xy'))
    [xp_est yp_est r] = xy_MrqLv_Gaussian(x0, y0, A0, sigma, bgr, data, opts);
    s_est = sigma;
    A_est = A0;
    bgr_est = bgr;
elseif (strcmp(mode, 'As'))
    [A_est s_est r] = As_MrqLv_Gaussian(x0, y0, A0, sigma, bgr, data, opts);
    xp_est = x0;
    yp_est = y0;
    bgr_est = bgr;    
elseif (strcmp(mode, 's'))
    [s_est r] = s_MrqLv_Gaussian(x0, y0, A0, sigma, bgr, data, opts);
    A_est = A0;
    xp_est = x0;
    yp_est = y0;
    bgr_est = bgr;    
else
    error('unknown mode');
end;




function [xp_est yp_est r] = xy_MrqLv_Gaussian(xp_est, yp_est, A, sigma, b, data, opts)
[x,r] = lsqnonlin(@cost_xy, [xp_est yp_est], [], [], opts, data, sigma, A, b);
xp_est = x(1);
yp_est = x(2);


function [xp_est yp_est A_est s_est bgr_est r] = xyAsc_MrqLv_Gaussian(xp_est, yp_est, A_est, s_est, bgr_est, data, opts)
[x,r] = lsqnonlin(@cost_xyAsc, [xp_est yp_est A_est s_est bgr_est], [], [], opts, data);
xp_est = x(1);
yp_est = x(2);
A_est = x(3);
s_est = x(4);
bgr_est = x(5);


function [xp_est yp_est A_est bgr_est r] = xyAc_MrqLv_Gaussian(xp_est, yp_est, A_est, sigma, bgr_est, data, opts)
[x,r] = lsqnonlin(@cost_xyAc, [xp_est yp_est A_est bgr_est], [], [], opts, data, sigma);
xp_est = x(1);
yp_est = x(2);
A_est = x(3);
bgr_est = x(4);


function [xp_est yp_est s_est r] = xys_MrqLv_Gaussian(xp_est, yp_est, A, s_est, bgr, data, opts)
[x,r] = lsqnonlin(@cost_xys, [xp_est yp_est s_est], [], [], opts, data, A, bgr);
xp_est = x(1);
yp_est = x(2);
s_est = x(3);


function [xp_est yp_est A_est r] = xyA_MrqLv_Gaussian(xp_est, yp_est, A_est, sigma, bgr, data, opts)
[x,r] = lsqnonlin(@cost_xyA, [xp_est yp_est A_est], [], [], opts, data, sigma, bgr);
xp_est = x(1);
yp_est = x(2);
A_est = x(3);


function [xp_est yp_est A_est s_est r] = xyAs_MrqLv_Gaussian(xp_est, yp_est, A_est, s_est, bg_est, data, opts)
[x,r] = lsqnonlin(@cost_xyAs, [xp_est yp_est A_est s_est], [], [], opts, data, bg_est);
xp_est = x(1);
yp_est = x(2);
A_est = x(3);
s_est = x(4);

function [A_est s_est r] = As_MrqLv_Gaussian(xp_est, yp_est, A_est, s_est, bg_est, data, opts)
[x,r] = lsqnonlin(@cost_As, [A_est s_est], [], [], opts, data, xp_est, yp_est, bg_est);
A_est = x(1);
s_est = x(2);

function [s_est r] = s_MrqLv_Gaussian(xp_est, yp_est, A_est, s_est, bg_est, data, opts)
[x,r] = lsqnonlin(@cost_s, [s_est], [], [], opts, data, A_est, xp_est, yp_est, bg_est);
s_est = x(1);


function [v, J] = cost_xyAsc(p, data)
xp = p(1);
yp = p(2);
A = p(3);
s = p(4);
b = p(5);
[x,y] = ndgrid(0:size(data,1)-1,0:size(data,2)-1);
r2 = (x-xp).^2+(y-yp).^2;
g_dA = exp(-r2/(2*s^2));
g_db = A*g_dA;
g_dxp = (x-xp)./s^2.*g_db;
g_dyp = (y-yp)./s^2.*g_db;
g_ds = r2/s^3.*g_db;
g = g_db + b;
g_db = ones(size(data));
v = g - data;
N = numel(data);
J = [reshape(g_dxp, [N 1]) reshape(g_dyp, [N 1]) reshape(g_dA, [N 1]) reshape(g_ds, [N 1]) reshape(g_db, [N 1])];

function [v, J] = cost_xyAs(p, data, b)
xp = p(1);
yp = p(2);
A = p(3);
s = p(4);
[x,y] = ndgrid(0:size(data,1)-1,0:size(data,2)-1);
r2 = (x-xp).^2+(y-yp).^2;
g_dA = exp(-r2/(2*s^2));
g_db = A*g_dA;
g_dxp = (x-xp)./s^2.*g_db;
g_dyp = (y-yp)./s^2.*g_db;
g_ds = r2/s^3.*g_db;
g = g_db + b;
v = g - data;
N = numel(data);
J = [reshape(g_dxp, [N 1]) reshape(g_dyp, [N 1]) reshape(g_dA, [N 1]) reshape(g_ds, [N 1])];


function [v, J] = cost_xyAc(p, data, s)
xp = p(1);
yp = p(2);
A = p(3);
b = p(4);
[x,y] = ndgrid(0:size(data,1)-1,0:size(data,2)-1);
r2 = (x-xp).^2+(y-yp).^2;
g_dA = exp(-r2/(2*s^2));
g_db = A*g_dA;
g_dxp = (x-xp)./s^2.*g_db;
g_dyp = (y-yp)./s^2.*g_db;
g = g_db + b;
g_db = ones(size(data));
v = g - data;
N = numel(data);
J = [reshape(g_dxp, [N 1]) reshape(g_dyp, [N 1]) reshape(g_dA, [N 1]) reshape(g_db, [N 1])];


function [v, J] = cost_xys(p, data, A, b)
xp = p(1);
yp = p(2);
s = p(3);
[x,y] = ndgrid(0:size(data,1)-1,0:size(data,2)-1);
r2 = (x-xp).^2+(y-yp).^2;
g_db = A*exp(-r2/(2*s^2));
g_dxp = (x-xp)./s^2.*g_db;
g_dyp = (y-yp)./s^2.*g_db;
g_ds = r2/s^3.*g_db;
g = g_db + b;
v = g - data;
N = numel(data);
J = [reshape(g_dxp, [N 1]) reshape(g_dyp, [N 1]) reshape(g_ds, [N 1])];


function [v, J] = cost_xyA(p, data, s, b)
xp = p(1);
yp = p(2);
A = p(3);
[x,y] = ndgrid(0:size(data,1)-1,0:size(data,2)-1);
r2 = (x-xp).^2+(y-yp).^2;
g_dA = exp(-r2/(2*s^2));
g_db = A*g_dA;
g_dxp = (x-xp)./s^2.*g_db;
g_dyp = (y-yp)./s^2.*g_db;
g = g_db + b;
v = g - data;
N = numel(data);
J = [reshape(g_dxp, [N 1]) reshape(g_dyp, [N 1]) reshape(g_dA, [N 1])];


function [v, J] = cost_xy(p, data, s, A, b)
xp = p(1);
yp = p(2);
[x,y] = ndgrid(0:size(data,1)-1,0:size(data,2)-1);
r2 = (x-xp).^2+(y-yp).^2;
g_dA = exp(-r2/(2*s^2));
g_db = A*g_dA;
g_dxp = (x-xp)./s^2.*g_db;
g_dyp = (y-yp)./s^2.*g_db;
g = g_db + b;
v = g - data;
N = numel(data);
J = [reshape(g_dxp, [N 1]) reshape(g_dyp, [N 1])];


function [v, J] = cost_As(p, data, xp, yp, b)
A = p(1);
s = p(2);
[x,y] = ndgrid(0:size(data,1)-1,0:size(data,2)-1);
r2 = (x-xp).^2+(y-yp).^2;
g_dA = exp(-r2/(2*s^2));
g = A*g_dA;
g_ds = r2/s^3.*g;
g = g + b;
v = g - data;
N = numel(data);
J = [reshape(g_dA, [N 1]) reshape(g_ds, [N 1])];

function [v, J] = cost_s(p, data, A, xp, yp, b)
s = p(1);
[x,y] = ndgrid(0:size(data,1)-1,0:size(data,2)-1);
r2 = (x-xp).^2+(y-yp).^2;
g_dA = exp(-r2/(2*s^2));
g = A*g_dA;
g_ds = r2/s^3.*g;
g = g + b;
v = g - data;
N = numel(data);
J = [reshape(g_ds, [N 1])];