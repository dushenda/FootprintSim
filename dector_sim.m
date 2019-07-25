clear;clc;
tic
diameter = 70;                   % ������ֱ��
radium = diameter/2;             % �����߰뾶
delta_min=15;delta_max = 35;     % ̽���֮��������ֵ
delta = delta_min:1:delta_max;   % ̽����֮������ȡֵ
circle_distance = 170;           % �������֮��ľ���
circle_number = 3;               % ��ߵĸ��� 
slope_angle = 0:1:15;            % ��б�Ƕȵ�ȡֵ
dector_x_min = 0;dector_x_max = 500+delta_max;
dector_y_min = -35;dector_y_max = 500+delta_max;

TMO = zeros(1,length(delta));TMSD = zeros(1,length(delta));
for delta_i = delta 
% ÿһ���������һ��TMO��TMSD,delta_i����ǰ�Ħ�
% ����õ�����Բ��Բ������ֵ
centroidxy1 = calCentroid(delta_i,radium,slope_angle,circle_distance,1);
centroidxy2 = calCentroid(delta_i,radium,slope_angle,circle_distance,2);
centroidxy3 = calCentroid(delta_i,radium,slope_angle,circle_distance,3);
dector_xy = setDector(dector_x_min,dector_x_max,dector_y_min,dector_y_max,delta_i);
[TMO(delta_i-delta(1)+1),TMSD(delta_i-delta(1)+1)] = calMean(centroidxy1,centroidxy2,centroidxy3,dector_xy);
end
toc