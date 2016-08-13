%% Point spread function and its derivatives generation. 
function [fPSF_decon,fPSF_refine,fPSF_dev_x,fPSF_dev_y,fPSF_dev_z] = ...
    Gen_kernels(x_dim,y_dim,up_decon,up_refine,Gsigma1,Gsigma2,Gsigma_ratio,delta_sigma)

%% PSF for deconvolution steps 1&2
Gsigma1_decon = Gsigma1*up_decon;
Gsigma2_decon = Gsigma2*up_decon;
% generation sub-grid
ind_s= 1/(2);
ind_x = linspace(ind_s,(x_dim)*up_decon-ind_s,(x_dim)*up_decon);
ind_y = linspace(ind_s,(y_dim)*up_decon-ind_s,(y_dim)*up_decon);
[x_kernel_grid, y_kernel_grid] = meshgrid(ind_x,ind_y);
ind_cx = ind_x(round(length(ind_x)/2+0.5));
ind_cy = ind_y(round(length(ind_y)/2+0.5));
scaling = up_decon^2;
% PSF
PSF = (Gsigma_ratio*Gauss_kernel(x_kernel_grid,y_kernel_grid,ind_cx ,ind_cy ,Gsigma1_decon)...
    + (1-Gsigma_ratio)*Gauss_kernel(x_kernel_grid,y_kernel_grid,ind_cx ,ind_cy ,Gsigma2_decon));
PSF = PSF/sum(PSF(:))*scaling;
% Fourier coefficients of PSF
fPSF_decon= single(fft2(ifftshift(PSF)));

%% PSF for refinement step
Gsigma1_refine = Gsigma1*up_refine;
Gsigma2_refine = Gsigma2*up_refine;
scaling = up_refine^2;
delta_eps = 0.5;
% generation sub-grid
ind_x = linspace(ind_s,(x_dim)*up_refine-ind_s,(x_dim)*up_refine);
ind_y = linspace(ind_s,(y_dim)*up_refine-ind_s,(y_dim)*up_refine);
[x_kernel_grid, y_kernel_grid] = meshgrid(ind_x,ind_y);
ind_cx = ind_x(round(length(ind_x)/2+0.5));
ind_cy = ind_x(round(length(ind_y)/2+0.5));

% PSF
PSF = (Gsigma_ratio*Gauss_kernel(x_kernel_grid,y_kernel_grid,ind_cx ,ind_cy ,Gsigma1_refine)...
    + (1-Gsigma_ratio)*Gauss_kernel(x_kernel_grid,y_kernel_grid,ind_cx ,ind_cy ,Gsigma2_refine));
PSF = PSF/sum(PSF(:))*scaling;

% Derivative of PSF in x axis.
PSF_temp1 = (Gsigma_ratio*Gauss_kernel(x_kernel_grid,y_kernel_grid,ind_cx + delta_eps*0.5 ,ind_cy ,Gsigma1_refine)...
    + (1-Gsigma_ratio)*Gauss_kernel(x_kernel_grid,y_kernel_grid,ind_cx + delta_eps*0.5,ind_cy ,Gsigma2_refine));
PSF_temp1 = PSF_temp1/sum(PSF_temp1(:))*scaling;
PSF_temp2 = (Gsigma_ratio*Gauss_kernel(x_kernel_grid,y_kernel_grid,ind_cx - delta_eps*0.5 ,ind_cy ,Gsigma1_refine)...
    + (1-Gsigma_ratio)*Gauss_kernel(x_kernel_grid,y_kernel_grid,ind_cx - delta_eps*0.5,ind_cy ,Gsigma2_refine));
PSF_temp2 = PSF_temp2/sum(PSF_temp2(:))*scaling;
PSF_dev_x = ((PSF_temp2-PSF_temp1))/delta_eps;

% Derivative of PSF in y axis.
PSF_temp1 = (Gsigma_ratio*Gauss_kernel(x_kernel_grid,y_kernel_grid,ind_cx  ,ind_cy+ delta_eps*0.5 ,Gsigma1_refine)...
    + (1-Gsigma_ratio)*Gauss_kernel(x_kernel_grid,y_kernel_grid,ind_cx ,ind_cy + delta_eps*0.5,Gsigma2_refine));
PSF_temp1 = PSF_temp1/sum(PSF_temp1(:))*scaling;
PSF_temp2 = (Gsigma_ratio*Gauss_kernel(x_kernel_grid,y_kernel_grid,ind_cx ,ind_cy - delta_eps*0.5 ,Gsigma1_refine)...
    + (1-Gsigma_ratio)*Gauss_kernel(x_kernel_grid,y_kernel_grid,ind_cx ,ind_cy - delta_eps*0.5,Gsigma2_refine));
PSF_temp2 = PSF_temp2/sum(PSF_temp2(:))*scaling;
PSF_dev_y = ((PSF_temp2-PSF_temp1))/delta_eps;

% Derivative of PSF with respect to width
PSF_temp1 = (Gsigma_ratio*Gauss_kernel(x_kernel_grid,y_kernel_grid,ind_cx,ind_cy ,Gsigma1_refine*(1+delta_sigma/2))...
    + (1-Gsigma_ratio)*Gauss_kernel(x_kernel_grid,y_kernel_grid,ind_cx,ind_cy ,Gsigma2_refine*(1+delta_sigma/2)));
PSF_temp1 = PSF_temp1/sum(PSF_temp1(:))*scaling;
PSF_temp2 = (Gsigma_ratio*Gauss_kernel(x_kernel_grid,y_kernel_grid,ind_cx,ind_cy ,Gsigma1_refine*(1-delta_sigma/2))...
    + (1-Gsigma_ratio)*Gauss_kernel(x_kernel_grid,y_kernel_grid,ind_cx,ind_cy ,Gsigma2_refine*(1-delta_sigma/2)));
PSF_temp2 = PSF_temp2/sum(PSF_temp2(:))*scaling;
PSF_dev_z = ((PSF_temp2-PSF_temp1)/delta_sigma);

% Fourier coefficients of PSF,PSF_dev_x,PSF_dev_y,PSF_dev_z
fPSF_refine= single(fft2(ifftshift(PSF)));
fPSF_dev_x= single(fft2(ifftshift(PSF_dev_x)));
fPSF_dev_y= single(fft2(ifftshift(PSF_dev_y)));
fPSF_dev_z= single(fft2(ifftshift(PSF_dev_z)));
end

