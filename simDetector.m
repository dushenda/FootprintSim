
function [TMO,TMSD] = simDetector(diameter,circle_distance,delta_min,step_delta,delta_max)
    radium = diameter/2;      % �����߰뾶
    delta = delta_min:step_delta:delta_max;   % ̽����֮������ȡֵ
    slope_angle = 0:1:15;     % ��ת�Ƕ�
    % Ԥ�����ڴ�
    TMO = zeros(1,length(delta));TMSD = zeros(1,length(delta));
    % ̽�����Ų�
    dector_x_min = 0;dector_x_max = 500+delta_max;
    dector_y_min = -35;dector_y_max = 200+delta_max;
for delta_i = delta 
    % ÿһ���������һ��TMO��TMSD,delta_i����ǰ�Ħ�
    % ����õ�����Բ��Բ������ֵ
    centroidxy1 = calCentroid(delta_i,radium,slope_angle,circle_distance,1);
    centroidxy2 = calCentroid(delta_i,radium,slope_angle,circle_distance,2);
    centroidxy3 = calCentroid(delta_i,radium,slope_angle,circle_distance,3);
%     dector_x_min = 0;dector_x_max = 500;
%     dector_y_min = -35;dector_y_max = 500;
    dector_xy = setDector(dector_x_min,dector_x_max,dector_y_min,dector_y_max,delta_i);
    [TMO(delta_i-delta(1)+1),TMSD(delta_i-delta(1)+1)] = calMean(centroidxy1,centroidxy2,centroidxy3,dector_xy,radium);
end

