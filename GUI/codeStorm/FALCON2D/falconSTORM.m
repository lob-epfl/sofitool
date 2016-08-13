function [SR_img] = falconSTORM(hMainGui)
%Calculates the STORM super-resolved image using FALCON
%
%Inputs:
% hMainGui  handles to SOFIsim interfaces [Figure] 
%
%Outputs:
% SR_img    super-resolved image (rendering of estimated molecular
%           localizations)

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


% --- Simulation setting
Optics = getappdata(hMainGui,'Optics');
Fluo = getappdata(hMainGui,'Fluo');
Cam = getappdata(hMainGui,'Cam');
Grid = getappdata(hMainGui,'Grid');
stack = getappdata(hMainGui,'digital_timeTraces');clear hMainGui;

debug = 0;
up_ren = 7; % up_sampling ratio
speed = 'normal';
numFrame = Optics.frames;
dummyFrame = 0;
baseline = Fluo.background;
EM = Cam.gain;
ADU = 1/EM;
Gsigma1 = round(Optics.fwhm_digital)/2.3548;
Gsigma2 = round(Optics.fwhm_digital)/2.3548;
Gsigma_ratio=1;

h=waitbar(0,'falconSTORM calculations...');

%tic
% --- Reconstruction: estimation of position
[Results,~] = FALCON_GPU_rel2(stack,numFrame,dummyFrame,ADU,baseline,EM,Gsigma1,Gsigma2,Gsigma_ratio,speed,debug);
%[Results,Avg_img] = FALCON_GPU_rel2(stack,numFrame,dummyFrame,ADU,baseline,EM,Gsigma1,Gsigma2,Gsigma_ratio,speed,debug);
waitbar(1/2);
% --- Rendering
img_size = Grid.sx;
[SR_img,~,~] = super_render(img_size,img_size,Results(:,4),Results(:,2:3),up_ren,1); 
%[SR_img,SR_img_scale,SR_img_bin] = super_render(img_size,img_size,Results(:,4),Results(:,2:3),up_ren,1); 
%run_time_GPU = toc;
waitbar(1);
close(h);
%% evaluation
% find the cloest true location within 300nm
% radius = 300; 
% true_poses ~= Fluo.emitters; % true_pos = zeros(num_mol,2,num_frame);
% CC_pitch = 100;
% [num_idens,num_clusters,errors_x,errors_y] = simul_eval(Results,true_poses,CCD_pitch,numFrame,radius);

% display Results
% fprintf('\n\n\n\');
% fprintf('Run time(GPU) : %.2fsec/frame, %.2fms/particle \n',run_time_GPU/numFrame,1000*run_time_GPU/size(Results,1));
% fprintf('Accuracy      : rms_x %.2fnm,  rms_y %.2fnm \n',rms(errors_x),rms(errors_y));
% fprintf('Recall        : %.2f (%.1f/%d) \n',mean(num_idens)/num_mol,mean(num_idens),mean(num_mol));
% fprintf('True-positive : %.2f (%.1f /%.1f) \n',mean(num_idens)/mean(num_clusters),mean(num_idens),mean(num_clusters));


% figure(1);
% subplot(1,3,1,'align')
% imagesc(CCD_imgs(:,:,1)); colormap(hot); axis image; colormap(hot); axis off; axis tight; title('single image');
% subplot(1,3,2,'align')
% imagesc(Avg_img); colormap(hot); axis image; colormap(hot); axis off; axis tight; title('Averaged image');
% subplot(1,3,3,'align')
% imagesc(SR_img); colormap(hot); axis image; colormap(hot); axis off; axis tight; title('Super resolution image');


end

