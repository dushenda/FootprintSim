% 计算阵列间距为20的TMO
clear;clc;
delta = 20; % detector array 20
diameter = 70;radium = diameter/2;
pointx = 0:20:500;pointy = -35:20:500;
[X,Y] = meshgrid(pointx,pointy);
% all detector coordinate
dectorxy = [reshape(X,1,numel(X));reshape(Y,1,numel(Y))]';
b = 0:1:delta;    % y move
m = 0:1:15;       % slope
l = 35:1:35+delta;% x move
N_m = length(m);N_b = length(b);N_s1 = length(l);
l_total = repmat(l,1,N_b*N_m);
l_x = repmat(reshape(repmat(cos((0:1:15)*pi/180),N_s1,1),1,N_m*N_s1),1,N_b);
l_y = repmat(reshape(repmat(sin((0:1:15)*pi/180),N_s1,1),1,N_m*N_s1),1,N_b);
x_total = l_total.*l_x;
y_b = reshape(repmat(0:1:delta,N_s1*N_m,1),1,N_b*N_m*N_s1);
y_total = y_b+l_y.*l_total;
% N_m = length(m);N_b = length(b);N_s1 = length(l);
% slope_x = cos(m*pi/180);slope_y = sin(m*pi/180);
% l_x = repmat(l,1,N_b*N_m);
% slope_x = repmat(slope_x,N_s1,1);slope_x = reshape(slope_x,1,N_m*N_s1);
% slope_x = repmat(slope_x,1,N_b);
% x_all = l_x.*slope_x;
% l_y = repmat(l,1,N_b*N_m);
% slope_y = repmat(slope_y,N_s1,1);slope_y = reshape(slope_y,1,N_m*N_s1);
% slope_y = repmat(slope_y,1,N_b);
% y_gap_all = l_y.*slope_y;
% y_b_ext = 0:1:delta;
% y_b_ext = repmat(y_b_ext,N_m*N_s1,1);y_b_ext = reshape(y_b_ext,1,N_b*N_m*N_s1);
% y_all = l_y+y_b_ext;
centroid_xy = [x_total;y_total]';
dis = pdist2(dectorxy,centroid_xy);
is_in_circle = dis<35;
x_ext = repmat(dectorxy(:,1),1,length(is_in_circle));
y_ext = repmat(dectorxy(:,2),1,length(is_in_circle));
x_in = x_ext.*is_in_circle;
y_in = y_ext.*is_in_circle;
x_in(x_in==0) = nan;y_in(y_in==0) = nan;
cal_x = mean(x_in,'omitnan');
cal_y = mean(y_in,'omitnan');
cal_xy = [cal_x;cal_y];
error = centroid_xy - cal_xy';
errortol = error(:,1).^2+error(:,2).^2;
TMO = mean(errortol)
