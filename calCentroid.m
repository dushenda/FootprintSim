function centroidxy = calCentroid(delta,radium,slope,distance,index)
% delta��̽�������
% radium�������߰뾶
% slope����ת�Ƕ�ȡֵ
% distance������Բ����֮��ľ���
% index���������
    % ����Բ�����еĿ����˶�
    index = index-1;          % �±��0��ʼ
    N_s1 = delta+1;           % x������ƶ�
    N_b = delta+1;            % y������ƶ�
    N_m = length(slope);      % �Ƕȵ���ת
    % �������Բ�ĳ���λ��ȷ��
    % ��չ˳����x�ƶ�����ʱ����ת��y�����ƽ��
    l_s1 = radium+index*distance:1:radium+index*distance+delta;% x�����ƶ�
    l_m = repmat(l_s1,1,N_m);  % ��ʱ����ת
    l_b = repmat(l_m,1,N_b);   % y����ƽ��
    l_all = l_b;               % ����x����ȫ��
    y_b = -delta:1:0; 
    y_s1_b = repmat(y_b,N_s1*N_m,1);
    y_all_before = reshape(y_s1_b,1,N_s1*N_b*N_m);
    % ��չ˳������ʱ����ת��x�ƶ���y�����ƽ��
    y_slope_m = sin(slope*pi/180);
    x_slope_m = cos(slope*pi/180);
    y_slope_s1 = repmat(y_slope_m,N_s1,1);
    x_slope_s1 = repmat(x_slope_m,N_s1,1);
    y_slope_s1 = reshape(y_slope_s1,1,N_m*N_s1);
    x_slope_s1 = reshape(x_slope_s1,1,N_m*N_s1);
    y_slope_b = repmat(y_slope_s1,1,N_b);
    x_slope_b = repmat(x_slope_s1,1,N_b);
    y_slope_all = y_slope_b;
    x_slope_all = x_slope_b;
    % ����y�����λ��
    y_gap = l_all.*y_slope_all;
    y_real = y_all_before+y_gap;
    x_real = l_all.*x_slope_all;
    centroidxy = [x_real;y_real];
end