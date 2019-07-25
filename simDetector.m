
function [TMO,TMSD] = simDetector(diameter,delta_min,delta_max,step_delta,circle_distance,circle_number,slope_step,slope_max)
    radium = diameter/2+circle_number*0;             % 激光光斑半径
    delta = delta_min:step_delta:delta_max;   % 探测器之间距离的取值
    slope_angle = 0:slope_step:slope_max;
    TMO = zeros(1,length(delta));TMSD = zeros(1,length(delta));
    dector_x_min = 0;dector_x_max = 500+delta_max;
    dector_y_min = -35;dector_y_max = 500+delta_max;
for delta_i = delta 
    % 每一个距离计算一次TMO和TMSD,delta_i代表当前的Δ
    % 计算得到三个圆的圆心坐标值
    centroidxy1 = calCentroid(delta_i,radium,slope_angle,circle_distance,1);
    centroidxy2 = calCentroid(delta_i,radium,slope_angle,circle_distance,2);
    centroidxy3 = calCentroid(delta_i,radium,slope_angle,circle_distance,3);
%     dector_x_min = 0;dector_x_max = 500;
%     dector_y_min = -35;dector_y_max = 500;
    dector_xy = setDector(dector_x_min,dector_x_max,dector_y_min,dector_y_max,delta_i);
    [TMO(delta_i-delta(1)+1),TMSD(delta_i-delta(1)+1)] = calMean(centroidxy1,centroidxy2,centroidxy3,dector_xy);
end

