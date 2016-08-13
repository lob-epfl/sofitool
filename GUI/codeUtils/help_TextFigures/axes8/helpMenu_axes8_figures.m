% SOFI tutorial 

clear all
close all

fwhm_lin = 3;
Grid = struct('blckSize',5,'sx',80,'sy',80);

s_xy_lin = fwhm_lin/2.3548;
s_xy = Grid.blckSize*s_xy_lin;

r_lin = 3*s_xy_lin;
r = Grid.blckSize*r_lin;

shift = round(Grid.sx/4);
emitter_position = [round(Grid.sy/2),-shift + round(Grid.sx/2);round(Grid.sy/2),shift + round(Grid.sx/2)];
Nemitters = 2;
emitter_brightness = [0.9;0.3];

% Linearized signal
[gridLinY,gridLinX] = meshgrid(1:Grid.sy,1:Grid.sx); % pixel number within the camera
gridLin = zeros(Grid.sy,Grid.sx); 

% Raw signal
[gridRawY,gridRawX] = meshgrid(1:Grid.sy,1:Grid.sx); % pixel number within the camera
gridRaw = zeros(Grid.sy,Grid.sx); 

for m=1:Nemitters
    % Linearized Grid
    [x,y]=ind2sub(size(gridLin),find((gridLinX - emitter_position(m,1)).^2 + (gridLinY - emitter_position(m,2)).^2 <=  r_lin^2 == 1));
    for k=1:length(x)
        gridLin(x(k),y(k),:)= squeeze(gridLin(x(k),y(k))).' + 0.25*...
                         (erf((x(k)-emitter_position(m,1)+0.5)/(sqrt(2)*s_xy_lin)) - erf((x(k)-emitter_position(m,1)-0.5)/(sqrt(2)*s_xy_lin))).*...
                         (erf((y(k)-emitter_position(m,2)+0.5)/(sqrt(2)*s_xy_lin)) - erf((y(k)-emitter_position(m,2)-0.5)/(sqrt(2)*s_xy_lin)));
    end
    
    % Raw grid
    clear x y;
    [x,y]=ind2sub(size(gridRaw),find((gridRawX - emitter_position(m,1)).^2 + (gridRawY - emitter_position(m,2)).^2 <=  r^2 == 1));
    for k=1:length(x)
        gridRaw(x(k),y(k),:)= squeeze(gridRaw(x(k),y(k),:)).' + 0.25*emitter_brightness(m,:)*...
                         (erf((x(k)-emitter_position(m,1)+0.5)/(sqrt(2)*s_xy)) - erf((x(k)-emitter_position(m,1)-0.5)/(sqrt(2)*s_xy))).*...
                         (erf((y(k)-emitter_position(m,2)+0.5)/(sqrt(2)*s_xy)) - erf((y(k)-emitter_position(m,2)-0.5)/(sqrt(2)*s_xy)));
    end
    clear x y;
end

clear emitter_position emitter_brightness Nemitters...
Grid m k shift ...
gridRawX gridRawY s_xy r fwhm...
gridLinX gridLinY s_xy_lin r_lin fwhm_lin;

gridRaw = gridRaw/max(gridRaw(:));
gridLin = gridLin/max(gridLin(:));

figure;colormap(gca,jet(64));
mesh(gridRaw);caxis([0 1]);
axis square;view([51 26]);
xlabel('pixel y axis','FontSize',8,'FontWeight','bold');
ylabel('pixel x axis','FontSize',8,'FontWeight','bold');
title('before Linearization');

figure;colormap(gca,jet(64));
mesh(gridLin);caxis([0 1]);
axis square;view([51 26]);
xlabel('pixel y axis','FontSize',8,'FontWeight','bold');
ylabel('pixel x axis','FontSize',8,'FontWeight','bold');
title('after Linearization');

save('helpMenu_axes8.mat');
