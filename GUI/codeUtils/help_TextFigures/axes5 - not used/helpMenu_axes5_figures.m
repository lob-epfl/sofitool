% SOFI tutorial 
% start from diract pulses, simulate signal and calculate correlation analysis
% Created by Tomas Lukes and Arik Girsault
% last change 17.2.2015

% used to generate SOFI tutorial diagram

clear all; close all; clc;
% outputPath = 'charts_tutorialDiagram'; % folder where the output figures will be saved
% export = 0; % export figure to outputPath folder (export = 1), do not export (export = 0) 

% ------------ Sample Characteristics -------------------------------------
% ------------

% Parameters of the fluorophores
Ion = 2000; % Signal per frame (on state) [photon]
Ton = 2; % Average duration of the on state [frame]
Toff = 4; % Average duration of the off state [frame]
Tbl = 8000; % Average bleaching time (on state) [frame]
b = 100; % Background of the test image [photons]
fluorophore_size = 10e-9; % size of the fluorophore [m]
room_temperature = 20+273.15; % [kelvins]

% Fluorophore Parameters
Fluo = struct('Ion',Ion,'Ton',Ton,'Toff',Toff,'Tbl',Tbl,'background',b,'radius',fluorophore_size,'temperature',room_temperature);
clear Ion Ton Toff Tbl b fluorophore_size room_temperature;
% ------------- Optical System --------------------------------------------
% -------------
% n : immersion index
% alpha : opening angle
% D : diameter of the pupil (assumed to be circular)
% f : focal length

% numerical aperture of the system
% NA = n*sin(alpha)                                                      
% NA = n D/2f  

% --- Camera Parameters: hamamatsu orca flash4
gain = 6;% # of electrons per photons absorbed by the CCD camera: can vary between 3 to 7

acq_speed = 100;                          % [frames/s]
frames = 300;                             % frames acquired for computation of a SOFI image
readout_noise = 1.6;                      % root mean square (randn between 0 and 1 -> multiply by readout noise)
dark_current = 0.06;                      % # of electrons per pixel per s at ambiant air (+20°C)
thermal_noise = dark_current/acq_speed;   % # of electrons per pixel per frame at ambiant air (+20°C)
quantum_efficiency = 0.7;                 % percentage of photons used to generate electrons at 600nm (0.5 at 750nm)
quantum_gain = quantum_efficiency * gain; % # of electrons per incoming photon 
pixel_size = 6.45e-6;                     % 6.45um x 6.45um 
nPixels = 2048;                           % # of pixels along horizontal and vertical direction of the camera

% Camera Parameters
Cam = struct('acq_speed',acq_speed,'pixel_size',pixel_size,'e_gain',gain,'quantum_gain',quantum_gain,'readout_noise',readout_noise,'thermal_noise',thermal_noise);
clear gain acq_speed readout_noise dark_current thermal_noise quantum_efficiency quantum_gain pixel_size nPixels;
% --- Diffraction Limited System

NA = 0.8;             % numerical aperture
lambda = 600e-9;    % wavelength of light                                       
% n_index=1;          % index {air=1}
magn = 100;          % magnification
Optics = struct('NA',NA,'wavelength',lambda,'magnification',magn,'frames',frames);

[Optics.psf,Optics.fwhm] = gaussianPSF(Optics.NA,Optics.wavelength,Fluo.radius);
clear NA lambda magn frames;

% ------------ Sampling Grid Characteristics ------------------------------
% ------------

% analogic signal: [blckSize*sy,blckSize*sx] ---> arriving on the camera
% discrete signal: [sy,sx]--> recorded by the camera
blckSize = round(Cam.pixel_size/(Optics.magnification*Fluo.radius)); % 1 pixel = 1 fluorophore = 1-10nm
sy = 30; sx = 30; % virtual number of pixels on the camera: 30 x 30

% Grid Parameters
Grid = struct('blckSize',blckSize,'sy',sy,'sx',sx); 
clear blckSize sy sx;
% ------------ Generate time lapse video of blinking fluorophores ---------
% ------------

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TUTORIAL %%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
%                                                                         %
%   Up to this point, we have prepared the input image: it is either      %
%   randomly generated based on the density or number of fluorophores in  % 
%   the sample, either based on an input image or consists of two equally %
%   spaced diracs (for tutorial purposes). In the latter case, the        %
%   tutorial would be in mode DEMONSTRATION (mode = false) or PRACTICAL   %
%   TOOL (mode=true).                                                     %
%                                                                         %  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%

input = generateTwoEquallySpacedDiracs(Grid);% generates an image with two equally spaced diracs
% Optical System Parameters
Optics.object = input;

stacks = simStacks(Optics.frames,Optics,Cam,Fluo,Grid);
timeTraces = stacks.discrete; clear stacks      % I(r,t)            --> [x,y,z]=[y,x,time]
sofi_xc = sofiCumulants2D_traces(timeTraces).'; % E[I(r,t)I(r,t+T)] --> [x,y]=[time,x]

% virtual sofi time Traces (before the time integration)
clear sofi;
[s,~] = sofiCumulants(timeTraces,[],[],[],1:2);
sofi = repmat(s{2},[1 1 size(timeTraces,3)]); clear s; % [x,y,z]=[y,x,time];
sofi = padarray(sofi,[3 3],'replicate','both');
for k=1:size(sofi,1)
    sofi(k,:,:) = squeeze(sofi(k,:,:)).*sofi_xc.';
end
sofi = (sofi - min(sofi(:)))/max(sofi(:) - min(sofi(:)));

norm_traces = zeros(2*size(timeTraces,1)-1,2*size(timeTraces,2)-1,size(timeTraces,3));
for k=1:size(timeTraces,3)
    norm_traces(:,:,k) = interp2(squeeze(timeTraces(:,:,k)),1,'spline');
end
norm_traces = (norm_traces - min(norm_traces(:)))/max(norm_traces(:) - min(norm_traces(:)));

% mixed_traces = zeros(size(sofi));
% mixed_traces(:,1:floor(size(sofi,2)/2),:)=norm_traces(:,1:floor(size(sofi,2)/2),:);
% mixed_traces(:,1+floor(size(sofi,2)/2):end,:)=sofi(:,1+floor(size(sofi,2)/2):end,:);

sk1 = squeeze(timeTraces(1+floor(Grid.sy/2),1+floor(0.5*Grid.sx - 0.25*Grid.sx),:));
sk2 = sofi_xc(:,1+floor(0.25*size(sofi_xc,2)));

sk1 = (sk1 - min(sk1))/max(sk1 - min(sk1));sk1(sk1<0.5)=0;sk1(sk1>=0.5)=1;
sk2 = 2+(sk2 - min(sk2))/max(sk2 - min(sk2));

mixed_traces = zeros(size(sofi,1),2*size(sofi,2),size(sofi,3));
mixed_traces(:,1:size(sofi,2),:)=norm_traces;
mixed_traces(:,1+size(sofi,2):end,:)=sofi;

mixed_image = zeros(size(sofi,1),2*size(sofi,2));
mixed_image(:,1:size(sofi,2))=abs(norm_traces(:,:,86)-.15); % change 44 using the for loop below
mixed_image(:,1+size(sofi,2):end)=sofi(:,:,1);

clear timeTraces sofi sofi_xc k norm_traces;
if(export==1);clear export;save('helpMenu_axes6');end;
% %k=66,86
% close all;
% for k=81:100
%     figure,imagesc(norm_traces(:,:,k));caxis([0 1]);
% end
%% --- Plotting figures

% --- sk(t) and <sk(t)sk(t+T)> 1D traces
figure('Color',[1 1 1]);
axis(gca,'square');
time_axis = (1:length(sk1)).'/Cam.acq_speed;
plot(time_axis,sk1,'b','LineWidth',1);hold on; plot(time_axis,sk2,'r','LineWidth',1);
% plot3(time_axis,ones(size(sk1)),sk1,'b','LineWidth',1);hold on; plot3(time_axis,2*ones(size(sk2)),sk2,'r','LineWidth',1);
xlim(gca,[0 1+length(sk1)]/Cam.acq_speed);ylim(gca,[0 max(sk2)]);
xlabel('Time[s]','FontSize',8,'FontWeight','bold');
legend_strings = {'s_k(t)','<s_k(t),s_k(t+\tau)>'};
legend(legend_strings);
set(gca,'XTick',[0:round(length(sk1)/10):length(sk1)]/Cam.acq_speed);set(gca,'YTick',[0:0.25:4]);
grid minor;
if(export==1);saveas(gcf,'helpMenu_TEX/axes5_1','png');end;

% --- 2D image of sofi and norm concatenated
h2 = figure('Color',[1 1 1]);
% --- annotation textbox
annotation(h2,'textbox',...
    [0.557142857142855 0.773809523809529 0.276785714285716 0.076190476190477],...
    'Interpreter','latex',...
    'String','$$E\{I(\vec{r_1},t)I(\vec{r_2},t+\tau{}_0)\}$$',...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1]);
annotation(h2,'textbox',...
    [0.285714285714285 0.800000000000001 0.217857142857143 0.0547619047619072],...
    'Interpreter','latex',...
    'String','$$I(\vec{r},t_0)$$',...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1]);

colormap(gca,jet(64));
mesh(mixed_image);caxis([0 1]);
axis square;view([12 12]);
xlabel('pixel y axis','FontSize',8,'FontWeight','bold');
ylabel('pixel x axis','FontSize',8,'FontWeight','bold');
if(export==1);saveas(gcf,'helpMenu_TEX/axes5_2','png');end;

% --- 2D movie of sofi and norma concatenated
if(export==1)
    writerObj = VideoWriter('helpMenu_TEX/axes5_3.mp4');writerObj.FrameRate=7;
    open(writerObj);
end

h1=figure('Color',[1 1 1]);
    % --- text boxes
    annotation(h1,'textbox',...
    [0.635648370497424 0.771428571428571 0.282018867924531 0.0571428571428572],...
    'String','Cumulant Time Traces: $$E\{I(\vec{r_1},t)I(\vec{r_2},t+\tau{})\}$$',...
    'Interpreter','latex',...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1]);

    annotation(h1,'textbox',...
    [0.326900514579758 0.808791208791209 0.237385199705956 0.0571428571428572],...
    'String',{'Pixel Time Traces: $$I(\vec{r_1},t)$$'},...
    'Interpreter','latex',...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1]);

for k = 1:size(mixed_traces,3)
    colormap(gca,jet(64));
    mesh(mixed_traces(:,:,k));caxis([0 1]);zlim([0 1]);view(gca,[20 20]);
    if(export==1);writeVideo(writerObj,getframe(h1));end;
    xlabel('pixel y axis','FontSize',8,'FontWeight','bold');ylabel('pixel x axis','FontSize',8,'FontWeight','bold');
    %pause(0.15);
end

if(export==1);close(writerObj);end;

% for k=1:size(sofi,3)
%     
%     subplot(133);axis(gca,'square');
%     colormap(gca,jet(64));
%     imagesc(mixed_traces(:,:,k));caxis([0 1]);
%     xlabel('pixel y axis','FontSize',8,'FontWeight','bold');ylabel('pixel x axis','FontSize',8,'FontWeight','bold')
%     set(gca,'XTick',[]);set(gca,'YTick',[]);
% 
%     subplot(131);axis(gca,'square');
%     colormap(gca,jet(64));
%     mesh(mixed_traces(:,:,k));caxis([0 1]);zlim([0 1]);view(gca,[20 20]);
%     xlabel('pixel y axis','FontSize',8,'FontWeight','bold');ylabel('pixel x axis','FontSize',8,'FontWeight','bold')
% 
%     if(k==1);pause(2);end;
%     pause(0.1);
% end
% %demoMenu_axes5:
% figure;
% sofi_x_axis = 1:size(sofi_xc,2);
% time_axis = 1:size(sofi_xc,1);
% xlim(gca,[0 1+size(sofi_xc,1)]);
% ylim(gca,[0 1+size(sofi_xc,2)]);
% zlim(gca,[0 1]);
% view([37,48]);xl = xlabel('Time lag','FontSize',8,'FontWeight','bold'); set(xl,'VerticalAlignment','bottom');
% yl = ylabel('Pixels x axis','FontSize',8,'FontWeight','bold'); set(yl,'VerticalAlignment','bottom');
% hold on;
% for x=1:length(sofi_x_axis)
%     plot3(time_axis,ones(size(time_axis))*x,sofi_xc(time_axis,x),'-r');
% end
% hold off;

% if ~mode
%     input = generateTwoEquallySpacedDiracs(Grid);% generates an image with two equally spaced diracs
%     % Optical System Parameters
%     Optics = struct('object',input,'psf',psf,'magnification',magn);
%     
%     [timeTraces1D,sofi_ac,sofi_xc] = demonstration(frames,Optics,Grid,Fluo,Cam);
%     demonstrationFigures(timeTraces1D,sofi_ac,sofi_xc);
% else
%     def = 3; % number of fluorophores [#], density of fluorophores [#/um^2] or image
%     type = 'density'; % 'number', 'density' or 'image'
%     input = generatePattern(def,type,Grid,Fluo); % generates an image with randomly placed diracs
%     % imagesc(input);colormap gray;
%     % Optical System Parameters
%     Optics = struct('object',input,'psf',psf,'fwhm',gauss_psf_fwhm,'magnification',magn);
%     
%     orders=1:5;
%     [timeTraces,sofi] = practicalTool(frames,Optics,Grid,Fluo,Cam,orders);
%     practicalToolFigures(timeTraces,sofi,orders);
% end





