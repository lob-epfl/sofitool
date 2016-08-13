% SOFI tutorial 

clear all
close all

fwhm_conv = 6;
Grid = struct('blckSize',2,'sx',80,'sy',80);

s_xy_conv = fwhm_conv/2.3548;
s_xy = Grid.blckSize*s_xy_conv;

r_conv = 3*s_xy_conv;
r = Grid.blckSize*r_conv;

shift = round(Grid.sx/4);
emitter_position = [round(Grid.sy/2),-shift + round(Grid.sx/2);round(Grid.sy/2),shift + round(Grid.sx/2)];
Nemitters = 2;
emitter_brightness = [0.9;0.3];

% Convearized signal
[gridConvY,gridConvX] = meshgrid(1:Grid.sy,1:Grid.sx); % pixel number within the camera
gridConv = zeros(Grid.sy,Grid.sx); 

% Raw signal
[gridRawY,gridRawX] = meshgrid(1:Grid.sy,1:Grid.sx); % pixel number within the camera
gridRaw = zeros(Grid.sy,Grid.sx); 

for m=1:Nemitters
    % Conv Grid
    [x,y]=ind2sub(size(gridConv),find((gridConvX - emitter_position(m,1)).^2 + (gridConvY - emitter_position(m,2)).^2 <=  r_conv^2 == 1));
    for k=1:length(x)
        gridConv(x(k),y(k),:)= squeeze(gridConv(x(k),y(k))).' + 0.25*...
                         (erf((x(k)-emitter_position(m,1)+0.5)/(sqrt(2)*s_xy_conv)) - erf((x(k)-emitter_position(m,1)-0.5)/(sqrt(2)*s_xy_conv))).*...
                         (erf((y(k)-emitter_position(m,2)+0.5)/(sqrt(2)*s_xy_conv)) - erf((y(k)-emitter_position(m,2)-0.5)/(sqrt(2)*s_xy_conv)));
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
gridConvX gridConvY s_xy_conv r_conv fwhm_conv;

gridRaw = gridRaw/max(gridRaw(:));
gridConv = gridConv/max(gridConv(:));

figure;colormap(gca,jet(64));
mesh(gridRaw);caxis([0 1]);
axis square;view([51 26]);
xlabel('pixel y axis','FontSize',8,'FontWeight','bold');
ylabel('pixel x axis','FontSize',8,'FontWeight','bold');
title('before Linearization');

figure;colormap(gca,jet(64));
mesh(gridConv);caxis([0 1]);
axis square;view([51 26]);
xlabel('pixel y axis','FontSize',8,'FontWeight','bold');
ylabel('pixel x axis','FontSize',8,'FontWeight','bold');
title('after Linearization and Convolution');

save('helpMenu_axes9.mat');
